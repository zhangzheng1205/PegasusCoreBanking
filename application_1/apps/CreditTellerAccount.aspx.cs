using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreditTellerAccount : System.Web.UI.Page
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
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBanks);
        bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBranches, user);
        bll.LoadTellerAccountsIntoDropDown(ddBanks.SelectedValue, ddTellers, user, ddBranches.SelectedValue);
    }


    protected void ddBranches_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bll.LoadTellerAccountsIntoDropDown(ddBanks.SelectedValue, ddTellers, user, ddBranches.SelectedValue);
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }


    protected void ddBanks_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBranches, user);
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            TransactionRequest tranRequest = GetTranRequest();
            Result result = client.CreditVaultAccount(tranRequest);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: Teller Account Credited Successfully. Transaction ID [" + result.PegPayId + "]";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private TransactionRequest GetTranRequest()
    {
        TransactionRequest tran = new TransactionRequest();
        tran.ApprovedBy = user.Id;
        tran.BankCode = user.BankCode;
        tran.BranchCode = user.BranchCode;
        tran.CustomerName = "BRANCH TELLER ACCOUNT CREDIT";
        BankBranch branch=client.GetById("BANKBRANCH",ddBranches.SelectedValue,ddBanks.SelectedValue,bll.BankPassword) as BankBranch;
        tran.FromAccount = branch.BranchVaultAccNumber;
        tran.Narration = "BRANCH TELLER ACCOUNT CREDIT";
        tran.Password = bll.BankPassword;
        tran.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        tran.Teller = user.Id;
        tran.ToAccount = ddTellers.SelectedValue;
        tran.TranAmount = txtAmount.Text;
        tran.TranCategory = "DEPOSIT";
        tran.CurrencyCode = "UGS";
        tran.BankTranId = bll.SaveTranRequest(tran, tran.FromAccount);
        tran.PaymentType = "CASH";
        tran.ChequeNumber = "";
        return tran;
    }
}