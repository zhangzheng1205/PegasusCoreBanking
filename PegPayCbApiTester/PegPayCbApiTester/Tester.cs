using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;
using PegPayCbApiTester.CbApi;

namespace PegPayCbApiTester
{
    [TestFixture]
    public class Tester
    {
        ServiceSoapClient client = new ServiceSoapClient();
        string BankCode = "TESTBANK";
        string Password = "TEST";

        public Tester()
        {

        }

        [Test]
        public void TestGetAll()
        {
            //List<Object> obj = 

            BaseObject[] bo = client.GetAll("BankUser", "TESTBANK", "TEST");
            foreach (BaseObject obj in bo)
            {
                BankUser user = obj as BankUser;
                Assert.AreEqual(user.StatusCode, "0");
            }
        }

        [Test]
        public void TestGetById()
        {
            //List<Object> obj = 
            BaseObject bo = client.GetById("BANKUSER","1","TESTBANK","TEST");
            BankUser user = bo as BankUser;
            Assert.AreEqual(user.StatusCode, "0");
        }

        [Test]
        public void TestSaveBankBranchDetails()
        {
            BankBranch branch = new BankBranch();
            branch.BankBranchId = "0";
            branch.BankCode = "TESTBANK";
            branch.BranchCode = "TESTBRANCH";
            branch.BranchManagerId = "1";
            branch.BranchName = "TESTBRANCH";
            branch.CreatedBy = "TEST";
            branch.CreatedOn = "27/12/2015";
            branch.LastModifiedOn = "27/12/2015";
            branch.Location = "KANSANGA";
            branch.ModifiedBy = "TEST";
            Result result = client.SaveBankBranchDetails(branch, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        [Test]
        public void TestSaveBankTellerDetails()
        {
            BankTeller teller = new BankTeller();
            teller.BranchCode = "TESTBRANCH";
            teller.CanHaveAccount = "True";
            teller.DateOfBirth = "17/02/1991";
            teller.FullName = "NSUBUGA KASOZI";
            teller.Gender = "MALE";
            teller.IsActive = "True";
            teller.ModifiedBy = "TEST";
            teller.Password = "TEST";
            teller.PhoneNumber = "256794132389";
            teller.StatusCode = "0";
            teller.Id = "0";
            teller.Email = "nsubugak@yahoo.com";
            teller.Usertype = "TELLER";

            Result result = client.SaveBankTellerDetails(teller, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveUserDetails()
        {
            BankUser user = new BankUser();
            user.BranchCode = "TESTBRANCH";
            user.CanHaveAccount = "True";
            user.DateOfBirth = "17/02/1991";
            user.Email = "nsubugak@yahoo.com";
            user.FullName = "Nsubuga Kasozi";
            user.Gender = "MALE";
            user.Id = "100";
            user.IsActive = "True";
            user.ModifiedBy = "TEST";
            user.Password = "TEST";
            user.PhoneNumber = "256785975800";
            user.Usertype = "CUSTOMER";

            Result result = client.SaveBankUserDetails(user, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveCustomerDetails()
        {
            BankCustomer user = new BankCustomer();
            user.BranchCode = "TESTBRANCH";
            user.CanHaveAccount = "True";
            user.DateOfBirth = "17/02/1991";
            user.Email = "nsubugak@yahoo.com";
            user.FullName = "Nsubuga Kasozi";
            user.Gender = "MALE";
            user.Id = "100";
            user.IsActive = "True";
            user.ModifiedBy = "TEST";
            user.Password = "TEST";
            user.PhoneNumber = "256785975800";
            user.Usertype = "CUSTOMER";

            Result result = client.SaveBankCustomerDetails(user, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveAccountDetails()
        {
            BankAccount acc = new BankAccount();
            acc.AccountBalance = "300";
            acc.AccountId = "12";
            acc.AccountNumber = "482136";
            acc.AccountType = "TEST";
            acc.BankCode = "TESTBANK";
            acc.UserId = "100";

            Result result = client.SaveBankAccountDetails(acc, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestTransact()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "100";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133328";
            req.CustomerId = "100";
            req.CustomerName = "TEST CUSTOMER";
            req.DigitalSignature = "";
            req.FromAccount = "0140586848601";
            req.ToAccount = "0140586848602";
            req.Teller = "TEST";
            req.TranAmount = "500";
            req.TranCategory = "TEST";
            req.BranchCode = "TESTBRANCH";
            req.Narration = "TEST NARRATION";
            req.PaymentDate = "28/12/2015";
            req.Password = "TEST";

            Result result = client.Transact(req);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestReverseTransaction()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "100";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133328";
            req.CustomerId = "";
            req.CustomerName = "";
            req.DigitalSignature = "";
            req.FromAccount = "";
            req.ToAccount = "";
            req.Teller = "";
            req.TranAmount = "";
            req.TranCategory = "";
            req.BranchCode = "";
            req.Narration = "";
            req.PaymentDate = "";
            req.Password = "TEST";

            Result result = client.ReverseTransaction(req);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveBankDetails()
        {

            Bank bank = new Bank();
            bank.BankCode = "TESTBANK";
            bank.BankContactEmail = "nsubugak@yahoo.com";
            bank.BankId = "0";
            bank.BankName = "TEST NAME";
            bank.BankPassword = "TEST";

            Result result = client.SaveBankDetails(bank, "TEST", "TEST");
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveCustomerTypeDetails()
        {

            CustomerType type = new CustomerType();
            type.ApprovedBy = "TEST";
            type.CreatedBy = "TEST";
            type.CustType = "FARMERS";
            type.Description = "TEST";
            type.Id = "0";

            Result result = client.SaveCustomerTypeDetails(type, "TESTBANK", "TEST");
            Assert.AreEqual(result.StatusCode, "0");
        }

        //public void TestSaveCustomerTypeDetails()
        //{

        //    CustomerType type = new CustomerType();
        //    type.ApprovedBy = "TEST";
        //    type.CreatedBy = "TEST";
        //    type.CustType = "FARMERS";
        //    type.Description = "TEST";
        //    type.Id = "0";

        //    Result result = client.SaveCustomerTypeDetails(type, "TESTBANK", "TEST");
        //    Assert.AreEqual(result.StatusCode, "0");
        //}






    }
}
