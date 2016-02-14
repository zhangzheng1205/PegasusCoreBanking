using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankBranch : System.Web.UI.Page
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
                LoadBranchData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;

            }
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void LoadBranchData(string Id, string BankCode)
    {
        BankBranch branch = client.GetById("BANKBRANCH", Id, BankCode, bll.BankPassword) as BankBranch;
        if (branch.StatusCode == "0")
        {
            this.ddBank.SelectedValue = branch.BranchCode;
            this.ddIsActive.Text = branch.IsActive;
            this.txtBranchCode.Text = branch.BranchCode;
            this.txtBranchName.Text = branch.BranchName;
            this.txtLocation.Text = branch.Location;
        }
        else 
        {
            string msg = branch.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankBranch branch = GetBranch();
            Result result = client.SaveBankBranchDetails(branch, ddBank.SelectedValue, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                string msg = "SUCCESS: BRANCH WITH BRANCH CODE [" + result.PegPayId + "] SAVED SUCCESSFULLY";
                bll.ShowMessage(lblmsg, msg, false, Session);
            }
            else 
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private BankBranch GetBranch()
    {
        BankBranch branch = new BankBranch();
        branch.BankBranchId = "";
        branch.BankCode = ddBank.SelectedValue;
        branch.BranchCode = txtBranchCode.Text;
        branch.BranchName = txtBranchName.Text;
        branch.IsActive = ddIsActive.Text;
        branch.Location = txtLocation.Text;
        branch.ModifiedBy = user.Id;
        return branch;
    }
}
