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
using System.Collections.Generic;

public partial class _Default : System.Web.UI.Page
{
    Bussinesslogic bll = new Bussinesslogic();
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
                AssignSessionVariables(user);
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

    private void AssignSessionVariables(BankUser user)
    {
        Bank UsersBank = client.GetById("BANK", user.BankCode, user.BankCode, bll.BankPassword) as Bank;
        List<string> allowedAreas = bll.GetAllowedAreas(user.Usertype, user.BankCode);

        if (user.Usertype == "SYS_ADMIN") 
        {
            SetSysAdminSession(ref UsersBank,ref allowedAreas, user);
        }
        if (UsersBank.StatusCode != "0")
        {
            throw new Exception("Unable To Determine Your Bank. Please contact System Administrator");
        }
        else if (allowedAreas.Count == 0)
        {
            throw new Exception("Unable To Determine Your Access Rights. Please contact System Administrator");
        }
        else
        {
            Session["User"] = user;
            Session["UsersBank"] = UsersBank;
            Session["AllowedAreas"] = allowedAreas;
            Response.Redirect("LoggedInStartPage.aspx", false);
        }
    }

    private void SetSysAdminSession(ref Bank UsersBank,ref List<string> allowedAreas,BankUser user)
    {
        if (user.Usertype == "SYS_ADMIN") 
        {
            if (UsersBank.StatusCode!="0")
            {
                UsersBank = new Bank();
                UsersBank.BankName = "PEGASUS TECH";
                UsersBank.BankCode = "PEGASUS";
                UsersBank.BankContactEmail = "kasozi.nsobya@pegasustechnologies.co.ug";
                UsersBank.BankPassword = "T3rr1613";
                UsersBank.IsActive = "True";
                UsersBank.ModifiedBy = "admin";
                UsersBank.PathToLogoImage = "Billing.jpg";
                UsersBank.PathToPublicKey = "";
                UsersBank.StatusCode = "0";
                UsersBank.StatusDesc = "SUCCESS";
                allowedAreas.Add("SYS_ADMIN");
                allowedAreas.Add("REPORTS");
            }
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
