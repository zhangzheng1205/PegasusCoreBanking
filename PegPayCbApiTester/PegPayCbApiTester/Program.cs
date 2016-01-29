using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PegPayCbApiTester
{
    class Program
    {
        static void Main(string[] args)
        {
            Tester test = new Tester();
            //test.TestSaveBankBranchDetails();
            //test.TestSaveBankTellerDetails();
            //test.TestSaveUserDetails();
            //test.TestSaveCustomerDetails();
            //test.TestSaveAccountDetails();
            //test.TestTransact();
            test.TestExportPdf();
            //test.TestTransact_SuspectedDoublePostingGoesAwayAfter10min();
            //test.TestReverseTransaction();
            //test.TestSaveBankDetails();
            //test.TestSaveCustomerTypeDetails();
            //test.TestGetAll();
            //test.TestGetById();
        }
    }
}
