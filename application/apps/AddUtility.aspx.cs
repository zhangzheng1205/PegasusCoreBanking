using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using InterLinkClass.EntityObjects;

public partial class AddUtility : System.Web.UI.Page
{
    //SystemUsers dac = new SystemUsers();
    ProcessUsers Process = new ProcessUsers();
    DataLogin datafile = new DataLogin();
    BusinessLogin bll = new BusinessLogin();
    DataTable dataTable = new DataTable();

    Vendor vendor = new Vendor();

    Merchant merchant = new Merchant();
    private HttpFileCollection uploads2 = HttpContext.Current.Request.Files;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["AreaID"].ToString().Equals("1"))
            {
                if (IsPostBack == false)
                {
                    chkIsActive.Checked = true;
                    MultiView1.ActiveViewIndex = 0;
                    txtUser.Text = Session["FullName"].ToString();
                    if (Request.QueryString["transferid"] != null)
                    {
                        string vendorCode = Request.QueryString["transferid"].ToString();
                        //LoadControls(vendorCode);
                    }
                    else
                    {
                        //MultiView2.ActiveViewIndex = -1;
                    }
                    Button MenuTool = (Button)Master.FindControl("btnCallSystemTool");
                    Button MenuPayment = (Button)Master.FindControl("btnCallPayments");
                    Button MenuReport = (Button)Master.FindControl("btnCalReports");
                    Button MenuRecon = (Button)Master.FindControl("btnCalRecon");
                    Button MenuAccount = (Button)Master.FindControl("btnCallAccountDetails");
                    Button MenuBatching = (Button)Master.FindControl("btnCallBatching");
                    MenuTool.Font.Underline = true;
                    MenuPayment.Font.Underline = false;
                    MenuReport.Font.Underline = false;
                    MenuRecon.Font.Underline = false;
                    MenuAccount.Font.Underline = false;
                    MenuBatching.Font.Underline = false;
                    string strProcessScript = "this.value='Working...';this.disabled=true;";
                    btnOK.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(btnOK, "").ToString());
                }
            }
            else
            {
                MultiView1.ActiveViewIndex = -1;
                ShowMessage("YOU DONOT HAVE RIGHTS TO VIEW THIS PAGE", true); 
            }
        }
        catch (Exception ex)
        {
            MultiView1.ActiveViewIndex = 0;
            ShowMessage(ex.Message,true);            
        }        
    }

    private void ShowMessage(string Message, bool Error)
    {
        Label lblmsg = (Label)Master.FindControl("lblmsg");
        if (Error) { lblmsg.ForeColor = System.Drawing.Color.Red; lblmsg.Font.Bold = false; }
        else { lblmsg.ForeColor = System.Drawing.Color.Black; lblmsg.Font.Bold = true; }
        if (Message == ".")
        {
            lblmsg.Text = ".";
        }
        else
        {
            lblmsg.Text = "MESSAGE: " + Message.ToUpper();
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {

    }
     protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
           ValidateInputs();
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);  
        }
    }

    private void ValidateInputs()
    {
        string email = txtemail.Text.Trim();
        if (txtCode.Text.Equals(""))
        {
            ShowMessage("Please Enter Utility Code", true);
            txtCode.Focus();
        }
        else if (txtName.Text.Equals(""))
        {
            ShowMessage("Please Enter Utility Name", true);
            txtName.Focus();
        }
        else if (txtemail.Equals(""))
        {
            ShowMessage("Please Enter Utility Email", true);
            txtemail.Focus();
        }
        else if (txtconfirmemail.Text.Equals(""))
        {
            ShowMessage("Please Confirm Email", true);
            txtconfirmemail.Focus();
        }
        else if(!email.Equals(txtconfirmemail.Text.Trim()))
        {
            ShowMessage("Please Emails Provided do not match", true);            
        }
        else if (!bll.IsValidEmailAddress(email))
        {
            ShowMessage("Please Provide valid Emails ", true);
            txtemail.Focus();
        }
        else
        {
            //string pre_res = bll.IsPerpaymentVendorDetails(merchant);
            //if (pre_res.Equals("OK"))
            {
                UtilityDetails utility = new UtilityDetails();
                utility.Active = chkIsActive.Checked;
                utility.CreationDate = DateTime.Now;
                utility.Email = email;
                utility.Utility = txtName.Text.Trim();
                utility.UtilityCode = txtCode.Text.Trim();
                utility.UtilityContact = txtcontact.Text.Trim();
                string ret = Process.SaveUtility(utility);
                //UploadCert(vendor.VendorCode);
                ShowMessage(ret, false);
                ClearControls();
            }
            //else
            //{
            //    if (pre_res.Contains("Client"))
            //    {
            //        txtClientId.Focus();
            //    }
            //    else if (pre_res.Contains("Terminal"))
            //    {
            //        txtTerminalId.Focus();
            //    }
            //    else if (pre_res.Contains("Operator"))
            //    {
            //        txtOperatorId.Focus();
            //    }
            //    else 
            //    {
            //        txtVPassword.Focus();
            //    }
            //    ShowMessage(pre_res, true);
            //}
        }
        
   }
    private void ClearControls()
    {
        txtCode.Text = "";
        txtName.Text = "";
        txtcontact.Text = "";
        txtcontact.Text = "";
        txtemail.Text = "";
        chkIsActive.Checked = false;
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {

    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
}