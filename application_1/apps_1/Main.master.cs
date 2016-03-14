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
using System.Net;

public partial class Main : System.Web.UI.MasterPage
{
    Bussinesslogic bll = new Bussinesslogic();
    BankUser user;
    Bank usersBank;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ServicePointManager.ServerCertificateValidationCallback = bll.RemoteCertificateValidation;
            if ((Session["User"] == null))
            {
                Response.Redirect("Default.aspx");
            }
            else 
            {
                LoadData();
            }
        }
        catch (NullReferenceException exe)
        {
            string Msg = exe.Message;
            Response.Redirect("Default.aspx?Msg="+Msg, false);
        }
        catch (Exception ex)
        {
            string Msg = ex.Message;
            Response.Redirect("Default.aspx?Msg="+Msg, false);
        }
    }

    private void LoadData()
    {
        user = (BankUser)Session["User"];
        usersBank = (Bank)Session["UsersBank"];
        TitleLbl.InnerHtml = "<i class=\"fa fa-bank\"></i> BANK-OS : " + usersBank.BankName.ToUpper();
        lblName.Text = user.FullName;
        lblUsersName.Text = user.FullName;
        lblUsersRole.Text = user.Usertype;
        lblCompnay.Text = usersBank.BankName;
        UserType type = bll.GetUserTypeById(user.Usertype, user.BankCode);
        if (type.StatusCode == "0") 
        {
            lblUsersRole.Text = type.UserTypeName;
        }

        BankTeller teller = user as BankTeller;
        if (teller != null) 
        {
            BankAccount account = bll.GetBankAccountById(teller.TellerAccountNumber, teller.BankCode);
            lblTellersBalance.Text = account.AccountBalance.Split('.')[0];
            lblTellerAccount.Text = teller.TellerAccountNumber;
            TellersSection.Visible = true;
        }
        else 
        {
            TellersSection.Visible = false;
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
