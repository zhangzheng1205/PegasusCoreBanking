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
            if (EditType != null)
            {
                RouteRequestToCorrectEditPage(EditType, Id, BankCode);
            }
            else if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            //is this a PostBack
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

    private void RouteRequestToCorrectEditPage(string EditType, string Id, string BankCode)
    {
        Result result = bll.GetRedirectUrl(EditType, user.Usertype);
        if (result.StatusCode == "0")
        {
            string Page = result.PegPayId;
            string url = Page + "?Id=" + Id + "&BankCode=" + BankCode;
            Response.Redirect(url);
            //Server.Transfer(url,false);
        }
        else
        {
            throw new Exception(result.StatusDesc);
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
        bll.LoadReportTypesIntoDropDown(ddBank.SelectedValue, ddReporttype, user);
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

        if (string.IsNullOrEmpty(ReportType))
        {
            throw new Exception("PLEASE SELECT A REPORT TYPE");
        }
        else if (ReportType == "TELLER" || ReportType == "CUSTOMER")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(ReportType);
            searchCriteria.Add(Id);
        }
        else if (ReportType == "SYSTEMUSERS")
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add("ALL");
            searchCriteria.Add(Id);
        }
        else
        {
            searchCriteria.Add(BankCode);
            searchCriteria.Add(Id);
        }
        return searchCriteria.ToArray();
    }
}