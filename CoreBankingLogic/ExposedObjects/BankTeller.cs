using System;
using System.Collections.Generic;
using System.Text;
using CoreBankingLogic.EntityObjects;

public class BankTeller : BankUser
{
    public BankTeller() 
    {
    
    }

    public BankTeller(BankUser user) :base(user)
    {
    
    }

    public string TellerAccountNumber = "";


}

