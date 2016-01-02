using System;
using System.Data;
using System.Collections;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.Epayment;
using InterLinkClass.EntityObjects;

/// <summary>
/// Summary description for ProcessPay
/// </summary>
public class ProcessPay
{
    DataLogin datafile = new DataLogin();
    Datapay datapay = new Datapay();
    BusinessLogin bll = new BusinessLogin();
    SendMail mailer = new SendMail();
    DataTable dTable = new DataTable();
    DataTable datatable = new DataTable();
    public ProcessPay()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public Responseobj InternalReversestr(string str, string reversal_ref, string naration, bool cheque)
    {
        Responseobj output = new Responseobj();
        string createdby = HttpContext.Current.Session["Username"].ToString();
        int recordid = int.Parse(str);
        datatable = datapay.Get_TransactionByTranID(recordid);
        if (datatable.Rows.Count > 0)
        {
            Transaction t = new Transaction();
            t = GetTransObject(datatable);
            t.VendorTranId = reversal_ref;
            t.Teller = createdby;
            if (!bll.IsduplicateVendorRef(t))
            {
                double amt = double.Parse(t.TranAmount);
                if (amt > 0)
                {
                    output.Errorcode = "201";
                    output.Message = "ARITHMATIC FAILURE";
                }
                else
                {
                    string recieptNo = datapay.PostUmemeTransaction(t);
                    if (!recieptNo.Equals(""))
                    {
                        string res_log = datapay.LogInternaltran(recieptNo, t.Teller);
                        if (res_log.Equals("LOGGED"))
                        {
                            string res_reconcile = bll.Reconcile_InternalTrans(recieptNo, t.Teller);
                            output.Errorcode = "0";
                            if (res_reconcile.Equals("RECONCILED"))
                            {
                                output.Message = "Transaction Posted Successfully [" + recieptNo + "]";
                            }
                            else
                            {
                                output.Message = "Transaction Posted Successfully [" + t.VendorTranId + "] but Reconciled failed, Please reconciled it";
                            }
                            bll.SendSms(t, recieptNo, true);
                        }
                    }
                }
            }
            else
            {
                output.Errorcode = "20";
                output.Message = datapay.GetStatusDescr(output.Errorcode);
            }
        }
        else
        {
            output.Errorcode = "2500";
            output.Message = "FAILED TO LOCATE MAIN TRANSACTION DETAILS";
        }
        return output;
    }

