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
        return IsValid(BankCode,Password);
    }

}
