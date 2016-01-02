using System;
using System.Collections.Generic;
using System.Text;


public class BankBranch : BaseObject
{
    public string BankBranchId = "";
    public string BranchName = "";
    public string BranchCode = "";
    public string Location = "";
    public string BranchManagerId = "";
    public string BankCode = "";
    public string CreatedOn = "";
    public string LastModifiedOn = "";
    public string CreatedBy = "";
    public string ModifiedBy = "";


    public bool IsValid(string BankCode, string Password)
    {
        return true;
    }
}

