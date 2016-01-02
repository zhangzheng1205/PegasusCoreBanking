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

public partial class AddVendor : System.Web.UI.Page
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
                        LoadControls(vendorCode);
                    }
                    else
                    {
                        MultiView2.ActiveViewIndex = -1;
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
                ShowMessage("YOU DO NOT HAVE RIGHTS TO VIEW THIS PAGE", true);
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }        
    }

    private void LoadControls(string VendorCode)
    {
        vendor.Vendorid = int.Parse(VendorCode);
        dataTable = datafile.GetVendorById(vendor);
        if (dataTable.Rows.Count > 0)
        {
            lblCode.Text = dataTable.Rows[0]["Vendorid"].ToString();
            txtCode.Text = dataTable.Rows[0]["VendorCode"].ToString();
            txtName.Text = dataTable.Rows[0]["Vendor"].ToString();
            txtBillSystemCode.Text = dataTable.Rows[0]["BillSystemCode"].ToString();
            txtcontact.Text = dataTable.Rows[0]["ContactPerson"].ToString();
            txtemail.Text = dataTable.Rows[0]["VendorEmail"].ToString();
            txtconfirmemail.Text = dataTable.Rows[0]["VendorEmail"].ToString();
            bool isActive = bool.Parse(dataTable.Rows[0]["Active"].ToString());
            bool isMActive = bool.Parse(dataTable.Rows[0]["MActive"].ToString());
            //txtClientId.Text = dataTable.Rows[0]["ClientId"].ToString();
            //txtTerminalId.Text = dataTable.Rows[0]["TerminalId"].ToString();
            //txtOperatorId.Text = dataTable.Rows[0]["OperatorId"].ToString();
            //txtVPassword.Text = dataTable.Rows[0]["OperatorPassword"].ToString();
            //chkIsActive.Checked = isActive;
            //chkPrepayment.Checked = isMActive;
            txtCode.Enabled = false;
            MultiView2.ActiveViewIndex = 0;
            //if (isMActive)
            //{
            //    MultiView3.ActiveViewIndex = 0;
            //}
            //else
            //{
            //    MultiView3.ActiveViewIndex = -1;
            //}
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
        vendor.Vendorid = int.Parse(lblCode.Text.Trim());
        vendor.VendorCode = txtCode.Text.Trim();
        vendor.BillSysCode = txtBillSystemCode.Text.Trim();
        vendor.VendorName = txtName.Text.Trim().ToUpper();      
        vendor.Email = txtemail.Text.Trim();      
        vendor.Active = chkIsActive.Checked;
        vendor.Sendemail = chkResend.Checked;
        vendor.Reset = chkResetPassword.Checked;
        vendor.Contract = txtcontact.Text.Trim();

        //////

        //merchant.Active = true;
        //merchant.ClientId = "";
        //merchant.TerminalId = "";
        //merchant.OperatorId = "";
        //merchant.Password = "";
        if (vendor.VendorCode.Equals(""))
        {
            ShowMessage("Please Enter Vendor Code", true);
            txtCode.Focus();
        }
        else if (vendor.BillSysCode.Equals(""))
        {
            ShowMessage("Please Enter Vendor Billing System Code", true);
            txtBillSystemCode.Focus();
        }
        else if (vendor.VendorName.Equals(""))
        {
            ShowMessage("Please Enter Vendor Name", true);
            txtName.Focus();
        }
        else if (vendor.Email.Equals(""))
        {
            ShowMessage("Please Enter Vendor Email", true);
            txtemail.Focus();
        }
        else if (txtconfirmemail.Text.Equals(""))
        {
            ShowMessage("Please Confirm Email", true);
            txtconfirmemail.Focus();
        }
        else if(!vendor.Email.Equals(txtconfirmemail.Text.Trim()))
        {
            ShowMessage("Please Emails Provided do not match", true);            
        }
        else if (!bll.IsValidEmailAddress(vendor.Email))
        {
            ShowMessage("Please Provide valid Emails ", true);
            txtemail.Focus();
        }
        else
        {
            //string pre_res = bll.IsPerpaymentVendorDetails(merchant);
            //if (pre_res.Equals("OK"))
            {
                string ret = Process.SaveVendor(vendor, merchant);
                UploadCert(vendor.VendorCode);
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
    private void UploadCert(string VendorCode)
    {
        HttpFileCollection uploads;
        uploads = HttpContext.Current.Request.Files;
        int countfiles = 0;
        for (int i = 0; i <= (uploads.Count - 1); i++)
        {
            if (uploads[i].ContentLength > 0)
            {
                string c = Path.GetFileName(uploads[i].FileName);
                string cNoSpace = c.Replace(" ", "-");
                string c1 = cNoSpace;
                string strPath = bll.GetFileApplicationPath(VendorCode);
                DirectoryInfo dic = new DirectoryInfo(strPath);
                bll.EmptyFolder(dic);
                string fullPath = strPath + "\\" + c1;
                FileUpload1.PostedFile.SaveAs(fullPath);                
            }
        }
    }
    private void ClearControls()
    {
        lblCode.Text = "0";
        txtName.Text = "";
        txtemail.Text = "";
        txtCode.Text = "";
        txtBillSystemCode.Text = "";
        txtconfirmemail.Text = "";
        txtcontact.Text = "";
        //txtVPassword.Text = "";
        //txtTerminalId.Text = "";
        //txtOperatorId.Text = "";
        //txtClientId.Text = "";
        chkIsActive.Checked = false;
        chkResend.Checked = false;
        chkResetPassword.Checked = false;
        //chkPrepayment.Checked = false;
        MultiView2.ActiveViewIndex = -1;
        //MultiView3.ActiveViewIndex = -1;
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {

    }
    protected void btnNo_Click(object sender, EventArgs e)
    {

    }
    protected void cboAccessLevel_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void chkResend_CheckedChanged(object sender, EventArgs e)
    {
        if (chkResend.Checked.Equals(true))
        {
            chkResetPassword.Checked = false;
        }
    }
    protected void chkResetPassword_CheckedChanged(object sender, EventArgs e)
    {
        if (chkResetPassword.Checked.Equals(true))
        {
            chkResend.Checked = false;
        }
    }
    //protected void chkPrepayment_CheckedChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        bool isPayment = chkPrepayment.Checked;
    //        if (isPayment)
    //        {
    //            MultiView3.ActiveViewIndex = 0;
    //        }
    //        else
    //        {
    //            MultiView3.ActiveViewIndex = -1;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ShowMessage(ex.Message, true);
    //    }
    //}
    protected void btnViewUtilityCreds_Click(object sender, EventArgs e)
    {
        string vendorCode = txtCode.Text.Trim();
        if (vendorCode.Equals(""))
        {
            ShowMessage("PLEASE SELECT A VENDOR", true);
        }
        else
        {
            Response.Redirect("./AddUtilityCredentials.aspx?transfereid=" + vendorCode, false);
        }
    }
}