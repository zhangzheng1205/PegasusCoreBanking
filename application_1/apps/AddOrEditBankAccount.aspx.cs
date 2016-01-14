using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankAccount : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            string Id = Request.QueryString["Id"];
            string BankCode = Request.QueryString["BankCode"];
            string UserId = Request.QueryString["UserId"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            //create customer request
            else if (UserId != null) 
            {
                LoadData();
                txtUserId.Text = UserId;
                txtUserId.Enabled = false;
                MultiView1.ActiveViewIndex = 0;
            }
            //this is an edit request
            else if (Id != null)
            {
                LoadData();
                LoadAccountData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;

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

    private void LoadAccountData(string Id, string BankCode)
    {
        BankAccount account = client.GetById("BANKACCOUNT", Id, BankCode, bll.BankPassword) as BankAccount;
        if (account.StatusCode == "0")
        {
            this.ddAccountType.SelectedValue = account.AccountType;
            this.ddBank.SelectedValue = account.BankCode;
            this.ddBankBranch.SelectedValue = account.BranchCode;
            this.txtUserId.Text = account.UserId;
            this.ddIsActive.Text = account.IsActive;
        }
        else 
        {
            string msg = account.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBankBranch, user);
        bll.LoadAccountTypesIntoDropDown(user.BankCode, ddAccountType, user);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankAccount account = GetBankAccount();
            Result result = client.SaveBankAccountDetails(account, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] SAVED SUCCESSFULLY";
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

    private BankAccount GetBankAccount()
    {
        BankAccount account = new BankAccount();
        account.AccountBalance = "0";
        account.AccountId = "";
        account.BranchCode = ddBankBranch.SelectedValue;
        account.AccountNumber = GenerateAccountNumber();
        account.AccountType = ddAccountType.SelectedValue;
        account.IsActive = ddIsActive.Text;
        account.BankCode = ddBank.SelectedValue;
        account.UserId = txtUserId.Text;
        account.ModifiedBy = user.Id;
        return account;
    }

    private string GenerateAccountNumber()
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }

}