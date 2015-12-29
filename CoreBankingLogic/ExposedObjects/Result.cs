using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

namespace CoreBankingLogic.ExposedObjects
{
    public class Result : Status
    {
        public string RequestId;
        public string PegPayId;
        public string ThirdPartyId;
    }
}
