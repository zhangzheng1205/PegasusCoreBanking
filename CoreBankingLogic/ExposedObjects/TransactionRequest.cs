using System;
using System.Data;
using System.Configuration;
using System.Web;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;


public class TransactionRequest:BaseObject
{
    public string CustomerName="";
    public string CustomerId="";
    public string ToAccount="";
    public string FromAccount="";
    public string TranAmount ="";
    public string BankTranId="";
    public string PaymentDate ="";
    public string Teller="";
    public string ApprovedBy="";
    public string BankCode="";
    public string Narration ="";
    public string Password = "";
    public string DigitalSignature = "";
    public string TranCategory = "";
    public string BranchCode = "";


    public bool IsValid()
    {
        return true;
    }

   

    public bool IsValidReversal()
    {
        return true;
    }
}
