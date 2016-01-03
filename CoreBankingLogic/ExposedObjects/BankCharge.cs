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
    public string TransCategory = "";
    public string ModifiedBy = "";
    public string ModifiedOn = "";
    public string IsDebit = "";
    public string ChargeDescription = "";
    public string BankCode = "";
    public string ChargeName = "";
    public string ChargeCode = "";
    public string IsActive = "";


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
