using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;
using CoreBankingLogic.ExposedObjects;
using System.Collections.Generic;
using System.Reflection;

/// <summary>
/// Summary description for BussinessLogic
/// </summary>
public class BussinessLogic
{
    public DatabaseHandler dh = new DatabaseHandler();
    public BussinessLogic()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public Result SaveAccountDetails(BankAccount account, string BankCode)
    {
        Result result = new Result();
        LogChangesInAuditLog(account, account.BankCode, account.BankCode, account.ModifiedBy);
        string accountId = dh.SaveAccount(account, BankCode);
        result.PegPayId = accountId;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result SaveChargeType(ChargeType chargeType, string BankCode)
    {
        Result result = new Result();
        LogChangesInAuditLog(chargeType, chargeType.BankCode, chargeType.BankCode, chargeType.ModifiedBy);
        string Id = dh.SaveChargeType(chargeType, BankCode);
        result.PegPayId = Id;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result SaveBankDetails(Bank bank)
    {
        Result result = new Result();
        LogChangesInAuditLog(bank, bank.BankCode, bank.BankCode, bank.ModifiedBy);
        string bankId = dh.SaveBank(bank);
        result.PegPayId = bankId;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result Transact(TransactionRequest tranRequest)
    {
        Result result = new Result();
        string TransactId = dh.Transact(tranRequest);
        result.PegPayId = TransactId;
        result.RequestId = tranRequest.BankTranId;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result ReverseTransaction(TransactionRequest tranRequest)
    {
        Result result = new Result();
        string TransactId = dh.Reverse(tranRequest.BankTranId, tranRequest.BankCode, tranRequest.Teller, tranRequest.ApprovedBy);
        result.PegPayId = TransactId;
        result.RequestId = tranRequest.BankTranId;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result SaveBankChargeDetails(BankCharge charge, string BankCode)
    {
        Result result = new Result();
        result.RequestId = charge.Id;
        LogChangesInAuditLog(charge, charge.ChargeCode, charge.BankCode, charge.ModifiedBy);
        string Id = dh.SaveCharge(charge, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public Result SaveBankCustomerDetails(BankCustomer cust, string BankCode)
    {
        Result result = new Result();
        result.RequestId = cust.Id;
        LogChangesInAuditLog(cust, cust.Id, cust.BankCode, cust.ModifiedBy);
        string CustId = dh.SaveCustomer(cust, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = CustId;
        return result;
    }

    public Result SaveTranType(TransactionCategory tranType, string BankCode)
    {
        Result result = new Result();
        result.RequestId = tranType.Id;
        LogChangesInAuditLog(tranType, tranType.TranCategoryCode, tranType.BankCode, tranType.ModifiedBy);
        string Id = dh.SaveTransactionType(tranType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public BankAccountStatement GenerateStatement(string AccountNumber, string BankCode, string Password, string StatementType)
    {
        BankAccountStatement statement = new BankAccountStatement();
        DataTable dt = dh.GetAccountStatement(AccountNumber, BankCode, StatementType);
        if (dt.Rows.Count > 0)
        {
            List<string> allTransactions = new List<string>();
            foreach (DataRow dr in dt.Rows)
            {
                string BankId = dr["BankTranId"].ToString();
                string Amount = dr["TranAmount"].ToString();
                string PaymentDate = DateTime.Parse(dr["PaymentDate"].ToString()).ToString("ddMMyyyy");
                string TranType = dr["TranType"].ToString();
                string line = BankId + "," +
                              Amount + "," +
                              TranType + "," +
                              PaymentDate;
                allTransactions.Add(line);
            }
            statement.statement = allTransactions;
            statement.StatusCode = "0";
            statement.StatusDesc = "SUCCESS";
        }
        else
        {
            statement.StatusCode = "100";
            statement.StatusDesc = "NO TRANSACTIONS FOUND DONE AGAINIST " + AccountNumber;
        }
        return statement;
    }

    public Result SaveCustomerTypeDetails(CustomerType custType, string BankCode)
    {
        Result result = new Result();
        result.RequestId = custType.Id;
        LogChangesInAuditLog(custType, custType.UserTypeCode, custType.BankCode, custType.ModifiedBy);
        string Id = dh.SaveUserTypeDetails(custType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public bool AreValidBankCredentials(string BankCode, string Password, out BaseObject valObj)
    {
        valObj = new BaseObject();
        Bank bank = dh.GetBankById(BankCode);
        valObj = bank;
        if (valObj.StatusCode == "0")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public bool IsDuplicateAccount(string AccountNumber, string BankCode)
    {
        return true;
    }

    public bool IsValidBankRef(string BankId, string BankCode, string toAccount, string fromAccount, string Amount, out BaseObject obj)
    {
        obj = new BaseObject();
        string[] parameters = { BankId, BankCode, toAccount, fromAccount, Amount };
        DataSet ds = dh.ExecuteDataSet("IsValidBankRef", parameters);
        DataTable dt = ds.Tables[0];

        //something has been found
        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];
            string BankRef = dr["BankTranId"].ToString().ToUpper().Trim();
            string PegPayId = dr["PegPayTranId"].ToString();
            if (BankId.ToUpper().Trim() == BankRef)
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "FAILED:DUPLICATE BANK TRANSACTION ID[" + BankRef + "], ORIGINAL RECIEPT NUMBER =" + PegPayId;
                return false;
            }
            else
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "FAILED:SUSPECTED DOUBLE POSTING,SAME AMOUNT TO SAME ACCOUNT NUMBER WITHIN 10 min, ORIGINAL RECIEPT NUMBER =" + PegPayId;
                return false;
            }
        }
        //no record of Id found
        else
        {
            obj.StatusCode = "0";
            obj.StatusDesc = "SUCCESS";
        }
        return true;
    }



    internal bool IsValidUser(string UserId, string BankCode, string UserType, out BaseObject obj)
    {
        List<string> allowedUserTypes = new List<string>();
        allowedUserTypes.AddRange(UserType.Split('|'));
        obj = new BaseObject();
        BankUser user = dh.GetUserById(UserId, BankCode);
        if (user.StatusCode == "0")
        {
            if (user.IsActive.ToUpper() == "TRUE")
            {
                if (allowedUserTypes.Contains(user.Usertype.ToUpper()))
                {
                    obj = user;
                    return true;
                }
                else
                {
                    obj.StatusCode = "100";
                    obj.StatusDesc = "ACCESS DENIED: BANK USER:" + UserId + " OF TYPE:" + user.Usertype + " IS NOT PERMITTED TO PERFORM THIS OPERATION";
                    
                    //log error for audit purposes
                    dh.LogError(UserId, BankCode, obj.StatusDesc);
                    return false;
                }
            }
            else 
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "FAILED: USER [" + UserId + "] IS NOT ACTIVATED.";
                return false;
            }
        }
        else
        {
            obj = user;
            return false;
        }
    }


    public Result SaveBankUserDetails(BankUser user, string BankCode)
    {
        Result result = new Result();
        result.RequestId = user.Id;
        LogChangesInAuditLog(user, user.Id, user.BankCode, user.ModifiedBy);
        string Id = dh.SaveUserDetails(user, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public Result SaveUserTypeDetails(UserType userType, string BankCode)
    {
        Result result = new Result();
        result.RequestId = userType.Id;
        LogChangesInAuditLog(userType, userType.UserTypeCode, userType.BankCode, userType.ModifiedBy);
        string Id = dh.SaveUserTypeDetails(userType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public Result SaveAccountTypeDetails(AccountType accountType, string BankCode)
    {
        Result result = new Result();
        result.RequestId = accountType.Id;
        LogChangesInAuditLog(accountType, accountType.AccTypeCode, accountType.BankCode, accountType.ModifiedBy);
        string Id = dh.SaveAccountTypeDetails(accountType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    private void LogChangesInAuditLog(BaseObject baseObj, string objectId, string BankCode, string modifiedBy)
    {
        try
        {
            //we use reflection to 
            //1. get the class of object passed
            //2.loop thru all properties of that class and get changes made
            AuditLog log = new AuditLog();
            BaseObject type = GetById(baseObj.GetType().Name, objectId, BankCode, "");
            string changesMade = "";

            //this is an Update
            if (type.StatusCode == "0")
            {
                log.ActionType = "UPDATE";
                changesMade += "Updated " + baseObj.GetType().Name + ",";
                FieldInfo[] oldFields = type.GetType().GetFields();
                FieldInfo[] newFields = baseObj.GetType().GetFields();
                foreach (FieldInfo oldField in oldFields)
                {
                    string oldFieldName = oldField.Name;
                    foreach (FieldInfo newField in newFields)
                    {
                        string newFieldName = newField.Name;

                        //when we find the matching field in the new object
                        if (oldFieldName == newFieldName)
                        {
                            //we compare the values in those fields

                            object oldFieldValue = type.GetType().GetField(oldFieldName).GetValue(type);
                            object newFieldValue = baseObj.GetType().GetField(newFieldName).GetValue(baseObj);

                            //values have changed
                            if (oldFieldValue != null && newFieldValue != null)
                            {
                                if (oldFieldValue.ToString() != newFieldValue.ToString())
                                {
                                    changesMade += " Changed " + oldFieldName + " From " + oldFieldValue + " To " + newFieldValue + ",";
                                }
                            }
                            break;
                        }
                    }
                }

            }
            //this is a new object. i.e an Insert
            else
            {
                changesMade += "Created new " + baseObj.GetType().Name + " with ";
                log.ActionType = "CREATE";
                FieldInfo[] newFields = baseObj.GetType().GetFields();

                foreach (FieldInfo newField in newFields)
                {
                    string newFieldName = newField.Name;
                    object obj = baseObj.GetType().GetField(newFieldName).GetValue(baseObj);
                    if (obj != null)
                    {
                        string newFieldValue =
                        changesMade += newFieldName + " = " + obj.ToString() + ", ";
                    }
                }
            }


            log.BankCode = BankCode;
            log.Action = changesMade;
            log.ModifiedBy = modifiedBy;
            log.TableName = baseObj.GetType().Name;
            dh.InsertIntoAuditLog(log);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public BaseObject GetById(string className, string objectId, string bankCode, string Password)
    {
        BaseObject result = new BaseObject();
        if (string.IsNullOrEmpty(className))
        {
            result.StatusCode = "100";
            result.StatusDesc = "PLEASE SUPPLY THE CLASS NAME";
            return result;
        }
        else if (string.IsNullOrEmpty(objectId))
        {
            result.StatusCode = "100";
            result.StatusDesc = "PLEASE SUPPLY THE OBJECT ID. i.e THE UNIQUE IDENTIFIER OF THIS OBJECT";
            return result;
        }
        else if (className.ToUpper() == "BANKUSER" || className.ToUpper() == "BANKTELLER" || className.ToUpper() == "BANKCUSTOMER")
        {
            result = GetBankUser(objectId, bankCode, Password);
            return result;
        }
        else if (className.ToUpper() == "BANK")
        {
            result = dh.GetBankById(objectId);
            return result;
        }
        else if (className.ToUpper() == "BANKBRANCH")
        {
            BankBranch branch = dh.GetBankBranchById(objectId, bankCode);
            result = branch;
            return result;
        }
        else if (className.ToUpper() == "USERTYPE")
        {
            UserType user = dh.GetUserTypeById(objectId, bankCode);
            result = user;
            return result;
        }
        else if (className.ToUpper() == "CUSTOMERTYPE")
        {
            UserType user = dh.GetUserTypeById(objectId, bankCode);
            result = user;
            return result;
        }
        else if (className.ToUpper() == "TRANSACTIONCATEGORY")
        {
            TransactionCategory category = dh.GetTransactionCategoryById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "BANKACCOUNT")
        {
            BankAccount category = dh.GetBankAccountById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "ACCOUNTTYPE")
        {
            AccountType category = dh.GetAccountTypeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "PAYMENTTYPE")
        {
            PaymentType category = dh.GetPaymentTypeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "BANKCHARGE")
        {
            BankCharge category = dh.GetBankChargeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "CHARGETYPE")
        {
            ChargeType category = dh.GetChargeTypeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "CURRENCY")
        {
            Currency category = dh.GetCurrencyCodeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "ACCESSRULE")
        {
            AccessRule rule = dh.GetAccessRuleById(objectId, bankCode);
            result = rule;
            return result;
        }
        else if (className.ToUpper() == "TRANSACTIONRULE")
        {
            TransactionRule rule = dh.GetTransactionRuleById(objectId, bankCode);
            result = rule;
            return result;
        }
        else
        {
            return result;
        }
    }

    private BaseObject GetBankUser(string objectId, string bankCode, string Password)
    {
        BaseObject result = new BaseObject();
        BankUser user = dh.GetUserById(objectId, bankCode);
        if (user.Usertype == "TELLER")
        {
            BankTeller teller = new BankTeller(user);
            teller.TellerAccountNumber = dh.GetAccountsByUserId(user.Id)[0];
            result = teller;
        }
        else
        {
            result = user;
        }

        return result;
    }

    public BaseObject[] GetAll(string className, string bankCode, string Password)
    {
        BaseObject[] result = { };
        if (string.IsNullOrEmpty(className))
        {
            return result;
        }
        else if (className.ToUpper() == "BANKUSER")
        {
            BankUser[] all = dh.GetAllUsers(bankCode);
            result = all;
            return result;
        }
        else if (className.ToUpper() == "USERTYPE")
        {
            UserType[] all = dh.GetAllUserTypes(bankCode);
            result = all;
            return result;
        }
        else if (className.ToUpper() == "BANK")
        {
            Bank[] all = dh.GetAllBanks();
            result = all;
            return result;
        }
        else if (className.ToUpper() == "BANKBRANCH")
        {
            BankBranch[] all = dh.GetAllBankBranches(bankCode);
            result = all;
            return result;
        }
        else
        {
            return result;
        }
    }

    public Result SaveTellerDetails(BankTeller teller, string BankCode)
    {
        Result result = new Result();
        result.RequestId = teller.Id;
        LogChangesInAuditLog(teller, teller.Id, teller.BankCode, teller.ModifiedBy);
        string Id = dh.SaveBankTeller(teller, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public Result SaveBankBranchDetails(BankBranch branch, string BankCode)
    {
        Result result = new Result();
        result.RequestId = branch.BankBranchId;
        LogChangesInAuditLog(branch, branch.BranchCode, branch.BankCode, branch.ModifiedBy);
        string Id = dh.SaveBankBranch(branch, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public DataSet ExecuteDataSet(string storedProcedureName, string[] Parameters)
    {
        DataSet ds = dh.ExecuteDataSet(storedProcedureName, Parameters);
        return ds;
    }

    public Result ExecuteNonQuery(string storedProcedureName, string[] Parameters)
    {
        Result ds = dh.ExecuteNonQuery(storedProcedureName, Parameters);
        return ds;
    }

    public Result SaveAccessRule(AccessRule rule, string BankCode)
    {
        Result result = new Result();
        result.RequestId = rule.Id;
        LogChangesInAuditLog(rule, rule.RuleName, rule.BankCode, rule.ModifiedBy);
        string Id = dh.SaveAccessRule(rule, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public Result SaveTransactionRule(TransactionRule rule, string BankCode)
    {
        Result result = new Result();
        result.RequestId = rule.Id;
        LogChangesInAuditLog(rule, rule.RuleCode, rule.BankCode, rule.ModifiedBy);
        string Id = dh.SaveTransactionRule(rule, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    internal bool IsValidBankCode(string BankCode, out BaseObject obj)
    {
        obj = new BaseObject();
        Bank bank = dh.GetBankById(BankCode);
        if (bank.StatusCode == "0")
        {
            if (bank.IsActive.ToUpper() == "TRUE")
            {
                obj = bank;
                return true;
            }
            else
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "BANK WITH BANK CODE [" + BankCode + "] IS NOT ACTIVATED";
                return false;
            }
        }
        else
        {
            obj = bank;
            return false;
        }
    }

    internal bool IsValidBankBranchCode(string BranchCode, string BankCode, out BaseObject obj)
    {
        obj = new BaseObject();
        BankBranch branch = dh.GetBankBranchById(BranchCode, BankCode);
        if (branch.StatusCode == "0")
        {
            if (branch.IsActive.ToUpper() == "TRUE")
            {
                obj = branch;
                return true;
            }
            else
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "FAILED: BANK BRANCH [" + BranchCode + "] IS NOT ACTIVE AT PEGPAY";
                return false;
            }
        }
        else
        {
            obj = branch;
            return false;
        }
    }

    internal bool IsValidAccountNumber(string AccountNumber, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        BankAccount account = dh.GetBankAccountById(AccountNumber, BankCode);

        if (account.StatusCode == "0")
        {
            if (account.IsActive.ToUpper() == "FALSE")
            {
                valObj.StatusCode = "100";
                valObj.StatusDesc = "FAILED: ACCOUNT WITH ACCOUNTNUMBER [" + AccountNumber + "] IS NOT ACTIVATED";
                return false;
            }
            else
            {
                valObj.StatusCode = "0";
                valObj.StatusDesc = "SUCCESS";
                return true;
            }
        }
        else
        {
            valObj = account;
            return false;
        }
    }

    internal bool IsValidTransactionAmount(string Amount, out BaseObject valObj)
    {
        valObj = new BaseObject();
        return true;
    }

    internal bool IsValidTransactionCategory(string tranCategory, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        TransactionCategory category = dh.GetTransactionCategoryById(tranCategory, BankCode);


        if (category.StatusCode == "0")
        {
            if (category.IsActive.ToUpper() == "")
            {
                valObj.StatusCode = "0";
                valObj.StatusDesc = "SUCCESS";
                return true;
            }
            else
            {
                valObj.StatusCode = "100";
                valObj.StatusDesc = "FAILED: TRANSACTION CATEGORY  [" + tranCategory + "] IS NOT ACTIVATED";
                return false;
            }
        }
        else
        {
            valObj = category;
            return false;
        }
    }

    internal bool IsValidReversal(string bankRef, string bankCode, out BaseObject valObject)
    {
        valObject = new BaseObject();
        DataTable dt = dh.GetTransactionByBankId(bankRef, bankCode);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                string TranCategory = dr["TranCategory"].ToString().Trim().ToUpper();
                if (TranCategory == "REVERSAL")
                {
                    string PegPayId = dr["PegPayTranId"].ToString();
                    valObject.StatusCode = "100";
                    valObject.StatusDesc = "TRANSACTION WITH BANK REF:" + bankRef + " ALREADY REVERSED. RECIEPT NUMBER FOR REVERSAL:" + PegPayId;
                    return false;
                }
                else
                {
                    continue;
                }
            }
            valObject.StatusCode = "0";
            valObject.StatusDesc = "SUCCESS";
            return true;
        }
        else
        {
            valObject.StatusCode = "100";
            valObject.StatusDesc = "TRANSACTION WITH BANK ID:" + bankRef + " NOT FOUND: REVERSAL NOT POSSIBLE";
            return false;
        }
    }

    internal bool IsValidBoolean(string p)
    {
        if (String.IsNullOrEmpty(p))
        {
            return false;
        }
        else if (p.ToUpper() == "TRUE" || p.ToUpper() == "FALSE")
        {
            return true;
        }
        return false;
    }

    internal bool IsValidAccountType(string accountType, string BankCode, List<string> AccountSignatories, out BaseObject valObj)
    {
        valObj = new BaseObject();
        AccountType accType = dh.GetAccountTypeById(accountType, BankCode);
        if (accType.StatusCode == "0")
        {
            if (accType.IsActive.ToUpper() == "FALSE")
            {
                valObj.StatusCode = "100";
                valObj.StatusDesc = "FAILED: ACCOUNT TYPE [" + accountType + "] IS NOT ACTIVATED.";
                return false;
            }
            //account must have less signatories(Owners) than those specified by the account type
            if (AccountSignatories.Count >= accType.MinNumberOfSignatories && AccountSignatories.Count <= accType.MaxNumberOfSignatories)
            {
                valObj = accType;
                return true;
            }
            else
            {
                valObj.StatusCode = "100";
                valObj.StatusDesc = "THIS ACCOUNT REQUIRES AT LEAST " + accType.MinNumberOfSignatories +
                                    " SIGNATORIES AND " + accType.MaxNumberOfSignatories + " MAXIMUM";
                return false;
            }
        }
        else
        {
            valObj = accType;
            return false;
        }
    }
    internal bool IsNumeric(string Amount)
    {
        try
        {
            int amount = int.Parse(Amount.Split('.')[0]);
            return true;
        }
        catch (Exception)
        {
            return false;
        }
    }


    internal bool IsNumericAndAboveZero(string Amount)
    {
        try
        {
            int amount = int.Parse(Amount.Split('.')[0]);
            if (amount <= 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception)
        {
            return false;
        }
    }

    internal bool IsValidGender(string Gender)
    {
        if (string.IsNullOrEmpty(Gender))
        {
            return false;
        }
        else if (Gender.ToUpper() == "MALE" || Gender.ToUpper() == "FEMALE")
        {
            return true;
        }
        return false;
    }

    public List<BankCustomer> GetAccountSignatories(string accountNumber, string bankCode, string Password)
    {
        List<BankCustomer> all = new List<BankCustomer>();
        DataTable dt = dh.GetAccountSignatories(accountNumber, bankCode);
        foreach (DataRow dr in dt.Rows)
        {
            BankCustomer cust = new BankCustomer();
            cust.BankCode = dr["BankCode"].ToString();
            cust.BranchCode = dr["BranchCode"].ToString();
            cust.CanHaveAccount = dr["CanHaveAccount"].ToString();
            cust.DateOfBirth = dr["DateOfBirth"].ToString();
            cust.Email = dr["Email"].ToString();
            cust.FullName = dr["FullName"].ToString();
            cust.Gender = dr["Gender"].ToString();
            cust.Id = dr["UserId"].ToString();
            cust.ModifiedBy = dr["ModifiedBy"].ToString();
            cust.PathToProfilePic = dr["PathToProfilePic"].ToString();
            cust.PathToSignature = dr["PathToSignature"].ToString();
            cust.PhoneNumber = dr["PhoneNumber"].ToString();
            all.Add(cust);
        }
        return all;
    }

    public Result SaveCurrencyDetails(Currency currency, string BankCode)
    {
        Result result = new Result();
        result.RequestId = currency.CurrencyCode;
        LogChangesInAuditLog(currency, currency.CurrencyCode, currency.BankCode, currency.ModifiedBy);
        string Id = dh.SaveCurrencyDetails(currency);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }


    internal bool IsValidCurrencyCode(string CurrencyCode, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        Currency code = dh.GetCurrencyCodeById(CurrencyCode, BankCode);
        if (code.StatusCode == "0")
        {
            valObj = code;
            return true;
        }
        else
        {
            valObj.StatusCode = "100";
            valObj.StatusDesc = code.StatusDesc;
            return false;
        }
    }

    internal bool IsValidPaymentType(string type, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        PaymentType result = dh.GetPaymentTypeById(type, BankCode);
        if (result.StatusCode == "0")
        {
            valObj = result;
            return true;
        }
        else
        {
            valObj.StatusCode = "100";
            valObj.StatusDesc = result.StatusDesc;
            return false;
        }
    }

    public Result SavePaymentType(PaymentType type, string BankCode)
    {
        Result result = new Result();
        result.RequestId = type.PaymentTypeCode;
        LogChangesInAuditLog(type, type.PaymentTypeCode, type.BankCode, type.ModifiedBy);
        string Id = dh.SavePaymentType(type);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }
}
