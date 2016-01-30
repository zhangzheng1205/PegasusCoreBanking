using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DisplayAccountDetails : System.Web.UI.Page
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

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            //this is a normal create account request
            else if (Id != null)
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData()
    {
        BankAccount account = client.GetById("BANKACCOUNT", Id, BankCode, bll.BankPassword) as BankAccount;
        if (account.StatusCode == "0")
        {
            lblAccountType.Text = account.AccountType;
            lblBank.Text = account.BankCode;
            lblBankBranch.Text = account.BranchCode;
            lblCurrency.Text = account.CurrencyCode;
            lblIsActive.Text = account.IsActive;
            lblAccountNumber.Text = account.AccountNumber;
            lblBalance.Text = account.AccountBalance;
            string signatories="";
            foreach (string signatory in account.AccountSignatories) 
            {
                signatories += signatory + ", ";
            }
            lblSignatories.Text = signatories;
        }
        else
        {
            string msg = account.StatusDesc;
            Response.Redirect("GetAccountDetails.aspx?Msg=" + msg);
        }
    }


    protected void btnTransact_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("DepositWithdraw.aspx?Op=Transact&Id=" + lblAccountNumber.Text);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnDeposit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("DepositWithdraw.aspx?Op=Deposit&Id=" + lblAccountNumber.Text);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnWithdraw_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("DepositWithdraw.aspx?Op=Withdraw&Id=" + lblAccountNumber.Text);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnViewStatement_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Reports.aspx?Id=" + lblAccountNumber.Text + "&BankCode=" + BankCode);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

}