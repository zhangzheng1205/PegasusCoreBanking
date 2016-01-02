using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class AccountType
    {
        public string Id = "";
        public string AccType = "";
        public string Description = "";
        public string MinimumBalance = "";
        public string CreatedBy = "";
        public string ApprovedBy = "";
        public string BankCode = "";


        public bool IsValid(string BankCode, string Password) 
        {
            return true;
        }
    }
}
