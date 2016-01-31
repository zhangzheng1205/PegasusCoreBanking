using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankAccount : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    string BankCode = "";
    string UserId = "";
    string Id = "";
    string BranchCode = "";
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            Id = Request.QueryString["Id"];
            BankCode = Request.QueryString["BankCode"];
            UserId = Request.QueryString["UserId"];
            BranchCode = Request.QueryString["BranchCode"];
            Msg = Request.QueryString["Msg"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            ////create customers bank account request
            //else if (UserId != null)
            //{
            //    LoadData();
            //    DisableControls(UserId);
            //    MultiView1.ActiveViewIndex = 0;
            //    bll.ShowMessage(lblmsg, Msg, false, Session);
            //}
            //this is an edit bank account request
            else if (Id != null)
            {
                LoadData();
                DisableControls(Id);
                LoadAccountData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;

            }
            //this is a normal create account request
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

    private void DisableControls(string UserId)
    {
        ddBank.SelectedValue = BankCode;
        ddBank.Enabled = false;
        ddBankBranch.SelectedValue = BranchCode;
        ddBankBranch.Enabled = true;
        AddSignatorySection.Visible = false;
        ddAccountType.Enabled = true;
        ddBank.Enabled = false;
        ddIsActive.Text = "False";
        ddIsActive.Enabled = true;
        ddCurrency.Enabled = false;

    }

    private void LoadAccountData(string Id, string BankCode)
    {
        BankAccount account = client.GetById("BANKACCOUNT", Id, BankCode, bll.BankPassword) as BankAccount;
        if (account.StatusCode == "0")
        {
            this.ddAccountType.SelectedValue = account.AccountType;
            this.ddBank.SelectedValue = account.BankCode;
            this.ddBankBranch.SelectedValue = account.BranchCode;
            this.ddIsActive.Text = account.IsActive;
            this.ddCurrency.SelectedValue = account.CurrencyCode;
        }
        else
        {
            string msg = account.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksIntoDropDown(user, ddBank2);
        bll.LoadBanksBranchesIntoDropDown(ddBank.SelectedValue, ddBankBranch, user);
        bll.LoadBanksBranchesIntoDropDown(ddBank.SelectedValue, ddBankBranches2, user);
        bll.LoadAccountTypesIntoDropDown(ddBank.SelectedValue, ddAccountType, user);
        bll.LoadCurrenciesIntoDropDown(ddBank.SelectedValue, ddCurrency, user);
        AddSignatorySection.Visible = true;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankAccount account = GetBankAccount();
            Result result = client.SaveBankAccountDetails(account, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                //if (string.IsNullOrEmpty(UserId))
                //{
                //create account request
                string msg = "SUCCESS: BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] SAVED SUCCESSFULLY";
                bll.ShowMessage(lblmsg, msg, false, Session);

                //Reset this so incase restarts this process they have to do it all over again
                ViewState["AccountSignatories"] = null;
                //}
                //else 
                //{
                //    //create customer request
                //    string msg = "SUCCESS: USER ID:"+UserId+" BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] CREATED SUCCESSFULLY";
                //    bll.ShowMessage(lblmsg, msg, false, Session);
                //}
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

    private BankAccount GetBankAccount()
    {
        BankAccount account = new BankAccount();
        account.AccountBalance = "0";
        account.AccountId = "";
        account.BranchCode = ddBankBranch.SelectedValue;
        account.AccountNumber = GenerateAccountNumber();
        account.AccountType = ddAccountType.SelectedValue;
        if (string.IsNullOrEmpty(Id) && string.IsNullOrEmpty(UserId))
        {
            account.IsActive = "False";
        }
        else
        {
            account.IsActive = "True";
        }
        account.BankCode = ddBank.SelectedValue;
        account.ModifiedBy = user.Id;
        account.CurrencyCode = ddCurrency.SelectedValue;
        List<string> accountSignatories = ViewState["AccountSignatories"] as List<string>;
        if (accountSignatories == null)
        {
            account.AccountSignatories = new string[] { };
        }
        else
        {
            account.AccountSignatories = accountSignatories.ToArray();
        }
        return account;
    }

    private string GenerateAccountNumber()
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
        bll.LoadBanksBranchesIntoDropDown(bankCode, ddBankBranch, user);
        ddBankBranch.Enabled = true;
    }

    protected void btnSaveCustomerDetails_Click(object sender, EventArgs e)
    {
        try
        {
            BankCustomer newUser = GetBankCustomer();
            Result result = client.SaveBankCustomerDetails(newUser, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                SaveVariablesInViewState(newUser);
                ClearCustomerDetailsPanel();            }
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

    private void ClearCustomerDetailsPanel()
    {
        txtDateOfBirth.Text = "";
        txtEmail.Text = "";
        txtPhoneNumber.Text = "";
        txtUserId.Text = "";
        txtBankUsersName.Text = "";
    }

    private void SaveVariablesInViewState(BankCustomer cust)
    {
        List<string> AccountSignatories = ViewState["AccountSignatories"] as List<string>;
        if (AccountSignatories == null)
        {
            AccountSignatories = new List<string>();
            AccountSignatories.Add(cust.Id);
           
        }
        else
        {
            AccountSignatories.Add(cust.Id);
        }
        ViewState["AccountSignatories"] = AccountSignatories;
        string msg = "CUSTOMER ADDED AS SIGNATORY. NUMBER OF SIGNATORIES ADDED: " + AccountSignatories.Count;
        bll.ShowMessage(lblmsg, msg, false, Session);
    }

    private BankCustomer GetBankCustomer()
    {
        BankCustomer aUser = new BankCustomer();
        aUser.BankCode = ddBank2.SelectedValue;
        aUser.BranchCode = ddBankBranches2.SelectedValue;
        aUser.CanHaveAccount = "False";
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = "false";
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GenerateBankPassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.Usertype = "CUSTOMER";
        aUser.TransactionLimit = "0";
        aUser.PathToProfilePic = GetPathToProfilePicImage(ddBank.SelectedValue);
        aUser.PathToSignature = GetPathToImageOfSignature(ddBank.SelectedValue);

        return aUser;
    }

    private string GetPathToProfilePicImage(string BankCode)
    {
        if (fuProfilePic.HasFile)
        {
            string fileName = fuProfilePic.FileName.ToUpper();
            if (fileName.Contains(".JPG") || fileName.Contains(".JPEG") || fileName.Contains(".PNG"))
            {
                string PathToFolderForBankLogos = Server.MapPath("Images") + @"\" + BankCode + @"\";
                bll.CreateFolderPathIfItDoesntExist(PathToFolderForBankLogos);
                string FullFileName = PathToFolderForBankLogos + fuProfilePic.FileName;
                fuProfilePic.SaveAs(FullFileName);
                return fuProfilePic.FileName;
            }
            else
            {
                throw new Exception("PLEASE UPLOAD A PROFILE PICTURE IMAGE IN .PNG OR .JPEG FORMAT");
            }
        }
        else
        {
            return "";
        }
    }

    private string GetPathToImageOfSignature(string BankCode)
    {
        if (fuProfilePic.HasFile)
        {
            string fileName = fuProfilePic.FileName.ToUpper();
            if (fileName.Contains(".JPG") || fileName.Contains(".JPEG") || fileName.Contains(".PNG"))
            {
                string PathToFolderForBankLogos = Server.MapPath("Images") + @"\" + BankCode + @"\";
                bll.CreateFolderPathIfItDoesntExist(PathToFolderForBankLogos);
                string FullFileName = PathToFolderForBankLogos + fuProfilePic.FileName;
                fuProfilePic.SaveAs(FullFileName);
                return fuProfilePic.FileName;
            }
            else
            {
                throw new Exception("PLEASE UPLOAD SCANNED SIGNATURE IMAGE IN .PNG OR .JPEG FORMAT");
            }
        }
        else
        {
            return "";
        }
    }

    protected void ddAccountType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            AccountType type = client.GetById("ACCOUNTTYPE", ddAccountType.SelectedValue, ddBank.SelectedValue, bll.BankPassword) as AccountType;
            if (type.StatusCode == "0")
            {
                string msg = ddAccountType.Text + " MUST HAVE BETWEEN " + type.MinNumberOfSignatories + " AND " + type.MaxNumberOfSignatories + " SIGNATORIES";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}