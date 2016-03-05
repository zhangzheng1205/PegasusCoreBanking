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
            Session["IsError"] = null;
            string Id = Request.QueryString["BankCode"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            else if (!string.IsNullOrEmpty(Id)) 
            {
                LoadData(Id);
            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true,Session);
        }
    }

    private void LoadData(string Id)
    {
        Bank bank = client.GetById("BANK", Id, user.BankCode, bll.BankPassword) as Bank;
        MultiView1.ActiveViewIndex = 0;
        if (bank.StatusCode == "0")
        {
            txtBankCode.Text = bank.BankCode;
            txtBankCode.Enabled = false;
            txtBankName.Text = bank.BankName;
            txtColor.Text = bank.TextColor.Replace("#", string.Empty);
            txtTheme.Text = bank.BankThemeColor.Replace("#",string.Empty);
            txtContactEmail.Text = bank.BankContactEmail;
        }
        else 
        {
            string msg = bank.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            Bank bank = GetBankFromDetails();
            if (bll.Exists(bank))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                Save(bank);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true,Session);
        }
    }

    private Bank GetBankFromDetails()
    {
        Bank bank = new Bank();
        bank.BankCode = txtBankCode.Text;
        bank.BankContactEmail = txtContactEmail.Text;
        bank.BankId = "0";
        bank.BankName = txtBankName.Text;
        bank.BankPassword = bll.GeneratePassword();
        bank.IsActive = ddIsActive.SelectedValue;
        bank.ModifiedBy = user.Id;
        bank.BankThemeColor = "#"+txtTheme.Text;
        bank.TextColor = "#" + txtColor.Text;
        bank.BankVaultAccNumber = bll.GenerateAccountNumber();

        //check if user has already upload this stuff
        string publicKey = ViewState["PublicKey"] as String;
        if (string.IsNullOrEmpty(publicKey))
        {
            bank.PathToPublicKey = GetPathToPublicKey(bank.BankCode);
            bank.PathToLogoImage = GetPathToLogoImage(bank.BankCode);
            ViewState["PublicKey"] = bank.PathToPublicKey;
            ViewState["BankLogo"] = bank.PathToLogoImage;
        }
        else 
        {
            bank.PathToPublicKey = publicKey;
            bank.PathToLogoImage = ViewState["BankLogo"] as String;
        }
        return bank;
    }

    private string GetPathToLogoImage(string BankCode)
    {
        if (fuBankLogo.HasFile)
        {
            string fileName = fuBankLogo.FileName.ToUpper();
            if (fileName.Contains(".JPG") || fileName.Contains(".JPEG") || fileName.Contains(".PNG"))
            {
                string PathToFolderForBankLogos = Server.MapPath("Images") + @"\" + BankCode + @"\";
                bll.CreateFolderPathIfItDoesntExist(PathToFolderForBankLogos);
                string FullFileName = PathToFolderForBankLogos + fuBankLogo.FileName;
                fuBankLogo.SaveAs(FullFileName);
                return fuBankLogo.FileName;
            }
            else
            {
                throw new Exception("PLEASE UPLOAD A BANK LOGO IMAGE IN .PNG OR .JPEG FORMAT");
            }
        }
        else 
        {
            return "";
        }
    }

    private string GetPathToPublicKey(string BankCode)
    {
        if (fuPublicKey.HasFile)
        {
            if (fuPublicKey.FileName.Contains(".cer"))
            {
                string PathToFolderForPublicKeys = @"C:\CoreBankingResources\PublicKeys\" + BankCode + @"\";
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
            return "";
        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            Bank bank = GetBankFromDetails();
            Save(bank);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(Bank bank)
    {
        Result result = client.SaveBankDetails(bank, user.Id, user.Password);
        MultiView1.ActiveViewIndex = 0;
        if (result.StatusCode == "0")
        {
           
            string msg = "SUCCESS: BANK SAVED. BANKCODE = [" + result.PegPayId + "]";
            bll.ShowMessage(lblmsg, msg, false,Session);

            if (ddSendEmail.Text == "YES")
            {
                bll.SendBankAdminCredentialsEmail(bank);
            }
        }
        else
        {
            string msg = result.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
  
}