using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class PaymentType:BaseObject
    {
        public string PaymentTypeCode = "";
        public string PaymentTypeName = "";
        public string BankCode = "";
        public string ModifiedBy = "";
        public string IsActive = "";


        public bool IsValid(string BankCode, string Password) 
        {
            return true;
        }
    }
}
