using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;

/// <summary>
/// Summary description for Charge
/// </summary>
public class BankCharge:BaseObject
{
    public string Id = "";
    public string CommissionAccountNumber = "";
    public string ChargeAmount = "";
    public string TransCategory = "";
    public string ModifiedBy = "";
    public string ModifiedOn = "";
    public string IsDebit = "";
    public string ChargeDescription = "";
    public string BankCode = "";
    public string ChargeName = "";
    public string ChargeCode = "";
    public string IsActive = "";
    public string AccountType = "";


	public BankCharge()
	{
        this.Id = "0";
        this.IsDebit = "True";
	}

    public bool IsValid(string BankCode, string Password)
    {
        BaseObject valObj=new BaseObject();
        if (string.IsNullOrEmpty(this.BankCode)) 
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANKCODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ChargeAmount))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CHARGE AMOUNT";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ChargeCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CHARGE CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ChargeDescription))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A CHARGE DESCRIPTION";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ChargeName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CHARGE NAME";
            return false;
        }
        else if (string.IsNullOrEmpty(this.CommissionAccountNumber))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE COMMISSION ACCOUNT NUMBER FOR THE CHARGE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.IsActive))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE WHETHER THIS CHARGE IS ACTIVE [TRUE OR FALSE]";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ModifiedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE ID OF USER WHO IS MODIFYING THIS CHARGE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.TransCategory))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE TRANSACTION CATEGORY TO BE AFFECTED BY THE CHARGE";
            return false;
        }
        else if (!bll.IsValidBoolean(this.IsActive))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE VALID ISACTIVE VALUE [TRUE OR FALSE]";
            return false;
        }
        else if (!bll.IsValidBankCode(BankCode,out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsNumericAndAboveZero(this.ChargeAmount))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A VALID CHARGE AMOUNT";
            return false;
        }
        else if (!bll.IsValidAccountNumber(this.CommissionAccountNumber,BankCode,out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else if (!bll.IsValidTransactionCategory(this.TransCategory, BankCode, out valObj))
        {
            StatusCode = "100";
            StatusDesc = valObj.StatusDesc;
            return false;
        }
        else 
        {
            StatusCode = "0";
            StatusDesc = "SUCCESS";
            return true;
        }
        
    }

   
}