    private Transaction GetTransObject(DataTable datatable)
    {
        Transaction t = new Transaction();
        string str_amount = datatable.Rows[0]["TranAmount"].ToString();
        double amt = double.Parse(str_amount);
        double TransAmount = 0 - amt;
        t.TranAmount = TransAmount.ToString();
        t.CustomerRef = datatable.Rows[0]["CustomerRef"].ToString();
        t.CustomerType = datatable.Rows[0]["CustomerType"].ToString();
        t.CustomerName = datatable.Rows[0]["CustomerName"].ToString();
        t.TranType = datatable.Rows[0]["TranType"].ToString();
        t.PaymentType = datatable.Rows[0]["PaymentType"].ToString();
        t.CustomerTel = datatable.Rows[0]["CustomerTel"].ToString();
        t.Reversal = "1";
        t.VendorCode = datatable.Rows[0]["VendorCode"].ToString();
        t.PaymentDate = DateTime.Now.ToString("dd/MM/yyyy");
        return t;
    }
    public string Reversestr(string str, string naration,bool cheque)
    {
        string output = "";  
        int suc = 0;
        if (str.Equals(""))
        {
            output = "Please Select Payment(s) to Reverse";
        }
        else
        {
            string createdby = HttpContext.Current.Session["Username"].ToString();
            int recordid = 0;
            string[] arr = str.Split(',');
            int i = 0;
            for (i = 0; i < arr.Length; i++)
            {
                recordid = int.Parse(arr[i].ToString());
                output = bll.ReversePayment(recordid, naration);
                if (output.Equals("POSTED"))
                {
                    suc++;
                    if (cheque)
                    {
                        // Bounce Cheque Payment.
                        datapay.BounceChequePay(recordid, createdby);
                    }                    
                }
            }
            output = suc + " TRANSACTION(S) POSTED SUCCESSFULLY";
        }
        return output;
    }
    public string Binstr(string str,string trans_type)
    {
        string output = "";
        if (str.Equals(""))
        {
            output = "Please Select Transaction to archived";
        }
        else
        {
            bool trans_status = Gettrans_status(trans_type);
            string createdby = HttpContext.Current.Session["Username"].ToString();
            int recordid = 0;
            string[] arr = str.Split(',');
            int i = 0;
            for (i = 0; i < arr.Length; i++)
            {
                recordid = int.Parse(arr[i].ToString());
                datapay.BinTransaction(recordid,trans_status, createdby);
            }
            /// Update Batch Details
            output = i + " Transaction(s) have been archived";
        }
        return output;
    }
    public string Restorestr(string str)
    {
        string output = "";
        if (str.Equals(""))
        {
            output = "Please Select Transaction to Restore";
        }
        else
        {
            string createdby = HttpContext.Current.Session["Username"].ToString();
            int recordid = 0;
            string[] arr = str.Split(',');
            int i = 0;
            for (i = 0; i < arr.Length; i++)
            {
                recordid = int.Parse(arr[i].ToString());
                datapay.RestoreTransaction(recordid, createdby);
            }
            /// Update Batch Details
            output = i + " Transaction(s) have been Restored";
        }
        return output;
    }
    public bool Gettrans_status(string trans_type)
    {
        if (trans_type.Equals("1"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    public string Reconcilestr(string str)
    {
        string output = "";
        if (str.Equals(""))
        {
            output = "Please Select Transaction to Reconcile";
        }
        else
        {
            string createdby = HttpContext.Current.Session["Username"].ToString();
            string source = "RECEIVED";
            int BatchNo = datapay.SaveReconBatch(0, 0, 0, 0, createdby);
            int recordid = 0;
            string[] arr = str.Split(',');
            int i = 0;
            for (i = 0; i < arr.Length; i++)
            {
                recordid = int.Parse(arr[i].ToString());
                string ReconType = "MR";
                datapay.ReconcileTransaction(recordid, BatchNo, source, ReconType, createdby);
            }
            /// Update Batch Details
            datapay.SaveReconBatch(BatchNo, i, 0, i, createdby);
            output = i + " Transaction(s) have been reconciled";
        }
        return output;
    }
    public string Batchstr(string str, string Agentcode,string option)
    {
        string output = "";
        if (option.Equals("0"))
        {
            output = "Please Select Batch Type";
        }
        else if (str.Equals(""))
        {
            output = "Please Select Transactions to Batch";
        }
        else
        {
            string createdby = HttpContext.Current.Session["Username"].ToString();            
            int recordid = 0;
            string[] arr = str.Split(',');
            int i = 0;
            int Transactions = arr.Length;
            string BatchNo = datapay.SavePayBatch(Agentcode,Transactions,option, createdby);
            if (BatchNo.Equals(""))
            {
                output = "Failed to generate batch Number";
            }
            else
            {
                for (i = 0; i < arr.Length; i++)
                {
                    recordid = int.Parse(arr[i].ToString());
                    datapay.BatchPayment(recordid, BatchNo);
                }
                output = i + " Payments have been batched Successfully";
            }
        }
        return output;
    }
    public bool ProcessCustomer(Cust cust)
    {
        ArrayList failedCustTransactions = new ArrayList();
        bool output = false;
        //string source = "RECEIVED";
        //string reason = "";
        //dTable = datapay.GetTransactionforReconciliation(tran.VendorRef, tran.VendorCode);
        //if (dTable.Rows.Count > 0)
        //{
        //    datatable = datapay.GetCustomerDetails(cust.CustRef, cust.Utility);
        //    if (datatable.Rows.Count > 0)
        //    {
                
        //            reason = "Customer "+cust.CustRef+","+cust.CustName;
        //            tran.Reason = reason;
        //            failedBankTransactions.Add(tran);
        //            output = false;
               
        //    }
        //    else
        //    {
        //        int recordid = int.Parse(dTable.Rows[0]["TranId"].ToString());
        //        double interamount = double.Parse(dTable.Rows[0]["TranAmount"].ToString());
        //        DateTime interDate = DateTime.Parse(dTable.Rows[0]["PaymentDate"].ToString());

        //        string strInterDate = interDate.ToString("dd/MM/yyyy");
        //        string strStateDate = tran.PayDate;

        //        if (interamount.Equals(tran.TransAmount))
        //        {
        //            if (strInterDate.Equals(strStateDate))
        //            {
        //                datapay.ReconcileTransaction(recordid, Reconcode, source, tran.ReconType, tran.ReconciledBy);
        //                output = true;
        //            }
        //            else
        //            {
        //                reason = "Payment Dates dont match";
        //                tran.Reason = reason;
        //                failedBankTransactions.Add(tran);
        //                output = false;
        //            }
        //        }
        //        else
        //        {
        //            reason = "Amount in Umeme Database does not match with that on the Statement";
        //            tran.Reason = reason;
        //            failedBankTransactions.Add(tran);
        //            output = false;
        //        }
        //    }
        //}
        //else
        //{
        //    datatable = datapay.GetReconciledTransaction(tran.VendorRef, tran.VendorCode);
        //    if (datatable.Rows.Count > 0)
        //    {
        //        DateTime recondate = DateTime.Parse(datatable.Rows[0]["ReconciledDate"].ToString());
        //        string recondatestr = recondate.ToString("dd/MM/yyyy : HH:MM:ss");
        //        reason = "Transaction already reconciled on " + recondatestr;
        //        tran.Reason = reason;
        //        failedBankTransactions.Add(tran);
        //        output = false;
        //    }
        //    else
        //    {
        //        reason = "Not found in the System database";
        //        tran.Reason = reason;
        //        failedBankTransactions.Add(tran);
        //        output = false;
        //    }
        //}
        return output;
    }
    public bool ReconcileTrans(Recontran tran, ArrayList failedBankTransactions, int Reconcode)
    {
        bool output;
        string source = "RECEIVED";
        string reason = "";
        dTable = datapay.GetTransactionforReconciliation(tran.VendorRef, tran.VendorCode);
        if (dTable.Rows.Count > 0)
        {
            datatable = datapay.GetReconciledTransaction(tran.VendorRef, tran.VendorCode);
            if (datatable.Rows.Count > 0)
            {
                int ReconId = int.Parse(datatable.Rows[0]["ReconciliationCode"].ToString());
                if (ReconId.Equals(Reconcode))
                {
                    reason = "Duplicate transaction with (" + datatable.Rows[0]["TranId"].ToString() + ")";
                    tran.Reason = reason;
                    failedBankTransactions.Add(tran);
                    output = false;
                }
                else
                {
                    DateTime recondate = DateTime.Parse(datatable.Rows[0]["ReconciledDate"].ToString());
                    string recondatestr = recondate.ToString("dd/MM/yyyy : HH:MM:ss");
                    reason = "Transaction already reconciled on " + recondatestr;
                    tran.Reason = reason;
                    failedBankTransactions.Add(tran);
                    output = false;
                }
            }
            else
            {
                int recordid = int.Parse(dTable.Rows[0]["TranId"].ToString());
                double interamount = double.Parse(dTable.Rows[0]["TranAmount"].ToString());
                DateTime interDate = DateTime.Parse(dTable.Rows[0]["PaymentDate"].ToString());

                string strInterDate = interDate.ToString("dd/MM/yyyy");
                string strStateDate = tran.PayDate;

                if (interamount.Equals(tran.TransAmount))
                {
                    if (strInterDate.Equals(strStateDate))
                    {
                        datapay.ReconcileTransaction(recordid, Reconcode, source, tran.ReconType, tran.ReconciledBy);
                        output = true;
                    }
                    else
                    {
                        reason = "Payment Dates dont match";
                        tran.Reason = reason;
                        failedBankTransactions.Add(tran);
                        output = false; 
                    }
                }
                else
                {
                    reason = "Amount in Umeme Database does not match with that on the Statement";
                    tran.Reason = reason;
                    failedBankTransactions.Add(tran);
                    output = false;  
                }
            }
        }
        else
        {
            datatable = datapay.GetReconciledTransaction(tran.VendorRef, tran.VendorCode);
            if (datatable.Rows.Count > 0)
            {
                DateTime recondate = DateTime.Parse(datatable.Rows[0]["ReconciledDate"].ToString());
                string recondatestr = recondate.ToString("dd/MM/yyyy : HH:MM:ss");
                reason = "Transaction already reconciled on " + recondatestr;
                tran.Reason = reason;
                failedBankTransactions.Add(tran);
                output = false;
            }
            else
            {
                reason = "Not found in the System database";
                tran.Reason = reason;
                failedBankTransactions.Add(tran);
                output = false;
            }
        }
        return output;
    }

    public string SaveInvoiceDetails(string fname, string mname, string lname, string phone, string email, string amount)
    {
        string ret = "";
        PhoneValidator ph = new PhoneValidator();
        if (!bll.IsValidEmailAddressOptional(email))
        {
            ret = "Please Provide a valid email address";
        }
        else if (!ph.PhoneNumbersOk(phone) && !phone.Equals(""))
        {
            ret = phone + " is not a valid phone number";
        }
        else
        {

        }
        return ret;
    }

    public InvoiceTran SaveInvoiceDetails(InvoiceTran inv)
    {
        InvoiceTran resp = new InvoiceTran();
        PhoneValidator ph = new PhoneValidator();
        if (!bll.IsValidEmailAddress(inv.Email) && !inv.Email.Equals(""))
        {
            resp.ErrorCode = "1";
            resp.Error = "Please Provide a valid email address";
        }
        else if (!ph.PhoneNumbersOk(inv.Phone) && !inv.Phone.Equals(""))
        {
            resp.ErrorCode = "1";
            resp.Error = inv.Phone + " is not a valid phone number";
        }
        else
        {
            inv.PayTypeCode = datafile.GetPayTypeCodeByShortName(inv.ShortName); 
            inv.User = HttpContext.Current.Session["Username"].ToString();
            inv.RegionCode = HttpContext.Current.Session["AreaCode"].ToString();
            inv.DistrictCode = HttpContext.Current.Session["DistrictCode"].ToString();
            inv.Vat = GetVatAmount(inv);
            resp.InvoiceSerial = datapay.SaveInvoiceDetails(inv);
            if (resp.InvoiceSerial.Equals(""))
            {
                resp.ErrorCode = "1";
                resp.Error = "Failed to create Invoice serial number";
            }
            else
            {
                resp.ErrorCode = "0";
                resp.Error = "Invoice created successfully[" + resp.InvoiceSerial + "]";
            }
        }
        return resp;
    }

    private double GetVatAmount(InvoiceTran inv)
    {
        double vat = 0;
        if (inv.Vatable)
        {
            vat = inv.Amount * 0.18;
        }
        return vat;
    }
    public string SaveChequeDetails(string agentref, string chequenumber, string accountnumber, string bank, string chequeDate)
    {
        string ret = "";
        try
        {
            DateTime chqDate = DateTime.Parse(chequeDate);
            datapay.SaveChequeDatails(agentref, chequenumber, accountnumber, bank, chqDate);
            ret = "SUCCESS";
        }
        catch (Exception ex)
        {
            ret = ex.Message;
        }
        return ret;
    }
  
}
