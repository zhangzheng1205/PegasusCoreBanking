using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{
    Bussinesslogic bll = new Bussinesslogic();
    BankUser user;
    Service client = new Service();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            user = Session["User"] as BankUser;
            if (user != null)
            {
                LoadData();
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblMsg, msg, true);
        }
    }

    private void LoadData()
    {
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string OldPassword = txtOldPassword.Text;
            string NewPassword = txtNewPassword.Text;
            string ConfirmedPassword = txtConfirmPassword.Text;

            if (NewPassword != ConfirmedPassword)
            {
                string msg = "Msg: Your New Password Doesnt match the confirmed Password";
                bll.ShowMessage(lblMsg, msg, true);
            }
            else if (bll.GenerateMD5Hash(OldPassword)!=user.Password)
            {
                string msg = "Msg: Your Old Password Is Incorrect";
                bll.ShowMessage(lblMsg, msg, true);
            }
            else
            {
                user.Password = bll.GenerateMD5Hash(NewPassword);
                user.ModifiedBy = user.Id;
                Result result = bll.ChangeUsersPassword(user.Id,user.BankCode,user.Password);
                if (result.StatusCode == "0")
                {
                    string msg = "Password Changed Successfully";
                    bll.ShowMessage(lblMsg, msg, false);
                }
                else 
                {
                    string msg = result.StatusDesc;
                    bll.ShowMessage(lblMsg, msg, true);
                }

            }
        }
        catch (Exception ex)
        {

            string msg="FAILED: "+ ex.Message;
            bll.ShowMessage(lblMsg, msg, true);
        }
    }
}