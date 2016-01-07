using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class UserType:BaseObject
    {
        public string Id = "";
        public string UserTypeName = "";
        public string UserTypeCode = "";
        public string Role = "";
        public string Description = "";
        public string BankCode = "";
        public string IsActive = "";
        public string ModifiedBy = "";
        public string ModifiedOn = "";


        public bool IsValid(string bankCode, string Password)
        {
            return true;
        }
    }
}
