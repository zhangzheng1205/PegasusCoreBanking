using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Common;
using System.Collections;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using InterLinkClass.EntityObjects;

public class DataLogin
{
    private Database PegPay_DB;
    private DbCommand procommand;
    private DataSet returnDataset;
    private DataTable datatable;

    public string ReturnConsring()
    {
        //string constring = "Ronnie";
        //string constring = "Jab_2008";
        //string constring = "LivePegPay";
        string constring = "TestPegPay";
        return constring;
    }
    public DataLogin()
    {
        try
        {
            PegPay_DB = DatabaseFactory.CreateDatabase(ReturnConsring());

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public Database ShareBilling_Con()
    {
        return PegPay_DB;
    }

    public DataTable GetUserAccessibility(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUserLoginDetails", user.Uname, user.Passwd);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetNetworkTariff()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetNetworkTariff");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetAreaList()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetAreas");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetBanks()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetChequeBanks");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetActiveBanks()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetActiveChequeBanks");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetAreas()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetAreaDetails");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string GetSystemParameter(int GroupCode, int ValueCode)
    {
        string ret = "";
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetSystemSetting", GroupCode, ValueCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                ret = datatable.Rows[0]["ValueVarriable"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ret;
    }

    internal DataTable CheckUsername(string userName)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUserLogins", userName);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable getInterfaceErrors()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("getInterfaceErrors");
            DataTable datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal DataTable GetAreaByName(string AreaName)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetAreaByName", AreaName);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal int GetNumberOfBranches(int RegionID)
    {
        int ret = 0;
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetNumofBranches", RegionID);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                ret = int.Parse(datatable.Rows[0]["Branches"].ToString());
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ret;
    }

