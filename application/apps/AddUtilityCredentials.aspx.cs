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

public partial class AddUtilityCredentials : System.Web.UI.Page
{
    //SystemUsers dac = new SystemUsers();
    ProcessUsers Process = new ProcessUsers();
    DataLogin datafile = new DataLogin();
    BusinessLogin bll = new BusinessLogin();
    DataTable dataTable = new DataTable();

    Vendor vendor = new Vendor();

    private HttpFileCollection uploads2 = HttpContext.Current.Request.Files;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["AreaID"].ToString().Equals("1"))
            {
                if (IsPostBack == false)
                {
                    MultiView1.ActiveViewIndex = 0;
                    //txtUser.Text = Session["FullName"].ToString();
                    LoadVendors();
                    LoadUtilities();
                    if (Request.QueryString["transferid"] != null)
                    {
                        string vendorCode = Request.QueryString["transferid"].ToString();
                        ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByValue(vendorCode));
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
                ShowMessage("YOU DO NOT HAVE RIGHTS TO VIEW THIS PAGE", true);
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }        
    }

    private void LoadUtilities()
    {
        try
        {
            DataTable dtable1 = datafile.GetAllUtilities("0");
            ddlUtility.DataSource = dtable1;
            ddlUtility.DataValueField = "UtilityCode";
            ddlUtility.DataTextField = "Utility";
            ddlUtility.DataBind();
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }

    private void LoadVendors()
    {
        try
        {
            DataTable dtable = datafile.GetAllVendors("0");
            ddlVendor.DataSource = dtable;
            ddlVendor.DataValueField = "VendorCode";
            ddlVendor.DataTextField = "Vendor";
            ddlVendor.DataBind();
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
            //lblCode.Text = dataTable.Rows[0]["Vendorid"].ToString();
            //txtCode.Text = dataTable.Rows[0]["VendorCode"].ToString();
            //txtName.Text = dataTable.Rows[0]["Vendor"].ToString();
            //txtBillSystemCode.Text = dataTable.Rows[0]["BillSystemCode"].ToString();
            //txtcontact.Text = dataTable.Rows[0]["ContactPerson"].ToString();
            //txtemail.Text = dataTable.Rows[0]["VendorEmail"].ToString();
            //txtconfirmemail.Text = dataTable.Rows[0]["VendorEmail"].ToString();
            //bool isActive = bool.Parse(dataTable.Rows[0]["Active"].ToString());
            //bool isMActive = bool.Parse(dataTable.Rows[0]["MActive"].ToString());
            //txtClientId.Text = dataTable.Rows[0]["ClientId"].ToString();
            //txtTerminalId.Text = dataTable.Rows[0]["TerminalId"].ToString();
            //txtOperatorId.Text = dataTable.Rows[0]["OperatorId"].ToString();
            //txtVPassword.Text = dataTable.Rows[0]["OperatorPassword"].ToString();
            //chkIsActive.Checked = isActive;
            //chkPrepayment.Checked = isMActive;
            //txtCode.Enabled = false;
            //MultiView2.ActiveViewIndex = 0;
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
        //vendor.Vendorid = int.Parse(lblCode.Text.Trim());
        //vendor.VendorCode = txtCode.Text.Trim();
        //vendor.BillSysCode = txtBillSystemCode.Text.Trim();
        //vendor.VendorName = txtName.Text.Trim().ToUpper();      
        //vendor.Email = txtemail.Text.Trim();      
        //vendor.Active = chkIsActive.Checked;
        //vendor.Sendemail = chkResend.Checked;
        //vendor.Reset = chkResetPassword.Checked;
        //vendor.Contract = txtcontact.Text.Trim();
        if (ddlVendor.SelectedIndex == 0)
        {
            ShowMessage("PLEASE SELECT A VENDOR", true);
        }
        else if (ddlUtility.SelectedIndex == 0)
        {
            ShowMessage("PLEASE SELECT A UTILITY", true);
        }
        else if (txtUsername.Text.Trim().Equals(""))
        {
            ShowMessage("PLEASE ENTER A UTILITY USERNAME TO SAVE", true);
        }
        else if (txtPassword.Text.Trim().Equals(""))
        {
            ShowMessage("PLEASE ENTER A UTILITY PASSWORD TO SAVE", true);
        }
        else if (ddlUtility.SelectedValue.Trim().Equals("URA"))
        {
            if (txtBankCode.Text.Trim().Equals(""))
            {
                ShowMessage("PLEASE ENTER A URA BANKCODE TO SAVE", true);
            }
        }
        else
        {
            try
            {
                string vendorCode = ddlVendor.SelectedValue;
                string utilityCode = ddlUtility.SelectedValue;
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();
                string bankCode = txtBankCode.Text.Trim();
                string createdBy = Session["FullName"].ToString();
                datafile.SaveUtilityCredentials(vendorCode, utilityCode, username, password, bankCode, createdBy, DateTime.Now);
                if (chkPrepayment.Checked)
                {
                    CreateDirectory(vendorCode, utilityCode);
                    if (!FileUpload1.FileName.Trim().Equals(""))
                    {
                        UploadCert(vendorCode, utilityCode);
                    }
                }
                ShowMessage("DETAILS SAVED SUCCESSFULLY", false);
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
            }
        }
        
   }

    private void CreateDirectory(string vendorCode, string utilityCode)
    {
        try
        {
            string rootDirectory = bll.DecryptString(datafile.GetSystemParameter(6, 3));
            string path = Path.Combine(rootDirectory, vendorCode);
            if (Directory.Exists(path))
            {
                path = Path.Combine(path, utilityCode);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
            }
            else
            {
                Directory.CreateDirectory(path);
                path = Path.Combine(path, utilityCode);
                Directory.CreateDirectory(path);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void UploadCert(string VendorCode, string UtilityCode)
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
                string strPath = bll.DecryptString(datafile.GetSystemParameter(6, 3));//bll.GetFileApplicationPath(VendorCode);
                strPath = Path.Combine(strPath, VendorCode);
                strPath = Path.Combine(strPath, UtilityCode);
                DirectoryInfo dic = new DirectoryInfo(strPath);
                bll.EmptyFolder(dic);
                string fullPath = Path.Combine(strPath, c1);//strPath + "\\" + c1;
                FileUpload1.PostedFile.SaveAs(fullPath);                
            }
        }
    }
    private void ClearControls()
    {
        ddlVendor.SelectedIndex = 0;
        ddlUtility.SelectedIndex = 0;
        txtUsername.Text = "";
        txtPassword.Text = "";
        txtBankCode.Text = "";
        chkPrepayment.Checked = false;
        MultiView3.ActiveViewIndex = -1;
    }

    protected void chkPrepayment_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            bool isPayment = chkPrepayment.Checked;
            if (isPayment)
            {
                MultiView3.ActiveViewIndex = 0;
            }
            else
            {
                MultiView3.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    protected void ddlVendor_DataBound(object sender, EventArgs e)
    {
        ddlVendor.Items.Insert(0, new ListItem("Select Vendor", "0"));
    }

    protected void ddlUtility_DataBound(object sender, EventArgs e)
    {
        ddlUtility.Items.Insert(0, new ListItem("Select Utility", "0"));
    }
    protected void ddlUtility_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlUtility.SelectedIndex = 0;
    }
    protected void btnGetCredentials_Click(object sender, EventArgs e)
    {
        ShowMessage("", true);
        if (ddlVendor.SelectedIndex == 0)
        {
            ShowMessage("PLEASE SELECT A VENDOR:", true);
            //ClearControls();
        }
        else if (ddlUtility.SelectedIndex == 0)
        {
            ShowMessage("PLEASE SELECT A UTILITY:", true);
        }
        else
        {
            string vendorCode = ddlVendor.SelectedValue;
            string utilityCode = ddlUtility.SelectedValue;
            DataTable dt = datafile.GetUtilityCredentials(vendorCode, utilityCode);
            if (dt.Rows.Count > 0)
            {
                string username = dt.Rows[0]["UtilityUsername"].ToString();
                string password = dt.Rows[0]["UtilityPassword"].ToString();
                string bankCode = dt.Rows[0]["BankCode"].ToString();
                txtUsername.Text = username;
                txtPassword.Text = password;
                txtBankCode.Text = bankCode;
            }
            else
            {
                ShowMessage("VENDOR:" + ddlVendor.SelectedItem.Text + " HAS NO CREDENTIALS FOR " + ddlUtility.SelectedItem.Text, true);
                ClearControls();
            }
        }
    }
}