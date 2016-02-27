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
                MultiView1.ActiveViewIndex = 0;
                LoadAccountTypeData(Id, BankCode);
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

    private void LoadAccountTypeData(string Id, string BankCode)
    {
        AccountType type = client.GetById("ACCOUNTTYPE", Id, BankCode, bll.BankPassword) as AccountType;
        if (type.StatusCode == "0")
        {
            this.ddBank.Text = type.BankCode;
            this.ddIsActive.Text = type.IsActive;
            this.ddIsDebitable.Text = type.IsDebitable;
            this.txtCategoryCode.Text = type.AccTypeCode;
            this.txtCategoryDesc.Text = type.Description;
            this.txtCategoryName.Text = type.AccTypeName;
            this.txtMinBal.Text = type.MinimumBalance;
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
            AccountType accType = GetAccountType();
            if (bll.Exists(accType))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                Save(accType);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(AccountType accType)
    {
        Result result = client.SaveAccountTypeDetails(accType, user.BankCode, bll.BankPassword);
        MultiView1.ActiveViewIndex = 0;
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
        accType.MaxNumberOfSignatories = Convert.ToInt32(ddMaxSignatories.SelectedValue);
        accType.MinNumberOfSignatories = Convert.ToInt32(ddMinSignatories.SelectedValue);
        return accType;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            AccountType accType = GetAccountType();
            Save(accType);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
}