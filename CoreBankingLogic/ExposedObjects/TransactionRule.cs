using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class TransactionRule : BaseObject
    {
        public string Id = "";
        public string RuleName = "";
        public string RuleCode = "";
        public string UserId = "";
        public string Description = "";
        public string MinimumAmount = "";
        public string MaximumAmount = "";
        public string IsActive = "";
        public string BankCode = "";
        public string BranchCode = "";
        public string ModifiedOn = "";
        public string ModifiedBy = "";
        public string Approver = "";


        public bool IsValid(string BankCode, string Password)
        {
            return true;
        }
    }
}
