using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditUserType : System.Web.UI.Page
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
            //this is an edit request
            else if (Id != null)
            {
                LoadData();
                LoadUserTypeData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;
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

    private void LoadUserTypeData(string Id, string BankCode)
    {
        UserType type = client.GetById("USERTYPE", Id, BankCode, bll.BankPassword) as UserType;
        if (type.StatusCode == "0")
        {
            this.txtCategoryCode.Text = type.UserTypeCode;
            this.txtCategoryName.Text = type.UserTypeName;
            this.txtCategoryDesc.Text = type.Description;
            this.ddBank.Text = type.BankCode;
            this.ddIsActive.Text = type.IsActive;
        }
        else 
        {
            string msg = type.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
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
            UserType category = GetUserType();
            if (bll.Exists(category))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                Save(category);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private UserType GetUserType()
    {
        UserType category = new UserType();
        category.BankCode = ddBank.SelectedValue;
        category.Description = txtCategoryDesc.Text;
        category.Id = "";
        category.Role = txtCategoryCode.Text;
        category.UserTypeCode = txtCategoryCode.Text;
        category.UserTypeName = txtCategoryName.Text;
        category.IsActive = ddIsActive.SelectedValue;
        category.ModifiedBy = user.Id;
        return category;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {

            UserType category = GetUserType();
            Save(category);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(UserType category)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SaveUserTypeDetails(category, user.BankCode, bll.BankPassword);
        if (result.StatusCode == "0")
        {
            string msg = "SUCCESS: USER CATEGORY WITH CATEGORY CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
            bll.ShowMessage(lblmsg, msg, false, Session);
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