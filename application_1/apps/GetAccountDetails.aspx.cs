using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GetAccountDetails : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    string BankCode = "";
    string UserId = "";
    string Id = "";
    string BranchCode = "";
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;
            BankCode = Request.QueryString["BankCode"];
            UserId = Request.QueryString["CustomerId"];
            BranchCode = Request.QueryString["BranchCode"];
            Msg = Request.QueryString["Msg"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            else if (UserId!=null)
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
                Multiview2.ActiveViewIndex = 1;
            }
            else if (Msg != null)
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
                Multiview2.ActiveViewIndex = 1;
                bll.ShowMessage(lblmsg, Msg, true, Session);
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
            DataTable dt = bll.SearchAccountsTable(parameters);
            if (dt.Rows.Count > 0)
            {
                if (UserId == null)
                {
                    dataGridResults.DataSource = dt;
                    dataGridResults.DataBind();
                    Multiview2.ActiveViewIndex = 0;
                    string msg = "SUCCESS: " + dt.Rows.Count + " RECORDS FOUND";
                    bll.ShowMessage(lblmsg, msg, false, Session);
                }
                else 
                {
                    dataGridResults2.DataSource = dt;
                    dataGridResults2.DataBind();
                    Multiview2.ActiveViewIndex = 2;
                    string msg = "SUCCESS: " + dt.Rows.Count + " RECORDS FOUND";
                    bll.ShowMessage(lblmsg, msg, false, Session);
                }
            }
            else 
            {
                dataGridResults.DataSource = null;
                dataGridResults.DataBind();
                string msg = "NO RECORD OF ACCOUNT FOUND FOR BANK SPECIFIED";
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
        string AccNumber = txtAccountNumber.Text;
        string BankCode = ddBank.SelectedValue;
        all.Add(AccNumber);
        all.Add(BankCode);
        all.Add(txtName.Text);
        return all.ToArray();
    }
    
}