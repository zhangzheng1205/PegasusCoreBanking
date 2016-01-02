using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class CustomerType:BaseObject
    {
        public string Id = "";
        public string CustType = "";
        public string Description = "";
        public string CreatedBy = "";
        public string ApprovedBy = "";

        public bool IsValid()
        {
            return true;
        }
    }
}
