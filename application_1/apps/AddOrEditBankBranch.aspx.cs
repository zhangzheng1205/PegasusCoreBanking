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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankBranch branch = GetBranch();
            Result result = client.SaveBankBranchDetails(branch, user.BankCode, bll.BankPassword);
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
        branch.CreatedBy = user.Id;
        branch.CreatedOn = DateTime.Now.ToString("dd/MM/yyyy");
        branch.IsActive = ddIsActive.Text;
        branch.Location = txtLocation.Text;
        branch.ModifiedBy = user.Id;
        branch.ModifiedOn = branch.CreatedOn;
        return branch;
    }
}
