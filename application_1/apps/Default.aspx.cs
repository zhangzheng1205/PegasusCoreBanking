using System;
using System.Data;
using System.Drawing;
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

public partial class _Default : System.Web.UI.Page
{
    Service client = new Service();
    String BankCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack)
            {
                BankCode = Request.QueryString["BankCode"];
                if (string.IsNullOrEmpty(BankCode)) 
                {
                    BankCode = "ALL";
                }
            }
            else 
            {
                //PageLoadMethod();
                //DisableBtnsOnClick();
            }
            
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message,true);
        }
    }
   
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            string UserId = txtEmail.Text;
            string Password = EncryptPassword(txtPassword.Text);

            if (string.IsNullOrEmpty(UserId)) 
            {
                ShowMessage("PLEASE SUPPLY YOUR USER ID",true);
            }
            else if (string.IsNullOrEmpty(Password))
            {
                ShowMessage("PLEASE SUPPLY YOUR PASSWORD",true);
            }
            else 
            {
                SignInUser(UserId, Password);
            }
        }
        catch (Exception ex) 
        {
            ShowMessage(ex.Message,true);
        }
    }

    private void SignInUser(string UserId, string Password)
    {
        BankUser user = (BankUser)client.GetById("BANKUSER", UserId, "ALL", "TEST");
        if (user.StatusCode == "0")
        {
            if (user.Password == Password)
            {
                Session["User"] = user;
                Response.Redirect("LoggedInStartPage.aspx");
            }
            else
            {
                ShowMessage("INVALID PASSWORD SUPPLIED",true);
            }
        }
        else
        {
            ShowMessage(user.StatusDesc,true);
        }
    }

    private string EncryptPassword(string password)
    {
        return password;
    }

    private void ShowMessage(string msg,bool IsError)
    {
        lblmsg.Text = msg;
        if (IsError)
        {
            lblmsg.ForeColor = Color.Red;
        }
        else 
        {
            lblmsg.ForeColor = Color.Green;
        }
    }
}
