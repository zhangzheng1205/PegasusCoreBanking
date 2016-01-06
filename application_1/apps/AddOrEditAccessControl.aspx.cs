using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditAccessControl : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }

            else if (IsPostBack)
            {

            }
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadUsertypesIntoDropDownsALL(user.BankCode, ddUserType, user);
        bll.LoadAccessAreasIntoDropDownsALL(user.BankCode, ddAccessAreas, user);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] parameters = GetAccessRuleDetails();
            Result result = bll.SaveAccessRule(parameters);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: Access Rule Saved";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else 
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private string[] GetAccessRuleDetails()
    {
        List<string> all = new List<string>();
        string AllowedAreas = txtAllowedAreas.Text;
        string UserType = ddUserType.SelectedValue;
        string BankCode = ddBank.SelectedValue;
        string UserId = txtUserId.Text;
        all.Add(UserType);
        all.Add(BankCode);
        all.Add(AllowedAreas);
        all.Add(UserId);
        return all.ToArray();
    }


    public void btnAddAccessArea_Click(object sender, EventArgs e)
    {
        try
        {
            string Area = ddAccessAreas.SelectedValue;
            string allowedAreas = txtAllowedAreas.Text;
            if (string.IsNullOrEmpty(allowedAreas))
            {
                txtAllowedAreas.Text = Area;
            }
            else
            {
                txtAllowedAreas.Text = allowedAreas + "," + Area;
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}