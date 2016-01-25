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

            //------------------------------------------------
            //Check if this is an Edit Request
            string EditType = Request.QueryString["EditType"];
            string Id = Request.QueryString["Id"];
            string BankCode = Request.QueryString["BankCode"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            //is this a PostBack
            else if (IsPostBack)
            {
                
            }
            //if this guy isnt empty then this is an Edit Request
            else if (EditType!=null)
            {
                RouteRequestToCorrectEditPage(EditType, Id, BankCode);
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

    private void RouteRequestToCorrectEditPage(string EditType, string Id, string BankCode)
    {
        if (EditType == "TELLER") 
        {
            string url = "~/AddOrEditBankUser.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "CUSTOMER")
        {
            string url = "~/AddOrEditCustomer.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "")
        {
            string url = "~/AddOrEditBank.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "TRANSACTIONCATEGORY")
        {
            string url = "~/AddOrEditTranCategory.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "USERTYPE")
        {
            string url = "~/AddOrEditUserType.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "ACCOUNTTYPE")
        {
            string url = "~/AddOrEditAccountType.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "ACCOUNT")
        {
            string url = "~/AddOrEditBankAccount.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "BRANCHES")
        {
            string url = "~/AddOrEditBankBranch.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else if (EditType == "CHARGES")
        {
            string url = "~/AddOrEditBankCharges.aspx?Id=" + Id + "&BankCode=" + BankCode;
            Server.Transfer(url);
        }
        else 
        {
            throw new Exception("UNABLE TO DETERMINE CORRECT EDIT PAGE TO ROUTE REQUEST TO");
        }

    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDownALL(user, ddBank);
        LoadReportTypesIntoDropDown();
    }

    private void LoadReportTypesIntoDropDown()
    {
        //think of moving these to DB
        ddReporttype.Items.Clear();
        ddReporttype.Items.Add(new ListItem("", ""));
        ddReporttype.Items.Add(new ListItem("BANK TELLERS", "TELLER"));
        ddReporttype.Items.Add(new ListItem("BANK CUSTOMERS", "CUSTOMER"));
        ddReporttype.Items.Add(new ListItem("TRANSACTION CATEGORIES", "TRANSACTIONCATEGORY"));
        ddReporttype.Items.Add(new ListItem("USER TYPES", "USERTYPE"));
        ddReporttype.Items.Add(new ListItem("ACCOUNT TYPES", "ACCOUNTTYPE"));
        ddReporttype.Items.Add(new ListItem("BANK ACCOUNTS", "ACCOUNTS"));
        ddReporttype.Items.Add(new ListItem("BANK BRANCHES", "BRANCHES"));
        ddReporttype.Items.Add(new ListItem("BANK CHARGES", "CHARGES"));
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
                dataGridResults.DataSource = null;
                dataGridResults.DataBind();
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
        string Id = txtName.Text;
        string ReportType = ddReporttype.SelectedValue;
        string UserType = ddReporttype.SelectedValue;
        if (ReportType == "TELLER" || ReportType == "CUSTOMER")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(ReportType);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "TRANSACTIONCATEGORY")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "")
        {
            searchCriteria.Add(BankCode);
        }
        else if (ReportType == "USERTYPE")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "ACCOUNTTYPE")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "ACCOUNTS")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "BRANCHES")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "CHARGES")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        else 
        {
            throw new Exception("PLEASE SELECT A BANK AND A REPORT TYPE");
        }
        return searchCriteria.ToArray();
    }
}