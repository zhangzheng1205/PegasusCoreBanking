using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;
using CoreBankingLogic.ExposedObjects;
using System.Runtime.Serialization;
using System.Data;

[WebService(Namespace = "http://pegasus.co.ug/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    private BussinessLogic bll = new BussinessLogic();


    public Service()
    {

    }

    [WebMethod]
    public Result Transact(TransactionRequest tranRequest)
    {
        Result result = new Result();
        try
        {
            if (tranRequest.IsValidTransactRequest())
            {
                result = bll.Transact(tranRequest);
            }
            else
            {
                result.StatusCode = tranRequest.StatusCode;
                result.StatusDesc = tranRequest.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result ReverseTransaction(TransactionRequest tranRequest)
    {
        Result result = new Result();
        try
        {
            if (tranRequest.IsValidReversal())
            {
                result = bll.ReverseTransaction(tranRequest);
            }
            else
            {
                result.StatusCode = tranRequest.StatusCode;
                result.StatusDesc = tranRequest.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }


    [WebMethod]
    public BankAccountStatement GetMiniStatement(string AccountNumber, string BankCode, string Password, BankCharge[] charges)
    {
        BankAccountStatement statement = new BankAccountStatement();
        try
        {
            statement = bll.GenerateStatement(AccountNumber, BankCode, Password, "MINI");
        }
        catch (Exception ex)
        {
            statement.StatusCode = "100";
            statement.StatusDesc = "FAILED: " + ex.Message;
        }
        return statement;
    }

    [WebMethod]
    public BankAccountStatement GetFullStatement(string AccountNumber, string BankCode, string Password)
    {
        BankAccountStatement statement = new BankAccountStatement();
        try
        {
            statement = bll.GenerateStatement(AccountNumber, BankCode, Password, "FULL");
        }
        catch (Exception ex)
        {
            statement.StatusCode = "100";
            statement.StatusDesc = "FAILED: " + ex.Message;
        }
        return statement;
    }

    [WebMethod]
    public Result SaveBankAccountDetails(BankAccount account, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (account.IsValidSaveAccountRequest(BankCode, Password))
            {
                result = bll.SaveAccountDetails(account, BankCode);
            }
            else
            {
                result.StatusCode = account.StatusCode;
                result.StatusDesc = account.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveBankDetails(Bank bank, string adminUsername, string adminPassword)
    {
        Result result = new Result();
        try
        {
            if (bank.IsValidSaveBankRequest(adminUsername, adminPassword))
            {
                result = bll.SaveBankDetails(bank);
            }
            else
            {
                result.StatusCode = bank.StatusCode;
                result.StatusDesc = bank.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveBankChargeDetails(BankCharge charge, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (charge.IsValid(BankCode, Password))
            {
                result = bll.SaveBankChargeDetails(charge, BankCode);
            }
            else
            {
                result.StatusCode = charge.StatusCode;
                result.StatusDesc = charge.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveAccessRule(AccessRule rule, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (rule.IsValid(BankCode, Password))
            {
                result = bll.SaveAccessRule(rule, BankCode);
            }
            else
            {
                result.StatusCode = rule.StatusCode;
                result.StatusDesc = rule.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveTransactionRule(TransactionRule rule, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (rule.IsValid(BankCode, Password))
            {
                result = bll.SaveTransactionRule(rule, BankCode);
            }
            else
            {
                result.StatusCode = rule.StatusCode;
                result.StatusDesc = rule.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }


    [WebMethod]
    public Result SaveBankUserDetails(BankUser user, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (user.IsValid(BankCode, Password))
            {
                result = bll.SaveBankUserDetails(user, BankCode);
            }
            else
            {
                result.StatusCode = user.StatusCode;
                result.StatusDesc = user.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public BaseObject GetById(string className, string objectId, string bankCode, string Password)
    {
        BaseObject result = new BaseObject();
        result = bll.GetById(className, objectId, bankCode, Password);
        return result;
    }

    [WebMethod]
    public List<BankCustomer> GetAccountSignatories(string accountNumber, string bankCode, string Password)
    {
        List<BankCustomer> all = new List<BankCustomer>();
        all = bll.GetAccountSignatories(accountNumber, bankCode, Password);
        return all;
    }

    [WebMethod]
    public BaseObject[] GetAll(string className, string bankCode, string Password)
    {
        BaseObject[] result = { };
        result = bll.GetAll(className, bankCode, Password);
        return result;
    }

    [WebMethod]
    public Result SaveBankTellerDetails(BankTeller teller, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (teller.IsValid(BankCode, Password))
            {
                result = bll.SaveTellerDetails(teller, BankCode);
            }
            else
            {
                result.StatusCode = teller.StatusCode;
                result.StatusDesc = teller.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED : " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveBankBranchDetails(BankBranch branch, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (branch.IsValid(BankCode, Password))
            {
                result = bll.SaveBankBranchDetails(branch, BankCode);
            }
            else
            {
                result.StatusCode = branch.StatusCode;
                result.StatusDesc = branch.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED : " + ex.Message;
        }
        return result;
    }



    [WebMethod]
    public Result SaveUserTypeDetails(UserType userType, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (userType.IsValid(BankCode, Password))
            {
                result = bll.SaveUserTypeDetails(userType, BankCode);
            }
            else
            {
                result.StatusCode = userType.StatusCode;
                result.StatusDesc = userType.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED : " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveAccountTypeDetails(AccountType accountType, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (accountType.IsValid(BankCode, Password))
            {
                result = bll.SaveAccountTypeDetails(accountType, BankCode);
            }
            else
            {
                result.StatusCode = accountType.StatusCode;
                result.StatusDesc = accountType.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED : " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveChargeTypeDetails(ChargeType chargeType, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (chargeType.IsValid(BankCode, Password))
            {
                result = bll.SaveChargeType(chargeType, BankCode);
            }
            else
            {
                result.StatusCode = chargeType.StatusCode;
                result.StatusDesc = chargeType.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED : " + ex.Message;
        }
        return result;
    }


    [WebMethod]
    public Result SaveTransactionCategoryDetails(TransactionCategory tranType, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (tranType.IsValid(BankCode, Password))
            {
                result = bll.SaveTranType(tranType, BankCode);
            }
            else
            {
                result.StatusCode = tranType.StatusCode;
                result.StatusDesc = tranType.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }




    [WebMethod]
    public Result SaveBankCustomerDetails(BankCustomer cust, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (cust.IsValidNewCustomer(BankCode,Password))
            {
                result = bll.SaveBankCustomerDetails(cust, BankCode);
            }
            else
            {
                result.StatusCode = cust.StatusCode;
                result.StatusDesc = cust.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result SaveCustomerTypeDetails(CustomerType custType, string BankCode, string Password)
    {
        Result result = new Result();
        try
        {
            if (custType.IsValid(BankCode,Password))
            {
                result = bll.SaveCustomerTypeDetails(custType, BankCode);
            }
            else
            {
                result.StatusCode = custType.StatusCode;
                result.StatusDesc = custType.StatusDesc;
            }
        }
        catch (Exception ex)
        {
            result.StatusCode = "100";
            result.StatusDesc = "FAILED: " + ex.Message;
        }
        return result;
    }

    [WebMethod]
    public Result ExecuteNonQuery(string storedProcedureName, params string[] Parameters)
    {

        Result result = new Result();
        try
        {
            result = bll.ExecuteNonQuery(storedProcedureName, Parameters);
        }
        catch (Exception e)
        {
            throw new SoapException(e.Message, new System.Xml.XmlQualifiedName(e.Message), e);
        }
        return result;
    }


    [WebMethod]
    public DataSet ExecuteDataSet(string storedProcedureName, params string[] Parameters)
    {

        DataSet dataSet = new DataSet();
        try
        {
            dataSet = bll.ExecuteDataSet(storedProcedureName, Parameters);
            return dataSet;
        }
        catch (Exception e)
        {
            throw new SoapException(e.Message, new System.Xml.XmlQualifiedName(e.Message), e);
        }
    }



}
