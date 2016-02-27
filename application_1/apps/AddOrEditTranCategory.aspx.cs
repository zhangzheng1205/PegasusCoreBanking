using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditTranCategory : System.Web.UI.Page
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
                LoadTranCategoryData(Id, BankCode);
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

    private void LoadTranCategoryData(string Id, string BankCode)
    {
        TransactionCategory tranCategory = client.GetById("TRANSACTIONCATEGORY", Id, BankCode, bll.BankPassword) as TransactionCategory;
        if (tranCategory.StatusCode == "0")
        {
            this.txtCategoryCode.Text = tranCategory.TranCategoryCode;
            this.txtCategoryDesc.Text = tranCategory.Description;
            this.txtCategoryName.Text = tranCategory.TranCategoryName;
            ddIsActive.Text = tranCategory.IsActive;
            ddBank.Text = tranCategory.BankCode;
        }
        else
        {
            string msg = tranCategory.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            TransactionCategory category = GetTransactionCategory();
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

    private TransactionCategory GetTransactionCategory()
    {
        TransactionCategory category = new TransactionCategory();
        category.ApprovedBy = "";
        category.BankCode = ddBank.SelectedValue;
        category.Description = txtCategoryDesc.Text;
        category.Id = "";
        category.ModifiedBy = user.Id;
        category.TranCategoryCode = txtCategoryCode.Text;
        category.TranCategoryName = txtCategoryName.Text;
        category.IsActive = ddIsActive.Text;
        return category;
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            TransactionCategory category = GetTransactionCategory();
            Save(category);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(TransactionCategory category)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SaveTransactionCategoryDetails(category, user.BankCode, bll.BankPassword);
        if (result.StatusCode == "0")
        {
            string msg = "SUCCESS: TRANSACTION CATEGORY WITH CATEGORY CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
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