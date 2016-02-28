using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Bussinesslogic
/// </summary>
public class Bussinesslogic
{
    DatabaseHandler dh = new DatabaseHandler();
    public string BankPassword = "TEST";
    Service client = new Service();

    public Bussinesslogic()
    {

    }

    public void LoadBanksBranchesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetBankBranchesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["BranchName"].ToString();
            string BranchCode = dr["BranchCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }

        //disable branch selection option if user is not an admin
        if (user.Usertype != "SYS_ADMIN" && user.Usertype != "BANK_ADMIN" && user.Usertype != "BUSSINESS_ADMIN")
        {
            ddlst.SelectedValue = user.BranchCode;
            ddlst.Enabled = false;
        }
    }

    public void LoadBanksBranchesIntoDropDownALL(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetBankBranchesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("ALL", "ALL"));
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["BranchName"].ToString();
            string BranchCode = dr["BranchCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }

        //disable branch selection option if user is not an admin
        if (user.Usertype != "SYS_ADMIN" && user.Usertype != "BANK_ADMIN" && user.Usertype != "BUSSINESS_ADMIN")
        {
            ddlst.SelectedValue = user.BranchCode;
            ddlst.Enabled = false;
        }
    }

    public void LoadAccountTypesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetAccountTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["AccTypeName"].ToString();
            string BranchCode = dr["AccTypeCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }
    }

    public void LoadChargeTypesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetChargeTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["ChargeTypeName"].ToString();
            string BranchCode = dr["ChargeTypeCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }
    }

    public void LoadAccountTypesIntoDropDownALL(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetAccountTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add("ALL");
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["AccTypeName"].ToString();
            string BranchCode = dr["AccTypeCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }
    }

    public void LoadUsertypesIntoDropDowns(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetUserTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string UserTypeName = dr["UserType"].ToString();
            string UserTypeCode = dr["UserType"].ToString();
            ddlst.Items.Add(new ListItem(UserTypeName, UserTypeCode));
        }
    }

    public void LoadBanksIntoDropDown(BankUser user, DropDownList ddlst)
    {
        string[] parameters = { };
        DataSet ds = dh.ExecuteSelect("GetAllBanks", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string BankName = dr["BankName"].ToString();
            string UserTypeCode = dr["BankCode"].ToString();
            ddlst.Items.Add(new ListItem(BankName, UserTypeCode));
        }

        if (user.Usertype.ToUpper() != "SYS_ADMIN")
        {
            ddlst.SelectedValue = user.BankCode;
            ddlst.Enabled = false;
        }
    }

    public void LoadBanksIntoDropDownALL(BankUser user, DropDownList ddlst)
    {
        string[] parameters = { };
        DataSet ds = dh.ExecuteSelect("GetAllBanks", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("ALL", "ALL"));
        foreach (DataRow dr in dt.Rows)
        {
            string BankName = dr["BankName"].ToString();
            string UserTypeCode = dr["BankCode"].ToString();
            ddlst.Items.Add(new ListItem(BankName, UserTypeCode));
        }

        //if user is not a Pegasus Admin disbale bank selection
        if (user.Usertype.ToUpper() != "SYS_ADMIN")
        {
            ddlst.SelectedValue = user.BankCode;
            ddlst.Enabled = false;
        }

    }

    public void CreateFolderPathIfItDoesntExist(string folderPath)
    {
        bool exists = Directory.Exists(folderPath);

        if (!exists)
        {
            Directory.CreateDirectory(folderPath);
        }
    }

    public void SendBankUserCredentialsEmail(BankUser user)
    {

        string email = user.Email;
        if (!string.IsNullOrEmpty(email))
        {
            string Subject = "BANK OS WEB PORTAL CREDENTIALS";
            string Message = "Hi " + user.FullName + "<br/>" +
                             "Find Below details needed to access " + user.BankCode + " BankOS Web Portal.<br/>" +
                             "Username: " + user.Email + "<br/>" +
                             "Password: " + user.Password + "<br/>" +
                             "URL: https://pegasus.co.ug <br/>" +
                             "Thank you.<br/>" +
                             "BankOS Team";
            Email.SendTo(email, Message, Subject);
        }
    }

