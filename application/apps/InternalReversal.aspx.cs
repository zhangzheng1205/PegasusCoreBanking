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
using InterLinkClass.EntityObjects;

public partial class InternalReversal : System.Web.UI.Page
{
    ProcessPay Process = new ProcessPay();
    DataLogin datafile = new DataLogin();
    Datapay datapay = new Datapay();
    BusinessLogin bll = new BusinessLogin();
    DataTable dataTable = new DataTable();
    DataTable dtable = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (IsPostBack == false)
            {                
                MultiView2.ActiveViewIndex = 0;
                MultiView3.ActiveViewIndex = 0;
                Button1.Enabled = false;        
                Button MenuTool = (Button)Master.FindControl("btnCallSystemTool");
                Button MenuPayment = (Button)Master.FindControl("btnCallPayments");
                Button MenuReport = (Button)Master.FindControl("btnCalReports");
                Button MenuRecon = (Button)Master.FindControl("btnCalRecon");
                Button MenuAccount = (Button)Master.FindControl("btnCallAccountDetails");
                Button MenuBatching = (Button)Master.FindControl("btnCallBatching");
                MenuTool.Font.Underline = false;
                MenuPayment.Font.Underline = true;
                MenuReport.Font.Underline = false;
                MenuRecon.Font.Underline = false;
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
        Button1.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button1, "").ToString());
        Button2.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button2, "").ToString());
        Button3.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button3, "").ToString());
        Button4.Attributes.Add("onclick", strProcessScript + ClientScript.GetPostBackEventReference(Button4, "").ToString());
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            string accountNo = "";
            string vendorref = txtreceiptno.Text.Trim();
            InquirePayment(vendorref,accountNo);
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }

    private void InquirePayment(string vendorref,string accountNo)
    {        
        if (vendorref.Equals(""))
        {
            ShowMessage("Please Enter Agent Transaction Ref To Reverse", true);
            ClearContrls2();
            Button1.Enabled = false;
            txtreceiptno.Focus();
        }
        else
        {
            ShowMessage(".", true);
            dtable = datapay.GetTransactionsbyRef(vendorref, accountNo, "", "");
            if (dtable.Rows.Count > 0)
            {
                int records = dtable.Rows.Count;
                if (records.Equals(1))
                {
                    bool Reversed = bool.Parse(dtable.Rows[0]["Reversal"].ToString());
                    if (!Reversed)
                    {
                        Button1.Enabled = true;
                        txtviewReceiptno.Text = dtable.Rows[0]["Str1"].ToString();
                        txtAgentRef.Text = dtable.Rows[0]["VendorTranId"].ToString();
                        txtcode.Text = dtable.Rows[0]["CustomerRef"].ToString();
                        txtname.Text = dtable.Rows[0]["CustomerName"].ToString();
                        txtpaymode.Text = dtable.Rows[0]["TranType"].ToString();
                        txtpaytype.Text = dtable.Rows[0]["PaymentType"].ToString();
                        lblcode.Text = dtable.Rows[0]["TranId"].ToString();//TranId
                        double amount = double.Parse(dtable.Rows[0]["TranAmount"].ToString());
                        DateTime paydate = DateTime.Parse(dtable.Rows[0]["PayDate"].ToString());
                        txtAmount.Text = amount.ToString("#,##0");
                        txtpaydate.Text = paydate.ToString("dd/MM/yyyy");
                        txtUser.Text = Session["FullName"].ToString();
                    }
                    else
                    {
                        ShowMessage("Transaction " + vendorref + " is already reversed", true);
                        ClearContrls2();
                        Button1.Enabled = false;
                    }
                }
                else
                {
                    ShowMessage("There are more than one transaction with Ref [" + vendorref + "]", true);
                }
            }
            else
            {
                ShowMessage("No Transaction found with Agent ref [" + vendorref + "]", true);
                ClearContrls2();
                Button1.Enabled = false;
            }

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            PostTransaction();
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }

    private void PostTransaction()
    {
        string reversal_ref = txtReversalRef.Text.Trim();
        if (!reversal_ref.Equals(""))
        {
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = 1;
            txtconfirmReceiptno.Text = txtviewReceiptno.Text.Trim();
            txtConfirmAgentRef.Text = txtAgentRef.Text.Trim();
            txtConfirmAccount.Text = txtcode.Text.Trim();
            txtconfirmpaydate.Text = txtpaydate.Text.Trim();
            txtconfirmamount.Text = txtAmount.Text.Trim();
            txtconfirmReversalRef.Text = reversal_ref;       
            string msg = "Enter Reversal Naration and Continue if you are sure";
            txtnaration.Focus();
            ShowMessage(msg, true);
        }
        else
        {
            ShowMessage("Please Enter Reversal Transaction Ref", true);
            txtReversalRef.Focus();
        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView3.ActiveViewIndex = 0;
            MultiView2.ActiveViewIndex = 0;
            txtcode.Text = "";
            txtviewReceiptno.Text = ""; 
            txtname.Text = "";
            txtreceiptno.Text = "";
            txtpaytype.Text = "";
            txtpaymode.Text = "";          
            txtAgentRef.Text = ""; 
            txtAmount.Text = "";
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView2.ActiveViewIndex = 0;
            MultiView3.ActiveViewIndex = 0;
            string msg = ".";
            ShowMessage(msg, true);
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    protected void Button4_Click1(object sender, EventArgs e)
    {
        try
        {
            string str = lblcode.Text.Trim();
            string reversal_ref = txtconfirmReversalRef.Text.Trim();
            string naration = txtnaration.Text.Trim();
            if (str.Equals(""))
            {
                MultiView2.ActiveViewIndex = 0;
                MultiView3.ActiveViewIndex = 0;
                ShowMessage("Sorry Failed to Get Transaction ID", true);
            }
            else if (naration.Equals(""))
            {
                ShowMessage("Please Enter Reversal Naration", true);
                txtnaration.Focus();
            }
            else
            {
                Responseobj res = new Responseobj();
                res = Process.InternalReversestr(str, reversal_ref, naration, false);
                if (res.Errorcode.Equals("0"))
                {
                    string recieptnumber = txtconfirmReceiptno.Text.Trim();
                    MultiView2.ActiveViewIndex = 0;
                    MultiView3.ActiveViewIndex = 0;
                    ClearContrls();
                    string msg = res.Message;
                    ShowMessage(msg, false);

                }
                else
                {
                    MultiView2.ActiveViewIndex = 0;
                    MultiView3.ActiveViewIndex = 0;
                    ShowMessage(res.Message, true);
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
        }
    }
    private void ClearContrls2()
    {
        txtAgentRef.Text = "";
        txtReversalRef.Text = "";     
        txtAmount.Text = "";   
        txtcode.Text = "";  
        txtname.Text = "";
        txtnaration.Text = "";
        txtpaydate.Text = "";
        txtpaymode.Text = "";
        txtpaytype.Text = "";     
        txtviewReceiptno.Text = "";
        txtAgentRef.Text = "";
        lblcode.Text = "0";
        txtconfirmamount.Text = "";      
        txtconfirmpaydate.Text = "";
        txtconfirmReceiptno.Text = "";
    }
    private void ClearContrls()
    {
        txtAgentRef.Text = "";
        txtAmount.Text = "";
        txtcode.Text = "";
        txtname.Text = "";
        txtnaration.Text = "";
        txtpaydate.Text = "";
        txtpaymode.Text = "";
        txtpaytype.Text = "";
        txtreceiptno.Text = "";
        txtconfirmReversalRef.Text = "";
        txtReversalRef.Text = "";        
        txtviewReceiptno.Text = "";
        lblcode.Text = "0";
        txtconfirmamount.Text = "";
        txtConfirmAgentRef.Text = "";
        txtconfirmpaydate.Text = "";
        txtconfirmReceiptno.Text = "";
        Button1.Enabled = false;
    }
    protected void DataGrid1_ItemCommand(object source, DataGridCommandEventArgs e)
    {
        try
        {
            string agentref = e.Item.Cells[2].Text;
            string account = e.Item.Cells[3].Text;
            InquirePayment(agentref, account);
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message, true);
            
        }
    }
}
