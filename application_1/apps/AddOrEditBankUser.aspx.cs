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
    string Id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            Id = Request.QueryString["Id"];
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
            else if (!string.IsNullOrEmpty(Id))
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
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
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
        bll.LoadBanksBranchesIntoDropDown(ddBank.SelectedValue, ddBankBranch, user);
        bll.LoadUsertypesIntoDropDowns(ddBank.SelectedValue, ddUserType, user);
        CustomersSection.Visible = false;
        TellersSection.Visible = false;
        txtTranLimit.Text = "0";
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
                throw new Exception("PLEASE UPLOAD A BANK LOGO IMAGE IN .PNG OR .JPEG FORMAT");
            }
        }
        else
        {
            return "";
        }
    }



    private void DisableControls(string UserId)
    {
        //ddUserType.Enabled = false;
        txtUserId.Text = UserId;
        txtUserId.Enabled = false;
    }





    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankUser newUser = GetBankUser();
            if (bll.Exists(newUser))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                Save(newUser);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private BankUser GetBankUser()
    {
        BankUser aUser = new BankUser();
        aUser.BankCode = ddBank.SelectedValue;
        aUser.BranchCode = ddBankBranch.SelectedValue;
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = ddIsActive.Text;
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GeneratePassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.Usertype = ddUserType.SelectedValue;
        aUser.TransactionLimit = txtTranLimit.Text;
        aUser.ApprovedBy = user.Id;
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
    protected void ddUserType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddUserType.SelectedValue == "CUSTOMER")
            {
                CustomersSection.Visible = true;
                TellersSection.Visible = false;
                txtTranLimit.Text = "0";
            }
            else if (ddUserType.SelectedValue == "TELLER")
            {
                CustomersSection.Visible = false;
                TellersSection.Visible = true;
                txtTranLimit.Text = "";
            }
            else
            {
                CustomersSection.Visible = false;
                TellersSection.Visible = false;
                txtTranLimit.Text = "0";
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            BankUser newUser = GetBankUser();
            Save(newUser);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(BankUser newUser)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SaveBankUserDetails(newUser, user.BankCode, bll.BankPassword);
        if (result.StatusCode == "0")
        {

            string msg = "SUCCESS: " + newUser.Usertype + " USER WITH ID [" + result.PegPayId + "] SAVED.";
            bll.ShowMessage(lblmsg, msg, false, Session);

            if (ddSendEmail.Text == "YES")
            {
                bll.SendBankUserCredentialsEmail(newUser);
            }
        }
        else
        {
            string msg = result.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
}