using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Web;
using System.Web.Services;
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
                string parameters=Request["__EVENTARGUMENT"];
                string target = Request["__EVENTTARGET"];
                if (target.ToUpper() == "UPLOAD") 
                {
                    string[] parts = parameters.Split('|');
                    Upload(parts[1], parts[0]);
                }
            }
            //create customers bank account request
            else if (UserId != null)
            {
                LoadData();
                DisableControls2(UserId);
                MultiView1.ActiveViewIndex = 0;
                bll.ShowMessage(lblmsg, Msg, false, Session);
            }
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

    private void DisableControls2(string UserId)
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
        ddCurrency.Enabled = true;
        AddSignatorySection.Visible = false;

        List<string> accountSignatories = ViewState["AccountSignatories"] as List<string>;

        if (accountSignatories == null)
        {
            accountSignatories = new List<string>();
        }

        accountSignatories.Add(UserId);
        ViewState["AccountSignatories"] = accountSignatories;
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
        AddSignatorySection.Visible = false;

        List<string> accountSignatories = ViewState["AccountSignatories"] as List<string>;

        if (accountSignatories == null)
        {
            accountSignatories = new List<string>();
        }

        accountSignatories.Add(UserId);
        ViewState["AccountSignatories"] = accountSignatories;
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
        CaptureCustomerDetailsForm.Visible = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankAccount account = GetBankAccount();
            Result result = client.SaveBankAccountDetails(account, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                //create account request
                string msg = "SUCCESS: BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] SAVED SUCCESSFULLY";
                bll.ShowMessage(lblmsg, msg, false, Session);

                //Reset this so incase restarts this process they have to do it all over again
                ViewState["AccountSignatories"] = null;

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
        account.AccountNumber = bll.GenerateAccountNumber();
        account.AccountType = ddAccountType.SelectedValue;
        account.IsActive = ddIsActive.Text;
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
                CaptureCustomerDetailsForm.Visible = false;
                btnSubmit.Visible = true;
                ClearCustomerDetailsPanel();
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

    private void ClearCustomerDetailsPanel()
    {
        txtDateOfBirth.Text = "";
        txtEmail.Text = "";
        txtPhoneNumber.Text = "";
        txtUserId.Text = "";
        txtBankUsersName.Text = "";
        UploadProfilePicSection.Visible = true;
        UploadSignatureSection.Visible = true;
        AddSignatorySection.Visible = true;
        btnSubmit.Visible = true;
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
        aUser.ApprovedBy = user.Id;
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = ddIsActive.Text;
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GeneratePassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.PathToProfilePic = ViewState["ProfilePic"] as string;//GetPathToProfilePicImage(ddBank.SelectedValue);
        aUser.PathToSignature = ViewState["SignaturePic"] as string;//GetPathToImageOfSignature(ddBank.SelectedValue);
        aUser.NextOfKinContact = txtNextOfKinTel.Text;
        aUser.NextOfKinName = txtNextOfKinName.Text;
        aUser.MaritalStatus = ddMaritalStatus.Text;
        aUser.Nationality = txtNationality.Text;
        return aUser;
    }

    private void Upload(string base64,string PicName)
    {
        BankUser user = HttpContext.Current.Session["User"] as BankUser;
        if (user != null)
        {
            string[] parts = base64.Split(new char[] { ',' }, 2);
            Byte[] bytes = Convert.FromBase64String(parts[1]);
            string fileName = string.Format("{0}.jpg", DateTime.Now.Ticks);
            string path = HttpContext.Current.Server.MapPath("Images") + @"\" + user.BankCode + @"\" + fileName;
            
            if (PicName == "Profile")
            {
                ViewState["ProfilePic"] = fileName;
                UploadProfilePicSection.Visible = false;
                string msg = "Profile Picture Uploaded Successfully";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else 
            {
                ViewState["SignaturePic"] = fileName;
                string msg = "Customers Signature Uploaded Successfully";
                bll.ShowMessage(lblmsg, msg, false, Session);
                UploadSignatureSection.Visible = false;
            }
            System.IO.File.WriteAllBytes(path, bytes);
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
    protected void btnAddAccountSingatory_Click(object sender, EventArgs e)
    {
        try
        {
            CaptureCustomerDetailsForm.Visible = true;
            btnSubmit.Visible = false;
            AddSignatorySection.Visible = false;
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            CaptureCustomerDetailsForm.Visible = false;
            btnSubmit.Visible = true;
            AddSignatorySection.Visible = true;
        }
        catch (Exception ex)
        {

        }
    }
}