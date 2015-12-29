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
    public List<string> BankAccountNumbers = new List<string>();
   

	public BankCustomer()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public bool IsValidNewCustomer()
    {
        return true;
    }

}
