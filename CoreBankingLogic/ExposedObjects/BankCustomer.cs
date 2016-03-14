using System;
using System.Data;
using System.Configuration;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;

/// <summary>
/// Summary description for Customer
/// </summary>
public class BankCustomer : BaseObject
{
    public string Email = "";
    public string Id = "";
    public string FirstName = "";
    public string LastName = "";
    public string OtherName = "";
    public string Password = "";
    public string IsActive = "";
    public string ModifiedBy = "";
    public string BranchCode = "";
    public string DateOfBirth = "";
    public string PhoneNumber = "";
    public string Gender = "";
    public string BankCode = "";
    public string PathToProfilePic = "";
    public string PathToSignature = "";
    public string ApprovedBy = "";
    public string NextOfKinName = "";
    public string NextOfKinContact = "";
    public string MaritalStatus = "";
    public string Nationality = "";


    public BankCustomer()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public bool IsValidNewCustomer(string BankCode, string Password)
    {
        BaseObject valObj = new BaseObject();

        //if the one who is Approving is the same as the one modifiying 
        //set the Approved By to be empty
        if (this.ModifiedBy.ToUpper().Trim() == this.ApprovedBy.ToUpper().Trim())
        {
            if (this.ModifiedBy.ToUpper() == "ADMIN")
            {
                this.ApprovedBy = "Admin";
            }
            else
            {
                this.ApprovedBy = "";
            }
        }

        //Lets start validations

        if (string.IsNullOrEmpty(this.BankCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BANK CODE TO WHICH CUSTOMER BELONGS";
            return false;
        }
        if (string.IsNullOrEmpty(this.BranchCode))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A BRANCH CODE OF BRANCH TO WHICH CUSTOMER BELONGS";
            return false;
        }
        if (string.IsNullOrEmpty(this.DateOfBirth))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A DATE OF BIRTH FOR THIS INDIVIDUAL";
            return false;
        }
        if (string.IsNullOrEmpty(this.Email) && string.IsNullOrEmpty(this.PhoneNumber))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY EITHER AN EMAIL OR A PHONE NUMBER FOR THIS INDIVIDUAL.";
            return false;
        }
        if (string.IsNullOrEmpty(this.FirstName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE FIRST NAME OF THIS INDIVIDUAL";
            return false;
        }
        if (string.IsNullOrEmpty(this.LastName))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY THE LAST NAME OF THIS INDIVIDUAL";
            return false;
        }
        if (!bll.IsValidGender(this.Gender))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE GENDER OF INDIVIDUAL. [MALE OR FEMALE]";
            return false;
        }
        if (!bll.IsValidBoolean(this.IsActive))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE INDICATE WHETHER CUSTOMER IS ACTIVE. [TRUE OR FALSE]";
            return false;
        }

        if (string.IsNullOrEmpty(this.Password))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A MD5 HASHED PASSWORD FOR THIS CUSTOMER";
            return false;
        }
        if (string.IsNullOrEmpty(this.Id))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY A UNIQUE ID FOR THIS INDIVIDUAL. It can be Email or Phone Number of CUSTOMER";
            return false;
        }
        if ((this.Id != this.Email) && (this.Id != this.PhoneNumber))
        {
            StatusCode = "100";
            StatusDesc = "FAILED: CUSTOMER ID MUST BE CUSTOMERS EMAIL OR PHONENUMBER.";
            return false;
        }
        if (string.IsNullOrEmpty(this.ModifiedBy))
        {
            StatusCode = "100";
            StatusDesc = "PLEASE SUPPLY USER ID OF MODIFIER IN MODIFIED BY FIELD";
            return false;
        }

        if (!bll.IsValidUser(this.ModifiedBy, BankCode, "SYS_ADMIN|BANK_ADMIN|CUSTOMER_SERVICE", out valObj))
        {
            string statusDesc = valObj.StatusDesc.ToUpper();
            if (statusDesc.Contains("NOT ACTIVATED") || statusDesc.Contains("NOT YET APPROVED"))
            {
                StatusCode = "0";
                statusDesc = "SUCCESS";
            }
            else
            {

                StatusCode = "100";
                StatusDesc = valObj.StatusDesc;
                return false;
            }
        }
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

        StatusCode = "0";
        StatusDesc = "SUCCESS";
        return true;


    }

}
