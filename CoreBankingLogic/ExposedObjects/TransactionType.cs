using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class TransactionType:BaseObject
    {
        public string Id = "";
        public string TranType = "";
        public string Description = "";
        public string CreatedBy = "";
        public string ApprovedBy = "";
        //public string BankCode = "";

        private BussinessLogic bll = new BussinessLogic();

       

        public bool IsValid(string BankCode, string Password)
        {
            if (!bll.AreValidBankCredentials(BankCode, Password)) 
            {
                StatusCode = "100";
                StatusDesc = "INVALID PEGPAY BANK CREDENTIALS";
                return false;
            }
            else if (!bll.IsValidUser(CreatedBy,BankCode))
            {
                StatusCode = "100";
                StatusDesc = "INVALID CREATED_BY USER";
                return false;
            }
            else if (!bll.IsValidUser(ApprovedBy, BankCode))
            {
                StatusCode = "100";
                StatusDesc = "INVALID APPROVED_BY USER";
                return false;
            }
            StatusCode = "0";
            StatusDesc = "SUCCESS";
            return true;
        }
    }
}
