using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Collections;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Net.Sockets;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;
using Encryption;
using InterLinkClass.EntityObjects;
using InterLinkClass.Epayment;
using InterLinkClass.PegPayApi;

public class BusinessLogin
{
    DataLogin datafile = new DataLogin();
    Datapay dalpay = new Datapay();
    DataTable datatable = new DataTable();
    DataTable dtable = new DataTable();
    DataSet dataSet = new DataSet();
    public BusinessLogin()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string EncryptString(string ClearText)
    {
        string ret = "";
        ret = Encryption.encrypt.EncryptString(ClearText, "Umeme2501PegPay");
        return ret;
    }
    public string DecryptString(string Encrypted)
    {
        string ret = "";
        ret = Encryption.encrypt.DecryptString(Encrypted, "Umeme2501PegPay");
        return ret;
    }
    public bool IsUserAccessAllowed(SystemUser user)
    {
        user.Passwd = EncryptString(user.Passwd);       
        datatable = datafile.GetUserAccessibility(user);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }

    }   
    public bool IsValidEmailAddress(string sEmail)
    {
        if (sEmail == null)
        {
            return false;
        }
        else
        {
            return Regex.IsMatch(sEmail, @"
               ^
               [-a-zA-Z0-9][-.a-zA-Z0-9]*
               @
               [-.a-zA-Z0-9]+
               (\.[-.a-zA-Z0-9]+)*
               \.
               (
               com|edu|info|gov|int|mil|net|org|biz|
               name|museum|coop|aero|pro
               |
               [a-zA-Z]{2}
               )
               $",
            RegexOptions.IgnorePatternWhitespace);
        }
    }
    public bool IsValidEmailAddressOptional(string sEmail)
    {
        if (sEmail == null)
        {
            return true;
        }
        else
        {
            return Regex.IsMatch(sEmail, @"
               ^
               [-a-zA-Z0-9][-.a-zA-Z0-9]*
               @
               [-.a-zA-Z0-9]+
               (\.[-.a-zA-Z0-9]+)*
               \.
               (
               com|edu|info|gov|int|mil|net|org|biz|
               name|museum|coop|aero|pro
               |
               [a-zA-Z]{2}
               )
               $",
            RegexOptions.IgnorePatternWhitespace);
        }
    }
    public  bool UserNameExists(string userName)
    {
        datatable = datafile.CheckUsername(userName);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public bool PasswordExpired(DateTime DateOfChange)
    {
        int Duration = 30;
        int GroupCode = 1;
        int valueCode = 1;
        string duration = DecryptString(datafile.GetSystemParameter(GroupCode, valueCode));
        Duration = Convert.ToInt16(duration);
        DateTime Today = DateTime.Now;
        TimeSpan t = Today.Subtract(DateOfChange);
        double dateDiff = t.TotalDays;
        if (dateDiff > Duration)
        {
            return true;
        }
        else
        {
            return false;
        }

    }
    public double IsRemainingDays(DateTime DateOfChange)
    {        
        int WarningAt = 5;
        int Duration = 30;
        int GroupCode = 1;
        int valueCode = 1;
        string duration = DecryptString(datafile.GetSystemParameter(GroupCode, valueCode));
        Duration = Convert.ToInt16(duration);
        DateTime Today = DateTime.Now;
        TimeSpan t = Today.Subtract(DateOfChange);
        double dateDiff = t.TotalDays;
        double Remaining = Duration - dateDiff;
        return Remaining;
    }
    public bool NameExists(string AreaName)
    {
        datatable = datafile.GetAreaByName(AreaName);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public DateTime ReturnDate(string date, int type)
    {
        DateTime dates;

        if (type == 1)
        {

            if (date == "")
            {
                dates = DateTime.Parse("January 1, 2012");
            }
            else
            {
                dates = DateTime.Parse(date);
            }
        }
        else
        {
            if (date == "")
            {
                dates = DateTime.Now;
            }
            else
            {
                dates = DateTime.Parse(date);
            }
        }

        return dates;
    }
    public bool AreaHasBranches(int AreaID)
    {
        int foundRows = datafile.GetNumberOfBranches(AreaID);
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    internal bool NamesExist(SystemUser user)
    {       
        datatable = datafile.GetUserByNames(user);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    internal bool IsRightOldPassword(SystemUser user)
    {       
        user.Passwd= EncryptString(user.Opasswd);
        datatable = datafile.GetUserAccessibility(user);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        }    
    }
    public bool ManualReceiptExists(string ReceiptNo)
    {
        datatable = dalpay.GetReceiptNumber(ReceiptNo);
        int foundRows = datatable.Rows.Count;
        if (foundRows > 0)
        {
            return true;
        }
        else
        {
            return false;
        } 
    }
    public string GetFileApplicationPath(string VendorCode)
    {
        int GlobalCode = 6;
        int ValueCode = 1;
        string strPath = datafile.GetSystemParameter(GlobalCode,ValueCode);
        if (strPath.Equals(""))
        {
            strPath = "C:\\Certificates\\";
        }
        strPath = strPath + "\\" + VendorCode;
        CheckPath(strPath);
        return strPath;
    }
    private void CheckPath(string Path)
    {
        if (!Directory.Exists(Path))
        {
            Directory.CreateDirectory(Path);
        }
    }
    public string GetPasswordString()
    {
        int intMin = 0;
        int intMax = 9;
        int strMin = 0;
        int strMax = 25;
        string[] alphabet = new string[26];
        alphabet[0] = "A";
        alphabet[1] = "B";
        alphabet[2] = "C";
        alphabet[3] = "D";
        alphabet[4] = "E";
        alphabet[5] = "F";
        alphabet[6] = "G";
        alphabet[7] = "H";
        alphabet[8] = "I";
        alphabet[9] = "J";
        alphabet[10] = "K";
        alphabet[11] = "L";
        alphabet[12] = "M";
        alphabet[13] = "N";
        alphabet[14] = "O";
        alphabet[15] = "P";
        alphabet[16] = "Q";
        alphabet[17] = "R";
        alphabet[18] = "S";
        alphabet[19] = "T";
        alphabet[12] = "U";
        alphabet[21] = "V";
        alphabet[22] = "W";
        alphabet[23] = "X";
        alphabet[24] = "Y";
        alphabet[25] = "Z";
        string pass = "";
        Random random1 = new Random();
        Random random = new Random();
        while (pass.Length < 10)
        {
            if (pass.Length == 2 || pass.Length == 5 || pass.Length == 6)
            {
                int rand = random1.Next(strMin, strMax);
                string letter = alphabet[rand];
                pass = pass + letter;
            }
            else
            {
                int randomno = random.Next(intMin, intMax);
                pass = pass + randomno.ToString();
            }
        }
        return pass;
    }
    public string ReconFilePath(string VendorCode, string fileName)
    {
        string filename = Path.GetFileName(fileName);
        string filePath = "E:\\Interface\\Reconciliation\\" + VendorCode + "\\Reconciled\\";
        string filepath = filePath + filename;
        CheckPath(filePath);
        return filepath;
    }
    public string UploadFilePath(string UtilityCode, string fileName)
    {
        string filename = Path.GetFileName(fileName);
        string filePath = "D:\\Interface\\CustFileUploads\\" + UtilityCode + "\\Uploads\\";
        string filepath = filePath + filename;
        CheckPath(filePath);
        return filepath;
    }
    public void SendMailViaGoogle(string mailTo, string message)
    {
        SmtpClient client = new SmtpClient();
        client.Credentials = new NetworkCredential("jab.arajab@gmail.com", "jabqas2012");
        client.Port = 587;
        client.Host = "smtp.gmail.com";
        client.EnableSsl = true;

        try
        {
            MailAddress
                maFrom = new MailAddress("sender_email@domain.tld", "COLLECTION", Encoding.UTF8),
                maTo = new MailAddress("recipient_email@domain2.tld", "Recipient's Name", Encoding.UTF8);
            MailMessage mmsg = new MailMessage(maFrom, maTo);
            mmsg.Body = "<html><body><h1>" + message + "</h1></body></html>";
            mmsg.BodyEncoding = Encoding.UTF8;
            mmsg.IsBodyHtml = true;
            mmsg.Subject = "ACCESS CREDENTIALS";
            mmsg.SubjectEncoding = Encoding.UTF8;
            client.Send(mmsg);

        }
        catch (Exception ex)
        {
            throw ex;
            //throw;
        }
    }
    public DataTable GetFailedReconTable()
    {
        DataTable dt = new DataTable("Table2");
        dt.Columns.Add("No.");
        dt.Columns.Add("VendorRef");
        dt.Columns.Add("PayDate");
        dt.Columns.Add("TransactionAmount");
        dt.Columns.Add("Reason");
        return dt;
    }
    public DataTable GetAgentTotalTable()
    {
        DataTable dt = new DataTable("Table2");
        dt.Columns.Add("No.");
        dt.Columns.Add("VendorCode");
        dt.Columns.Add("Vendor");
        dt.Columns.Add("Amount");
        return dt;
    }
    public string BuildBatchfile(string BatchCode,string BillCode,int trans,double total)
    {
        int new_trans = trans + 1;
        DateTime now = DateTime.Now;
        string strdt = now.ToString("dMMyy");
        string name = "C"+BillCode + "" + strdt;
        string filename = name + ".txt";    
        int GroupCode = 6;
        int ValueCode = 2;
        string reportFolder = datafile.GetSystemParameter(GroupCode, ValueCode);
        if (reportFolder.Equals(""))
        {
            reportFolder = "C:\\Interface\\BatchFiles\\";
        }
        CheckPath(reportFolder);
        TextWriter tw = new StreamWriter(reportFolder + filename);
        try
        {
            tw.WriteLine("000CSU" + DateTime.Now.ToString("yyyyMMdd") + "000000" + BillCode.PadLeft(3, ' ') + "1".PadLeft(4, ' ') + "" + new_trans.ToString().PadLeft(6, ' ') + "" + total.ToString().PadLeft(12, ' '));//File Header
            /// Details
            DataTable dtpayments = datafile.GetTransByBatch(BatchCode);
            string[] batchArray = BatchCode.Split('-');
            string batchno = batchArray[1].ToString();
            foreach (DataRow dr in dtpayments.Rows)
            {
                string RecieptNo = dr["Receiptno"].ToString();
                string ChequeNo = "";
                string custaccount = dr["CustomerRef"].ToString();
                DateTime payDate = DateTime.Parse(dr["PayDate"].ToString());
                string payDateStr = payDate.ToString("yyyyMMdd");
                DateTime postDate = DateTime.Parse(dr["PostDate"].ToString());
                string postDateStr = payDate.ToString("yyyyMMdd");
                double amount = double.Parse(dr["TranAmount"].ToString());
                //string PaymentTypeCode = dr["PaymentType"].ToString();
                string PaymentTypeCode = "2";
                string line = batchno.PadLeft(8, ' ') + "" + RecieptNo.PadLeft(10, '0') + "" + BillCode + "" + custaccount.PadLeft(10, ' ') + " " + PaymentTypeCode+"N" + ChequeNo.PadLeft(16, ' ') + "" + payDateStr + "" + postDateStr + "" + amount.ToString().PadLeft(12, ' ') + "" + "".PadLeft(4, ' ');
                tw.WriteLine(line);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            tw.Close();
        }
        string fullPath = reportFolder + "\\" + filename;
        return fullPath;  
    }
    private string SpaceCreator(int x)
    {
        string s = "";
        for (int i = 0; i < x; i++)
        {
            s = s + " ";
        }
        return s;
    }

    public void RemoveFile(string Filepath)
    {
        File.Delete(Filepath);
    }
    public void EmptyFolder(DirectoryInfo directoryInfo)
    {
        foreach (FileInfo file in directoryInfo.GetFiles())
        {

            file.Delete();
        }
    }
    private bool RemoteCertValidation(Object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
    {
        return true;
    }
    public string GetServerStatus()
    {
        PegPay ep = new PegPay();
        System.Net.ServicePointManager.ServerCertificateValidationCallback = RemoteCertValidation;
        string status = ep.GetServerStatus();
        return status;
    }
    public InterLinkClass.Epayment.Customer InquireCust(string custRef)
    {
        EPayment ep = new EPayment();
        InterLinkClass.Epayment.Customer cust = new InterLinkClass.Epayment.Customer();
        string Vendorcode = HttpContext.Current.Session["DistrictCode"].ToString();
        datatable = datafile.GetVendorDetails(Vendorcode);
        if (datatable.Rows.Count > 0)
        {
            string passwd = datatable.Rows[0]["VendorPassword"].ToString();
            string dpassword = DecryptString(passwd);
            System.Net.ServicePointManager.ServerCertificateValidationCallback = RemoteCertValidation;
            cust = ep.ValidateCustomer(custRef, Vendorcode, dpassword);
        }
        else
        {
            cust.StatusCode = "NIL";
            cust.StatusDescription = "Your District have no access to transact on the interface, contact administrator";
        }
        return cust;

    }
    public Responseobj PostInternalPayment(InterLinkClass.Epayment.Transaction tr,bool sms)
    {
        Responseobj ret = new Responseobj();
        if (!IsduplicateVendorRef(tr))
        {
            string recieptNo = dalpay.PostUmemeTransaction(tr);
            if (!recieptNo.Equals(""))
            {
                string res_log = dalpay.LogInternaltran(recieptNo, tr.Teller);
                if (res_log.Equals("LOGGED"))
                {
                    // Now Reconcile the transaction
                    string res_reconcile = Reconcile_InternalTrans(recieptNo, tr.Teller);
                    ret.Errorcode = "0";
                    if (res_reconcile.Equals("RECONCILED"))
                    {
                        ret.Message = "Transaction Posted Successfully [" + recieptNo + "]";
                    }
                    else
                    {
                        ret.Message = "Transaction Posted Successfully [" + tr.VendorTranId + "] but Reconciled failed, Please reconciled it";
                    }
                    SendSms(tr, recieptNo,sms);
                }
            }
            else
            {
                ret.Errorcode = "100";
                ret.Message = "Failure To Process Transaction Receipt number";
            }
        }
        else
        {
            ret.Errorcode = "20";
            ret.Message = dalpay.GetStatusDescr(ret.Errorcode);

        }
        return ret;
    }

    public void SendSms(InterLinkClass.Epayment.Transaction trans, string receiptNo,bool sms)
    {
        try
        {
            if (sms)
            {
                if (!trans.CustomerTel.Equals(""))
                {
                    double amt = double.Parse(trans.TranAmount);
                    double amt1 = amt - (amt * 2);
                    string amount = amt.ToString("#,##0");
                    string msg = "";
                    if (amt > 0)
                    {
                        msg = "Dear " + trans.CustomerName + ", payment of " + amount + " for a/c " + trans.CustomerRef + " received by UMEME. Payment Ref. is " + receiptNo;
                    }
                    else
                    {
                        if (trans.TranType.ToUpper().Contains("CHEQUE"))
                        {
                            msg = "Dear " + trans.CustomerName + ", cheque payment of " + amt1.ToString("#,##0") + " for a/c " + trans.CustomerRef + " has been reversed. Payment Ref. is " + receiptNo;
                        }
                        else
                        {
                            msg = "Dear " + trans.CustomerName + ", payment of " + amt1.ToString("#,##0") + " for a/c " + trans.CustomerRef + " has been reversed. Payment Ref. is " + receiptNo;
                        }
                    }
                    dalpay.InsertSmsToSend(trans.CustomerTel, trans.CustomerName, trans.CustomerRef, msg, "UMEME", "PEGPAY");
                    dalpay.UpdateLoggedSms(receiptNo);
                }
            }
        }
        catch (Exception ex)
        {
            ////
        }
    }

    public string Reconcile_InternalTrans(string recieptNo,string createdby)
    {
        string res = "";
        int BatchNo = dalpay.SaveReconBatch(0, 0, 0, 0, createdby);
        int recordid = GetRecordIDByReceipt(recieptNo);
        if (!recordid.Equals(0))
        {
            string ReconType = "MR";
            string source = "RECEIVED";
            dalpay.ReconcileTransaction(recordid, BatchNo, source, ReconType, createdby);
            dalpay.SaveReconBatch(BatchNo, 1, 0, 1, createdby);
            res = "RECONCILED";
        }
        else
        {
            res = "NOT RECONCILED";
        }
        return res;
    }
    public bool IsduplicateVendorRef(InterLinkClass.Epayment.Transaction trans)
    {
        bool ret = false;
        DataTable dt = dalpay.GetDuplicateVendorRef(trans);
        if (dt.Rows.Count > 0)
        {
            ret = true;
        }
        else
        {
            ret = false;
        }
        return ret;
    }
    private int GetRecordIDByReceipt(string recieptNo)
    {
        int trans_Id = 0;
        datatable = dalpay.GetTransDetailsByReceipt(recieptNo);
        if (datatable.Rows.Count > 0)
        {
            string transno = datatable.Rows[0]["TranId"].ToString();
            trans_Id = int.Parse(transno);
        }
        return trans_Id;
    }
    public Responseobj PostPayment(InterLinkClass.Epayment.Transaction tr,string bal,string mreceiptno, bool cancelled, bool sms)
    {
        EPayment ep = new EPayment();
        InterLinkClass.Epayment.Response res = new InterLinkClass.Epayment.Response();
        Responseobj ret = new Responseobj();
        string Vendorcode = HttpContext.Current.Session["DistrictCode"].ToString();
        datatable = datafile.GetVendorDetails(Vendorcode);
        if (datatable.Rows.Count > 0)
        {
            string passwd = datatable.Rows[0]["VendorPassword"].ToString();
            string dpassword = DecryptString(passwd);
            double amount = double.Parse(tr.TranAmount);
            double balance = double.Parse(bal);
            int user_Id = int.Parse(HttpContext.Current.Session["UserID"].ToString());
            string regioncode = HttpContext.Current.Session["AreaCode"].ToString();
            string districtcode = HttpContext.Current.Session["DistrictCode"].ToString();

            string VendorRef = dalpay.SavePayment(tr.CustomerRef, tr.CustomerName, tr.CustomerType,tr.CustomerTel, tr.PaymentType, tr.TranType, amount, balance,
              regioncode, districtcode, tr.Reversal, tr.Teller, mreceiptno,cancelled);
            if (!VendorRef.Equals(""))
            {
                tr.VendorTranId = VendorRef;
                tr.VendorCode = districtcode;
                tr.Password = dpassword;
                if (!sms)
                {
                    tr.CustomerTel = "";
                }
                string dataToSign = tr.CustomerRef + tr.CustomerName + tr.CustomerTel + tr.CustomerType + tr.VendorTranId + tr.VendorCode + tr.Password + tr.PaymentDate + tr.PaymentType + tr.Teller + tr.TranAmount + tr.TranNarration + tr.TranType;
                tr.DigitalSignature = SignCertificate(dataToSign, districtcode);
                System.Net.ServicePointManager.ServerCertificateValidationCallback = RemoteCertValidation;                
                res = ep.PostBankUmemePayment(tr);
                if (res.StatusCode.Equals("0"))
                {
                    ret.Errorcode = res.StatusCode;
                    ret.Message = res.StatusDescription;
                    ret.Receiptno = res.ReceiptNumber;
                    ret.VendorRef = VendorRef;
                    dalpay.UpdatePayment(ret, mreceiptno, districtcode, amount, user_Id, cancelled);
                }
                else
                {
                    ret.Errorcode = res.StatusCode;
                    ret.Message = res.StatusDescription;
                    ret.Receiptno = res.ReceiptNumber;
                    /// Now Dump this failed Payment
                    dalpay.DumpPayment(VendorRef, res.StatusDescription);
                }
            }
            else
            {
                ret.Errorcode = "111";
                ret.Message = "Failed to Generate Payment Reference";
            }

            if (cancelled)
            {
                amount = 0 - amount;
                int tranamount = 0 - int.Parse(tr.TranAmount);
                tr.TranAmount = tranamount.ToString();
                tr.TranIdToReverse = VendorRef;
                tr.Reversal = "1";
                tr.TranNarration = "Manual Receipt Cancelled";
                VendorRef = dalpay.SavePayment(tr.CustomerRef, tr.CustomerName, tr.CustomerType,tr.CustomerTel, tr.PaymentType, tr.TranType, amount, balance,
               regioncode, districtcode, tr.Reversal, tr.Teller, mreceiptno, cancelled);
                if (!VendorRef.Equals(""))
                {
                    tr.VendorTranId = VendorRef;
                    tr.VendorCode = districtcode;
                    tr.Password = dpassword;
                    if (!sms)
                    {
                        tr.CustomerTel = "";
                    }
                    string dataToSign = tr.CustomerRef + tr.CustomerName + tr.CustomerTel + tr.CustomerType + tr.VendorTranId + tr.VendorCode + tr.Password + tr.PaymentDate + tr.PaymentType + tr.Teller + tr.TranAmount + tr.TranNarration + tr.TranType;
                    tr.DigitalSignature = SignCertificate(dataToSign, districtcode);
                    System.Net.ServicePointManager.ServerCertificateValidationCallback = RemoteCertValidation;
                    res = ep.PostUmemePayment(tr);
                    if (res.StatusCode.Equals("0"))
                    {
                        ret.Errorcode = res.StatusCode;
                        ret.Message = res.StatusDescription;
                        ret.Receiptno = res.ReceiptNumber;
                        ret.VendorRef = VendorRef;
                        dalpay.UpdatePayment(ret, mreceiptno, districtcode, amount, user_Id, cancelled);
                    }
                    else
                    {
                        ret.Errorcode = res.StatusCode;
                        ret.Message = res.StatusDescription;
                        ret.Receiptno = res.ReceiptNumber;
                        /// Now Dump this failed Payment
                        dalpay.DumpPayment(VendorRef, res.StatusDescription);
                    }
                }
                else
                {
                    ret.Errorcode = "111";
                    ret.Message = "Failed to Generate Payment Reference";
                }
            }

        }
        else
        {
            ret.Errorcode = "NIL";
            ret.Message = "Your District have no access to transact on the interface, contact administrator";
        }
        /// 
       
        return ret;
    }
    public static string SignCertificate(string text, string districtcode)
    {
        // Open certificate store of current user
        //X509Store my = new X509Store(StoreName.My, StoreLocation.CurrentUser);
        X509Store my = new X509Store(districtcode, StoreLocation.LocalMachine);
        my.Open(OpenFlags.ReadOnly);

        // Look for the certificate with specific subject 
        RSACryptoServiceProvider csp = null;
        foreach (X509Certificate2 cert in my.Certificates)
        {
            //if (cert.Subject.Contains("CN=WINGROUP\\micwein"))
            if (cert.Subject.Contains(districtcode))
            {
                // retrieve private key
                csp = (RSACryptoServiceProvider)cert.PrivateKey;
            }
        }
        if (csp == null)
        {
            throw new Exception("Valid certificate was not found");
        }

        // Hash the data
        SHA1Managed sha1 = new SHA1Managed();
        //UnicodeEncoding encoding = new UnicodeEncoding();
        ASCIIEncoding encoding = new ASCIIEncoding();
        byte[] data = encoding.GetBytes(text);
        byte[] hash = sha1.ComputeHash(data);
        byte[] sig = csp.SignHash(hash, CryptoConfig.MapNameToOID("SHA1"));
        string strSig = Convert.ToBase64String(sig);
        // Sign the hash
        return strSig;
    }

    internal string ReversePayment(int recordid, string naration)
    {
        string ret = "";
        InterLinkClass.Epayment.Transaction tr = new InterLinkClass.Epayment.Transaction();
        Responseobj resp = new Responseobj();
        datatable = dalpay.GetPaymentById(recordid);
        if (datatable.Rows.Count > 0)
        {
            string oldreceiptno = datatable.Rows[0]["RecieptNo"].ToString();
            string oldvendorref = datatable.Rows[0]["VendorRef"].ToString();
            string custref = datatable.Rows[0]["Custref"].ToString();
            string Custname = datatable.Rows[0]["Custname"].ToString();
            string CustType = datatable.Rows[0]["CustType"].ToString();
            string Phone = datatable.Rows[0]["CustPhone"].ToString();//CustPhone
            string PaymentMode = datatable.Rows[0]["PaymentMode"].ToString();
            string PaymentType = datatable.Rows[0]["PaymentType"].ToString();
            double amount = double.Parse(datatable.Rows[0]["amount"].ToString());
            double Balance = double.Parse(datatable.Rows[0]["Balance"].ToString());
            string Postedby = datatable.Rows[0]["PostedBy"].ToString();            
            DateTime PayDate = DateTime.Parse(datatable.Rows[0]["PaymentDate"].ToString());
            ////
            tr.TranIdToReverse = oldvendorref;
            tr.CustomerRef = custref;
            tr.CustomerName = Custname;
            tr.CustomerType = CustType;
            tr.CustomerTel = Phone;
            tr.TranType = PaymentMode;
            tr.PaymentType = PaymentType;
            double amt =  0 - amount;
            double bal = 0 - Balance;
            tr.TranAmount = amt.ToString();            
            tr.Reversal = "1";
            tr.TranNarration = naration;
            tr.Teller = Postedby;
            tr.PaymentDate = PayDate.ToString("dd/MM/yyyy");
            resp = PostPayment(tr, bal.ToString(), "", false, true);
            if (resp.Errorcode.Equals("0"))
            {
                string newvendorref = resp.VendorRef;
                string newreceiptno = resp.Receiptno;
                string user = HttpContext.Current.Session["Username"].ToString();
                dalpay.SavePaymenReversal(oldvendorref, newvendorref, oldreceiptno, newreceiptno, user);
                ret = "POSTED";
            }
            else
            {
                ret = resp.Message;
            }
        }
        else
        {
            ret = "Failed to locate origin payment details";
        }
        return ret;
    }

    internal bool IsTokenIn(int TellerID, DateTime date, string DistrictCode)
    {
        datatable = datafile.GetTellerSession(TellerID, date, DistrictCode);
        if (datatable.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public bool IsvalidToken()
    {
        int userid = int.Parse(HttpContext.Current.Session["UserID"].ToString());
        string districtCode = HttpContext.Current.Session["DistrictCode"].ToString();
        DateTime date = DateTime.Now;
        datatable = datafile.GetTellerSession(userid, districtCode, date);
        if (datatable.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    internal bool IsCurrentDate(DateTime date)
    {
        DateTime now = DateTime.Now;
        string str_now = now.ToString("ddMMyyyy");
        string str_date = date.ToString("ddMMyyyy");
        if (str_date.Equals(str_now))
        {
            return true;
        }
        else
        {
            return false;
        }

    }   
    public string isValidManualReceipt(string receiptNo,string Amt)
    {
        string ret = "";
        int receipt_no = int.Parse(receiptNo);
        double amount = double.Parse(Amt);
        string teller = HttpContext.Current.Session["UserID"].ToString();
        string districtcode = HttpContext.Current.Session["DistrictCode"].ToString();
        string district = HttpContext.Current.Session["DistrictName"].ToString();
        int tellerID = int.Parse(teller);
        dtable = dalpay.CheckReceiptRange(districtcode, tellerID);
        if (dtable.Rows.Count > 0)
        {
            int start_point = int.Parse(dtable.Rows[0]["StartOn"].ToString());
            int end_point = int.Parse(dtable.Rows[0]["EndAt"].ToString());
            int level_point = int.Parse(dtable.Rows[0]["LevelAt"].ToString());
            double bal = double.Parse(dtable.Rows[0]["Balance"].ToString());
            int new_point = level_point + 1;
            if (receipt_no < start_point)
            {
                ret = "Receipt Number[" + receiptNo + "] is less than " + district + " range";
            }
            else if (receipt_no > end_point)
            {
                ret = "Receipt Number[" + receiptNo + "] is out of " + district + " range";
            }
            else
            {
                if (receipt_no < level_point)
                {
                    ret = "Duplicate Receipt Number[" + receiptNo + "]";
                }
                else if (receipt_no != new_point)
                {
                    ret = "Unexpected Receipt Number[" + receiptNo + "], Expecting " + new_point;
                }
                else if (amount > bal)
                {
                    ret = amount.ToString("#,##0") + " is greater than the balance on the receipt range";
                }
                else
                {
                    ret = "YES";
                }
            }
        }
        else
        {
            ret = "No Active Manual Receipt Range in System for " + district + " Please Contact Your Supervisor";
        }
        return ret;
    }
    internal string ReceiptRangeExists(int recordId,int startpoint, int endpoint, string districtcode)
    {
        string ret = "";
        datatable = dalpay.CheckReceiptRange(districtcode, 0);
        if (datatable.Rows.Count > 0)
        {
            int record = int.Parse(datatable.Rows[0]["RecordID"].ToString());
            int start = int.Parse(datatable.Rows[0]["StartOn"].ToString());
            int end = int.Parse(datatable.Rows[0]["EndAt"].ToString());            
            if (recordId == record)
            {
                dtable = dalpay.GetFormerReceipt(districtcode, recordId);
                if (dtable.Rows.Count > 0)
                {
                    int formerStart = int.Parse(dtable.Rows[0]["StartOn"].ToString());
                    int formerEnd = int.Parse(dtable.Rows[0]["EndAt"].ToString());
                    if (startpoint <= formerEnd)
                    {
                        ret = startpoint.ToString() + " Starting Point is already in another range";
                    }
                    else if (endpoint <= formerEnd)
                    {
                        ret = endpoint.ToString() + " Ending Point is already in the System";
                    }
                    else
                    {
                        ret = "YES";
                    }
                }
                else
                {
                    ret = "YES";
                }
            }
            else
            {
                if (startpoint <= start)
                {
                    ret = startpoint.ToString() + " Starting Point is already in the System";
                }
                else if (endpoint <= end)
                {
                    ret = endpoint.ToString() + " Ending Point is already in the System";
                }
                else if (startpoint <= end)
                {
                    ret = startpoint.ToString() + " Start Point is already in another range";
                }
                else
                {
                    ret = "YES";
                }
            }
        }
        else
        {
            ret = "YES";
        }
        return ret;
    }

    internal string RangeIn(string districtcode,int cashier, int record_id)
    {
        string ret = "";
        dtable = dalpay.CheckReceiptRange(districtcode, cashier);
        if (dtable.Rows.Count > 0)
        {
            bool is_active = bool.Parse(dtable.Rows[0]["Active"].ToString());
            int recordId = int.Parse(dtable.Rows[0]["RecordID"].ToString());
            if (record_id.Equals(recordId))
            {
                ret = "NO";
            }
            else if (is_active)
            {
                ret = "THERE IS AN ACTIVE RECEIPT RANGE IN THE SYSTEM";
            }
            else
            {
                ret = "NO";
            }
        }
        else
        {
            ret = "NO";
        }
        return ret;
    }
    public string PasswdString(int size)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }

        return builder.ToString();
    }


    internal bool IsSubEmail(string email)
    {
        datatable = datafile.GetErrorSubByEmail(email);
        if (datatable.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    internal bool IsSubPhone(string phone)
    {
        datatable = datafile.GetErrorSubByPhone(phone);
        if (datatable.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public string FormatPhoneNumber(string number)
    {
        if (number.Length == 9)
        {
            number = "256" + number;
        }
        else if (number.Length == 10 && number.StartsWith("0"))
        {
            number = number.Remove(0, 1);
            number = "256" + number;
        }
        else if (number.StartsWith("+") && number.Length == 13)
        {
            number = number.Remove(0, 1);
        }
        return number;
    }

    public string IsPerpaymentVendorDetails(Merchant merchant)
    {
        string res = "";
        if (!merchant.Active)
        {
            res = "OK";
        }
        else
        {
            if (merchant.ClientId.Equals(""))
            {
                res = "Please Provide Prepayment Vending Client ID";
            }
            else if (merchant.TerminalId.Equals(""))
            {
                res = "Please Provide Prepayment Vending Terminal ID";
            }
            else if (merchant.OperatorId.Equals(""))
            {
                res = "Please Provide Prepayment Vending Operator ID";
            }
            else if (merchant.Password.Equals(""))
            {
                res = "Please Provide Prepayment Vending Password";
            }
            else
            {
                res = "OK";
            }
        }
        return res;
    }
    public string CreditAccount(string CompanyCode, string Account, double Amount)
    {
        try
        {
            string status = "";
            string recordedBy = HttpContext.Current.Session["UserName"].ToString();
            datafile.CreditAccountWithTelecomId(CompanyCode, Account, Amount, recordedBy);
            status = "OK";
            return status;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

}
