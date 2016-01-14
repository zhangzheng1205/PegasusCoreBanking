using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;
using CoreBankingLogic.ExposedObjects;
using System.Collections.Generic;

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
        string accountId = dh.SaveAccount(account, BankCode);
        result.PegPayId = accountId;
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        return result;
    }

    public Result SaveBankDetails(Bank bank)
    {
        Result result = new Result();
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
        string TransactId = dh.Reverse(tranRequest.BankTranId, tranRequest.BankCode);
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
            string Header = "BankId,Amount,PayDate,ToAccount,FromAccount,TransactionType";
            allTransactions.Add(Header);
            foreach (DataRow dr in dt.Rows)
            {
                string BankId = dr["VendorTranId"].ToString();
                string Amount = dr["TranAmount"].ToString();
                string PaymentDate = dr["PaymentDate"].ToString();
                string toAccount = dr["toAccount"].ToString();
                string fromAccount = dr["fromAccount"].ToString();
                string TranType = dr["TranType"].ToString();
                string line = BankId + "," +
                              Amount + "," +
                              PaymentDate + "," +
                              toAccount + "," +
                              fromAccount + "," +
                              TranType;
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
        string Id = dh.SaveCustomerType(custType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public bool AreValidBankCredentials(string BankCode, string Password)
    {
        return true;
    }

    public bool IsDuplicateAccount(string AccountNumber, string BankCode)
    {
        return true;
    }

    public bool IsValidBankRef(string BankId, string BankCode, string toAccount,string fromAccount, string Amount, out BaseObject obj)
    {
        obj = new BaseObject();
        string[] parameters ={ BankId, BankCode, toAccount,fromAccount, Amount };
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
                obj.StatusDesc = "FAILED:DUPLICATE BANK TRANSACTION ID["+BankRef+"], ORIGINAL RECIEPT NUMBER =" + PegPayId;
            }
            else
            {
                obj.StatusCode = "100";
                obj.StatusDesc = "FAILED:SUSPECTED DOUBLE POSTING,SAME AMOUNT TO SAME ACCOUNT NUMBER WITHIN 10 min, ORIGINAL RECIEPT NUMBER =" + PegPayId;
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

    internal bool IsValidUser(string username, string BankCode, out BaseObject obj)
    {
        obj = new BaseObject();
        BankUser user = dh.GetUserById(username, BankCode);
        obj = user;
        return true;
    }

    public Result SaveBankUserDetails(BankUser user, string BankCode)
    {
        Result result = new Result();
        result.RequestId = user.Id;
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
        string Id = dh.SaveAccountTypeDetails(accountType, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    public BaseObject GetById(string className, string objectId, string bankCode, string Password)
    {
        BaseObject result = new BaseObject();
        if (string.IsNullOrEmpty(className))
        {
            return result;
        }
        else if (string.IsNullOrEmpty(objectId))
        {
            return result;
        }
        else if (className.ToUpper() == "BANKUSER")
        {
            result = GetBankUser(objectId, bankCode, Password);
            return result;
        }
        else if (className.ToUpper() == "BANK")
        {
            result = dh.GetBankById(objectId);
            return result;
        }
        else if (className.ToUpper() == "USERTYPE")
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
        else if (className.ToUpper() == "ACCOUNTYPE")
        {
            AccountType category = dh.GetAccountTypeById(objectId, bankCode);
            result = category;
            return result;
        }
        else if (className.ToUpper() == "ACCESSRULE")
        {
            AccessRule rule = dh.GetAccessRuleById(objectId, bankCode);
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
        else if (user.Usertype == "CUSTOMER")
        {
            //BankCustomer cust = new BankCustomer(user);
            //cust.
        }
        else
        {
            result = user;
        }

        return result;
    }

    public BaseObject[] GetAll(string className, string bankCode, string Password)
    {
        BaseObject[] result ={ };
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
        string Id = dh.SaveTransactionRule(rule, BankCode);
        result.StatusCode = "0";
        result.StatusDesc = "SUCCESS";
        result.PegPayId = Id;
        return result;
    }

    internal bool IsValidBankCode(string BankCode, out BaseObject obj)
    {
        obj = new BaseObject();
        obj = dh.GetBankById(BankCode);
        if (obj.StatusCode == "0")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    internal bool IsValidBankBranchCode(string BranchCode, string BankCode, out BaseObject obj)
    {
        obj = new BaseObject();
        return true;
    }

    internal bool IsValidAccountNumber(string AccountNumber, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        return true;
    }

    internal bool IsValidTransactionAmount(string Amount, out BaseObject valObj)
    {
        valObj = new BaseObject();
        return true;
    }

    internal bool IsValidTransactionCategory(string tranCategory, string BankCode, out BaseObject valObj)
    {
        valObj = new BaseObject();
        return true;
    }
}
