using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditChargeType : System.Web.UI.Page
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
                LoadChargeTypeData(Id, BankCode);
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

    private void LoadChargeTypeData(string Id, string BankCode)
    {
        ChargeType type = client.GetById("CHARGETYPE", Id, BankCode, bll.BankPassword) as ChargeType;
        if (type.StatusCode == "0")
        {
            this.ddBank.Text = type.BankCode;
            this.ddIsActive.Text = type.IsActive;
            this.txtCategoryCode.Text = type.ChargeTypeCode;
            this.txtCategoryDesc.Text = type.Description;
            this.txtCategoryName.Text = type.ChargeTypeName;
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
            ChargeType type = GetChargeType();
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
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private ChargeType GetChargeType()
    {
        ChargeType accType = new ChargeType();
        accType.ChargeTypeCode = txtCategoryCode.Text;
        accType.ChargeTypeName = txtCategoryName.Text;
        accType.BankCode = ddBank.SelectedValue;
        accType.Description = txtCategoryDesc.Text;
        accType.ModifiedBy = user.Id;
        accType.IsActive = ddIsActive.Text;
        return accType;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            ChargeType type = GetChargeType();
            Save(type);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void Save(ChargeType type)
    {
        MultiView1.ActiveViewIndex = 0;
        Result result = client.SaveChargeTypeDetails(type, user.BankCode, bll.BankPassword);
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //send fresh request to this very page
        Server.TransferRequest(Request.Url.AbsolutePath, false);
    }
}