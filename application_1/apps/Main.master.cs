using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.EntityObjects;
using InterLinkClass.CoreBankingApi;

public partial class Main : System.Web.UI.MasterPage
{
    ProcessUsers Usersdll = new ProcessUsers();
    BankUser user;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if ((Session["User"] == null))
            {
                Response.Redirect("Default.aspx");
            }
            else 
            {
                user=(BankUser)Session["User"];
                TitleLbl.InnerText = "BankName: " + user.BankCode;
                lblName.Text = user.FullName;
            }
        }
        catch (NullReferenceException exe)
        {
            Response.Redirect("Default.aspx?login=1", false);

        }
        catch (Exception ex)
        {
        }
    }

    private void Logout()
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("Default.aspx");
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Logout();
    }
    protected void btnCallSystemTool_Click(object sender, EventArgs e)
    {       
        Response.Redirect("Admin.aspx");
    }
    protected void btnCallAccountDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("SystemPassword.aspx");
    }
    protected void btnCalRecon_Click(object sender, EventArgs e)
    {
        Response.Redirect("Accountant.aspx");
    }
    protected void btnCalReports_Click(object sender, EventArgs e)
    {
        Response.Redirect("Reports.aspx");
    }
    protected void btnCallBatching_Click(object sender, EventArgs e)
    {
        Response.Redirect("Batching.aspx");
    }
    protected void btnCallPayments_Click(object sender, EventArgs e)
    {
        Response.Redirect("Payment.aspx");
    }
    protected void btnCallBatching_Click1(object sender, EventArgs e)
    {
        Response.Redirect("Billing.aspx");
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {

    }
}
