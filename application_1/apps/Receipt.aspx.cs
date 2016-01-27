using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.Epayment;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using CrystalDecisions.Shared;
using InterLinkClass.CoreBankingApi;

public partial class Receipt : System.Web.UI.Page
{
    private ReportDocument Rptdoc = new ReportDocument();
    Datapay datapay = new Datapay();
    DataTable dataTable = new DataTable();
    DataTable dtable = new DataTable();
    Bussinesslogic bll = new Bussinesslogic();
    DatabaseHandler dh = new DatabaseHandler();
    Bank usersBank = new Bank();



    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string Id = Request.QueryString["Id"];
            string Code = Request.QueryString["BankCode"];

            if ((Session["User"] == null) || Id == null || Code == null || Session["UsersBank"] == null)
            {
                Response.Redirect("Default.aspx", false);
            }
            else if (IsPostBack)
            {


            }
            else
            {
                usersBank = Session["UsersBank"] as Bank;
                LoadData(Id, Code);
                MultiView1.ActiveViewIndex = 0;
            }

        }
        catch (NullReferenceException ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
    }

    private void LoadData(string vendorref, string BankCode)
    {
        string[] parameters = { vendorref, BankCode };
        DataTable dataTable = dh.ExecuteSelect("GetTransactionRequestDetails", parameters).Tables[0];
        if (dataTable.Rows.Count > 0)
        {
            DataRow dr = dataTable.Rows[0];
            string status = dr["Status"].ToString().ToUpper();
            if (status == "SUCCESS")
            {
                lblcode.Text = BankCode;
                lblAgentRef.Text = vendorref;
                lblamount.Text = dr["TranAmount"].ToString();
                lblcashier.Text = dr["Teller"].ToString();
                lblCustname.Text = dr["CustomerName"].ToString();
                lblAccountRef.Text = dr["AccountNumber"].ToString();
                lblPayDate.Text = dr["PaymentDate"].ToString();
                lblRecieptno.Text = dr["Reason"].ToString();
                lblTitle.Text = "Payment Reciept";
                lblTranCategory.Text = dr["TranCategory"].ToString();
                lblBranchCode.Text = dr["BranchCode"].ToString();
                lblBankCode.Text = BankCode;
                Label1.Text = usersBank.BankName;
                logo1.Attributes["src"] = @"Images\"+usersBank.BankCode+@"\"+ usersBank.PathToLogoImage;
                logo2.Attributes["src"] = @"Images\" + usersBank.BankCode + @"\" + usersBank.PathToLogoImage;
                
            }
            else
            {
                throw new Exception("No Successfull Bank Transaction has been found with Id Specified");
            }
        }
        else
        {
            throw new Exception("Bank Transaction with Id Specified Not Found");
        }
    }


    private void Page_Unload(object sender, EventArgs e)
    {
        if (Rptdoc != null)
        {
            Rptdoc.Close();
            Rptdoc.Dispose();
            GC.Collect();
        }
    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        try
        {
            string pageto = "Transact.aspx";//Session["frompage"].ToString();
            Response.Redirect(pageto, true);
        }
        catch (NullReferenceException ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
            Response.Redirect("LoggedInStartPage.aspx");
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }

    }


    private void LoadReceiptRpt(string vendorref, string BankCode)
    {
        Responseobj res = new Responseobj();
        string[] parameters = { vendorref, BankCode };
        DataTable dataTable = dh.ExecuteSelect("GetTransactionRequestDetails", parameters).Tables[0];
        if (dataTable.Rows.Count > 0)
        {
            dataTable = formatTable(dataTable);

            MultiView1.ActiveViewIndex = 1;
            string appPath, physicalPath, rptName;
            appPath = HttpContext.Current.Request.ApplicationPath;
            physicalPath = HttpContext.Current.Request.MapPath(appPath);

            rptName = physicalPath + "\\Bin\\Reports\\Receipt.rpt";

            Rptdoc.Load(rptName);
            Rptdoc.SetDataSource(dataTable);
            CrystalReportViewer1.ReportSource = Rptdoc;
            Rptdoc.PrintOptions.PaperSize = PaperSize.PaperEnvelopeDL;
            Hidetoolbar();
        }
        else
        {
            string msg = "Failed: Record of a Transaction with this Id not found";
            bll.ShowMessage(lblmsg, msg, true);
        }
    }

    private void Hidetoolbar()
    {
        CrystalReportViewer1.HasCrystalLogo = false;
        CrystalReportViewer1.HasRefreshButton = false;
        CrystalReportViewer1.HasExportButton = false;
        CrystalReportViewer1.HasPageNavigationButtons = false;
        CrystalReportViewer1.HasSearchButton = false;
        CrystalReportViewer1.HasToggleGroupTreeButton = false;
        CrystalReportViewer1.HasPrintButton = false;
        CrystalReportViewer1.HasViewList = false;
        CrystalReportViewer1.HasZoomFactorList = false;
        CrystalReportViewer1.HasGotoPageButton = false;
        CrystalReportViewer1.HasToggleGroupTreeButton = false;
        CrystalReportViewer1.DisplayGroupTree = false;
    }

    private DataTable formatTable(DataTable dataTable)
    {
        DataTable formedTable;
        string pagefrom = Session["frompage"].ToString();
        string Header = "";

        DataColumn myDataColumn = new DataColumn();
        myDataColumn.DataType = System.Type.GetType("System.String");
        myDataColumn.ColumnName = "Title";
        dataTable.Columns.Add(myDataColumn);
        // Add data to the new columns

        //dataTable.Rows[0]["Title"] = Header;
        formedTable = dataTable;
        return formedTable;
    }

    private DataTable formatTokenTable(DataTable dataTable)
    {
        DataTable formedTable;
        string pagefrom = Session["frompage"].ToString();
        string Header = "";
        if (pagefrom.ToUpper().Equals("MAKEPAYMENT.ASPX"))
        {
            Header = "";
        }
        else
        {
            Header = "DUPLICATE TOKEN";
        }

        DataColumn myDataColumn = new DataColumn();
        myDataColumn.DataType = System.Type.GetType("System.String");
        myDataColumn.ColumnName = "Str1";
        dataTable.Columns.Add(myDataColumn);
        // Add data to the new columns

        dataTable.Rows[0]["Str1"] = Header;
        formedTable = dataTable;
        return formedTable;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            string receiptno = lblcode.Text.Trim();
            string vendorRef = lblvendorcode.Text.Trim();
            LoadReceiptRpt(receiptno, vendorRef);

            Rptdoc.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "RECEIPT(" + receiptno + ")");

        }
        catch (NullReferenceException exe)
        {
            Response.Redirect("Default.aspx?login=1", false);

        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true);
        }
    }

    private string bankCode;

    public string BankCode
    {
        get { return bankCode; }
        set { bankCode = value; }
    }
}