    public void SendBankAdminCredentialsEmail(Bank bank)
    {

        string email = bank.BankContactEmail;
        if (!string.IsNullOrEmpty(email))
        {
            string Subject = "BANK OS WEB PORTAL CREDENTIALS";
            string Message = "Hi " + bank.BankName + " Team,<br/>" +
                             "Find Below details needed to access " + bank.BankName + " BankOS Web Service.<br/>" +
                             "BankCode: " + bank.BankCode + "<br/>" +
                             "Password: " + bank.BankPassword + "<br/>" +
                             "URL: https://pegasus.co.ug <br/>" +
                             "Thank you.<br/>" +
                             "BankOS Team";
            Email.SendTo(email, Message, Subject);
        }
    }

    public string GeneratePassword()
    {
        string RandomPassword = "T3rr1613";
        return GenerateMD5Hash(RandomPassword);
    }

    public string GenerateMD5Hash(string input)
    {
        // Use input string to calculate MD5 hash
        MD5 md5 = System.Security.Cryptography.MD5.Create();
        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
        byte[] hashBytes = md5.ComputeHash(inputBytes);

        // Convert the byte array to hexadecimal string
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < hashBytes.Length; i++)
        {
            sb.Append(hashBytes[i].ToString("X2"));
        }
        return sb.ToString();
    }

    public void ShowMessage(Label lblmsg, string msg, bool IsError)
    {
        lblmsg.Text = msg;
        if (IsError)
        {
            lblmsg.ForeColor = Color.Red;
        }
        else
        {
            lblmsg.ForeColor = Color.Green;
        }
    }



    public string SaveTranRequest(TransactionRequest tran, string AccountNumber)
    {
        string[] parameters ={ tran.CustomerName,
                               AccountNumber,
                               tran.ToAccount,
                               tran.FromAccount,
                               tran.TranAmount,
                               tran.TranCategory,
                               DateTime.Now.ToString(),
                               tran.Teller,
                               tran.ApprovedBy,
                               tran.BankCode,
                               tran.BranchCode,
                               tran.Narration,
                               tran.CurrencyCode,
                               tran.PaymentType,
                               tran.ChequeNumber};
        DataSet ds = dh.ExecuteSelect("SaveTranRequest", parameters);
        DataTable dt = ds.Tables[0];
        DataRow dr = dt.Rows[0];
        string InsertedId = dr[0].ToString();
        return InsertedId;
    }

    public void LoadTransactionTypesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetTransactionTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string TranType = dr["TranType"].ToString();
            string TranTypeName = dr["TranType"].ToString();
            ddlst.Items.Add(new ListItem(TranTypeName, TranType));
        }
    }

    public void LoadCurrenciesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetCurrenciesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string CurrencyCode = dr["CurrencyCode"].ToString();
            string CurrencyName = dr["CurrencyName"].ToString();
            ddlst.Items.Add(new ListItem(CurrencyName, CurrencyCode));
        }
    }

    public void LoadTransactionTypesIntoDropDownALL(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetTransactionTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("ALL", "ALL"));
        foreach (DataRow dr in dt.Rows)
        {
            string TranType = dr["TranType"].ToString();
            string TranTypeName = dr["TranType"].ToString();
            ddlst.Items.Add(new ListItem(TranTypeName, TranType));
        }
    }

    public void LoadCommissionAccountsIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };

        DataSet ds = dh.ExecuteSelect("GetCommissionAccountsByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string AccName = dr["AccNumber"].ToString();
            string AccNumber = dr["AccNumber"].ToString();
            ddlst.Items.Add(new ListItem(AccName, AccNumber));
        }
    }

    public void ShowMessage(Label lblmsg, string msg, bool IsError, System.Web.SessionState.HttpSessionState Session)
    {
        lblmsg.Text = msg;
        if (IsError)
        {
            Session["IsError"] = "True";
            lblmsg.ForeColor = Color.Red;
        }
        else
        {
            Session["IsError"] = "False";
            lblmsg.ForeColor = Color.Green;
        }
    }

    public bool TransactionRequiresApproval(ref TransactionRequest tran)
    {
        string[] parameters = { tran.BankCode, tran.BranchCode, tran.Teller, tran.TranAmount };
        DataSet ds = dh.ExecuteSelect("CheckIfItViolatesRules", parameters);
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            string Approver = dt.Rows[0]["Approver"].ToString();
            SendToSupervisorForApproval(tran, Approver);
            tran.StatusCode = "100";
            tran.StatusDesc = dt.Rows[0]["Description"].ToString();
            return true;
        }
        else
        {
            return false;
        }
    }

    public void SendToSupervisorForApproval(TransactionRequest tran, string Approver)
    {
        string[] parameters = { tran.BankTranId, "PENDING", "True", Approver };
        dh.ExecuteNonQuery("UpdateTransacttionApprovalStatus", parameters);
    }

    public DataTable SearchGeneralLedgerTable(string[] searchParams)
    {
        DataSet ds = dh.ExecuteSelect("SearchGeneralLedgerTable", searchParams);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public DataTable SearchAll(string[] searchParams, string code)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        DataTable datatable = client.ExecuteDataSet("GetRedirectUrl", new string[] { code }).Tables[0];
        if (datatable.Rows.Count > 0)
        {
            DataRow dr = datatable.Rows[0];
            string storedProc = dr["StoredProc"].ToString();
            ds = dh.ExecuteSelect(storedProc, searchParams);
            dt = ds.Tables[0];
            return dt;
        }
        else
        {
            return dt;
        }

    }

    public DataTable SearchTransactionRequestsTable(string[] searchParams)
    {
        DataSet ds = dh.ExecuteSelect("SearchTransactionRequestsTable", searchParams);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public void LoadUsertypesIntoDropDownsALL(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetUserTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("ALL", "ALL"));
        foreach (DataRow dr in dt.Rows)
        {
            string UserTypeName = dr["UserType"].ToString();
            string UserTypeCode = dr["UserType"].ToString();
            ddlst.Items.Add(new ListItem(UserTypeName, UserTypeCode));
        }
    }

    public void LoadAccessAreasIntoDropDownsALL(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { };
        DataSet ds = dh.ExecuteSelect("AccessAreas_SelectAll", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("ALL", "ALL"));
        foreach (DataRow dr in dt.Rows)
        {
            string AreaName = dr["AreaName"].ToString();
            string AreaCode = dr["AreaCode"].ToString();
            ddlst.Items.Add(new ListItem(AreaName, AreaCode));
        }
    }

    public Result SaveAccessRule(string[] parameters)
    {
        int rows = dh.ExecuteNonQuery("AccessRules_Update", parameters);
        Result result = new Result();
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = rows.ToString();
        return result;
    }

    public DataTable SearchAccountsTable(string[] parameters)
    {
        DataSet ds = dh.ExecuteSelect("SearchAccountsTable", parameters);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public List<string> GetAllowedAreas(string usertype, string BankCode)
    {
        List<string> allowedAreas = new List<string>();
        string[] parameters = { usertype, BankCode };
        DataSet ds = dh.ExecuteSelect("AccessRules_SelectRow", parameters);
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                string allowedArea = dr["CanAccess"].ToString().ToUpper();
                allowedAreas.AddRange(allowedArea.Split(','));
            }
        }

        return allowedAreas;
    }

    public void UpdateBankTransactionStatus(string BankID, string BankCode, string PegPayId,string Status)
    {
        string[] parameters = { BankID, BankCode, PegPayId,Status };
        int rowsAffected = dh.ExecuteNonQuery("UpdateBankTransactionStatus", parameters);
    }

    public TransactionRequest GetTransactionRequest(string BankTranId, string BankCode, string Approver)
    {
        TransactionRequest tran = new TransactionRequest();
        string[] parameters = { BankTranId, BankCode };
        DataSet ds = dh.ExecuteSelect("GetTransactionRequest", parameters);
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];
            tran.ApprovedBy = Approver;
            tran.BankCode = BankCode;
            tran.BankTranId = BankTranId;
            tran.BranchCode = dr["BranchCode"].ToString();
            tran.CustomerName = dr["CustomerName"].ToString();
            tran.DigitalSignature = "";
            tran.FromAccount = dr["fromAccount"].ToString();
            tran.Narration = dr["Narration"].ToString();
            tran.Password = BankPassword;
            tran.PaymentDate = dr["PaymentDate"].ToString();
            DateTime payDate = DateTime.Parse(tran.PaymentDate);
            tran.PaymentDate = payDate.ToString("dd/MM/yyyy");
            tran.Teller = dr["Teller"].ToString();
            tran.ToAccount = dr["toAccount"].ToString();
            tran.TranAmount = dr["TranAmount"].ToString();
            tran.TranCategory = dr["TranCategory"].ToString();
            tran.CurrencyCode = dr["CurrencyCode"].ToString();
            tran.PaymentType = dr["PaymentType"].ToString();
            tran.ChequeNumber = dr["ChequeNumber"].ToString();
        }
        else
        {
            throw new Exception("Failed to Find Transaction with Bank Id:" + BankTranId);
        }
        return tran;
    }

    public DataTable SearchBankUsersTable(string[] parameters)
    {
        DataSet ds = dh.ExecuteSelect("GetBankUsersPendingApproval", parameters);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public Result UpdateUserIsActiveStatus(string[] parameters)
    {
        Result result = new Result();
        int rows = dh.ExecuteNonQuery("AprroveOrRejectUser", parameters);
        if (rows > 0)
        {
            result.StatusCode = "0";
            result.StatusDesc = "SUCCESS";
        }
        else
        {
            result.StatusCode = "100";
            result.StatusDesc = "UNBALE TO APPROVE USER AT THE MOMENT";
        }
        return result;
    }

    public Result UpdateBankAccountApprovalStatus(string[] parameters)
    {
        Result result = new Result();
        int rows = dh.ExecuteNonQuery("ApproveOrRejectBankAccount", parameters);
        if (rows > 0)
        {
            result.StatusCode = "0";
            result.StatusDesc = "SUCCESS";
        }
        else
        {
            result.StatusCode = "100";
            result.StatusDesc = "UNBALE TO APPROVE USER AT THE MOMENT";
        }
        return result;
    }

    public DataTable GetBankAccountsPendingApproval(string[] parameters)
    {
        DataSet ds = dh.ExecuteSelect("GetBankAccountsPendingApproval", parameters);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public Result SaveAccountSignatory(string[] parameters)
    {
        Result result = new Result();
        int rowsAffected = dh.ExecuteNonQuery("UsersToAccounts_Insert", parameters);
        if (rowsAffected > 0)
        {
            result.StatusCode = "0";
            result.StatusDesc = "SUCCESS";
        }
        else
        {
            result.StatusCode = "100";
            result.StatusDesc = "UNABLE TO ADD CUSTOMER AS SIGNATORY. TRY AGAIN OR CONTACT BANK ADMIN";
        }
        return result;
    }

    public Result SaveReversalRequest(string[] parameters)
    {
        Result result = new Result();
        int rowsAffected = dh.ExecuteNonQuery("InsertReversedTransaction", parameters);
        if (rowsAffected > 0)
        {
            result.StatusCode = "0";
            result.StatusDesc = "SUCCESS";
        }
        else
        {
            result.StatusCode = "100";
            result.StatusDesc = "UNABLE TO ADD CUSTOMER AS SIGNATORY. TRY AGAIN OR CONTACT BANK ADMIN";
        }
        return result;
    }

    public DataTable SearchAuditlogsTable(string[] parameters)
    {
        DataSet ds = dh.ExecuteSelect("SearchAuditlogsTable", parameters);
        DataTable dt = ds.Tables[0];
        return dt;
    }

    public void LoadPaymentTypesIntoDropDown(string bankCode, DropDownList ddlst, BankTeller teller)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetPaymentTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string CurrencyCode = dr["PaymentTypeCode"].ToString();
            string CurrencyName = dr["PaymentTypeName"].ToString();
            ddlst.Items.Add(new ListItem(CurrencyName, CurrencyCode));
        }
    }

    public BankUser GetBankUser(string UserId)
    {
        BankUser user = new BankUser();
        try
        {
            string[] parameters = { UserId };
            DataTable datatable = client.ExecuteDataSet("Users_SelectRow", parameters).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString().ToUpper();
                if (IsActive == "TRUE")
                {
                    user.FullName = dr["FullName"].ToString();
                    user.IsActive = IsActive;
                    user.Password = dr["Password"].ToString();
                    user.Id = dr["UserId"].ToString();
                    user.Email = dr["Email"].ToString();
                    user.Usertype = dr["Usertype"].ToString();
                    user.PhoneNumber = dr["PhoneNumber"].ToString();
                    user.BankCode = dr["BankCode"].ToString();
                    user.BranchCode = dr["BranchCode"].ToString();
                    user.Gender = dr["Gender"].ToString();
                    user.DateOfBirth = dr["DateOfBirth"].ToString();
                    user.CanHaveAccount = dr["CanHaveAccount"].ToString();
                    user.StatusCode = "0";
                    user.StatusDesc = "SUCCESS";
                }
                else
                {
                    user.StatusCode = "100";
                    user.StatusDesc = "FAILED: USER [" + UserId + "] IS DE-ACTIVATED. PLEASE CONTACT SYSTEM ADMINISTRATORS";
                }
            }
            else
            {
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: USER WITH ID: " + UserId + " NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message + "";
        }
        return user;
    }

    public Bank GetBankById(string objectId)
    {
        Bank bank = new Bank();
        try
        {
            string[] Parameters = { objectId };
            DataTable datatable = client.ExecuteDataSet("Banks_SelectRow", Parameters).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                bank.BankCode = dr["BankCode"].ToString();
                bank.BankContactEmail = dr["BankContactEmail"].ToString();
                bank.BankId = dr["BankId"].ToString();
                bank.BankName = dr["BankName"].ToString();
                bank.BankPassword = dr["BankPassword"].ToString();
                bank.IsActive = dr["IsActive"].ToString();
                bank.ModifiedBy = dr["ModifiedBy"].ToString();
                bank.PathToLogoImage = dr["PathToLogoImage"].ToString();
                bank.PathToPublicKey = dr["PathToPublicKey"].ToString();
                bank.BankThemeColor = dr["ThemeColor"].ToString();
                bank.TextColor = dr["NavbarTextColor"].ToString();
                bank.StatusCode = "0";
                bank.StatusDesc = "SUCCESS";
            }
            else
            {
                bank.StatusCode = "100";
                bank.StatusDesc = "FAILED: BANK  [" + objectId + "] NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            bank.StatusCode = "100";
            bank.StatusDesc = "FAILED: " + ex.Message;
        }
        return bank;
    }

    public Result GetRedirectUrl(string EditType, string UserType)
    {
        Result result = new Result();
        List<string> allowedUserTypes = new List<string>();
        try
        {
            string[] parameters = { EditType };
            DataTable dt = client.ExecuteDataSet("GetRedirectUrl", parameters).Tables[0];
            if (dt.Rows.Count > 0)
            {
                allowedUserTypes.AddRange(dt.Rows[0]["UserTypeWhoCanView"].ToString().Split(','));
                if (allowedUserTypes.Contains(UserType.ToUpper()))
                {
                    result.StatusCode = "0";
                    result.StatusDesc = "SUCCESS";
                    result.PegPayId = dt.Rows[0]["Url"].ToString();
                }
                else
                {
                    result.StatusCode = "100";
                    result.StatusDesc = "YOU DONT HAVE ACCESS RIGHTS TO EDIT THIS";
                }
            }
            else
            {
                result.StatusCode = "100";
                result.StatusDesc = "NO REDIRECT URL FOUND FOR THIS OBJECT TYPE. CONTACT SYS ADMIN";
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public void LoadReportTypesIntoDropDown(string BankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { user.Usertype };
        DataSet ds = dh.ExecuteSelect("GetAllRedirectUrls", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        ddlst.Items.Add(new ListItem("", ""));
        foreach (DataRow dr in dt.Rows)
        {
            string TranType = dr["EditType"].ToString();
            string TranTypeName = dr["Name"].ToString();
            List<string> AllowedTypes = new List<string>();
            AllowedTypes.AddRange(dr["UserTypeWhoCanView"].ToString().Split(','));
            if (AllowedTypes.Contains(user.Usertype.ToUpper()))
            {
                ddlst.Items.Add(new ListItem(TranTypeName, TranType));
            }
        }
    }

    public bool Exists(Object obj)
    {
        string className = GetClassNameByReflection(obj);
        switch (className.ToUpper()) 
        {
            case "ACCOUNTTYPE":
                AccountType type=obj as AccountType;
                return TrueIfExists(className, type.AccTypeCode, type.BankCode);
            case "BANK":
                Bank bank = obj as Bank;
                return TrueIfExists(className, bank.BankCode, bank.BankCode);
            case "BANKACCOUNT":
                BankAccount bankAcc = obj as BankAccount;
                return TrueIfExists(className, bankAcc.AccountNumber, bankAcc.BankCode);
            case "BANKBRANCH":
                BankBranch branch = obj as BankBranch;
                return TrueIfExists(className, branch.BranchCode, branch.BankCode);
            case "BANKCHARGE":
                BankCharge charge = obj as BankCharge;
                return TrueIfExists(className, charge.ChargeCode, charge.BankCode);
            case "BANKUSER":
                BankUser user = obj as BankUser;
                return TrueIfExists(className, user.Id, user.BankCode);
            case "CHARGETYPE":
                ChargeType chargeType = obj as ChargeType;
                return TrueIfExists(className, chargeType.ChargeTypeCode, chargeType.BankCode);
            case "CURRENCY":
                Currency currency = obj as Currency;
                return TrueIfExists(className, currency.CurrencyCode, currency.BankCode);
            case "PAYMENTTYPE":
                PaymentType payType = obj as PaymentType;
                return TrueIfExists(className, payType.PaymentTypeCode, payType.BankCode);
            case "TRANSACTIONCATEGORY":
                TransactionCategory tranCategory = obj as TransactionCategory;
                return TrueIfExists(className, tranCategory.TranCategoryCode, tranCategory.BankCode);
            case "TRANSACTIONRULE":
                TransactionRule rule = obj as TransactionRule;
                return TrueIfExists(className, rule.RuleCode, rule.BankCode);
            default:
                return false;
        }
    }

    private string GetClassNameByReflection(object obj)
    {
        string className = obj.GetType().Name;
        return className;
    }

    private bool TrueIfExists(string className, string Id, string BankCode)
    {
        BaseObject obj = client.GetById(className, Id, BankCode, BankPassword);
        if (obj.StatusCode == "0")
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}