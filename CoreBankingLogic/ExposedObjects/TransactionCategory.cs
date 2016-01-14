using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class TransactionCategory:BaseObject
    {
        public string Id = "";
        public string TranCategoryCode = "";
        public string TranCategoryName = "";
        public string Description = "";
        public string ModifiedBy = "";
        public string ApprovedBy = "";
        public string BankCode = "";
        public string IsActive = "";

        private BussinessLogic bll = new BussinessLogic();

       

        public bool IsValid(string BankCode, string Password)
        {
            BaseObject valobj=new BaseObject();
            if (!bll.AreValidBankCredentials(BankCode, Password)) 
            {
                StatusCode = "100";
                StatusDesc = "INVALID PEGPAY BANK CREDENTIALS";
                return false;
            }
            else if (!bll.IsValidUser(ModifiedBy,BankCode,out valobj))
            {
                StatusCode = "100";
                StatusDesc = "INVALID CREATED_BY USER";
                return false;
            }
            else if (!bll.IsValidUser(ApprovedBy, BankCode,out valobj))
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
