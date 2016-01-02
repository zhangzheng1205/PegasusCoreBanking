using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
//using System.Text;
//using System.Data;
using System.Net;
//using NumberText;
using System.Net.Mail;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.text;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using CrystalDecisions.Shared;
public partial class ApproveCredits : System.Web.UI.Page
{
    BusinessLogin bll = new BusinessLogin();
    DataLogin datafile = new DataLogin();
    Datapay datapay = new Datapay();
    DataTable dataTable = new DataTable();
    DataTable dtable = new DataTable();
    private ReportDocument Rptdoc = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void chkTransactions_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            chkAllData.Visible = true;

            if (chkAllData.Checked == true)
            {

            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    private void SelectAllItems()
    {
        foreach (DataGridItem Items in DataGrid1.Items)
        {
            CheckBox chk = ((CheckBox)(Items.FindControl("CheckBox1")));
            if (chk.Checked)
            {
                chk.Checked = false;
            }
            else
            {
                chk.Checked = true;
            }
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
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            string str = GetRecordsToApprove().TrimEnd(',');
            if (str.Equals(""))
            {
                ShowMessage("Please Select Credits to Approve", true);
            }
            else
            {
                ProcessApprovals(str);

                LoadCredits();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }

    private void ProcessApprovals(string str)
    {
        try
        {
            int suc = 0;
            int failed = 0;
            int count = 0;
            string[] arr = str.Split(',');
            int i = 0;
            string User = Session["UserName"].ToString();
            for (i = 0; i < arr.Length; i++)
            {
                int RecordId = int.Parse(arr[i].ToString());

                string ss = datafile.ApproveAccountCredit(RecordId);
                if (ss.Equals("SUCCESS"))
                {
                    count++;
                    //update approved credits
                    datafile.UpdateApprovedCredit(RecordId, User);

                    //Insert into 

                    CustomerReceiptCreditDetails cust = datafile.GetCustomerReceiptDetails(RecordId);
                    DateTime todaydate = DateTime.Now;
                    string datetoday = todaydate.ToString().Replace("/", "-").Replace(":", "-").Replace(" ", "-");
                    string vendorTranld = "CREDIT" + datetoday;

                    int insertedstatuscount = 0;

                    insertedstatuscount = datafile.InsertIntoReceivedPrepaidTxns(cust.CustomerCode, cust.CustomerAccount, cust.CustomerCreditAmount, vendorTranld);
                    if (insertedstatuscount > 0)
                    {

                        //UpdateCustomerAccount
                        int updatestatuscount = 0;
                        updatestatuscount = datafile.UpdatePrepaidCustomerAccountBalance(cust.CustomerCode, cust.CustomerCreditAmount, cust.CustomerAccount);
                        if (updatestatuscount > 0)
                        {


                        }

                    }
                }
                else
                {
                    failed++;
                }

            }
            string msg = suc + " Credits Have Been Approved and " + failed + "Failed";
            //datafile.LogActivity(Session["UserName"].ToString(), "Approved Account Credits Details");
            ShowMessage(msg, false);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private string GetRecordsToApprove()
    {
        int Count = 0;
        string ItemArr = "";
        foreach (DataGridItem Items in DataGrid1.Items)
        {
            CheckBox chk = ((CheckBox)(Items.FindControl("CheckBox1")));
            if (chk.Checked)
            {
                Count++;
                string ItemFound = Items.Cells[0].Text;
                ItemArr = ItemArr += ItemFound + ",";
            }
        }
        return ItemArr;
    }
    //public void SendReceiptToUsernameEmail(CustomerReceiptCreditDetails cust)
    //{


    //    // string custName = txtCustName.Text;
    //    //string CustAccount = txtCustAccount.Text;
    //    string AccountNumber = "";
    //    string AccountBalance = "";
    //    int AccountBalanceNo = 0;
    //    int CreditAmount = 0;
    //    DateTime todaydate = DateTime.Today.Date;
    //    //string bbd = todaydate.ToShortDateString();  //mm/dd/yy
    //    string datetoday = todaydate.ToString("dd/MM/yyyy");
    //    try
    //    {
    //        DataTable dtable = datafile.GetPegPayAccount(cust.CustomerCode);
    //        if (dtable.Rows.Count > 0)
    //        {
    //            AccountNumber = dtable.Rows[0]["AccountNumber"].ToString();
    //            AccountBalance = dtable.Rows[0]["AccountBalance"].ToString();
    //        }

    //        AccountBalanceNo = Convert.ToInt32(AccountBalance.Split('.')[0]);
    //        CreditAmount = Convert.ToInt32(cust.CustomerCreditAmount.Split('.')[0]);
    //        //string nn = Num2Wrd(CreditAmount);
    //        //string companyName = "PEGASUS CREIT RECEIPT";

    //        DataTable ReceiptTable = GetReceiptDataTable();
    //        DataRow row;

    //        // int count = 0;


    //        for (int i = 0; i < 1; i++)
    //        {
    //            row = ReceiptTable.NewRow();
    //            row["Custname"] = cust.CustomerCode;
    //            row["Custref"] = cust.CustomerAccount;
    //            row["Amount"] = CreditAmount + "\t USHS";
    //            row["NewBal"] = AccountBalanceNo;
    //            row["PaymentDate"] = datetoday;
    //            ReceiptTable.Rows.Add(row);
    //            ReceiptTable.AcceptChanges();
    //            // count++;
    //            //dt.Columns.Add("CustName");
    //            //dt.Columns.Add("CustRef");
    //            //dt.Columns.Add("Amount");
    //            //dt.Columns.Add("NewBal");
    //            //dt.Columns.Add("PaymentDate");
    //            //}

    //        }

    //        //ReportDocument crystalReport = new ReportDocument();
    //        CrystalReportViewer1.DisplayGroupTree = false;
    //        string appPath, physicalPath, rptName;
    //        appPath = HttpContext.Current.Request.ApplicationPath;
    //        physicalPath = HttpContext.Current.Request.MapPath(appPath);
    //        rptName = physicalPath + "\\Bin\\reports\\ClientReceipt.rpt";
    //        Rptdoc.Load(rptName);
    //        //Rptdoc.Load(Server.MapPath("~/ClientReceipt.rpt"));
    //        //Customers dsCustomers = GetData(query, crystalReport);
    //        Rptdoc.SetDataSource(ReceiptTable);
    //        CrystalReportViewer1.ReportSource = Rptdoc;
    //        CrystalReportViewer1.DataBind();
    //        //CrystalReportViewer1.Refresh();
    //        //CrystalReport1 objRpt = new CrystalReport1();
    //        //objRpt.SetDataSource(ReceiptTable);
    //        //crystalReportViewer1.ReportSource = objRpt;
    //        //crystalReportViewer1.Refresh();

    //        //string appPath, physicalPath, rptName;
    //        //appPath = HttpContext.Current.Request.ApplicationPath;
    //        //physicalPath = HttpContext.Current.Request.MapPath(appPath);
    //        //rptName = physicalPath + "\\Bin\\reports\\ClientReceipt.rpt";
    //        //Rptdoc.Load(rptName);
    //        //Rptdoc.SetDataSource(ReceiptTable);
    //        //objRpt.SetDataSource(ReceiptTable);
    //        //CrystalReportViewer1.ReportSource = objRpt;
    //        //CrystalReportViewer1.Refresh();
    //        //Rptdoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "PAYMENTS");
    //        //CrystalReportViewer1.ReportSource = Rptdoc;
    //        //CrystalReportViewer1.ReportSource = Rptdoc;
    //        //CrystalReportViewer1.Refresh();
    //        //StringBuilder sb = new StringBuilder();
    //        //sb.Append("<table width='100%' cellspacing='0' cellpadding='2' border = '0'>");
    //        //sb.Append("<img src='E:\\PePay\\MoMo\\Production\\application\\apps\\Images\\Receipt.png' width='125' height='101' hspace='20' vspace='3'>");
    //        ////E:\PePay\MoMo\Production\application\apps\Images\Receipt.png
    //        //sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>PEGASUS CREDIT RECEIPT</b></td></tr>");

    //        //sb.Append("<tr><td colspan = '4'></td></tr>");


    //        //sb.Append("<tr><td colspan = '3'><b>Customer Name:</b>");
    //        //sb.Append(cust.CustomerCode);
    //        //sb.Append("</td></tr>");


    //        //sb.Append("<tr><td colspan = '3'><b>CustomerAccount :</b> ");
    //        //sb.Append(cust.CustomerAccount);
    //        //sb.Append("</td></tr>");



    //        //sb.Append("<tr><td colspan = '3'><b>Customer Credit Amount :</b> ");
    //        //sb.Append(CreditAmount+ "\t USHS");
    //        //sb.Append("</td></tr>");



    //        //sb.Append("<tr><td colspan = '3'><b>Account Balance :</b> ");
    //        //sb.Append(AccountBalanceNo +"\t USHS");
    //        //sb.Append("</td></tr>");


    //        //sb.Append("<tr><td colspan = '3'><b>Date Credited :</b> ");
    //        //sb.Append(datetoday);
    //        //sb.Append("</td></tr>");


    //        //sb.Append("</table>");

    //        //StringReader sr = new StringReader(sb.ToString());
    //        ////

    //        //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //        //using (MemoryStream memoryStream = new MemoryStream())
    //        //{
    //        //    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
    //        //    pdfDoc.Open();
    //        //    htmlparser.Parse(sr);
    //        //    pdfDoc.Close();
    //        //    byte[] bytes = memoryStream.ToArray();
    //        //    memoryStream.Close();

    //        string sendEmailsFrom = bll.DecryptString(datafile.GetSystemParameter(2, 19));
    //        //string sendEmailTo = datafile.GetVendorCodeEmail(cust.CustomerCode);


    //        MailMessage mm = new MailMessage(sendEmailsFrom, "antheamartha@yahoo.com");
    //        mm.Subject = "Pegasus Receipt";
    //        mm.Body = cust.CustomerCode + "Receipt Attachment";
    //        //mm.Attachments.Add(new Attachment(new MemoryStream(bytes), cust.CustomerCode + "\t Receipt.pdf"));
    //        Attachment attachment = new System.Net.Mail.Attachment(Rptdoc.ExportToStream(ExportFormatType.PortableDocFormat), "Report.pdf");
    //        mm.Attachments.Add(attachment);
    //        mm.IsBodyHtml = true;
    //        SmtpClient smtp = new SmtpClient();
    //        smtp.Host = "smtp.gmail.com";
    //        smtp.EnableSsl = true;
    //        NetworkCredential NetworkCred = new NetworkCredential();
    //        NetworkCred.UserName = bll.DecryptString(datafile.GetSystemParameter(2, 19)); //"antheamarthy@gmail.com";
    //        NetworkCred.Password = bll.DecryptString(datafile.GetSystemParameter(2, 20));//"steven186";
    //        smtp.UseDefaultCredentials = true;
    //        smtp.Credentials = NetworkCred;
    //        smtp.Port = 587;
    //        smtp.Send(mm);
    //    }






    //    catch (Exception ex)
    //    {
    //        throw ex;

    //    }



    //}

    private DataTable GetReceiptDataTable()
    {
        DataTable dt = new DataTable("Table2");
        // dt.Columns.Add("No.");
        dt.Columns.Add("Custname");
        dt.Columns.Add("Custref");
        dt.Columns.Add("Amount");
        dt.Columns.Add("NewBal");
        dt.Columns.Add("PaymentDate");
        //dt.Columns.Add("PrintedBy");
        //dt.Columns.Add("Str1");
        //dt.Columns.Add("Str2");
        return dt;
    }
    private void LoadCredits()
    {

        try
        {
            string custName = txtCustName.Text;
            string CustAccount = txtCustAccount.Text;
            DateTime fromdate = bll.ReturnDate(txtfromDate.Text.Trim(), 1);
            DateTime todate = bll.ReturnDate(txttoDate.Text.Trim(), 2);
            dataTable = datafile.GetCreditsToApprove(custName, CustAccount, fromdate, todate);
            if (dataTable.Rows.Count > 0)
            {
                MultiView1.ActiveViewIndex = 0;
                DataGrid1.Visible = true;
                DataGrid1.DataSource = dataTable;
                DataGrid1.CurrentPageIndex = 0;
                DataGrid1.DataBind();
                //ShowMessage(".", false);
            }
            else
            {
                MultiView1.ActiveViewIndex = -1;
                ShowMessage("No Credits To Approve", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {

    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            LoadCredits();
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    protected void DataGrid1_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        try
        {
            string custName = txtCustName.Text;
            string CustAccount = txtCustAccount.Text;
            DateTime fromdate = bll.ReturnDate(txtfromDate.Text.Trim(), 1);
            DateTime todate = bll.ReturnDate(txttoDate.Text.Trim(), 2);
            dataTable = datafile.GetCreditsToApprove(custName, CustAccount, fromdate, todate);
            MultiView1.ActiveViewIndex = 0;
            DataGrid1.DataSource = dataTable;
            DataGrid1.CurrentPageIndex = e.NewPageIndex;
            DataGrid1.DataBind();
            ShowMessage(".", false);
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }

    }
    //protected void btnApprove_Click(object sender, EventArgs e)
    //{

    //}
}
