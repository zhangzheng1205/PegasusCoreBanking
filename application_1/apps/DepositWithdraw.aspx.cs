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
                //if teller wants to process deposit
                if (Operation == "DEPOSIT")
                {
                    txtFromAccount.Text = teller.TellerAccountNumber;
                    txtFromAccount.Enabled = false;
                }
                //if teller wants to process withdraw
                else
                {
                    txtToAccount.Text = teller.TellerAccountNumber;
                    txtToAccount.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //build transaction request
            TransactionRequest tran = GetTranRequest();
            Result result = client.Transact(tran);

            //success in core banking
            if (result.StatusCode == "0")
            {
                //print reciept
                string msg = "Transaction SUCCESS!! BANK ID: " + result.RequestId;
                bll.ShowMessage(lblmsg, msg, false);
            }
            else
            {
                //show error msg
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true);
            }
        }
        catch (Exception ex)
        {
            //show error msg
            string msg = ex.Message;
            bll.ShowMessage(lblmsg, msg, true);
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
        tran.BankTranId = bll.SaveTranRequest(tran);
        return tran;
    }
}