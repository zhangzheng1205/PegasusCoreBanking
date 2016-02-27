using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankCharges : System.Web.UI.Page
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
                LoadChargeData(Id, BankCode);
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
            bll.ShowMessage(lblmsg, ex.Message, true,Session);
        }
    }

    private void LoadChargeData(string Id, string BankCode)
    {
        BankCharge charge = client.GetById("BANKCHARGE", Id, BankCode, bll.BankPassword) as BankCharge;
        if (charge.StatusCode == "0")
        {
            this.ddBank.SelectedValue = charge.BankCode;
            this.ddComAccount.Text = charge.CommissionAccountNumber;
            this.ddIsActive.Text = charge.IsActive;
            this.ddIsDebit.Text = charge.IsDebit;
            this.ddTranCategory.SelectedValue = charge.TransCategory;
            this.txtChargeAmount.Text = charge.ChargeAmount;
            this.txtChargeCode.Text = charge.ChargeCode;
            this.txtChargeDesc.Text = charge.ChargeDescription;
            this.txtChargeName.Text = charge.ChargeName;
            this.ddAccountType.SelectedValue = charge.AccountType;
            this.ddChargeType.SelectedValue = charge.ChargeType;
        }
        else 
        {
            string msg = charge.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDownALL(user, ddBank);
        if (user.Usertype == "SYS_ADMIN")
        {
            //disbale these submit btn till the sys admin can select a bank
            ddComAccount.Items.Clear();
            ddTranCategory.Items.Clear();// = false;
            ddAccountType.Items.Clear();
            ddChargeType.Items.Clear();
            btnSubmit.Enabled = false;
        }
        else 
        {
            bll.LoadCommissionAccountsIntoDropDown(user.BankCode, ddComAccount, user);
            bll.LoadTransactionTypesIntoDropDown(user.BankCode, ddTranCategory, user);
            bll.LoadAccountTypesIntoDropDownALL(user.BankCode, ddAccountType, user);
            bll.LoadChargeTypesIntoDropDown(user.BankCode, ddChargeType, user);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankCharge charge = GetBankCharge();
            if (bll.Exists(charge))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {

                Save(charge);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg,msg, true,Session);
        }
    }

    private BankCharge GetBankCharge()
    {
        BankCharge charge = new BankCharge();
        charge.BankCode = ddBank.SelectedValue;
        charge.ChargeAmount = txtChargeAmount.Text;
        charge.ChargeCode = txtChargeCode.Text;
        charge.ChargeDescription = txtChargeDesc.Text;
        charge.ChargeName = txtChargeName.Text;
        charge.CommissionAccountNumber = ddComAccount.SelectedValue;
        charge.Id = "";
        charge.IsActive = ddIsActive.Text;
        charge.IsDebit = ddIsDebit.Text;
        charge.ModifiedBy = user.Id;
        charge.TransCategory = ddTranCategory.SelectedValue;
        charge.AccountType = ddAccountType.SelectedValue;
        charge.ChargeType = ddChargeType.SelectedValue;
        return charge;
    }
    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        string bankCode = ddBank.SelectedValue.ToUpper();
        if (bankCode != "ALL")
        {
            bll.LoadTransactionTypesIntoDropDown(bankCode, ddTranCategory, user);
            bll.LoadCommissionAccountsIntoDropDown(bankCode, ddComAccount, user);
            bll.LoadAccountTypesIntoDropDown(bankCode, ddAccountType, user);
            bll.LoadChargeTypesIntoDropDown(bankCode, ddChargeType, user);
            btnSubmit.Enabled = true;
        }
        else 
        {
            //disbale these submit btn till the sys admin can select a bank
            ddComAccount.Items.Clear();
            ddTranCategory.Items.Clear();// = false;
            btnSubmit.Enabled = false;
        }
    }

    protected void txtEmail_TextChanged(object sender, EventArgs e)
    {

    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            BankCharge charge = GetBankCharge();
            Save(charge);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(BankCharge charge)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SaveBankChargeDetails(charge, charge.BankCode, bll.BankPassword);
        if (result.StatusCode == "0")
        {
            string msg = "SUCCESS: BANK CHARGE WITH CHARGECODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
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