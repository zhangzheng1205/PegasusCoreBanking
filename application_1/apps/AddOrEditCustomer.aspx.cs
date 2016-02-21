using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditCustomer : System.Web.UI.Page
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
       

    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBankBranch, user);
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
            BankCustomer newUser = GetBankCustomer();
            Result result = client.SaveBankCustomerDetails(newUser, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                Response.Redirect("~/AddOrEditBankAccount.aspx?UserId=" + newUser.Id + "&BankCode=" + newUser.BankCode + "&BranchCode=" + newUser.BranchCode + "&Msg=CREATE A CUSTOMER ACCOUNT FOR THIS CUSTOMER");
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

    private BankCustomer GetBankCustomer()
    {
        BankCustomer aUser = new BankCustomer();
        aUser.BankCode = ddBank.SelectedValue;
        aUser.BranchCode = ddBankBranch.SelectedValue;
        aUser.CanHaveAccount = "False";
        aUser.DateOfBirth = txtDateOfBirth.Text;
        aUser.Email = txtEmail.Text;
        aUser.FullName = txtBankUsersName.Text;
        aUser.Gender = ddGender.Text;
        aUser.Id = txtUserId.Text;
        aUser.IsActive = "false";
        aUser.ModifiedBy = user.Id;
        aUser.Password = bll.GeneratePassword();
        aUser.PhoneNumber = txtPhoneNumber.Text;
        aUser.Usertype = "CUSTOMER";
        aUser.TransactionLimit = "0";
        aUser.PathToProfilePic = GetPathToProfilePicImage(ddBank.SelectedValue);
        aUser.PathToSignature = GetPathToImageOfSignature(ddBank.SelectedValue);
        return aUser;
    }
    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
        bll.LoadBanksBranchesIntoDropDown(bankCode, ddBankBranch, user);
        ddBankBranch.Enabled = true;
    }
}