    internal DataTable GetUserByNames(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUserByfullName", user.Fname, user.Oname, user.Sname);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetBranches(int AreaID)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetDistrictsByArea", AreaID);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetDistrictByRegionCode(string RegionCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetDistrictByRegionCode", RegionCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable getInterfaceErrorVendorCodes()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("getInterfaceErrorVendorCodes");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable getInterfaceErrorUtilities()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("getInterfaceErrorUtilities");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetUserDetailsByID(int UserID)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetLoginDetailsByID", UserID);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetSystemRoles()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetSystemRoles");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetSystemUsers(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetSystemUsers", user.Name, user.Area, user.Branch, user.Role);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetVendors(Vendor vendor)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetVendors", vendor.VendorName, vendor.Active);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetAllVendors(string VendorCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetVendorDetails", VendorCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPrepaidVendorStatus()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPrepaidVendorStatus");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPayTypes()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPayTypes");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetActivePayTypes()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetActivePayTypes");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPaymentTypes()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPaymentTypes");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetVendorById(Vendor vendor)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetVendorById", vendor.Vendorid);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetFileProcesses(string file_type, DateTime fromDate, DateTime toDate)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetFileProcesses", file_type, fromDate, toDate);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetLogs(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUserLogs", user.Name, user.Role, user.FromDate, user.ToDate);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetSystemParameters()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetSystemParameters");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetAreaDetailsByID(int areaid)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetAreaDetailsByID", areaid);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetBankDetailsByID(int bankid)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetBankDetailsByID", bankid);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal DataTable GetTransByBatch(string BatchCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetTransByBatch", BatchCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetDistricts(string regioncode, string name, bool Isactive)
    {
        try
        {
            int regionid = int.Parse(regioncode);
            procommand = PegPay_DB.GetStoredProcCommand("GetDistricts", regionid, name, Isactive);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetDistrictDetails(string districtcode)
    {
        try
        {
            int districtid = int.Parse(districtcode);
            procommand = PegPay_DB.GetStoredProcCommand("GetDistrictDetails", districtid);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal DataTable GetVendorDetails(string vendorCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetVendorDetails", vendorCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPayTypeByCode(string PayTypeCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPayTypeByCode", PayTypeCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetCashiers(string districtcode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetCashiers", districtcode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetTellerSession(int tellerId, string districtCode, DateTime date)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetTellerSession", tellerId, districtCode, date);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetTellerSessions(string districtCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetTellerSessionTokens", districtCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPayTypesByShortName(string shortname)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPayTypeCodeByShortName", shortname);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal DataTable GetTellerSession(int TellerID, DateTime date, string DistrictCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetTellerSession", TellerID, DistrictCode, date);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetErrorSubs()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetErrorSub");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal DataTable GetErrorSubByEmail(string email)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetErrorSubByEmail", email);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal DataTable GetErrorSubByPhone(string phone)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetErrorSubByPhone", phone);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public string GetPayTypeCodeByShortName(string ShortName)
    {
        string ret = "";
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPayTypeCodeByShortName", ShortName);
            procommand.CommandTimeout = 120;
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                ret = datatable.Rows[0]["PaymentCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ret;
    }
    public Hashtable GetNetworkCodes()
    {
        Hashtable networkCodes = new Hashtable();
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetNetworkCodes");
            DataSet ds = PegPay_DB.ExecuteDataSet(procommand);
            int recordCount = ds.Tables[0].Rows.Count;
            if (recordCount != 0)
            {
                for (int i = 0; i < recordCount; i++)
                {
                    DataRow dr = ds.Tables[0].Rows[i];
                    string network = dr["Network"].ToString();
                    string code = dr["Code"].ToString();
                    networkCodes.Add(code, network);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return networkCodes;
    }
    /////////////////////////////////////////////
    //////////////////////////

    ////
    internal void LogActivity(string UserCode, string Action)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("LogSystemActivity", UserCode, Action);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void UpdatePassword(int UserID, string EncryptedPassword)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("PasswordChange", UserID, EncryptedPassword);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal void LoginStatus(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("LoginStatus", user.Userid, user.LoggedOn);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal void SaveLoginDetails(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveSystemUser", user.Userid, user.Fname, user.Sname, user.Oname,
                user.Uname, user.Passwd, user.Role, user.Area, user.Branch, user.Email, user.Phone, user.Title, user.Active, user.LoggedOn, user.User);
            PegPay_DB.ExecuteNonQuery(procommand);
            if (user.Userid.Equals(0))
            {
                // Save in SMS Credit Table
                SaveInCredit(user, 0);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveInCredit(SystemUser user, int credit)
    {
        try
        {
            DateTime now = DateTime.Now;
            procommand = PegPay_DB.GetStoredProcCommand("AddCredit", user.Uname, credit, user.User, now);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveVendorDetails(Vendor vendor, Merchant merchant)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveVendorDetails", vendor.Vendorid, vendor.VendorCode, vendor.BillSysCode, vendor.VendorName,
             vendor.Contract, vendor.Passwd, vendor.Email, vendor.Active, vendor.User);
            PegPay_DB.ExecuteNonQuery(procommand);
            //merchant.PegPayVendorCode = vendor.VendorCode;
            //SaveMerchantDetails(merchant, vendor.User);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SaveMerchantDetails(Merchant merchant, string user)
    {
        procommand = PegPay_DB.GetStoredProcCommand("SaveMerchantsDetails", merchant.PegPayVendorCode, merchant.ClientId,
            merchant.TerminalId, merchant.OperatorId,
            merchant.Password, merchant.Active, user);
        PegPay_DB.ExecuteNonQuery(procommand);
    }

    public void ResetPassword(SystemUser user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("ResetPassword", user.Userid, user.Passwd);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal void ResetVendorPassword(Vendor vendor)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("ResetVendorPassword", vendor.Vendorid, vendor.Passwd);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    internal void UpdateSystemParameter(int valueid, string Varriable, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("UpdateSystemParameter", valueid, Varriable, CreatedBy);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveAreaDetails(int areaid, string areacode, string areaname, bool active, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveAreaDetail", areaid, areacode, areaname, active, CreatedBy);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveDistrictDetails(int districtid, string code, string name, int regionid, bool Isactive, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveDistrictDetails", districtid, code, name, regionid, Isactive, CreatedBy);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SavePayType(string code, string shortname, string name, double amount, bool IsActive, bool IsVat, bool IsRef, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SavePayType", code, shortname, name, amount, IsRef, IsVat, IsActive, CreatedBy);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void ConfirmBatchUpdate(string BatchCode, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("ConfirmBatchUpdate", BatchCode, CreatedBy);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveBankDetails(int bankid, string name, string phone, string email, bool active, string CreatedBy)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveBankDetails", bankid, name, phone, email, CreatedBy, active);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveTellerSession(int TellerID, DateTime date, string User, string DistrictCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveTellerSession", TellerID, date, DistrictCode, User);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void ChangeTokenState(int tokenId, bool active, string User)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("ChangeTokenState", tokenId, active, User);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveReceiptRange(int recordId, int startpoint, int endpoint, string cashier, string districtcode, double amount, string user)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveManualReceiptRange", recordId, startpoint, endpoint, cashier, amount, districtcode, user);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveErrorSub(string name, string phone, string email)
    {
        try
        {
            string user = HttpContext.Current.Session["Username"].ToString();
            procommand = PegPay_DB.GetStoredProcCommand("SaveErrorSub", name, phone, email, user);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void ChangeSubStatus(int recordId, bool status)
    {
        try
        {
            string user = HttpContext.Current.Session["Username"].ToString();
            procommand = PegPay_DB.GetStoredProcCommand("UpdateErrorSubStatus", recordId, status, user);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveNetworkTariff(string code, int tarrifNo)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveNetworkTariff", code, tarrifNo);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetAllUtilities(string UtilityCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUtilityDetails", UtilityCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            for (int i = 0; i < datatable.Rows.Count; i++)
            {
                string text = datatable.Rows[0]["Utility"].ToString();
                string text1 = datatable.Rows[0]["UtilityCode"].ToString();
            }
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public DataTable GetUtilityCredentials(string vendorCode, string utilityCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUtilityCredentials", vendorCode, utilityCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void SaveUtilityCredentials(string vendorCode, string utilityCode, string username, string password, string bankCode, string createdBy, DateTime createDate)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveUtilityCredentials", vendorCode, utilityCode, username, password, bankCode, createdBy, createDate);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal void SaveUtilityDetails(UtilityDetails utility)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SaveUtilityDetails", utility.UtilityCode, utility.Utility, utility.UtilityContact, utility.Email, utility.CreatedBy, utility.CreationDate, utility.Active);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public ArrayList GetExcelColNames()
    {
        ArrayList excelCols = new ArrayList();
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetExcelColNames");
            DataTable dt = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    excelCols.Add(dr["ExcelColumnNames"].ToString().ToUpper().Trim());
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return excelCols;
    }

    public DataTable GetAllUtilities()
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetUtilityDetails1", "0");
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetSystemCompanies(string CompanyName, string CompanyCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetSystemCompanies", CompanyName, CompanyCode);
            datatable = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetPegPayAccount(string CompanyCode)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetPegPayAccount", CompanyCode);
            DataTable dt = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    internal void CreditAccountWithTelecomId(string CompanyCode, string Account, double Amount, string RecordedBy)
    {
        try
        {

            //procommand = MMoney_DB.GetStoredProcCommand("CreditAccount", Account, Amount);
            //MMoney_DB.ExecuteNonQuery(procommand);
            procommand = PegPay_DB.GetStoredProcCommand("CreditAccountHoldingsWithTelecomId", CompanyCode, Account, Amount, RecordedBy);
            PegPay_DB.ExecuteNonQuery(procommand);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DataTable GetCreditsToApprove(string CustName, string CustAccount, DateTime fromDate, DateTime toDate)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetCreditsToApprove", CustName, CustAccount, fromDate, toDate);
            DataTable dt = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public string ApproveAccountCredit(int recordId)
    {
        //InterLinkClass.PegpayMMoney.Response resp = new InterLinkClass.PegpayMMoney.Response();
        string success = "";
        try
        {
            datatable = GetCreditToApproveById(recordId);
            if (datatable.Rows.Count > 0)
            {
                string CustomerAccount = datatable.Rows[0]["CustomerAccount"].ToString();
                double amount = Convert.ToDouble(datatable.Rows[0]["CreditAmount"].ToString());
                string CreditAmount = Math.Round(amount, 0).ToString();
                //string Network = datatable.Rows[0]["Network"].ToString();
                string CustomerCode = datatable.Rows[0]["CustomerCode"].ToString();
                success = "SUCCESS";


            }
            else
            {

                success = "FAILED";

            }
            //return resp;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return success;
    }
    internal DataTable GetCreditToApproveById(int recordId)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetCreditToApproveById", recordId);
            DataTable dt = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            return dt;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void UpdateApprovedCredit(int RecordId, string username)
    {
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("UpdateApprovedCredit", RecordId, username);
            PegPay_DB.ExecuteNonQuery(procommand);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public CustomerReceiptCreditDetails GetCustomerReceiptDetails(int recordId)
    {
        CustomerReceiptCreditDetails cust = new CustomerReceiptCreditDetails();
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetCustomerReceiptDetails", recordId);
            DataTable dt = PegPay_DB.ExecuteDataSet(procommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                cust.CustomerCode = dt.Rows[0]["CustomerCode"].ToString();
                cust.CustomerAccount = dt.Rows[0]["CustomerAccount"].ToString();
                cust.CustomerCreditAmount = dt.Rows[0]["CreditAmount"].ToString();

                cust.ReceiptNumber = recordId;
                cust.StatusCode = "0";
                cust.StatusDescription = "SUCCESS";
            }
            else
            {
                cust.StatusCode = "100";
                cust.StatusDescription = "INVALID CUSTOMER CODE.";
            }
        }
        catch (Exception ex)
        {
            GetCustomerReceiptDetails(recordId);
            // throw ex;
        }
        return cust;
    }
    public int InsertIntoReceivedPrepaidTxns(string vendorCode, string vendorAccount, string CustomerCreditAmount, string vendorTranld)
    {
        // cust.CustomerCode,cust.CustomerAccount,cust.CustomerCreditAmount,vendorTranld
        int insertTransactionsuccess;
        try
        {

            procommand = PegPay_DB.GetStoredProcCommand("InsertCreditIntoReceivedPrepaidTxns", vendorCode, vendorAccount, CustomerCreditAmount, vendorTranld);
            procommand.CommandTimeout = 400;
            insertTransactionsuccess = PegPay_DB.ExecuteNonQuery(procommand);
            return insertTransactionsuccess;

        }
        catch (Exception ex)
        {

            throw ex;

        }


    }
    public int UpdatePrepaidCustomerAccountBalance(string vendorCode, string CustomerCreditAmount, string vendorAccount)
    {
        // cust.CustomerCode,cust.CustomerAccount,cust.CustomerCreditAmount,vendorTranld
        int UpdateTransactionsuccess;
        try
        {

            procommand = PegPay_DB.GetStoredProcCommand("UpdatePrepaidVendorAccountBalance", vendorCode, CustomerCreditAmount, vendorAccount);
            procommand.CommandTimeout = 400;

            UpdateTransactionsuccess = PegPay_DB.ExecuteNonQuery(procommand);


            return UpdateTransactionsuccess;

        }
        catch (Exception ex)
        {

            throw ex;

        }


    }
    public DataTable GetUserPassword(string username, string userEmail)
    {
        //throw new Exception("The method or operation is not implemented.");
        DataTable results = new DataTable();
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("GetResetPasswordUserDetails", username, userEmail);
            results = PegPay_DB.ExecuteDataSet(procommand).Tables[0];

        }
        catch (Exception ex)
        {
            GetUserPassword(username, userEmail);
            // throw ex;
        }
        return results;

    }



    public int ResendThisTransaction(string tranId, string vendor,string Id)
    {
        int status;
        DataTable results = new DataTable();
        try
        {

            procommand = PegPay_DB.GetStoredProcCommand("ResendThisTransaction", tranId, vendor, Id);
            procommand.CommandTimeout = 400;
            //PegPay_DB.clo
            status = PegPay_DB.ExecuteNonQuery(procommand);
                
        }
        catch (Exception ex)
        {
            
            throw;
        }
        return status;
    }

    public DataTable SelectTransactionsToResend(string tranId, string vendor)
    {
        DataTable results,rst = new DataTable();
        try
        {
            procommand = PegPay_DB.GetStoredProcCommand("SelectTransactionsToResend", tranId, vendor);
            results = PegPay_DB.ExecuteDataSet(procommand).Tables[0];

        }
        catch (Exception ex)
        {

            throw ex;
        }
        return results;
    }
}
