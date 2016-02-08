using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

namespace CoreBankingLogic.ExposedObjects
{
    public class Result : BaseObject
    {
        public string RequestId;
        public string PegPayId;
        public string ThirdPartyId;
    }
}
