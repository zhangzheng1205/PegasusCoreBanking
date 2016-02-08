using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class ChargeType:BaseObject
    {
        public string ChargeTypeCode = "";
        public string ChargeTypeName = "";
        public string Description = "";
        public string IsActive = "";
        public string BankCode = "";
        public string ModifiedBy = "";

        public bool IsValid(string BankCode,string Password) 
        {
            return true;
        }
    }
}
