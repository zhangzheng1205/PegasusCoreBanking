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
using System.IO;
using InterLinkClass.EntityObjects;
using InterLinkClass.CoreBankingApi;
using System.Collections.Generic;

public partial class ReversePayments : System.Web.UI.Page
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
    }

    protected void btnReverse_Click(object sender, EventArgs e)
    {
        try
        {
            ReversePayment();
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void ReversePayment()
    {

        foreach (GridViewRow row in dataGridResults.Rows)
        {
            CheckBox ChkBox = (CheckBox)row.FindControl("CheckBox");
            if (ChkBox.Checked)
            {
                if (row.RowType != DataControlRowType.Header)
                {
                    string BankTranId = row.Cells[1].Text.Trim();
                    string BankCode = user.BankCode;
                    TransactionRequest tranRequest = new TransactionRequest();
                    tranRequest.BankCode = BankCode;
                    tranRequest.BankTranId = BankTranId;
                    Result result = client.ReverseTransaction(tranRequest);
                    if (result.StatusCode == "0")
                    {
                        string msg = "SUCCESS: Transaction with bank Id:" + BankTranId + " reversed Successfully";
                        bll.ShowMessage(lblmsg, msg, false, Session);
                    }
                    else
                    {
                        string msg = result.StatusDesc;
                        bll.ShowMessage(lblmsg, msg, true, Session);
                    }
                }
            }
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
        DataTable dt = bll.SearchTransactionRequestsTable(searchParams);
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
        string Approver = "";
        string Status = "";
        searchCriteria.Add(BankCode);
        searchCriteria.Add(BranchCode);
        searchCriteria.Add(Teller);
        searchCriteria.Add(AccountNumber);
        searchCriteria.Add(CustomerName);
        searchCriteria.Add(TransCategory);
        searchCriteria.Add(BankId);
        searchCriteria.Add(FromDate);
        searchCriteria.Add(ToDate);
        searchCriteria.Add(Approver);
        searchCriteria.Add(Status);
        return searchCriteria.ToArray();
    }


    protected void dataGridResults_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckBox ChkBoxHeader = (CheckBox)dataGridResults.HeaderRow.FindControl("chkboxSelectAll");
        foreach (GridViewRow row in dataGridResults.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("CheckBox");
            if (ChkBoxHeader.Checked == true)
            {
                ChkBoxRows.Checked = true;
            }
            else
            {
                ChkBoxRows.Checked = false;
            }
        }
    }
}
