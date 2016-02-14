using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;

/// <summary>
/// Summary description for Customer
/// </summary>
public class BankCustomer:BankUser
{  
	public BankCustomer()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public bool IsValidNewCustomer(string BankCode,string Password)
    {
        bool result= IsValid(BankCode,Password);
        if (result == true) 
        {
            if (string.IsNullOrEmpty(this.PathToProfilePic))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY A PROFILE PICTURE FOR THIS CUSTOMER";
                return false;
            }
            if (string.IsNullOrEmpty(this.PathToSignature))
            {
                StatusCode = "100";
                StatusDesc = "PLEASE SUPPLY AN IMAGE OF THE CUSTOMERS SIGNATURE.";
                return false;
            }
            else 
            {
                StatusCode = "0";
                StatusDesc = "SUCCESS";
                return true;
            }
        }
        else 
        {
            //replace the word user in the error message with the word customer2
            StatusDesc = StatusDesc.Replace("USER", "CUSTOMER");
            return false;
        }
    }

}
