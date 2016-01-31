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
    BankUser user = null;
    string fromDate = "";
    string toDate = "";
    Bank usersBank = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            user = Session["User"] as BankUser;
            usersBank = Session["UsersBank"] as Bank;
            fromDate = Session["fromDate"] as string;
            toDate = Session["toDate"] as string;
            DataTable dt = Session["StatementDataTable"] as DataTable;


            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            else
            {
                LoadData(dt);
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData(DataTable dt)
    {
        dataGridResults.DataSource = dt;
        dataGridResults.DataBind();
        dataGridResults.AllowPaging = false;
        lblBranchName.Text = "BranchName: " + user.BranchCode;
        lblPrintedBy.Text = "Printed BY: " + user.FullName;
        lblUserId.Text = "ID: [" + user.Id + "]";
        lblRole.Text = "Role: " + user.Usertype;
        lblTitle.Text = usersBank.BankName.ToUpper() + " STATEMENT";
        lblHeading.Text = "BANK STATEMENT FOR TRANSACTIONS DONE FROM [" + fromDate + "] to [" + toDate + "]";
        Session["IsError"] = null;
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Reports.aspx");
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }
}