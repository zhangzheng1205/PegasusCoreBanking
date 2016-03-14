using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewAuditLogs : System.Web.UI.Page
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
        bll.LoadBanksIntoDropDown(user, ddBank);
    }

    protected void btnConvert_Click(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] parameters = GetSearchParameters();
            DataTable dt = bll.SearchAuditlogsTable(parameters);
            if (dt.Rows.Count > 0)
            {
                dataGridResults2.DataSource = dt;
                dataGridResults2.DataBind();
                Multiview2.ActiveViewIndex = 2;
                string msg = "SUCCESS: " + dt.Rows.Count + " RECORDS FOUND";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else
            {
                dataGridResults2.DataSource = null;
                dataGridResults2.DataBind();
                Multiview2.ActiveViewIndex = 2;
                string msg = "NO RECORD OF LOGS FOUND FOR USER SPECIFIED";
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
        List<string> all = new List<string>();
        string UserId = txtUserId.Text;
        string BankCode = ddBank.SelectedValue;
        string Action = ddAction.Text;
        all.Add(UserId);
        all.Add(BankCode);
        all.Add(Action);
        return all.ToArray();
    }
}