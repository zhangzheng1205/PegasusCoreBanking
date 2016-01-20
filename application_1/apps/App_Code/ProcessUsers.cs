using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections;
using InterLinkClass.EntityObjects;

/// <summary>
/// Summary description for ProcessUsers
/// </summary>
public class ProcessUsers
{
    DataLogin datafile = new DataLogin();
    BusinessLogin bll = new BusinessLogin();
    SendMail mailer = new SendMail();
    DataTable dTable = new DataTable();
    public ProcessUsers()
    {

    }
    public void LogActivity(SystemUser user)
    {
        datafile.LogActivity(user.Uname, user.Action);
    }

    public string ChangeUserPassword(SystemUser user)
    {
        string ouput = "";
        if (user.Passwd.Equals(""))
        {
            ouput = "Please Enter New Password";
        }
        else if (user.Cpasswd.Equals(""))
        {
            ouput = "Please Confirm Password";
        }
        else if (user.Passwd != user.Cpasswd)
        {
            ouput = "Passwords do not match";
        }
        else if (!IsPasswordStrengthOk(user.Passwd))
        {
            ouput = "Your Password Strength is not ok(Password should be alpha-numeric and length of 6)";
        }
        else
        {
            string EncryptedPassword = bll.EncryptString(user.Passwd);
            datafile.UpdatePassword(user.Userid, EncryptedPassword);
            ouput = "System User Password has been Changed Successfully";
        }
        return ouput;
    }
    private bool IsPasswordStrengthOk(string Password)
    {
        if (Password.Length > 6)
        {
            if (passwordContainsIntegers(Password))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    private bool passwordContainsIntegers(string password)
    {
        bool ok = false;
        char[] chPassword = password.Trim().ToCharArray();
        ArrayList chArray = new ArrayList();
        chArray.Add('0');
        chArray.Add('1');
        chArray.Add('2');
        chArray.Add('3');
        chArray.Add('4');
        chArray.Add('5');
        chArray.Add('6');
        chArray.Add('7');
        chArray.Add('8');
        chArray.Add('9');
        foreach (char c in chPassword)
        {
            if (chArray.Contains(c))
            {
                ok = true;
                break;
            }
        }
        return ok;
    }
    public string ResetUserPassword(SystemUser user)
    {
        throw new Exception("The method or operation is not implemented.");
    }

    public string ChangeUserAccess(SystemUser user)
    {
        throw new Exception("The method or operation is not implemented.");
    }

    public string ChangeMyPassword(SystemUser user)
    {
        string ret = "";
        user.Uname = HttpContext.Current.Session["Username"].ToString();
        if (bll.IsRightOldPassword(user))
        {
            user.Passwd = user.Cpasswd;            
            ret = ChangeUserPassword(user);
        }
        else
        {
            ret = "Invalid Old Password";
        }
        return ret;
    }

    public string SaveSystemUser(SystemUser user)
    {
        string ret = "";
        if (bll.NamesExist(user) && user.Userid.Equals(0))
        {
            ret = "Account Names( " + user.Fname + " " + user.Oname + " " + user.Sname + " ) is already in the System";

        }
        else
        {
            string passwd = bll.PasswdString(8);
            if (user.Userid.Equals(0))
            {
                if (user.UserName.Equals(""))
                {
                    user.Uname = GetUserName(user).ToLower();
                }
                else
                {
                    user.Uname = user.UserName;
                }
                user.Passwd = bll.EncryptString(passwd);
            }
            else
            {
                if (user.Reset)
                {
                    user.Passwd = bll.EncryptString(passwd);
                    /// Reset Password
                    datafile.ResetPassword(user);
                }
            }
            user.User = HttpContext.Current.Session["UserName"].ToString();
            if (bll.UserNameExists(user.Uname) && user.Userid.Equals(0) && user.UserName.Equals(""))
            {
                ret = "System generated username "+user.Uname.ToString() + " already exists. Please Enter UserName & Save User again";
            }
            else if (bll.UserNameExists(user.Uname) && user.Userid.Equals(0))
            {
                ret = user.Uname+" UserName Provided already Exists";
            }
            else
            {
                datafile.SaveLoginDetails(user);
                if (user.Userid.Equals(0))
                {
                    string message = "Hello " + user.Fname + " " + user.Sname + ", \n";
                    message += "Interface Portal Credentials have been created and they are \n" + Environment.NewLine + Environment.NewLine;
                    message += " User Name : " + user.Uname + "\n" + Environment.NewLine + Environment.NewLine;
                    message += " Password : " + passwd;
                    string mailto = user.Email;
                    string subject = "INTERFACE PORTAL CREDENTIALS";
                    string name = user.Fname + " " + user.Oname + " " + user.Sname;
                    string res = mailer.GoogleMail(mailto, subject, message, name);
                    ret = "System Login created Successfully, Username [" + user.Uname + "]";
                }
                else
                {
                    if (user.Reset)
                    {
                        string message = "Hello " + user.Fname + " " + user.Sname + ",\n" + Environment.NewLine + Environment.NewLine;
                        message += "Your Interface Portal password has been reset \n" + Environment.NewLine + Environment.NewLine;
                        message += " User Name : " + user.Uname + Environment.NewLine + Environment.NewLine;
                        message += " Password : " + passwd;
                        string mailto = user.Email;
                        string subject = "INTERFACE PORTAL CREDENTIALS";
                        string name = user.Fname + " " + user.Oname + " " + user.Sname;
                        string res = mailer.GoogleMail(mailto, subject, message, name);
                    }
                    ret = "System Login Details updated Successfully";
                }
            }
        }
        return ret;
    }

    private string GetUserName(SystemUser user)
    {
        string ret = "";
        string initial = user.Fname.Substring(0, 1);
        ret = initial + "." + user.Sname;
        return ret;
    }

    public string SaveUtility(UtilityDetails utility)
    {
        string ret = "";
        utility.CreatedBy = HttpContext.Current.Session["UserName"].ToString();
        datafile.SaveUtilityDetails(utility);
        ret = "UTILITY DETAILS SUCCESSFULLY SAVED.";
        return ret;
    }
    public string SaveVendor(Vendor vendor, Merchant merchant)
    {
        string ret = "";
        vendor.User = HttpContext.Current.Session["UserName"].ToString();
        string passwd = bll.GetPasswordString();
        vendor.Passwd = bll.EncryptString(passwd);
        vendor.Status = bll.DecryptString(datafile.GetSystemParameter(3, 2));
        vendor.Subject = bll.DecryptString(datafile.GetSystemParameter(3, 1));
        vendor.Message = bll.DecryptString(datafile.GetSystemParameter(3, 3));
        datafile.SaveVendorDetails(vendor, merchant);
        if (vendor.Vendorid.Equals(0))
        {
            /// Now Notify the Person of the Vendor.
            string message = "Hello " + vendor.Contract + "\n. Your "+vendor.Status+" Vendor Credentials for the PegPay Payments Platform are" + Environment.NewLine + Environment.NewLine + "\n";
            message += " Vendor Code: " + vendor.VendorCode + Environment.NewLine + Environment.NewLine + "\n";
            message += ", Password: " + passwd + "\n . The Url for the " + vendor.Status + " PegPay Payments Platform is: " + vendor.Message;
            string mailto = vendor.Email;
            string subject = vendor.Subject+" - "+vendor.Status;
            string name = vendor.Contract;
            string res = mailer.GoogleMail(mailto, subject, message, name);
            if (res.Equals("SENT"))
            {
                ret = "Vendor Created Successfully [" + vendor.VendorCode + " - " + passwd + "]";
            }
            else
            {
                ret = "Vendor " + vendor.VendorName + " created successfully, Email failed :(" + ret + ")";
            }
        }
        else
        {
            if (vendor.Sendemail)
            {
                dTable = datafile.GetVendorById(vendor);
                if (dTable.Rows.Count > 0)
                {
                    string spasswd = dTable.Rows[0]["VendorPassword"].ToString();
                    passwd = bll.DecryptString(spasswd);
                    string message = "Hello " + vendor.Contract + "," + Environment.NewLine + Environment.NewLine + "\n";
                    message += "Your "+vendor.Status+" Vendor Credentials are" + Environment.NewLine + Environment.NewLine + "\n";
                    message += " Vendor Code: " + vendor.VendorCode + Environment.NewLine + Environment.NewLine + "\n";
                    message += ", Password: " + passwd + "\n . The Url for the " + vendor.Status + " PegPay Payments Platform is: " + vendor.Message;
                    string mailto = vendor.Email;
                    string subject = vendor.Subject + " - " + vendor.Status;
                    string name = vendor.Contract;
                    string res = mailer.GoogleMail(mailto, subject, message, name);
                    if (res.Equals("SENT"))
                    {
                        ret = vendor.VendorName + " Vendor Details Updated and Email Resent Successfully";
                    }
                    else
                    {
                        ret = vendor.VendorName + " Vendor Details Updated but Email Resending failed (" + res + ")";
                    }
                }
            }
            else if (vendor.Reset)
            {
                datafile.ResetVendorPassword(vendor);
                SystemUser user = new SystemUser();
                user.Uname = HttpContext.Current.Session["Username"].ToString();
                user.Action = "Vendor Password Reset [" + vendor.VendorCode + "]";
                LogActivity(user);
                string message = "Hello " + vendor.Contract + "," + Environment.NewLine + Environment.NewLine + "\n";
                message += "Your "+vendor.Status+" Vendor Credentials have been reset" + Environment.NewLine + Environment.NewLine + "\n";
                message += " Vendor Code: " + vendor.VendorCode + Environment.NewLine + Environment.NewLine + "\n";
                message += ", Password: " + passwd + "\r\n . The Url for the " + vendor.Status + " PegPay Payments Platform is: " + vendor.Message;
                string mailto = vendor.Email;
                string subject = vendor.Subject + " - " + vendor.Status;
                string name = vendor.Contract;
                string res = mailer.GoogleMail(mailto, subject, message, name);
                if (res.Equals("SENT"))
                {
                    ret = vendor.VendorName + " Vendor Details Updated and Email Resent Successfully";
                }
                else
                {
                    ret = vendor.VendorName + " Vendor Details Updated but Email Resend faile(" + res + ")";
                }
            }
            else
            {
                ret = vendor.VendorName + " Vendor Details Updated Successfully";
            }
        }
        return ret;
    }
    public void LoginStatus(SystemUser user)
    {
        datafile.LoginStatus(user);
    }

    public void UpdateSystemParameter(string ValueCode, string Varriable)
    {
        int valueid = int.Parse(ValueCode);
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.UpdateSystemParameter(valueid, Varriable, CreatedBy);
    }

    public string SaveAreaDetails(string serial, string areacode, string areaname, bool active)
    {
        string ret = "";
        int areaid = int.Parse(serial);
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.SaveAreaDetails(areaid, areacode, areaname, active, CreatedBy);
        if (serial.Equals("0"))
        {
            ret = areaname + " Region Saved Successfully";
        }
        else
        {
            ret = areaname + " Region update Successfully";
        }
        return ret;
    }
    public string SaveBankDetails(string Serial,string name,string email,string phone, bool isActive)
    {
        string ret = "";
        int bankid = int.Parse(Serial);
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.SaveBankDetails(bankid, name.ToUpper(), phone, email, isActive, CreatedBy);
        if (Serial.Equals("0"))
        {
            ret = name + " Saved Successfully";
        }
        else
        {
            ret = name + " update Successfully";
        }
        return ret;
    }
    public string SaveDistrictDetails(string districtcode, string code, string name, string regioncode, bool Isactive)
    {
        string ret = "";
        int districtid = int.Parse(districtcode);
        int regionid = int.Parse(regioncode);
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.SaveDistrictDetails(districtid, code, name, regionid, Isactive, CreatedBy);
        if (districtcode.Equals("0"))
        {
            ret = name + " District Saved Successfully";
        }
        else
        {
            ret = name + " District update Successfully";
        }
        return ret;
    }

    public string SavePayType(string code,string shortname, string name, string amount, bool IsActive, bool IsVat, bool IsRef)
    {
        string ret = "";
        string amt = amount;
        if (amount.Equals(""))
        {
            amt = "0";
        }
        double charge = double.Parse(amt);
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.SavePayType(code,shortname, name, charge, IsActive, IsVat, IsRef, CreatedBy);
        ret = "Payment Type " + name + " has been Saved Successfully";
        return ret;
    }

    public string ConfirmBillSystemUpdate(string BatchCode)
    {
        string ret = "";
        string CreatedBy = HttpContext.Current.Session["Username"].ToString();
        datafile.ConfirmBatchUpdate(BatchCode, CreatedBy);
        ret = "Batch[" + BatchCode + "] has been confirmed as Billing System Uploaded";
        return ret;
    }
    public string SaveReceiptRange(string Code, string start, string end,string districtcode,string cashier,string total_amount)
    {
        string ret = "";
        int recordId = int.Parse(Code);
        int startpoint = int.Parse(start);
        int endpoint = int.Parse(end);
        int cashier_Id = int.Parse(cashier);
        double amount = double.Parse(total_amount.Replace(",", ""));
        if (startpoint == endpoint)
        {
            ret = "Start Point cannot be equal to End point";
        }       
        else if (startpoint > endpoint)
        {
            ret = "Start Point cannot be less than End point";
        }
        else if (amount.Equals(0))
        {
            ret = "Total Amount cannot be Zero";
        }
        else
        {
            string avail_status = bll.RangeIn(districtcode, cashier_Id, recordId);
            if (!avail_status.Equals("NO"))
            {
                ret = avail_status;
            }
            else
            {
                string status = bll.ReceiptRangeExists(recordId, startpoint, endpoint, districtcode);
                if (status.Equals("YES"))
                {
                    string CreatedBy = HttpContext.Current.Session["Username"].ToString();
                    
                    datafile.SaveReceiptRange(recordId, startpoint, endpoint,cashier, districtcode,amount, CreatedBy);
                    if (recordId.Equals(0))
                    {
                        ret = startpoint.ToString() + " - " + endpoint.ToString() + " Receipt Range has been Save Successfully";
                    }
                    else
                    {
                        ret = startpoint.ToString() + " - " + endpoint.ToString() + " Receipt Range has been Update Successfully";
                    }
                }
                else
                {
                    ret = status;
                }
            }
        }
        return ret;
    }
    public string SaveTellerSessionToken(string TellerCode,string TellerName, DateTime date)
    {
        string res = "";
        string User = HttpContext.Current.Session["Username"].ToString();
        string DistrictCode = HttpContext.Current.Session["DistrictCode"].ToString();
        DateTime now = DateTime.Now;
        int TellerID = int.Parse(TellerCode);
        if (bll.IsTokenIn(TellerID, date,DistrictCode))
        {
            res = "There is already a token for " + TellerName + " in the system for " + date.ToString("dd-MM-yyyy");
        }
        else
        {
            datafile.SaveTellerSession(TellerID, date, User, DistrictCode);
            string supervisor = HttpContext.Current.Session["FullName"].ToString();
            string msg = "Hello " + TellerName + "\n Transaction Session has been granted to you for " + date.ToString("dd-MM-yyyy") + " by " + supervisor + "\n you can now transact";
            string mail = NotifyCashier(TellerID,TellerName, msg);
            if (mail.Equals("SENT"))
            {
                res = "Transaction Session Created Successfully for " + TellerName;
            }
            else
            {
                res = "Transaction Session Created Successfully for " + TellerName + ", But Notification failed";
            }          

        }
        return res;
    }

    private string NotifyCashier(int TellerID,string TellerName, string msg)
    {
        string res = "";
        try
        {
            dTable = datafile.GetUserDetailsByID(TellerID);
            if (dTable.Rows.Count > 0)
            {
                string mail = dTable.Rows[0]["UserEmail"].ToString();
                string subject = "INTERFACE SESSION TOKEN";
                string name = TellerName;
                res = mailer.GoogleMail(mail, subject, msg, name);
            }
        }
        catch (Exception ex)
        {
            res = "NOT SENT";
        }
        return res;
    }

    public string ChangeTokenStatus(string tokencode, string name, string status, DateTime date)
    {
        string res = "";
        bool active = GetStatus(status);
        if (!bll.IsCurrentDate(date))
        {
            res = "You cannot change this Session transaction's state because it is an expired one";
        }
        else
        {
            string state = "";
            int tokenId = int.Parse(tokencode);
            string User = HttpContext.Current.Session["Username"].ToString();
            datafile.ChangeTokenState(tokenId, active, User);
            if (active)
            {
                res = name + " token has been enabled Successfully";
                state = "enabled";
            }
            else
            {
                res = name + " token has been disabled Successfully";
                state = "disabled";
            }
        }
        return res;
    }

    private bool GetStatus(string status)
    {
        if (status.Equals("YES"))
        {
            return false;
        }
        else
        {
            return true;
        }
    }  
    public string SaveErrorSub(string name, string phone, string email)
    {
        string ret = "";
        PhoneValidator pv = new PhoneValidator();
        phone = bll.FormatPhoneNumber(phone);
        if (!pv.PhoneNumbersOk(phone))
        {
            ret = "Please Enter a valid Phone Number";
        }
        else if (!bll.IsValidEmailAddress(email))
        {
            ret = "Please Enter a valid Email Address";
        }
        else if (bll.IsSubEmail(email))
        {
            ret = "Email is already subscribed";
        }
        else if (bll.IsSubPhone(phone))
        {
            ret = "Phone is already subscribed";
        }
        else
        {            
            datafile.SaveErrorSub(name, phone, email);
            ret = "Subscriber Saved Successfully";
        }
        return ret;
    }

    public void ChangeSubStatus(string code, string oldstatus)
    {
        bool status = true;
        if (oldstatus.Equals("ON"))
        {
            status = false;
        }
        int recordId = int.Parse(code);
        datafile.ChangeSubStatus(recordId, status);
    }

    public string SaveSMSCredit(string credit, string username)
    {
        string res = "";
        if (credit.Equals(""))
        {
            res = "Please Enter Credit to add";
        }
        else if (credit.Equals("0"))
        {
            res = "Credit to add cannot be Zero";
        }
        else
        {
            int creditNo = int.Parse(credit);
            string User = HttpContext.Current.Session["Username"].ToString();
            SystemUser user = new SystemUser();
            user.Uname = username;
            user.User = User;
            datafile.SaveInCredit(user, creditNo);
            res = credit + " Credit added to User Successfully";
        }
        return res;
    }

    public string SaveNetworkTariff(string code, string tariff)
    {
        int tarrifNo = int.Parse(tariff);
        datafile.SaveNetworkTariff(code, tarrifNo);
        string res = tariff+" Tariff Save Successfully";
        return res;
    }
}
