using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

namespace CoreBankingLogic.ExposedObjects
{
    public class Bank:BaseObject
    {
        public string BankId = "0";
        public string BankName = "";
        public string BankCode = "";
        public string BankContactEmail = "";
        public string BankPassword = "";
        public string IsActive = "";
        public string ModifiedBy = "";
        public string PathToPublicKey = "";
        public string PathToLogoImage = "";
       

        public bool IsValidCreateBankRequest(string BankCode, string Password)
        {
            return true;
        }
    }
}
