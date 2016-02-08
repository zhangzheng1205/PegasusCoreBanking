using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

namespace CoreBankingLogic.ExposedObjects
{
    public class Bank : BaseObject
    {
        public string BankId = "0";
        public string BankName = "";
        public string BankCode = "";
        public string BankContactEmail = "";
        public string BankPassword = "";
        public string IsActive = "";
        public string ModifiedBy = "";
        public string PathToPublicKey = "";
        public string PathToLogoImage = "";
        private string[] allowedPublicKeyTypes ={ ".cer" };
        private string[] allowedLogoImageTypes ={ ".jpg",".jpeg",".JPG",".JPEG",".png",".PNG" };


        public bool IsValidSaveBankRequest(string BankCode, string Password)
        {
            BaseObject valObj = new BaseObject();
            if (string.IsNullOrEmpty(this.BankCode))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A BANKCODE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BankContactEmail))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY AN EMAIL FOR THE BANK CONTACT PERSON";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BankName))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE NAME OF THIS BANK";
                return false;
            }
            else if (string.IsNullOrEmpty(this.BankPassword))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A PASSWORD FOR THIS BANK";
                return false;
            }
            else if (!bll.IsValidBoolean(this.IsActive))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE INDICATE WHETHER THIS BANK IS ACTIVE.[TRUE OR FALSE]";
                return false;
            }
            else if (string.IsNullOrEmpty(this.ModifiedBy))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY ID OF USER MODIFYING THE BANK";
                return false;
            }
            else if (string.IsNullOrEmpty(this.PathToLogoImage))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE PATH TO THE BANKS LOGO IMAGE";
                return false;
            }
            else if (string.IsNullOrEmpty(this.PathToPublicKey))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE PATH TO THE BANKS PUBLIC KEY";
                return false;
            }
            else if (string.IsNullOrEmpty(this.PathToPublicKey))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY THE PATH TO THE BANKS PUBLIC KEY";
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
