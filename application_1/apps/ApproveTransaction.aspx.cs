using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ApproveTransaction : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    string Approver = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;
            Approver = Request.QueryString["Approver"];

            //Session is invalid
            if (user == null || string.IsNullOrEmpty(Approver))
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
                Multiview2.ActiveViewIndex = 1;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDownALL(user, ddBank);
        bll.LoadBanksBranchesIntoDropDownALL(user.BankCode, ddBankBranch, user);
        bll.LoadTransactionTypesIntoDropDownALL(user.BankCode, ddTranCategory, user);
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            ApproveTransactions();
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void ApproveTransactions()
    {
        //loop thru the rows
        foreach (GridViewRow row in dataGridResults.Rows)
        {
            //for each row get the checkbox attached
            CheckBox ChkBox = (CheckBox)row.FindControl("CheckBox");

            //has user ticked the box
            if (ChkBox.Checked)
            {
                //if this row is not the header row
                if (row.RowType != DataControlRowType.Header)
                {
                    try
                    {
                        //send reversal request
                        ApproveTransactionRequest(row);
                    }
                    catch (Exception ex)
                    {
                        string msg = "FAILED: " + ex.Message;
                        bll.ShowMessage(lblmsg, msg, true, Session);
                    }
                }
            }
        }
    }

    private void ApproveTransactionRequest(GridViewRow row)
    {
        //get the Bank Transaction Id and the bank code
        string BankTranId = row.Cells[1].Text.Trim();
        string BankCode = ddBank.SelectedValue;

        //send transact request
        TransactionRequest tran = bll.GetTransactionRequest(BankTranId, BankCode, user.Id);
        Result result = client.Transact(tran);

        //success
        if (result.StatusCode == "0")
        {
            //generate reciept
            string msg = "SUCCESS!! BANK Transaction Id: " + result.RequestId;
            bll.UpdateBankTransactionStatus(tran.BankTranId, tran.BankCode, result.PegPayId,"SUCCESS");
            Response.Redirect("~/Receipt.aspx?Id=" + tran.BankTranId + "&BankCode=" + tran.BankCode);
        }
        else
        {
            //display error
            string msg = result.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }

    }

    protected void dataGridResults_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
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
                string msg = "No Records Found Matching Search Criteria";
                Multiview2.ActiveViewIndex = 1;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
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
        string FromDate = txtFromDate.Text;
        string ToDate = txtToDate.Text;
        string Status = "PENDING";
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

    protected void btnReject_Click(object sender, EventArgs e)
    {
        //loop thru the rows
        foreach (GridViewRow row in dataGridResults.Rows)
        {
            //for each row get the checkbox attached
            CheckBox ChkBox = (CheckBox)row.FindControl("CheckBox");

            //has user ticked the box
            if (ChkBox.Checked)
            {
                //if this row is not the header row
                if (row.RowType != DataControlRowType.Header)
                {
                    try
                    {
                        //send reversal request
                        RejectTransactionRequest(row);
                    }
                    catch (Exception ex)
                    {
                        string msg = "FAILED: " + ex.Message;
                        bll.ShowMessage(lblmsg, msg, true, Session);
                    }
                }
            }
        }
    }

    private void RejectTransactionRequest(GridViewRow row)
    {
        //get the Bank Transaction Id and the bank code
        string BankTranId = row.Cells[1].Text.Trim();
        string BankCode = ddBank.SelectedValue;
        string Status = "Rejected";
        string RejectedBy = user.Id;
        string Reason = "Rejected By " + RejectedBy;

        //send transact request
        bll.UpdateBankTransactionStatus(BankTranId, BankCode, Reason, Status);
        string msg = "Successfully Rejected Transaction " + BankTranId;
        bll.ShowMessage(lblmsg, msg, false, Session);
    }
}