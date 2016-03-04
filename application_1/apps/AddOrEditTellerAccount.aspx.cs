using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditTellerAccount : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    string BankCode = "";
    string UserId = "";
    string Id = "";
    string BranchCode = "";
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            Id = Request.QueryString["Id"];
            BankCode = Request.QueryString["BankCode"];
            UserId = Request.QueryString["UserId"];
            BranchCode = Request.QueryString["BranchCode"];
            Msg = Request.QueryString["Msg"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {
            }
            //create customers bank account request
            else if (UserId != null)
            {
                LoadData();
                DisableControls2(UserId);
                MultiView1.ActiveViewIndex = 0;
                bll.ShowMessage(lblmsg, Msg, false, Session);
            }
            //this is an edit bank account request
            else if (Id != null)
            {
                LoadData();
                DisableControls(Id);
                LoadAccountData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;
            }
            //this is a normal create account request
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

    private void DisableControls2(string UserId)
    {
        ddBank.SelectedValue = BankCode;
        ddBank.Enabled = false;
        ddBankBranch.SelectedValue = BranchCode;
        ddBankBranch.Enabled = true;

        AddSignatorySection.Visible = false;
        ddAccountType.Enabled = true;
        ddBank.Enabled = false;
        ddIsActive.Text = "False";
        ddIsActive.Enabled = true;
        ddCurrency.Enabled = true;
        AddSignatorySection.Visible = false;

        List<string> accountSignatories = ViewState["AccountSignatories"] as List<string>;

        if (accountSignatories == null)
        {
            accountSignatories = new List<string>();
        }

        accountSignatories.Add(UserId);
        ViewState["AccountSignatories"] = accountSignatories;
    }


    private void DisableControls(string UserId)
    {
        ddBank.SelectedValue = BankCode;
        ddBank.Enabled = false;
        ddBankBranch.SelectedValue = BranchCode;
        ddBankBranch.Enabled = true;

        AddSignatorySection.Visible = false;
        ddAccountType.Enabled = true;
        ddBank.Enabled = false;
        ddIsActive.Text = ddIsActive.Text;
        ddIsActive.Enabled = true;
        ddCurrency.Enabled = false;
        AddSignatorySection.Visible = false;

        List<string> accountSignatories = ViewState["AccountSignatories"] as List<string>;

        if (accountSignatories == null)
        {
            accountSignatories = new List<string>();
        }

        accountSignatories.Add(UserId);
        ViewState["AccountSignatories"] = accountSignatories;
    }

    private void LoadAccountData(string Id, string BankCode)
    {
        BankAccount account = client.GetById("BANKACCOUNT", Id, BankCode, bll.BankPassword) as BankAccount;
        if (account.StatusCode == "0")
        {
            this.ddAccountType.SelectedValue = account.AccountType;
            this.ddBank.SelectedValue = account.BankCode;
            this.ddBankBranch.SelectedValue = account.BranchCode;
            this.ddIsActive.Text = account.IsActive;
            this.ddCurrency.SelectedValue = account.CurrencyCode;

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
        bll.LoadBanksBranchesIntoDropDown(ddBank.SelectedValue, ddBankBranch, user);
        bll.LoadAccountTypesIntoDropDown(ddBank.SelectedValue, ddAccountType, user);
        bll.LoadCurrenciesIntoDropDown(ddBank.SelectedValue, ddCurrency, user);
        bll.LoadTellersWhoDontHaveAccountsIntoDropDown(ddBank.SelectedValue, ddTellers, user);
        ddAccountType.SelectedValue = "TELLER_ACCOUNT";
        ddAccountType.Enabled = false;
        ddBankBranch.Enabled = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankAccount account = GetBankAccount();
            Result result = client.SaveBankTellerAccountDetails(account, ddBank.SelectedValue, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                //create account request
                string msg = "SUCCESS: BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] SAVED SUCCESSFULLY";
                bll.ShowMessage(lblmsg, msg, false, Session);

                //Reset this so incase restarts this process they have to do it all over again
                ViewState["AccountSignatories"] = null;

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
        account.ModifiedBy = user.Id;
        account.CurrencyCode = ddCurrency.SelectedValue;
        account.AccountSignatories = new string[] { ddTellers.Text };
        return account;
    }

    private string GenerateAccountNumber()
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
        bll.LoadBanksBranchesIntoDropDown(bankCode, ddBankBranch, user);
        ddBankBranch.Enabled = true;
    }



    private void SaveVariablesInViewState(BankCustomer cust)
    {
        List<string> AccountSignatories = ViewState["AccountSignatories"] as List<string>;
        if (AccountSignatories == null)
        {
            AccountSignatories = new List<string>();
            AccountSignatories.Add(cust.Id);

        }
        else
        {
            AccountSignatories.Add(cust.Id);
        }
        ViewState["AccountSignatories"] = AccountSignatories;
        string msg = "CUSTOMER ADDED AS SIGNATORY. NUMBER OF SIGNATORIES ADDED: " + AccountSignatories.Count;
        bll.ShowMessage(lblmsg, msg, false, Session);
    }




    protected void ddTellers_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string tellerId = ddTellers.SelectedValue;
            BankUser user = client.GetById("BANKUSER", tellerId, ddBank.SelectedValue, bll.BankPassword) as BankUser;
            if (user.StatusCode == "0")
            {
                ddBankBranch.SelectedValue = user.BranchCode;
                ddBankBranch.Enabled = false;
            }
            else
            {
                string msg = user.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}