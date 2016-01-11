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
            if (user == null||string.IsNullOrEmpty(Approver))
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

    protected void btnConvert_Click(object sender, EventArgs e)
    { }

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
}