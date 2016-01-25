using System;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for Users
/// </summary>

public class BankUser : BaseObject
{
    public string Email = "";
    public string Id = "";
    public string FullName = "";
    public string Usertype = "";
    public string Password = "";
    public string IsActive = "";
    public string ModifiedBy = "";
    public string CanHaveAccount = "";
    public string BranchCode = "";
    public string DateOfBirth = "";
    public string PhoneNumber = "";
    public string Gender = "";
    public string BankCode = "";
    public string TransactionLimit = "";
    public string PathToProfilePic = "";
    public string PathToSignature = "";


    public BankUser()
    {

    }

    public BankUser(BankUser user) 
    {
        this.BankCode = user.BankCode;
        this.BranchCode = user.BranchCode;
        this.CanHaveAccount = user.CanHaveAccount;
        this.DateOfBirth = user.DateOfBirth;
        this.Email = user.Email;
        this.FullName = user.FullName;
        this.Gender = user.Gender;
        this.Id = user.Id;
        this.IsActive = user.IsActive;
        this.ModifiedBy = user.ModifiedBy;
        this.Password = user.Password;
        this.PhoneNumber = user.PhoneNumber;
        this.StatusCode = user.StatusCode;
        this.StatusDesc = user.StatusDesc;
        this.Usertype = user.Usertype;
        this.PathToProfilePic = user.PathToProfilePic;
        this.PathToSignature = user.PathToSignature;
        this.TransactionLimit = user.TransactionLimit;
    }

    public bool IsValid(string bankCode, string Password)
    {
        BaseObject valObj = new BaseObject();
        if (string.IsNullOrEmpty(this.BankCode)) 
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK CODE TO WHICH USER BELONGS";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BranchCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BRANCH CODE OF BRANCH TO WHICH USER BELONGS";
            return false;
        }
        else if (string.IsNullOrEmpty(this.DateOfBirth))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A DATE OF BIRTH FOR THIS INDIVIDUAL";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Email)&&string.IsNullOrEmpty(this.PhoneNumber))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY EITHER AN EMAIL OR A PHONE NUMBER FOR THIS INDIVIDUAL.";
            return false;
        }
        else if (string.IsNullOrEmpty(this.FullName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE FULL NAME OF THIS INDIVIDUAL";
            return false;
        }
        else if (!bll.IsValidGender(this.Gender))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE GENDER OF INDIVIDUAL. [MALE OR FEMALE]";
            return false;
        }
        else if (!bll.IsValidBoolean(this.IsActive))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE WHETHER USER IS ACTIVE. [TRUE OR FALSE]";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Password))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A MD5 HASHED PASSWORD FOR THIS USER";
            return false;
        }
        else if ((this.Id!=this.Email)&&(this.Id!=this.PhoneNumber))
        {
            StatusCode = "100";
            StatusDesc = "FAILED: USER ID MUST BE USERS EMAIL OR PHONENUMBER.";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ModifiedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY CURRENT USER ID IN MODIFIED BY FIELD";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Usertype))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE THE USERTYPE OF USER";
            return false;
        }
        else if (!bll.IsValidUser(this.ModifiedBy,BankCode,"SYS_ADMIN|BANK_ADMIN",out valObj))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE THE USERTYPE OF USER";
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
