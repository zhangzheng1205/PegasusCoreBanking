using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditTransactionRule : System.Web.UI.Page
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
            TransactionRule rule = GetTransactionRule();
            Result result = client.SaveTransactionRule(rule, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: TRANSACTION RULE CREATED WITH RULECODE = [" + result.PegPayId + "]";
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

    private TransactionRule GetTransactionRule()
    {
        TransactionRule rule = new TransactionRule();
        rule.Approver = ddApprover.SelectedValue;
        rule.BankCode = ddBank.SelectedValue;
        rule.BranchCode = ddBank.SelectedValue;
        rule.Description = "";
        rule.Id = "";
        rule.IsActive = ddIsActive.Text;
        rule.MaximumAmount = txtMaxAmount.Text;
        rule.MinimumAmount = txtMinAmount.Text;
        rule.ModifiedBy = user.Id;
        rule.RuleCode = txtRuleCode.Text;
        rule.RuleName = txtRuleName.Text;
        rule.UserId = txtUserId.Text;
        return rule;
    }
}