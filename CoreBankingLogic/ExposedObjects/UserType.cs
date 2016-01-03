using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class UserType:BaseObject
    {
        public string Id = "";
        public string UserTypeName = "";
        public string Usertype = "";
        public string Role = "";
        public string Description = "";
        public string BankCode = "";


        public bool IsValid(string bankCode, string Password)
        {
            return true;
        }
    }
}
