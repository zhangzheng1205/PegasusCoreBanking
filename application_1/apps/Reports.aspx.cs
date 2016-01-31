using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.CoreBankingApi;
using System.Collections.Generic;

public partial class Reports : System.Web.UI.Page
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
                LoadAccountStatement(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;

            }
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
                Multiview2.ActiveViewIndex = 1;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadAccountStatement(string Id, string BankCode)
    {
        this.txtAccount.Text = Id;
        this.ddBank.SelectedValue = BankCode;
        this.ddBank.Enabled = false;
        this.ddBankBranch.Enabled = false;
        this.txtAccount.Enabled = false;
        SearchDb();
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDownALL(ddBank.SelectedValue, ddBankBranch, user);
        bll.LoadTransactionTypesIntoDropDownALL(ddBank.SelectedValue, ddTranCategory, user);
        if (user.Usertype == "TELLER")
        {
            txtTeller.Text = user.Id;
            txtTeller.Enabled = false;
        }
        else 
        {
            txtTeller.Text = "";
            txtTeller.Enabled = true;
        }
    }

    protected void btnConvert_Click(object sender, EventArgs e)
    {
        try
        {
            string[] searchParams = GetSearchParameters();
            DataTable dt = bll.SearchGeneralLedgerTable(searchParams);
            if (dt.Rows.Count > 0)
            {
                SetSessionVariables(dt);
                string msg = "Found " + dt.Rows.Count + " Records Matching Search Criteria";
                Response.Redirect("Statement.aspx");
            }
            else
            {
                string msg = "No Records Found Matching Search Criteria";
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void SetSessionVariables(DataTable dt)
    {
        Session["StatementDataTable"] = dt;
        if (string.IsNullOrEmpty(txtFromDate.Text) || string.IsNullOrEmpty(txtToDate.Text))
        {
            Session["fromDate"] = "THE START";
            Session["toDate"] = "TO TODAY";
        }
        else
        {
            Session["fromDate"] = txtFromDate.Text;
            Session["toDate"] = txtToDate.Text;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SearchDb();
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void SearchDb()
    {
        string[] searchParams = GetSearchParameters();
        DataTable dt = bll.SearchGeneralLedgerTable(searchParams);
        if (dt.Rows.Count > 0)
        {
            dataGridResults.DataSource = dt;
            dataGridResults.DataBind();
            string msg = "Found " + dt.Rows.Count + " Records Matching Search Criteria";
            Multiview2.ActiveViewIndex = 0;
            bll.ShowMessage(lblmsg, msg, false, Session);
        }
        else
        {
            dataGridResults.DataSource = null;
            dataGridResults.DataBind();
            string msg = "No Records Found Matching Search Criteria";
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private string[] GetSearchParameters()
    {
        List<string> searchCriteria = new List<string>();
        string BankCode = ddBank.SelectedValue;
        string BranchCode = ddBankBranch.SelectedValue;
        string Teller = txtTeller.Text;
        string AccountNumber = txtAccount.Text;
        string CustomerName = txtCustName.Text;
        string TransCategory = ddTranCategory.SelectedValue;
        string BankId = txtBankTranId.Text;
        string PegPayId = txtPegPayId.Text;
        string FromDate = txtFromDate.Text;
        string ToDate = txtToDate.Text;
        searchCriteria.Add(BankCode);
        searchCriteria.Add(BranchCode);
        searchCriteria.Add(Teller);
        searchCriteria.Add(AccountNumber);
        searchCriteria.Add(CustomerName);
        searchCriteria.Add(TransCategory);
        searchCriteria.Add(BankId);
        searchCriteria.Add(PegPayId);
        searchCriteria.Add(FromDate);
        searchCriteria.Add(ToDate);
        return searchCriteria.ToArray();
    }

    protected void ddBank_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bll.LoadBanksBranchesIntoDropDownALL(ddBank.SelectedValue, ddBankBranch, user);
            bll.LoadTransactionTypesIntoDropDownALL(ddBank.SelectedValue, ddTranCategory, user);
            ddBankBranch.Enabled = true;
            ddTranCategory.Enabled = true;
            btnSubmit.Enabled = true;
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}