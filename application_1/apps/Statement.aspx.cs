using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Statement : System.Web.UI.Page
{
    Bussinesslogic bll = new Bussinesslogic();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            BankUser user = Session["User"] as BankUser;
            Bank usersBank = Session["UsersBank"] as Bank;
            string fromDate = Session["fromDate"] as string;
            string toDate = Session["toDate"] as string;
            DataTable dt = Session["StatementDataTable"] as DataTable;
            dataGridResults.DataSource = dt;
            dataGridResults.DataBind();
            dataGridResults.AllowPaging = false;
            lblBranchName.Text = "BranchName: " + user.BranchCode;
            lblPrintedBy.Text = "Printed BY: " + user.FullName ;
            lblUserId.Text = "ID: [" + user.Id + "]";
            lblRole.Text = "Role: " + user.Usertype;
            lblTitle.Text = usersBank.BankName.ToUpper() + " STATEMENT";
            lblHeading.Text = "BANK STATEMENT FOR TRANSACTIONS DONE FROM [" + fromDate + "] to [" + toDate+"]";
            Session["IsError"] = null;
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }
}