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
        return true;
    }
}

