using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class PaymentType:BaseObject
    {
        public string PaymentTypeCode = "";
        public string PaymentTypeName = "";
        public string BankCode = "";
        public string ModifiedBy = "";
        public string IsActive = "";


        public bool IsValid(string BankCode, string Password) 
        {
            BaseObject valObj = new BaseObject();
            if (string.IsNullOrEmpty(this.PaymentTypeCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE CURRENCY NAME";
                return false;
            }
            else if (string.IsNullOrEmpty(this.PaymentTypeName))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE CURRENCY CODE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BankCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE BANK CODE TO WHICH THE CURRENCY BELONGS";
                return false;
            }
            else if (string.IsNullOrEmpty(this.ModifiedBy))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE ID OF USER MODIFYING THIS CURRENCY";
                return false;
            }
            else if (bll.IsValidUser(ModifiedBy,BankCode,"BUSSINESS_ADMIN",out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            else if (string.IsNullOrEmpty(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS PAYMENT TYPE IS ACTIVE OR NOT";
                return false;
            }
            else if (bll.IsValidBoolean(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS PAYMENT TYPE IS ACTIVE OR NOT. TRUE OR FALSE";
                return false;
            }
            else
            {
                StatusCode = "0";
                StatusDesc = "SUCCESS";
                return true;
            }
        }
    }
}
