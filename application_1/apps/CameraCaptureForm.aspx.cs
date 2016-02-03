using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CameraCaptureForm : System.Web.UI.Page
{
    BankUser user = null;
    private void Message(string GetMessage, bool ColorRed)
    {
        Label msg = (Label)Master.FindControl("lblmsg");
        msg.Visible = true;
        if (ColorRed == true) { msg.ForeColor = System.Drawing.Color.Red; msg.Font.Bold = false; }
        else { msg.ForeColor = System.Drawing.Color.Blue; msg.Font.Bold = true; }
        if (GetMessage == ".")
        {
            msg.Text = ".";
        }
        else
        {
            msg.Text = "MESSAGE: " + GetMessage.ToUpper();
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        //Thread.Sleep(1000);
        BankUser user = Session["User"] as BankUser;
        string username = user.Id;
        string userBranchCode = user.BranchCode;
        username = username.Replace('/', '^');
        ValueHiddenField.Value = username;
        ValueHiddenFieldBranch.Value = userBranchCode;
    }


    [WebMethod]
    public static string getLoggedOnUser()
    {
        string username = (string)HttpContext.Current.Session["UserName"];
        username = username.Replace('/', '^');
        return username;
    }


    protected void btnEnrollPhoto_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "Get Status", "chechEmbeddedStatus()", true);
            if (JSStatusString.Value.Equals("1"))
            {
                string CustUserN = Request.QueryString["username"];
                Response.Redirect("./fingerPrint.aspx?username=" + CustUserN, false);
            }
            else
            {
                Message("Cannot Proceed. Please first Capture and Save Customer Photo to Proceed!", true);
            }
        }
        catch (Exception ex)
        {
            Message(ex.Message, true);
        }
    }
}