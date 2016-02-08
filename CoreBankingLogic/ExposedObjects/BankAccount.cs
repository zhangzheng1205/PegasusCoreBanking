using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;

namespace CoreBankingLogic.EntityObjects
{
    public class BankAccount : BaseObject
    {
        public string AccountId = "0";
        public string AccountNumber = "";
        public string AccountBalance = "";
        public string AccountType = "";
        public string BankCode = "";
        public string ModifiedBy = "";
        public string BranchCode = "";
        public string IsActive = "";
        public string CurrencyCode = "";
        public List<string> AccountSignatories = new List<string>();


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

        public bool IsValidSaveAccountRequest(string BankCode, string Password)
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
            else if (string.IsNullOrEmpty(this.CurrencyCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE THE CURRENCY THAT THE ACCOUNT BALANCE IS STORED IN.";
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
            else if (AccountSignatories.Count == 0)
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY AN ACCOUNT SIGNATORY.i.e ID OF CUSTOMER WHO OWNS THE CUSTOMER";
                return false;
            }
            else if (!bll.IsValidAccountType(this.AccountType, this.BankCode, AccountSignatories, out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            else if (!bll.IsValidBoolean(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS ACCOUNT IS ACTIVE [TRUE OR FALSE]";
                return false;
            }
            else if (!bll.IsValidCurrencyCode(this.CurrencyCode,BankCode,out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            else if (!bll.IsValidUser(this.ModifiedBy, BankCode, "CUSTOMER_SERVICE|MANAGER|BANK_ADMIN", out valObj))
            {
                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
            foreach (string UserId in AccountSignatories)
            {
                if (!bll.IsValidUser(UserId, BankCode, "CUSTOMER|TELLER", out valObj))
                {
                    string statusDesc = valObj.StatusDesc.ToUpper();
                    if (statusDesc.Contains("NOT ACTIVATED"))
                    {
                        StatusCode = "0";
                        statusDesc = "SUCCESS";
                        continue;
                    }
                    else
                    {

                        StatusCode = "100";
                        StatusDesc = valObj.StatusDesc;
                        return false;
                    }
                }
            }
            return true;
        }


    }
}
