using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class AuditLog:BaseObject
    {
        public string AuditLogId = "";
        public string BankCode = "";
        public string Action = "";
        public string TableName = "";
        public string ActionType = "";
        public string ModifiedBy = "";
    }
}
