using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditCurrency : System.Web.UI.Page
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
      
        Currency currency = client.GetById("CURRENCY", Id, BankCode, bll.BankPassword) as Currency;
        if (currency.StatusCode == "0")
        {
            this.ddBank.Text = currency.BankCode;
            this.txtCurrencyCode.Text = currency.CurrencyCode;
            this.txtCurrencyName.Text = currency.CurrencyName;
            this.txtValue.Text = currency.ValueInLocalCurrency;
        }
        else
        {
            string msg = currency.StatusDesc;
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
            Currency currency = GetCurrencyDetails();
            Result result = client.SaveCurrencyDetails(currency, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: CURRENCY WITH CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
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
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private Currency GetCurrencyDetails()
    {
        Currency currency = new Currency();
        currency.BankCode = ddBank.SelectedValue;
        currency.CurrencyCode = txtCurrencyCode.Text;
        currency.CurrencyName = txtCurrencyName.Text;
        currency.ModifiedBy = user.Id;
        currency.ValueInLocalCurrency = txtValue.Text;
        return currency;
    }
}