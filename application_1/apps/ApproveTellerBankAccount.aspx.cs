using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ApproveTellerBankAccount : System.Web.UI.Page
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
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDownALL(user.BankCode, ddBankBranch, user);
    }

    protected void btnApprove_Click(object sender, EventArgs e)
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
                        ApproveUser(row);
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

    private void ApproveUser(GridViewRow row)
    {
        //get the Bank Transaction Id and the bank code
        string UserId = row.Cells[1].Text.Trim();
        string BankCode = ddBank.SelectedValue;
        string ApprovedBy = user.Id;
        string IsActive = "True";
        string[] parameters = { UserId, BankCode, IsActive, ApprovedBy };

        Result result = bll.UpdateTellerAccountIsActiveStatus(parameters);
        if (result.StatusCode == "0")
        {
            SearchDB();
            string msg = "Customer(s) Approved Successfully";
            bll.ShowMessage(lblmsg, msg, false, Session);
        }
        else
        {
            string msg = result.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SearchDB();
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void SearchDB()
    {
        string[] parameters = GetSearchParameters();
        DataTable dt = bll.GetBankTellerAccountsPendingApproval(parameters);
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
            Multiview2.ActiveViewIndex = 1;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private string[] GetSearchParameters()
    {
        List<string> parameters = new List<string>();
        string BankCode = ddBank.SelectedValue;
        string BranchCode = ddBankBranch.SelectedValue;
        string Username = txtCustName.Text;

        parameters.Add(BankCode);
        parameters.Add(BranchCode);
        parameters.Add(Username);

        return parameters.ToArray();
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
                        RejectUser(row);
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

    private void RejectUser(GridViewRow row)
    {
        //get the Bank Transaction Id and the bank code
        string UserId = row.Cells[1].Text.Trim();
        string BankCode = ddBank.SelectedValue;
        string RejectedBy = user.Id;
        string IsActive = "False";
        string[] parameters = { UserId, BankCode, IsActive, RejectedBy };

        Result result = bll.UpdateTellerAccountIsActiveStatus(parameters);
        if (result.StatusCode == "0")
        {
            SearchDB();
            string msg = "Teller Account(s) Rejected Successfully";
            bll.ShowMessage(lblmsg, msg, false, Session);
        }
        else
        {
            string msg = result.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}