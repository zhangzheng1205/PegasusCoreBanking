using System;
using System.Collections.Generic;
using System.Text;
using InterLinkClass;

namespace InterLinkClass
{
    public class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                //NWSCTransaction trans = new NWSCTransaction();
                //if (customer.CustomerError.Equals("NONE"))
                //{
                //    Console.WriteLine(customer.CustRef + "," + customer.CustName + "," + customer.Area + "," + customer.OutstandingBal.ToString());
                //    trans.Area = customer.Area;
                //    trans.CustName = customer.CustName;
                //    trans.CustomerTel = "772525184";
                //    trans.CustRef = customer.CustRef;
                //    trans.Password = "test1";
                //    trans.VendorCode = "V1";
                //    trans.PaymentDate = DateTime.Now;
                //    trans.TransactionType = "Cash";
                //    trans.TransactionAmount = 10000;
                //    trans.VendorTransactionRef = "V12345";
                //    NWSCPostResponse response = water.PostCustomerTransactions(trans);
                //    Console.WriteLine(response.Successful + "," + response.PostError);
                //}
                //else
                //{
                //    Console.WriteLine(customer.CustomerError);
                //}
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            Console.ReadLine();
        }
    }
}
