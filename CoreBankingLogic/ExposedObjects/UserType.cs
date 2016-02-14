using System;
using System.Collections.Generic;
using System.Text;

namespace CoreBankingLogic.ExposedObjects
{
    public class UserType : BaseObject
    {
        public string Id = "";
        public string UserTypeName = "";
        public string UserTypeCode = "";
        public string Role = "";
        public string Description = "";
        public string BankCode = "";
        public string IsActive = "";
        public string ModifiedBy = "";


        public bool IsValid(string bankCode, string Password)
        {
            BaseObject valObj = new BaseObject();
            if (string.IsNullOrEmpty(this.BankCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A BANKCODE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.Description))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A BRIEF DESCRIPTION OF THIS USERTYPE";
                return false;
            }
            else if (!bll.IsValidBoolean(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS USERTYPE IS ACTIVE OR NOT";
                return false;
            }
            else if (string.IsNullOrEmpty(this.ModifiedBy))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY ID OF USER MODIFYING THIS USERTYPE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.UserTypeCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A USERTYPE CODE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.UserTypeName))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A USERTYPE NAME";
                return false;
            }
            else if (!bll.IsValidUser(this.ModifiedBy, BankCode, "BANK_ADMIN|SYS_ADMIN", out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
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
