using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class AccessRule : BaseObject
    {
        public string Id = "";
        public string UserType = "";
        public string BankCode = "";
        public string CanAccess = "";
        public string UserId = "";
        public string BranchCode = "";
        public string ModifiedOn = "";
        public string ModifiedBy = "";
        public string RuleName = "";
        public string IsActive = "";

        public bool IsValid(string BankCode, string Password)
        {
            return true;
        }
    }
}
