using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Transact : System.Web.UI.Page
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
        bll.LoadTransactionTypesIntoDropDown(user.BankCode, ddTranCategory, user);
        bll.LoadCurrenciesIntoDropDown(user.BankCode, ddCurrency, user);
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
        tran.ApprovedBy = user.Id;
        tran.BankCode = user.BankCode;
        tran.BranchCode = user.BranchCode;
        tran.CustomerName = txtName.Text;
        tran.FromAccount = txtFromAccount.Text;
        tran.Narration = txtReason.Text;
        tran.Password = bll.BankPassword;
        tran.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        tran.Teller = user.Id;
        tran.ToAccount = txtToAccount.Text;
        tran.TranAmount = txtAmount.Text;
        tran.TranCategory = ddTranCategory.SelectedValue;
        tran.CurrencyCode = ddCurrency.SelectedValue;
        tran.BankTranId = bll.SaveTranRequest(tran,tran.FromAccount);
        
        return tran;
    }
}