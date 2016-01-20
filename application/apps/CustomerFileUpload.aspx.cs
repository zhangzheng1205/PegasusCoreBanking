using System;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.EntityObjects;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using CrystalDecisions.Shared;

public partial class CustomerFileUpload : System.Web.UI.Page
{
    ProcessPay Process = new ProcessPay();
    DataLogin datafile = new DataLogin();
    Datapay datapay = new Datapay();
    BusinessLogin bll = new BusinessLogin();
    DataTable dataTable = new DataTable();
    DataTable dtable = new DataTable();

    private ReportDocument Rptdoc = new ReportDocument();

    DataFileProcess dfile = new DataFileProcess();
    private ArrayList fileContents;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack == false)
            {
                LoadUtilities();
                if (Session["AreaID"].ToString().Equals("2"))
                {
                    cboUtility.SelectedIndex = cboUtility.Items.IndexOf(new ListItem(Session["DistrictName"].ToString(), Session["DistrictID"].ToString()));
                    cboUtility.Enabled = false;
                }
                //ToggleVendor();
                MultiView1.ActiveViewIndex = 0;
                Button MenuTool = (Button)Master.FindControl("btnCallSystemTool");
                Button MenuPayment = (Button)Master.FindControl("btnCallPayments");
                Button MenuReport = (Button)Master.FindControl("btnCalReports");
                Button MenuRecon = (Button)Master.FindControl("btnCalRecon");
                Button MenuAccount = (Button)Master.FindControl("btnCallAccountDetails");
                Button MenuBatching = (Button)Master.FindControl("btnCallBatching");
                MenuTool.Font.Underline = false;
                MenuPayment.Font.Underline = false;
                MenuReport.Font.Underline = false;
                MenuRecon.Font.Underline = true;
                MenuAccount.Font.Underline = false;
                MenuBatching.Font.Underline = false;
                DisableBtnsOnClick();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    private void ToggleVendor()
    {
        string districtcode = Session["DistrictCode"].ToString();
        string role = Session["RoleCode"].ToString();
        if (role.Equals("005"))
        {
            cboUtility.Enabled = false;
            cboUtility.SelectedIndex = cboUtility.Items.IndexOf(cboUtility.Items.FindByValue(districtcode));
        }
        else
        {
            cboUtility.Enabled = true;
        }
    }

    private void LoadUtilities()
    {
        dtable = datafile.GetAllUtilities("0");
        cboUtility.DataSource = dtable;
        cboUtility.DataValueField = "UtilityCode";
        cboUtility.DataTextField = "Utility";
        cboUtility.DataBind();
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
    private void DisableBtnsOnClick()
    {
        string strProcessScript = "this.value='Working...';this.disabled=true;";
        btnOK.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(btnOK, "").ToString());
        Button1.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button1, "").ToString());
        Button2.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button2, "").ToString());
    }
    protected void cboUtility_DataBound(object sender, EventArgs e)
    {
        cboUtility.Items.Insert(0, new ListItem("Select", "0"));
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            string utilityCode = cboUtility.SelectedValue.ToString();
            if (utilityCode.Equals("0"))
            {
                ShowMessage("Please Select Company",true);
            }
            else if (FileUpload1.FileName.Trim().Equals(""))
            {
                ShowMessage("Please Browse Customer file to Upload",true);
            }
            else
            {
                ReadFileToRecon(utilityCode);
            } 
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message,true);
        }
    }
    private int CreateReconCode()
    {
        int output = 0;
        string createdby = Session["Username"].ToString();
        output = datapay.SaveReconBatch(0, 0, 0, 0, createdby);
        return output;
    }
    private void ReadFileToRecon(string utilityCode)
    {
        //ShowMessage("", true);
        //string filename = Path.GetFileName(FileUpload1.FileName);
        //string extension = Path.GetExtension(filename);
        //if (extension.ToUpper().Equals(".XLS") || extension.ToUpper().Equals(".XLSX"))
        //{
        //    string filePath = bll.UploadFilePath(utilityCode, filename);//bll.ReconFilePath(utilityCode, filename);
        //    FileUpload1.SaveAs(filePath);
        //    //ArrayList failedCustomerRecords = new ArrayList();
        //    bool Status;
        //    int count = 0;
        //    int failedRecon = 0;
        //    int Reconciled = 0;
        //    string user = Session["Username"].ToString();
        //    dfile = new DataFileProcess();
        //    DataFile df = new DataFile();
        //    string columnsCorrect = df.ValidateColumNames(filePath, extension);
        //    if (columnsCorrect.Equals("YES"))
        //    {
                //fileContents = df.readExcelFile(filePath, extension);
        //        int Reconcode = CreateReconCode();
        //        //Recontran tran;
        //        Cust cust;
        //        ArrayList excelCols = datafile.GetExcelColNames();
        //        for (int i = 0; i < fileContents.Count; i++)
        //        {
        //            count++;
        //            string line = fileContents[i].ToString();
        //            string[] sLine = line.Split(',');
        //            {
        //                //tran = new Recontran();
        //                cust = new Cust();
        //                if (sLine.Length == excelCols.Count)
        //                {
        //                    string custRef = sLine[0].Trim();
        //                    string custName= sLine[1].Trim();
        //                    string balance = sLine[2].Trim();
        //                    string custType = sLine[3].Trim();
        //                    string payType = sLine[4].Trim();
        //                    if (balance.Trim().Equals(""))
        //                    {
        //                        balance = "0";
        //                    }
        //                    //string datestr = GetPayDate(sLine[2].Trim());
        //                    double amt;
        //                    //DateTime dt;
        //                    //if (!Double.TryParse(amountstr, out amt))
        //                    //{
        //                    //    throw new Exception("Incorrect amount format at line " + count.ToString());
        //                    //}
        //                    //else if (!DateTime.TryParse(datestr, out dt))
        //                    //{
        //                    //    throw new Exception("Incorrect date format at line " + count.ToString());
        //                    //}
        //                    //else
        //                    {
        //                        tran.VendorRef = vendorref;
        //                        tran.VendorCode = utilityCode;
        //                        tran.TransAmount = Double.Parse(amountstr);
        //                        tran.PayDate = datestr;
        //                        tran.ReconciledBy = user;
        //                        tran.ReconType = "AR";
        //                        cust.CustRef = custRef;
        //                        cust.CustName = custName;
        //                        cust.Balance = balance;
        //                        cust.CustomerType = custType;
        //                        cust.PaymentType = payType;
        //                        cust.Utility = cboUtility.SelectedValue;
        //                        Status = Process.ProcessCustomer(cust);
        //                        if (Status)
        //                        {
        //                            Reconciled++;
        //                        }
        //                        else
        //                        {
        //                            failedRecon++;
        //                        }

        //                    }
        //                }
        //                else
        //                {
        //                    CancelRecnBatch(Reconcode);
        //                    throw new Exception("File Format is not OK, Columns must be 3... and not " + sLine.Length.ToString());
        //                }
        //            }

        //        }
        //        int Total = Reconciled + failedRecon;
        //        if (failedRecon == 0)
        //        {
        //            ShowMessage("File of " + Total + " record(s) Reconciled Successfully", false);
        //        }
        //        else if (Reconciled == 0)
        //        {
        //            ShowMessage("File of " + Total + " record(s) Reconciliation failed", true);
        //            DisplayFailed(failedCustomerRecords);
        //        }
        //        else
        //        {
        //            ShowMessage("File of " + Total + " record(s) Processed( Success -" + Reconciled + " Failed - " + failedRecon + ")", true);
        //            DisplayFailed(failedCustomerRecords);
        //        }
        //    }
        //    else
        //    {
        //        ShowMessage(columnsCorrect, true);
        //    }
        //}
        //else
        //{
        //    ShowMessage("Please Browse For an EXCEL File, " + extension + " file not supported", true);
        //}
    }

    private string GetPayDate(string pay_date)
    {
        string res = "";
        try
        {            
            string[] str_date = pay_date.Split('/');
            if (str_date.Length.Equals(3))
            {
                string dd = str_date[0].ToString();
                string mm = str_date[1].ToString();
                string yy = str_date[2].ToString();
                int dd_len = dd.Length;
                int mm_len = mm.Length;
                int yy_len = yy.Length;
                if (dd_len.Equals(2) && mm_len.Equals(2) && yy_len.Equals(4))
                {
                    res = dd + "/" + mm + "/" + yy;
                }
                else
                {
                    throw new Exception("Wrong Payment Date");
                }
            }
            else
            {
                throw new Exception("Wrong Payment Date");
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Wrong Payment Date");
        }
        return res;
    }
    private void DisplayFailed(ArrayList failedTransactions)
    {
        try
        {
            DataTable dt = bll.GetFailedReconTable();
            Recontran recontran = new Recontran();
            for (int i = 0; i < failedTransactions.Count; i++)
            {
                recontran = (Recontran)failedTransactions[i];
                DataRow dr = dt.NewRow();
                dr["No."] = i + 1;
                dr["VendorRef"] = recontran.VendorRef;
                dr["PayDate"] = recontran.PayDate;
                dr["TransactionAmount"] = recontran.TransAmount.ToString("#,##0");
                dr["Reason"] = recontran.Reason;
                dt.Rows.Add(dr);

                dt.AcceptChanges();
            }
            LoadFailedGrid(dt);
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message,true);
        }
    }
    private void LoadFailedGrid(DataTable dt)
    {
        MultiView1.ActiveViewIndex = 1;
        DataGrid1.DataSource = dt;
        DataGrid1.DataBind();
        //string filePath = CallFilling(dt);
        //foreach (DataRow dr in dac.GetEmailSubscribers().Rows)
        //{
        //    string Email = dr["Email"].ToString();
        //    string FName = dr["FullName"].ToString();
        //    string Msg = "Hello " + " " + FName + "\nPlease find attached, \n Failed Reconciliations for Vendor : " + cboBank.SelectedItem.ToString();
        //    string Subject = "Failed Reconciliations for Vendor: " + cboBank.SelectedItem.ToString();
        //    string Sender = Session["UserName"].ToString();
        //    bll.SendMail(Email, Msg, Sender, Subject, filePath);
        //}     
    }

    private void CancelRecnBatch(int Reconcode)
    {
        datapay.CancelReconBatch(Reconcode);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        ShowMessage(".", true);
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            string fileFormat = GetFileformat();
            if (fileFormat.Equals("NONE"))
            {
                ShowMessage("Please Select File Format", true);
            }
            else
            {
                ShowMessage(".", true);
                ConvertToPdf(fileFormat);
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
        finally
        {
            Rptdoc.Dispose();
        }
    }

    private string GetFileformat()
    {
        string res = "NONE";
        if (rdPdf.Checked == false && rdExcel.Checked == false)
        {
            res = "NONE";
        }
        else
        {
            if (rdPdf.Checked == true)
            {
                res = "1";
            }
            else
            {
                res = "2";
            }
        }
        return res;
    }

    private void ConvertToPdf(string fileformat)
    {
        dataTable = GetGridRptTable();
        LoadReport(dataTable, fileformat);
    }
    private DataTable GetGridRptTable()
    {
        DataTable dtble = GetFailedRptDataTable();
        string vendor = cboUtility.SelectedItem.ToString();
        foreach (DataGridItem Items in DataGrid1.Items)
        {
            DataRow dr = dtble.NewRow();
            string No = Items.Cells[0].Text;
            string VendorRef = Items.Cells[1].Text;
            string PayDate = Items.Cells[2].Text;
            string Amount = Items.Cells[3].Text;
            string Reason = Items.Cells[4].Text;
            string bank = vendor;
            string PrintedBy = Session["FullName"].ToString();
            ///////
            dr["No."] = No;
            dr["VendorRef"] = VendorRef;
            dr["PayDate"] = PayDate;
            dr["Amount"] = Amount;
            dr["Reason"] = Reason;
            dr["Bank"] = bank;
            dr["PrintedBy"] = PrintedBy;            
            dtble.Rows.Add(dr);
            dtble.AcceptChanges();
        }
        return dtble;
    }
    private DataTable GetFailedRptDataTable()
    {
        DataTable dt = new DataTable("Table2");
        dt.Columns.Add("No.");
        dt.Columns.Add("VendorRef");
        dt.Columns.Add("PayDate");
        dt.Columns.Add("Amount");
        dt.Columns.Add("Reason");
        dt.Columns.Add("Bank");
        dt.Columns.Add("PrintedBy");
        return dt;
    }
    private void LoadReport(DataTable dataTable,string fileformat)
    {
        string appPath, physicalPath, rptName;
        appPath = HttpContext.Current.Request.ApplicationPath;
        physicalPath = HttpContext.Current.Request.MapPath(appPath);
        rptName = physicalPath + "\\Bin\\reports\\FailedRecon.rpt";
        Rptdoc.Load(rptName);
        Rptdoc.SetDataSource(dataTable);
        CrystalReportViewer1.ReportSource = Rptdoc;
        Response.Buffer = false;
        Response.ClearContent();
        Response.ClearHeaders();
        if (fileformat.Equals("1"))
        {
            Rptdoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "FAILED RECONCILIATIONS");
        }
        else
        {
            Rptdoc.ExportToHttpResponse(ExportFormatType.Excel, Response, true, "FAILED RECONCILIATIONS");
        }
        ShowMessage(".",true);
    }
}
