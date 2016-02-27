using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditPaymentType : System.Web.UI.Page
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
                LoadPaymentTypeData(Id, BankCode);
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

    private void LoadPaymentTypeData(string Id, string BankCode)
    {
        PaymentType type = client.GetById("PAYMENTTYPE", Id, BankCode, bll.BankPassword) as PaymentType;
        if (type.StatusCode == "0")
        {
            this.txtPaymentTypeCode.Text = type.PaymentTypeCode;
            this.txtCategoryName.Text = type.PaymentTypeName;
            ddIsActive.Text = type.IsActive;
            ddBank.Text = type.BankCode;
        }
        else
        {
            string msg = type.StatusDesc;
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
            PaymentType type = GetPaymentType();
            if (bll.Exists(type))
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else
            {
                Save(type);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            bll.ShowMessage(lblmsg, msg, false, Session);
        }
    }

    private PaymentType GetPaymentType()
    {
        PaymentType type = new PaymentType();
        type.BankCode = ddBank.SelectedValue;
        type.IsActive = ddIsActive.SelectedValue;
        type.ModifiedBy = user.Id;
        type.PaymentTypeCode = txtPaymentTypeCode.Text;
        type.PaymentTypeName = txtCategoryName.Text;
        return type;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            PaymentType type = GetPaymentType();
            Save(type);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(PaymentType type)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SavePaymentTypeDetails(type, ddBank.SelectedValue, bll.BankPassword);
        if (result.StatusCode == "0")
        {
            string msg = "PAYMENT TYPE WITH CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
            bll.ShowMessage(lblmsg, msg, false, Session);
        }
        else
        {
            string msg = type.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
   
}