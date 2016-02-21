using System;
using System.Collections.Generic;
using System.Text;
public class Currency : BaseObject
{
    public string CurrencyName = "";
    public string CurrencyCode = "";
    public string BankCode = "";
    public string ModifiedBy = "";
    public string ValueInLocalCurrency = "";


    public bool IsValid(string BankCode, string Password)
    {
        BaseObject valObj = new BaseObject();
        if (string.IsNullOrEmpty(this.CurrencyName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CURRENCY NAME";
            return false;
        }
        else if (string.IsNullOrEmpty(this.CurrencyCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE CURRENCY CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BankCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE BANK CODE TO WHICH THE CURRENCY BELONGS";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ModifiedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE ID OF USER MODIFYING THIS CURRENCY";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ValueInLocalCurrency))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY LOCAL CURRENCY VALUE AS WELL.i.e HOW MUCH IS 1 UNIT OF THIS CURRENCY IN LOCAL CURRENCY";
            return false;
        }
        else if (bll.IsValidUser(ModifiedBy, BankCode, "BUSSINESS_ADMIN", out valObj))
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

