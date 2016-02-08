using System;
using System.Data;
using System.Configuration;
using System.Web;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;


public class TransactionRequest:BaseObject
{
    public string CustomerName="";
    public string ToAccount="";
    public string FromAccount="";
    public string TranAmount ="";
    public string BankTranId="";
    public string PaymentDate ="";
    public string Teller="";
    public string ApprovedBy="";
    public string BankCode="";
    public string Narration ="";
    public string Password = "";
    public string DigitalSignature = "";
    public string TranCategory = "";
    public string BranchCode = "";
    public string CurrencyCode = "";
    public string PaymentType = "";
    public string ChequeNumber = "";

   


    public bool IsValidTransactRequest()
    {
        BaseObject valObj=new BaseObject();
        if (string.IsNullOrEmpty(this.ApprovedBy)) 
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY APPROVER USER ID IN APPROVEDBY FIELD";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BankCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANKCODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BankTranId))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK TRANSACTION ID";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BranchCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BRANCH CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.PaymentType))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A PAYMENT TYPE";
            return false;
        }

        else if (string.IsNullOrEmpty(this.CustomerName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A CUSTOMER NAME";
            return false;
        }
        else if (string.IsNullOrEmpty(this.FromAccount))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A FROM ACCOUNT";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Narration))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A NARRATION/REASON FOR THIS TRANSACTION";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Password))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK PASSWORD";
            return false;
        }
        else if (string.IsNullOrEmpty(this.PaymentDate))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A PAYMENT DATE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Teller))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A TELLER ID";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ToAccount))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A TO ACCOUNT";
            return false;
        }
        else if (string.IsNullOrEmpty(this.TranAmount))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A TRANSACTION AMOUNT";
            return false;
        }
        else if (string.IsNullOrEmpty(this.TranCategory))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A TRANSACTION CATEGORY";
            return false;
        }
        else if (string.IsNullOrEmpty(this.CurrencyCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CURRENCY CODE.";
            return false;
        }
        else if (this.PaymentType.ToUpper().Contains("CHEQUE")&&string.IsNullOrEmpty(this.ChequeNumber))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CHEQUE NUMBER";
            return false;
        }
        else if (!bll.IsValidBankCode(this.BankCode,out valObj))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A VALID BANKCODE. BANK NOT FOUND";
            return false;
        }
        else if (!bll.IsValidUser(this.ApprovedBy,this.BankCode,"SUPERVISOR|TELLER",out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidBankRef(this.BankTranId,this.BankCode,this.ToAccount,this.FromAccount,this.TranAmount,out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidBankBranchCode(this.BranchCode,this.BankCode,out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidAccountNumber(this.FromAccount, this.BankCode, out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidUser(this.Teller, this.BankCode,"TELLER", out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidAccountNumber(this.ToAccount, this.BankCode, out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidTransactionAmount(this.TranAmount, out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidTransactionCategory(this.TranCategory, this.BankCode, out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        
        return true;
    }

   

    public bool IsValidReversal()
    {
        BaseObject valObject = new BaseObject();
        if (string.IsNullOrEmpty(this.BankTranId)) 
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK REFERENCE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BankCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Password))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK PASSWORD";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Teller))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY ID OF BANK TELLER";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ApprovedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A ID OF BANK SUPERVISOR IN APPROVED BY FIELD";
            return false;
        }
        else if (!bll.IsValidUser(this.ApprovedBy,this.BankCode,"SUPERVISOR",out valObject))
        {
            StatusCode = "100";
            StatusDesc = valObject.StatusDesc;
            return false;
        }
        else if (!bll.IsValidUser(this.Teller,this.BankCode,"TELLER",out valObject))
        {
            StatusCode = "100";
            StatusDesc = valObject.StatusDesc;
            return false;
        }

        else if (!bll.IsValidReversal(this.BankTranId, this.BankCode, out valObject))
        {
            StatusCode = "0";
            StatusDesc = valObject.StatusDesc;
            return false;
        }

        return true;
    }
}
