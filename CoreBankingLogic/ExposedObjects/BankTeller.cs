using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

public class BankTeller : BankUser
{
    public BankTeller()
    {

    }

    public BankTeller(BankUser user)
        : base(user)
    {

    }

    public string TellerAccountNumber = "";




    public bool IsValidBankTeller(string BankCode, string Password)
    {
        bool result = IsValid(BankCode, Password);
        if (result == true)
        {
            StatusCode = "0";
            StatusDesc = "SUCCESS";
            return true;
        }
        else
        {
            //replace the word user in the error message with the word customer2
            StatusDesc = StatusDesc.Replace("USER", "TELLER");
            return false;
        }
    }
}

