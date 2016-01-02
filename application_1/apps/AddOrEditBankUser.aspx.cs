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
        LoadBanksIntoDropDown();
        if (user.Usertype != "SYS_ADMIN")
        {
            LoadBanksBranchesIntoDropDown(user.BankCode);
            LoadUsertypesIntoDropDowns(user.BankCode);
        }

    }

    private void LoadUsertypesIntoDropDowns(string bankCode)
    {
        List<UserType> userTypes = new List<UserType>();
        BaseObject[] bo = client.GetAll("UserType", bankCode, bll.BankPassword);
        foreach (BaseObject obj in bo)
        {
            UserType usertype = obj as UserType;
            ddUserType.Items.Add(new ListItem(usertype.Usertype));
            userTypes.Add(usertype);
        }

        List<UserType> filtered = userTypes.FindAll(delegate(UserType p) { return p.BankCode == bankCode; });
        ddUserType.Items.Clear();

        foreach (UserType b in filtered)
        {
            ddUserType.Items.Add(new ListItem(b.Usertype));
        }
        HttpContext.Current.Cache.Insert("UserTypes", filtered);
    }

    private void LoadBanksBranchesIntoDropDown(string bankCode)
    {
        List<BankBranch> bankBranches = new List<BankBranch>();
        BaseObject[] bo = client.GetAll("BankBranch", bankCode, bll.BankPassword);

        foreach (BaseObject obj in bo)
        {
            BankBranch branch = obj as BankBranch;
            bankBranches.Add(branch);
        }

        List<BankBranch> filtered= bankBranches.FindAll(delegate(BankBranch p) { return p.BankCode == bankCode; });
        ddBankBranch.Items.Clear();

        foreach (BankBranch b in filtered) 
        {
            ddBankBranch.Items.Add(new ListItem(b.BranchName));
        }
        HttpContext.Current.Cache.Insert("BankBranches", filtered);
    }

    private void LoadBanksIntoDropDown()
    {
        List<Bank> banks = new List<Bank>();
        BaseObject[] bo = client.GetAll("Bank", user.BankCode, bll.BankPassword);
        foreach (BaseObject obj in bo)
        {
            Bank bank = obj as Bank;
            ddBank.Items.Add(new ListItem(bank.BankName));
            banks.Add(bank);
        }
        if (user.Usertype.ToUpper() != "SYS_ADMIN")
        {
            ddBank.SelectedValue = banks.Find(delegate(Bank p) { return p.BankCode == user.BankCode; }).BankName;
            ddBank.Enabled = false;
        }
        HttpContext.Current.Cache.Insert("Banks", banks);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankUser newUser = GetBankUser();
            Result result = client.SaveBankUserDetails(newUser, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: BANK USER WITH USER ID:" + result.PegPayId + " SAVED.";
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
        aUser.BankCode = ddBank.Text;
        aUser.BranchCode = ddBankBranch.Text;
        aUser.CanHaveAccount = "";
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = ddIsActive.Text;
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GenerateBankPassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.Usertype = ddUserType.Text;
        return aUser;
    }
    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        List<Bank> banks = (List<Bank>)HttpContext.Current.Cache["Banks"];
        string bankCode = banks[ddBank.SelectedIndex].BankCode;
        LoadBanksBranchesIntoDropDown(bankCode);
        LoadUsertypesIntoDropDowns(bankCode);
        ddUserType.Enabled = true;
        ddBankBranch.Enabled = true;

    }
}