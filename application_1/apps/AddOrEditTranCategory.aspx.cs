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
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
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
            TransactionCategory category = GetTransactionCategory();
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
        catch (Exception ex)
        {
            string msg="FAILED: "+ex.Message;
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
        return category;
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue;
    }
}