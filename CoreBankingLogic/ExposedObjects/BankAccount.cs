using System;
using System.Data;
using System.Configuration;

namespace CoreBankingLogic.EntityObjects
{
    public class BankAccount : Status
    {
        public string AccountId = "0";
        public string AccountNumber = "";
        public string AccountBalance = "";
        public string UserId = "";
        public string AccountType = "";
        public string BankCode = "";


        public BankAccount()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public BankAccount(string accountType) 
        {
            this.AccountType = accountType;
        }

        public bool IsValidCreateAccountRequest(string BankCode,string Password)
        {
            return true;
        }

        
    }
}
