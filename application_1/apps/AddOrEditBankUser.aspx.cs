using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankUser : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;

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
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user,ddBank);
        if (user.Usertype != "SYS_ADMIN")
        {
            bll.LoadBanksBranchesIntoDropDown(user.BankCode,ddBankBranch,user);
            bll.LoadUsertypesIntoDropDowns(user.BankCode,ddUserType,user);
        }

    }

   

   

    

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankUser newUser = GetBankUser();
            Result result = client.SaveBankUserDetails(newUser, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: BANK USER WITH USER ID [" + result.PegPayId + "] SAVED.";
                bll.ShowMessage(lblmsg, msg, false);
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true);
        }
    }

    private BankUser GetBankUser()
    {
        BankUser aUser = new BankUser();
        aUser.BankCode = ddBank.SelectedValue;
        aUser.BranchCode = ddBankBranch.SelectedValue;
        aUser.CanHaveAccount = "False";
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = ddIsActive.Text;
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GenerateBankPassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.Usertype = ddUserType.SelectedValue;
        return aUser;
    }
    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        List<Bank> banks = (List<Bank>)HttpContext.Current.Cache["Banks"];
        string bankCode = banks[ddBank.SelectedIndex].BankCode;
        bll.LoadBanksBranchesIntoDropDown(bankCode,ddBankBranch,user);
        bll.LoadUsertypesIntoDropDowns(bankCode,ddUserType,user);
        ddUserType.Enabled = true;
        ddBankBranch.Enabled = true;

    }
}