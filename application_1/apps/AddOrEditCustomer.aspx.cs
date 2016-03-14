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
        this.txtFirstName.Text = userEdited.FirstName;
        this.txtLastName.Text = userEdited.LastName;
        this.txtOtherName.Text = userEdited.OtherName;
        this.txtDateOfBirth.Text = userEdited.DateOfBirth;
        this.txtEmail.Text = userEdited.Email;
        this.txtPhoneNumber.Text = userEdited.PhoneNumber;
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
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankCustomer newUser = GetBankCustomer();
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

    private BankCustomer GetBankCustomer()
    {
        BankCustomer aCustomer = new BankCustomer();
        aCustomer.BankCode = ddBank.SelectedValue;
        aCustomer.BranchCode = ddBankBranch.SelectedValue;
        aCustomer.DateOfBirth = txtDateOfBirth.Text;
        aCustomer.Email = txtEmail.Text;
        aCustomer.FirstName = txtFirstName.Text;
        aCustomer.LastName = txtLastName.Text;
        aCustomer.OtherName = txtOtherName.Text;
        aCustomer.Gender = ddGender.Text;
        if (string.IsNullOrEmpty(txtEmail.Text)) { aCustomer.Id = txtPhoneNumber.Text; } else { aCustomer.Id = txtEmail.Text; }
        aCustomer.IsActive = ddIsActive.Text;
        aCustomer.ModifiedBy = user.Id;
        aCustomer.Password = bll.GeneratePassword();
        aCustomer.PhoneNumber = txtPhoneNumber.Text;
        aCustomer.PathToProfilePic = GetPathToProfilePicImage(ddBank.SelectedValue);
        aCustomer.PathToSignature = GetPathToImageOfSignature(ddBank.SelectedValue);
        aCustomer.ApprovedBy = user.Id;
        return aCustomer;
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
        bll.LoadBanksBranchesIntoDropDown(bankCode, ddBankBranch, user);
        ddBankBranch.Enabled = true;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            BankCustomer newUser = GetBankCustomer();
            Save(newUser);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(BankCustomer newUser)
    {
        MultiView1.ActiveViewIndex = 0;
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
}