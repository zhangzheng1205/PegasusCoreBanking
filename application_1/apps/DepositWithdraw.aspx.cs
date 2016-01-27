using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DepositWithdraw : System.Web.UI.Page
{
    string Operation = "";
    BankTeller teller;
    Bussinesslogic bll = new Bussinesslogic();
    Service client = new Service();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Operation = Request.QueryString["Op"].ToUpper();
            teller = Session["User"] as BankTeller;
            Session["IsError"] = null;

            //Session is invalid
            if (teller == null)
            {
                Response.Redirect("Default.aspx");
            }
            //Operation is missing
            else if (string.IsNullOrEmpty(Operation))
            {
                Response.Redirect("Transact.aspx");
            }
            else if (IsPostBack) 
            {
            
            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
                LoadData();
                //if teller wants to process deposit
                if (Operation == "DEPOSIT")
                {
                    ddTranCategory.Text = Operation;
                    txtFromAccount.Text = teller.TellerAccountNumber;
                    txtFromAccount.Enabled = false;
                }
                //if teller wants to process withdraw
                else
                {
                    ddTranCategory.Text = Operation;
                    txtToAccount.Text = teller.TellerAccountNumber;
                    txtToAccount.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true,Session);
        }
    }

    private void LoadData()
    {
        bll.LoadTransactionTypesIntoDropDown(teller.BankCode, ddTranCategory, teller);
        bll.LoadCurrenciesIntoDropDown(teller.BankCode, ddCurrency, teller);
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
        tran.ApprovedBy = "";
        tran.BankCode = teller.BankCode;
        tran.BranchCode = teller.BranchCode;
        tran.CustomerName = txtName.Text;
        tran.FromAccount = txtFromAccount.Text;
        tran.Narration = txtReason.Text;
        tran.Password = "";
        tran.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        tran.Teller = teller.Id;
        tran.ToAccount = txtToAccount.Text;
        tran.TranAmount = txtAmount.Text;
        tran.TranCategory = ddTranCategory.SelectedValue;
        tran.CurrencyCode = ddCurrency.SelectedValue;
        if (Operation == "Deposit")
        {
            tran.BankTranId = bll.SaveTranRequest(tran,tran.ToAccount);
        }
        else 
        {
            tran.BankTranId = bll.SaveTranRequest(tran, tran.FromAccount);
        }
       
        return tran;
    }
}