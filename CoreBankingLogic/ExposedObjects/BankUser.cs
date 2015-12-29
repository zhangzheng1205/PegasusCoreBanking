using System;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for Users
/// </summary>
public class BankUser : Status
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



    public BankUser()
    {

    }

    public bool IsValid(string bankCode, string Password)
    {
        return true;
    }
}
