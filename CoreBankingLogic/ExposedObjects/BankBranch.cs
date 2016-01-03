using System;
using System.Collections.Generic;
using System.Text;


public class BankBranch : BaseObject
{
    public string BankBranchId = "";
    public string BranchName = "";
    public string BranchCode = "";
    public string Location = "";
    public string BankCode = "";
    public string CreatedOn = "";
    public string ModifiedOn = "";
    public string CreatedBy = "";
    public string ModifiedBy = "";
    public string IsActive = "";


    public bool IsValid(string BankCode, string Password)
    {
        return true;
    }
}

