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
                string msg = "Transaction Has Been Sent to Supervisor for Approval: "+tran.StatusDesc;
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
        tran.BankTranId = bll.SaveTranRequest(tran,tran.FromAccount);
        return tran;
    }
}