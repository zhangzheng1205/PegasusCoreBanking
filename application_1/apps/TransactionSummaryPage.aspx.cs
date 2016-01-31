using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TransactionSummaryPage : System.Web.UI.Page
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
        TransactionRequest tran = Session["TranSummary"] as TransactionRequest;
        Bank bank=Session["UsersBank"] as Bank;
        lblTitle.Text = tran.BankTranId;
        lblAmount.Text = tran.TranAmount;
        lblBankName.Text = bank.BankName;
        lblCustName.Text = tran.CustomerName;
        lblDate.Text = tran.PaymentDate;
        lblFromAccount.Text = tran.FromAccount;
        lblReason.Text = tran.Narration;
        lblToAccount.Text = tran.ToAccount;
        lblTranCategory.Text = tran.TranCategory;
        lblTeller.Text=tran.Teller;
        lblCurrency.Text = tran.CurrencyCode;
        
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try 
        {
            TransactionRequest tran = Session["TranSummary"] as TransactionRequest;
            //does request need approval??
            if (bll.TransactionRequiresApproval(ref tran))
            {
                //send to supervisor
                //display message to user
                string msg = "Transaction Has Been Sent to Supervisor for Approval: " + tran.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
            //doesnt need approval
            else
            {
                //go to core banking and move funds
                Result result = client.Transact(tran);

                //is successfull
                if (result.StatusCode == "0")
                {
                    //generate reciept
                    string msg = "SUCCESS!! BANK Transaction Id: " + result.RequestId;
                    bll.UpdateBankTransactionStatus(tran.BankTranId, tran.BankCode, result.PegPayId);
                    Session["frompage"] = Request.Url.AbsolutePath;
                    Response.Redirect("~/Receipt.aspx?Id=" + tran.BankTranId + "&BankCode=" + tran.BankCode);
                }
                //it has failed
                else
                {
                    //display error
                    string msg = result.StatusDesc;
                    bll.ShowMessage(lblmsg, msg, true, Session);
                }
            }
        }
        catch (Exception ex) 
        {
            //display error
            string msg = "Failed: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("GetAccountDetails.aspx");
        }
        catch (Exception ex)
        {
           //display error
            string msg = "Failed: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}