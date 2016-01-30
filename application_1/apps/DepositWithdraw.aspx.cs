using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DepositWithdraw : System.Web.UI.Page
{
    string Operation = "";
    string Id = "";
    BankTeller teller;
    Bussinesslogic bll = new Bussinesslogic();
    Service client = new Service();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Operation = Request.QueryString["Op"].ToUpper();
            Id = Request.QueryString["Id"].ToUpper();
            teller = Session["User"] as BankTeller;
            Session["IsError"] = null;

            //Session is invalid
            if (teller == null)
            {
                LoadData();
            }
            //Operation is missing
            if (string.IsNullOrEmpty(Operation))
            {
                string msg = "FAILED: Operation not supported at the moment";
                bll.ShowMessage(lblmsg, msg, true, Session);
                btnSubmit.Enabled = false;
            }
            else if (IsPostBack)
            {

            }
            else
            {
               
                LoadData();
               
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadTransactionTypesIntoDropDown(teller.BankCode, ddTranCategory, teller);
        bll.LoadCurrenciesIntoDropDown(teller.BankCode, ddCurrency, teller);
        DisableControls();
        MultiView1.ActiveViewIndex = 0;
    }

    public void DisableControls() 
    {

        //if teller wants to process deposit
        if (Operation == "DEPOSIT")
        {
            ddTranCategory.Text = Operation;
            txtFromAccount.Text = teller.TellerAccountNumber;
            txtFromAccount.Enabled = false;
            txtToAccount.Text = Id;
            txtToAccount.Enabled = false;
        }
        //if teller wants to process withdraw
        else if (Operation == "WITHDRAW")
        {
            ddTranCategory.Text = Operation;
            txtToAccount.Text = teller.TellerAccountNumber;
            txtFromAccount.Text = Id;
            txtFromAccount.Enabled = false;
            txtToAccount.Enabled = false;
        }
        //funds transfer
        //disable from account 
        //set it to users acc number so he cant withdraw
        else
        {
            txtFromAccount.Text = Id;
            txtFromAccount.Enabled = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //generate transaction request
            TransactionRequest tran = GetTranRequest();
            Session["TranSummary"] = tran;
            Response.Redirect("TransactionSummaryPage.aspx");
        }
        catch (Exception ex)
        {
            //display error
            string msg = "Failed: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private TransactionRequest GetTranRequest()
    {
        TransactionRequest tran = new TransactionRequest();
        tran.BankCode = teller.BankCode;
        tran.BranchCode = teller.BranchCode;
        tran.CustomerName = txtName.Text;
        tran.FromAccount = txtFromAccount.Text;
        tran.Narration = txtReason.Text;
        tran.Password = bll.BankPassword;
        tran.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        tran.Teller = teller.Id;
        tran.ToAccount = txtToAccount.Text;
        tran.TranAmount = txtAmount.Text;
        tran.TranCategory = ddTranCategory.SelectedValue;
        tran.CurrencyCode = ddCurrency.SelectedValue;
        tran.ApprovedBy = teller.Id;
        if (Operation == "Deposit")
        {
            tran.BankTranId = bll.SaveTranRequest(tran, tran.ToAccount);
        }
        else
        {
            tran.BankTranId = bll.SaveTranRequest(tran, tran.FromAccount);
        }

        return tran;
    }
}