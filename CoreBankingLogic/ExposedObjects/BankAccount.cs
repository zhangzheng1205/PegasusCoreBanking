using System;
using System.Data;
using System.Configuration;

namespace CoreBankingLogic.EntityObjects
{
    public class BankAccount : BaseObject
    {
        public string AccountId = "0";
        public string AccountNumber = "";
        public string AccountBalance = "";
        public string UserId = "";
        public string AccountType = "";
        public string BankCode = "";
        public string ModifiedBy = "";
        public string BranchCode = "";
        public string IsActive = "";


        public BankAccount()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public BankAccount(string accountType) 
        {
            this.AccountType = accountType;
        }

        public bool IsValidSaveAccountRequest(string BankCode,string Password)
        {
            BaseObject valObj = new BaseObject();
            if (string.IsNullOrEmpty(this.AccountNumber)) 
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY AN ACCOUNT NUMBER";
                return false;
            }
            else if (string.IsNullOrEmpty(this.AccountType))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY AN ACCOUNT TYPE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BankCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A BANKCODE FOR BANK TO WHICH THIS ACCOUNT BELONGS";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BranchCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE BRANCHCODE WHERE THIS ACCOUNT WAS CREATED";
                return false;
            }
            else if (string.IsNullOrEmpty(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS ACCOUNT IS ACTIVE [TRUE OR FALSE]";
                return false;
            }
            else if (string.IsNullOrEmpty(this.ModifiedBy))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY  ID of USER WHO IS MODIFYING THIS ACCOUNT";
                return false;
            }
            else if (string.IsNullOrEmpty(this.UserId))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE ID OF THE CUSTOMER TO WHOM THIS ACCOUNT BELONGS";
                return false;
            }
            else if (!bll.IsValidAccountType(this.AccountType,this.BankCode))
            {
                StatusCode = "100";
                StatusDesc = "INVALID ACCOUNT TYPE SUPPLIED";
                return false;
            }
            else if (!bll.IsValidBoolean(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS ACCOUNT IS ACTIVE [TRUE OR FALSE]";
                return false;
            }
            else if (!bll.IsValidUser(this.ModifiedBy,BankCode,"CUSTOMER_SERVICE|MANAGER|BANK_ADMIN",out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            else if (!bll.IsValidUser(this.UserId, BankCode, "CUSTOMER",out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            return true;
        }

        
    }
}
