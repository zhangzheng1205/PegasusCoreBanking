using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;

/// <summary>
/// Summary description for Charge
/// </summary>
public class BankCharge:BaseObject
{
    public string Id = "";
    public string CommissionAccountNumber = "";
    public string ChargeAmount = "";
    public string TransactionType = "";
    public string CreatedBy = "";
    public string ApprovedBy = "";
    public string IsDebit = "";
    public string ChargeDescription = "";

	public BankCharge()
	{
        this.Id = "0";
        this.IsDebit = "True";
	}

    public bool IsValid(string adminUsername, string adminPassword)
    {
        return true;
    }

   
}
