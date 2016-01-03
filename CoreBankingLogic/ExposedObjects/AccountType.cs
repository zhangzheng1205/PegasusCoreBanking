using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class AccountType:BaseObject
    {
        public string Id = "";
        public string AccTypeName = "";
        public string AccTypeCode = "";
        public string Description = "";
        public string MinimumBalance = "";
        public string ModifiedBy = "";
        public string BankCode = "";
        public string IsDebitable = "";
        public string ModifiedOn = "";
        public string IsActive = "";


        public bool IsValid(string BankCode, string Password) 
        {
            return true;
        }
    }
}
