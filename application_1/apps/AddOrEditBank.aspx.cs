using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBank : System.Web.UI.Page
{
    Bussinesslogic bll = new Bussinesslogic();
    BankUser user = new BankUser();
    Service client = new Service();
    List<string> allowedImageExtensions = new List<string>(new string[] { ".JPG", ".JPEG", ".PNG" });

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            user = Session["User"] as BankUser;

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }

            else if (IsPostBack)
            {

            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Bank bank = GetBankFromDetails();
            Result result = client.SaveBankDetails(bank, user.Id, user.Password);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: BANK CREATED WITH BANKCODE = " + result.PegPayId;
                bll.ShowMessage(lblmsg, msg, false);
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true);
        }
    }

    private Bank GetBankFromDetails()
    {
        Bank bank = new Bank();
        bank.BankCode = txtBankCode.Text;
        bank.BankContactEmail = txtContactEmail.Text;
        bank.BankId = "0";
        bank.BankName = txtBankName.Text;
        bank.BankPassword = bll.GenerateBankPassword();
        bank.IsActive = ddIsActive.SelectedValue;
        bank.ModifiedBy = user.Id;
        bank.PathToPublicKey = GetPathToPublicKey(bank.BankCode);
        bank.PathToLogoImage = GetPathToLogoImage(bank.BankCode);
        return bank;
    }

    private string GetPathToLogoImage(string BankCode)
    {
        if (fuBankLogo.HasFile)
        {
            string fileName = fuBankLogo.FileName.ToUpper();
            if (fileName.Contains(".JPG") || fileName.Contains(".JPEG") || fileName.Contains(".PNG"))
            {
                string PathToFolderForBankLogos = @"C:\CoreBankingResources\BankLogos\" + BankCode + @"\";
                bll.CreateFolderPathIfItDoesntExist(PathToFolderForBankLogos);
                string FullFileName = PathToFolderForBankLogos + fuBankLogo.FileName;
                fuBankLogo.SaveAs(FullFileName);
                return FullFileName;
            }
            else
            {
                throw new Exception("PLEASE UPLOAD A BANK LOGO IMAGE IN .PNG OR .JPEG FORMAT");
            }
        }
        else
        {
            throw new Exception("PLEASE UPLOAD A BANK LOGO IMAGE");
        }
    }

    private string GetPathToPublicKey(string BankCode)
    {
        if (fuPublicKey.HasFile)
        {
            if (fuPublicKey.FileName.Contains(".cer"))
            {
                string PathToFolderForPublicKeys = @"C:\CoreBankingResources\PublicKeys\"+BankCode+@"\";
                bll.CreateFolderPathIfItDoesntExist(PathToFolderForPublicKeys);
                string FullFileName = PathToFolderForPublicKeys + fuPublicKey.FileName;
                fuPublicKey.SaveAs(FullFileName);
                return FullFileName;
            }
            else
            {
                throw new Exception("PLEASE UPLOAD A PUBLIC KEY IN THE .CER FORMAT");
            }
        }
        else
        {
            throw new Exception("PLEASE UPLOAD A PUBLIC KEY");
        }
    }

  
}