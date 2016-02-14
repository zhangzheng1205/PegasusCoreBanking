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
    public string ModifiedBy = "";
    public string IsActive = "";


    public bool IsValid(string BankCode, string Password)
    {
        if (string.IsNullOrEmpty(this.BankCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BranchCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BRANCH CODE";
            return false;
        }
        else if (string.IsNullOrEmpty(this.BranchName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BRANCH NAME";
            return false;
        }
        else if (string.IsNullOrEmpty(this.Location))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE LOCATION OF THIS BRANCH";
            return false;
        }
        else if (string.IsNullOrEmpty(this.ModifiedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY ID OF USER MODIFYING THIS BRANCH";
            return false;
        }
        else if (!bll.IsValidBoolean(this.IsActive))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE WHETHER THIS BRANCH IS ACTIVATED.[TRUE OR FALSE]";
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

