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
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            string Id = Request.QueryString["Id"];
            string BankCode = Request.QueryString["BankCode"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            //this is an edit Bank User request
            else if (Id != null)
            {
                LoadData();
                DisableControls(Id);
                MultiView1.ActiveViewIndex = 0;
                LoadUserData(Id, BankCode);
            }
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true,Session);
        }
    }

    private void LoadUserData(string Id, string BankCode)
    {

        BankUser userEdited = client.GetById("BankUser", Id, BankCode, bll.BankPassword) as BankUser;
        if (userEdited.StatusCode == "0")
        {
            FillFormWithData(userEdited);
        }
        else
        {
            string msg = userEdited.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void FillFormWithData(BankUser userEdited)
    {
        this.txtBankUsersName.Text = userEdited.FullName;
        this.txtDateOfBirth.Text = userEdited.DateOfBirth;
        this.txtEmail.Text = userEdited.Email;
        this.txtPhoneNumber.Text = userEdited.PhoneNumber;
        this.txtUserId.Text = userEdited.Id;
        this.ddBank.Text = userEdited.BankCode;
        this.ddBankBranch.Text = userEdited.BranchCode;
        this.ddGender.Text = userEdited.Gender;
        this.ddIsActive.Text = userEdited.IsActive;
        this.ddUserType.Text = userEdited.Usertype;

    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBankBranch, user);
        bll.LoadUsertypesIntoDropDowns(user.BankCode, ddUserType, user);

    }

    private void DisableControls(string UserId)
    {
        ddIsActive.Text = "False";
        ddIsActive.Enabled = false;
        txtUserId.Text = UserId;
        txtUserId.Enabled = false;
    }





    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankUser newUser = GetBankUser();
            Result result = client.SaveBankUserDetails(newUser, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                if (newUser.Usertype.Contains("CUSTOMER"))
                {
                    Response.Redirect("~/AddOrEditBankAccount.aspx?UserId=" + newUser.Id + "&BankCode=" + newUser.BankCode + "&BranchCode=" + newUser.BranchCode + "&Msg=CREATE A CUSTOMER ACCOUNT FOR THIS CUSTOMER");
                }
                else if (newUser.Usertype.Contains("TELLER"))
                {
                    Response.Redirect("~/AddOrEditBankAccount.aspx?UserId=" + newUser.Id + "&BankCode=" + newUser.BankCode + "&BranchCode=" + newUser.BranchCode+"&Msg=CREATE A TELLER ACCOUNT FOR THIS USER");
                }
                else
                {
                    string msg = "SUCCESS: BANK USER WITH USER ID [" + result.PegPayId + "] SAVED.";
                    bll.ShowMessage(lblmsg, msg, false,Session);
                }
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true,Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true,Session);
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
        string bankCode = ddBank.SelectedValue;
        bll.LoadBanksBranchesIntoDropDown(bankCode, ddBankBranch, user);
        bll.LoadUsertypesIntoDropDowns(bankCode, ddUserType, user);
        ddUserType.Enabled = true;
        ddBankBranch.Enabled = true;

    }
}