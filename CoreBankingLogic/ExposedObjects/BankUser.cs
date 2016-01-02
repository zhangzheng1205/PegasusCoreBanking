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
    }

    public bool IsValid(string bankCode, string Password)
    {
        return true;
    }
}
