using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditAccountType : System.Web.UI.Page
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
        bll.LoadBanksIntoDropDown(user,ddBank);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            AccountType accType = GetAccountType();
            Result result = client.SaveAccountTypeDetails(accType,user.BankCode,bll.BankPassword);
            if (result.StatusCode == "0") 
            {
                string msg = "SUCCESS: ACCOUNT TYPE WITH CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
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

    private AccountType GetAccountType()
    {
        AccountType accType = new AccountType();
        accType.AccTypeCode = txtCategoryCode.Text;
        accType.AccTypeName = txtCategoryName.Text;
        accType.BankCode = ddBank.SelectedValue;
        accType.Description = txtCategoryDesc.Text;
        accType.Id = "";
        accType.IsDebitable = ddIsDebitable.Text;
        accType.MinimumBalance = txtMinBal.Text;
        accType.ModifiedBy = user.Id;
        accType.IsActive = ddIsActive.Text;
        return accType;
    }
}