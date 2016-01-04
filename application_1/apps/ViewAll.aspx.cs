using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewAll : System.Web.UI.Page
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
        LoadReportTypesIntoDropDown();
    }

    private void LoadReportTypesIntoDropDown()
    {
        ddReporttype.Items.Clear();
        ddReporttype.Items.Add(new ListItem("BANK TELLERS","BANK_TELLERS"));
        ddReporttype.Items.Add(new ListItem("BANK CUSTOMERS", "BANK_CUSTOMERS"));
        ddReporttype.Items.Add(new ListItem("TRANSACTION CATEGORIES", "TRAN_CATEGORIES"));
        ddReporttype.Items.Add(new ListItem("USER TYPES", "USER_TYPES"));
        ddReporttype.Items.Add(new ListItem("ACCOUNT TYPES", "ACCOUNT_TYPES"));
    }

    protected void btnConvert_Click(object sender, EventArgs e)
    { 
    
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] parameters = GetSearchCriteria();
            DataTable dt = bll.SearchAll(parameters, ddReporttype.SelectedValue);
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

    private string[] GetSearchCriteria()
    {
        List<string> searchCriteria = new List<string>();
        string BankCode = ddBank.SelectedValue;
        string Name = txtName.Text;
        string ReportType = ddReporttype.SelectedValue;
        if (ReportType == "BANK_TELLERS") 
        {
            string UserType = "TELLER";
            searchCriteria.Add(BankCode);
            searchCriteria.Add(UserType);
            searchCriteria.Add(Name);
            return searchCriteria.ToArray();
        }
        return searchCriteria.ToArray();

    }
}