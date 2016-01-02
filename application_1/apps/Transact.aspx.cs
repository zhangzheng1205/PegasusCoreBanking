using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Transact : System.Web.UI.Page
{
    BankUser user;
    Bussinesslogic bll = new Bussinesslogic();
    Service client = new Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            user = Session["user"] as BankUser;
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (IsPostBack)
            {

            }
            else 
            {
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            TransactionRequest tran = GetTranRequest();
            Result result = client.Transact(tran);
            if (result.StatusCode == "0")
            {
                string msg = "Transaction SUCCESS!! BANK ID: "+result.RequestId;
                bll.ShowMessage(lblmsg, msg, false);
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true);
            }
        }
        catch (Exception ex) 
        {
            string msg = ex.Message;
            bll.ShowMessage(lblmsg, msg, true);
        }
    }

    private TransactionRequest GetTranRequest()
    {
        TransactionRequest tran = new TransactionRequest();
        tran.ApprovedBy = "";
        tran.BankCode = user.BankCode;
        tran.BranchCode = user.BranchCode;
        tran.CustomerName = txtName.Text;
        tran.FromAccount = txtFromAccount.Text;
        tran.Narration = txtReason.Text;
        tran.Password = "";
        tran.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        tran.Teller = user.Id;
        tran.ToAccount = txtToAccount.Text;
        tran.TranAmount = txtAmount.Text;
        tran.TranCategory = ddTranCategory.SelectedValue;
        tran.BankTranId = bll.SaveTranRequest(tran);
        return tran;
    }
}