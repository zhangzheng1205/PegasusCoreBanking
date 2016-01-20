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
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //generate transaction request
            TransactionRequest tran = GetTranRequest();

            //does request need approval??
            if (bll.TransactionRequiresApproval(ref tran))
            {
                //send to supervisor
                //display message to user
                string msg = "Transaction Has Been Sent to Supervisor for Approval: " + tran.StatusDesc;
                //bll.SendToSupervisorForApproval(tran);
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
                    bll.UpdateBankTransactionStatus(tran.BankTranId, tran.BankCode,result.PegPayId);
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
            string msg = "Failed: "+ex.Message;
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