using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class BankAccountStatement:Result
    {
        public List<string> statement = new List<string>();
    }
}
