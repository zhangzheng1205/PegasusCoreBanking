using System;
using System.Data;
using System.Configuration;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Globalization;
using CoreBankingLogic.ExposedObjects;
using CoreBankingLogic.EntityObjects;
using System.Collections.Generic;

/// <summary>
/// Summary description for DatabaseHandler
/// </summary>
public class DatabaseHandler
{
    private Database CbDatabase;
    private DbCommand command;
    public string SmsQueuePath = "";
    public string ConnectionString = "TestCbConnectionString";
    //public string ConnectionString = "PegPayConnectionString";

    public DatabaseHandler()
    {
        try
        {
            CbDatabase = DatabaseFactory.CreateDatabase(ConnectionString);
            SmsQueuePath = @".\private$\smsQueue";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string SaveCustomer(BankCustomer cust, string BankCode)
    {
        string format = "dd/MM/yyyy";
        DateTime birthDate = DateTime.ParseExact(cust.DateOfBirth, format, CultureInfo.InvariantCulture);
        try
        {
            command = CbDatabase.GetStoredProcCommand("Customers_Update",
                                                       cust.Id,
                                                       cust.Email,
                                                       cust.FirstName,
                                                       cust.LastName,
                                                       cust.OtherName,
                                                       cust.Password,
                                                       cust.IsActive,
                                                       cust.BankCode,
                                                       cust.ModifiedBy,//CreatedBy
                                                       cust.ModifiedBy,//ModifiedBY
                                                       cust.ApprovedBy,
                                                       cust.PhoneNumber,
                                                       cust.BranchCode,
                                                       cust.DateOfBirth,
                                                       cust.Gender,
                                                       cust.PathToProfilePic,
                                                       cust.PathToSignature,
                                                       cust.NextOfKinName,
                                                       cust.NextOfKinContact,
                                                       cust.MaritalStatus,
                                                       cust.Nationality
                );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveBank(Bank bank)
    {
        try
        {
            if (bank.IsActive == "") { bank.IsActive = "True"; }
            command = CbDatabase.GetStoredProcCommand("Banks_Update",
                                                        bank.BankId,
                                                        bank.BankName,
                                                        bank.BankCode,
                                                        bank.BankContactEmail,
                                                        bank.BankPassword,
                                                        bank.IsActive,
                                                        bank.ModifiedBy,
                                                        bank.PathToLogoImage,
                                                        bank.PathToPublicKey,
                                                        bank.BankThemeColor,
                                                        bank.TextColor,
                                                        bank.BankVaultAccNumber
                );
            DataSet allTables = CbDatabase.ExecuteDataSet(command);
            //get last table because it has what we need
            DataTable datatable = allTables.Tables[allTables.Tables.Count - 1];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    internal string SaveBankBranch(BankBranch branch, string BankCode)
    {
        try
        {
            string CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
            string ModifyDate = CreateDate;
            command = CbDatabase.GetStoredProcCommand("BankBranches_Update",
                                                       branch.BankBranchId,
                                                       branch.BranchName,
                                                       branch.BranchCode,
                                                       branch.Location,
                                                       branch.IsActive,
                                                       branch.BankCode,
                                                       branch.ModifiedBy,
                                                       branch.BranchVaultAccNumber

                );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveBankTeller(BankTeller teller, string BankCode)
    {
        try
        {
            string CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
            string ModifyDate = CreateDate;
            command = CbDatabase.GetStoredProcCommand("BankTellers_Update",
                                                       teller.Email,
                                                       teller.FirstName,
                                                       teller.LastName,
                                                       teller.OtherName,
                                                       teller.Usertype,
                                                       teller.Password,
                                                       teller.IsActive,
                                                       teller.ModifiedBy,//because he who creates either also modifies
                                                       teller.ModifiedBy,
                                                       teller.ApprovedBy,
                                                       teller.BranchCode,
                                                       teller.DateOfBirth,
                                                       teller.PhoneNumber,
                                                       teller.Gender,
                                                       teller.TellerAccountNumber,
                                                       teller.BankCode);
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[1];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveAccount(BankAccount account, string BankCode)
    {
        try
        {
            string AccountId = "";
            foreach (string signatory in account.AccountSignatories)
            {
                command = CbDatabase.GetStoredProcCommand("Accounts_Update",
                                                            account.AccountId,
                                                            account.AccountBalance,
                                                            signatory,
                                                            account.AccountNumber,
                                                            account.AccountType,
                                                            account.BankCode,
                                                            account.ModifiedBy,
                                                            account.BranchCode,
                                                            account.IsActive,
                                                            account.CurrencyCode,
                                                            account.ApprovedBy
                    );
                DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
                AccountId = datatable.Rows[0][0].ToString();
            }
            return AccountId;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string Transact(TransactionRequest tranRequest)
    {
        try
        {
            DateTime payDate = DateTime.ParseExact(tranRequest.PaymentDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            command = CbDatabase.GetStoredProcCommand("InsertReceivedTransactionWithCharges",
                                                        tranRequest.CustomerName,
                                                        tranRequest.ToAccount,
                                                        tranRequest.FromAccount,
                                                        tranRequest.TranAmount,
                                                        tranRequest.BankTranId,
                                                        payDate,
                                                        tranRequest.Teller,
                                                        tranRequest.ApprovedBy,
                                                        tranRequest.BankCode,
                                                        tranRequest.Narration,
                                                        tranRequest.TranCategory,
                                                        tranRequest.BranchCode,
                                                        tranRequest.CurrencyCode,
                                                        tranRequest.PaymentType,
                                                        tranRequest.ChequeNumber
                                                      );
            DataSet ds = CbDatabase.ExecuteDataSet(command);
            int index = ds.Tables.Count - 1;
            DataTable dt = ds.Tables[index];
            foreach (DataTable de in ds.Tables)
            {
                DataTable dc = de;
            }
            return dt.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string Reverse(string BankId, string BankCode, string Teller, string ApprovedBy)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("ReverseTransaction",
                                                        BankId,
                                                        BankCode,
                                                        Teller,
                                                        ApprovedBy
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveCharge(BankCharge charge, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("Charges_Update",
                                                       charge.Id,
                                                       charge.ChargeAmount,
                                                       charge.CommissionAccountNumber,
                                                       charge.TransCategory,
                                                       charge.IsDebit,
                                                       charge.BankCode,
                                                       charge.ModifiedBy,
                                                       DateTime.Now,
                                                       charge.ChargeDescription,
                                                       charge.ChargeName,
                                                       charge.ChargeCode,
                                                       charge.IsActive,
                                                       charge.AccountType,
                                                       charge.ChargeType
                                                      );

            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveTransactionType(TransactionCategory tranType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("TransactionTypes_Update",
                                                       tranType.Id,
                                                       tranType.TranCategoryCode,
                                                       tranType.Description,
                                                       tranType.BankCode,
                                                       tranType.ModifiedBy,
                                                       tranType.IsActive
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    internal string SaveUserDetails(BankUser user, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("Users_Update",
                                                       user.Id,
                                                       user.Email,
                                                       user.FirstName,
                                                       user.LastName,
                                                       user.OtherName,
                                                       user.Usertype,
                                                       user.Password,
                                                       user.IsActive,
                                                       user.BankCode,
                                                       user.ModifiedBy,
                                                       user.ModifiedBy,
                                                       user.ApprovedBy,
                                                       user.PhoneNumber,
                                                       user.BranchCode,
                                                       user.DateOfBirth,
                                                       user.Gender,
                                                       user.TransactionLimit
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveUserTypeDetails(UserType userType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("UserTypes_Update",
                                                       userType.Id,
                                                       userType.UserTypeCode,
                                                       userType.Role,
                                                       userType.Description,
                                                       userType.BankCode,
                                                       userType.ModifiedBy
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveAccountTypeDetails(AccountType accountType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("AccountTypes_Update",
                                                       accountType.Id,
                                                       accountType.AccTypeName,
                                                       accountType.AccTypeCode,
                                                       accountType.MinimumBalance,
                                                       accountType.BankCode,
                                                       accountType.IsDebitable,
                                                       accountType.Description,
                                                       accountType.ModifiedBy,
                                                       accountType.IsActive,
                                                       accountType.MinNumberOfSignatories,
                                                       accountType.MaxNumberOfSignatories
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



    internal DataTable GetAccountStatement(string AccountNumber, string BankCode, string StatementType)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("GetAccountStatement",
                                                       AccountNumber,
                                                       BankCode,
                                                       StatementType
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal BankUser GetUserById(string objectId, string BankCode)
    {
        BankUser user = new BankUser();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Users_SelectRow",
                                                       objectId
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString().ToUpper();

                user.FirstName = dr["FirstName"].ToString();
                user.LastName = dr["LastName"].ToString();
                user.OtherName = dr["OtherName"].ToString();
                user.IsActive = IsActive;
                user.Password = dr["Password"].ToString();
                user.Id = dr["UserId"].ToString();
                user.Email = dr["Email"].ToString();
                user.Usertype = dr["Usertype"].ToString();
                user.PhoneNumber = dr["PhoneNumber"].ToString();
                user.BankCode = dr["BankCode"].ToString();
                user.BranchCode = dr["BranchCode"].ToString();
                user.Gender = dr["Gender"].ToString();
                user.DateOfBirth = dr["DateOfBirth"].ToString();
                user.ApprovedBy = dr["ApprovedBy"].ToString();
                user.StatusCode = "0";
                user.StatusDesc = "SUCCESS";

            }
            else
            {
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: USER WITH ID: " + objectId + " NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message + "";
        }
        return user;
    }

    internal UserType GetUserTypeById(string objectId, string BankCode)
    {
        UserType user = new UserType();
        try
        {
            command = CbDatabase.GetStoredProcCommand("UserTypes_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                user.Description = dr["Description"].ToString();
                user.Id = dr["UserTypeId"].ToString();
                user.Role = dr["Role"].ToString();
                user.UserTypeCode = dr["UserType"].ToString();
                user.UserTypeName = dr["UserType"].ToString();
                user.BankCode = dr["BankCode"].ToString();
                user.StatusCode = "0";
                user.StatusDesc = "SUCCESS";
            }
            else
            {
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: USERTYPE NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message;
        }
        return user;
    }


    internal AccountType GetAccountTypeById(string objectId, string BankCode)
    {
        AccountType type = new AccountType();
        try
        {
            command = CbDatabase.GetStoredProcCommand("AccountTypes_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                type.AccTypeCode = dr["AccTypeCode"].ToString();
                type.AccTypeName = dr["AccTypeName"].ToString();
                type.BankCode = dr["BankCode"].ToString();
                type.Description = dr["Description"].ToString();
                type.Id = dr["AccTypeId"].ToString();
                type.IsActive = dr["IsActive"].ToString();
                type.IsDebitable = dr["IsDebitable"].ToString();
                type.MinimumBalance = dr["MinimumBal"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();
                type.MinNumberOfSignatories = ConvertToInt(dr["MinNumberOfSignatories"].ToString());
                type.MaxNumberOfSignatories = ConvertToInt(dr["MaxNumberOfSignatories"].ToString());
                type.StatusCode = "0";
                type.StatusDesc = "SUCCESS";
            }
            else
            {
                type.StatusCode = "100";
                type.StatusDesc = "FAILED: USERTYPE NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            type.StatusCode = "100";
            type.StatusDesc = "FAILED: " + ex.Message;
        }
        return type;
    }

    public int ConvertToInt(string aString)
    {
        int result = 0;
        try
        {
            result = Convert.ToInt32(aString);
            return result;
        }
        catch (Exception)
        {
            result = 0;
            return result;
        }
    }



    internal BankAccount GetBankAccountById(string objectId, string BankCode)
    {
        BankAccount account = new BankAccount();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Accounts_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString();

                account.AccountBalance = dr["AccBalance"].ToString();
                account.AccountId = dr["AccountId"].ToString();
                account.BankCode = dr["BankCode"].ToString();
                account.AccountNumber = dr["AccNumber"].ToString();
                account.AccountType = dr["AccType"].ToString();
                account.IsActive = dr["IsActive"].ToString();
                account.BranchCode = dr["BranchCode"].ToString();
                account.ModifiedBy = dr["ModifiedBy"].ToString();
                account.CurrencyCode = dr["CurrencyCode"].ToString();
                account.ApprovedBy = dr["ApprovedBy"].ToString();
                foreach (DataRow row in datatable.Rows)
                {
                    account.AccountSignatories.Add(row["UserId"].ToString());
                }
                account.StatusCode = "0";
                account.StatusDesc = "SUCCESS";

            }
            else
            {
                account.StatusCode = "100";
                account.StatusDesc = "FAILED: ACCOUNT WITH ACCOUNT_NUMBER:" + objectId + " NOT FOUND UNDER BANK: " + BankCode;
            }
        }
        catch (Exception ex)
        {
            account.StatusCode = "100";
            account.StatusDesc = "FAILED: " + ex.Message;
        }
        return account;
    }

    internal BankUser[] GetAllUsers(string bankCode)
    {
        List<BankUser> allUsers = new List<BankUser>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Users_SelectAll",
                                                       bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                foreach (DataRow dr in datatable.Rows)
                {
                    BankUser user = new BankUser();
                    user.FirstName = dr["FirstName"].ToString();
                    user.LastName = dr["LastName"].ToString();
                    user.OtherName = dr["OtherName"].ToString();
                    user.IsActive = dr["IsActive"].ToString();
                    user.Password = dr["Password"].ToString();
                    user.Id = dr["UserId"].ToString();
                    user.Email = dr["Email"].ToString();
                    user.Usertype = dr["Usertype"].ToString();
                    user.StatusCode = "0";
                    user.StatusDesc = "SUCCESS";
                    allUsers.Add(user);
                }
            }
            else
            {
                BankUser user = new BankUser();
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: NO USER FOUND";
                allUsers.Add(user);
            }
        }
        catch (Exception ex)
        {
            BankUser user = new BankUser();
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message;
            allUsers.Add(user);
        }
        return allUsers.ToArray();
    }

    internal UserType[] GetAllUserTypes(string bankCode)
    {
        List<UserType> all = new List<UserType>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("UserTypes_SelectAll",
                                                       bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                foreach (DataRow dr in datatable.Rows)
                {
                    UserType user = new UserType();
                    user.Description = dr["Description"].ToString();
                    user.Id = dr["UserTypeId"].ToString();
                    user.Role = dr["Role"].ToString();
                    user.UserTypeCode = dr["UserType"].ToString();
                    user.BankCode = dr["BankCode"].ToString();
                    user.StatusCode = "0";
                    user.StatusDesc = "SUCCESS";
                    all.Add(user);
                }
            }
            else
            {
                UserType user = new UserType();
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: NO USERTYPE FOUND";
                all.Add(user);
            }
        }
        catch (Exception ex)
        {
            UserType user = new UserType();
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message;
            all.Add(user);
        }
        return all.ToArray();
    }

    internal TransactionCategory[] GetAllTransactionTypes(string bankCode)
    {
        List<TransactionCategory> all = new List<TransactionCategory>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("TransactionTypes_SelectAll",
                                                       bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                foreach (DataRow dr in datatable.Rows)
                {
                    TransactionCategory tranType = new TransactionCategory();
                    tranType.BankCode = dr["BankCode"].ToString();
                    tranType.Description = dr["Description"].ToString();
                    tranType.Id = dr["TranTypeId"].ToString();
                    tranType.ModifiedBy = dr["ModifiedBy"].ToString();
                    tranType.TranCategoryCode = dr["TranType"].ToString();
                    tranType.StatusCode = "0";
                    tranType.StatusDesc = "SUCCESS";
                    all.Add(tranType);
                }
            }
            else
            {
                TransactionCategory tranType = new TransactionCategory();
                tranType.StatusCode = "100";
                tranType.StatusDesc = "FAILED: NO USERTYPE FOUND";
                all.Add(tranType);
            }
        }
        catch (Exception ex)
        {
            TransactionCategory user = new TransactionCategory();
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message;
            all.Add(user);
        }
        return all.ToArray();
    }




    internal DataSet ExecuteDataSet(string storedProcedureName, string[] Parameters)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand(storedProcedureName,
                                                       Parameters
                                                      );
            DataSet ds = CbDatabase.ExecuteDataSet(command);
            return ds;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal Result ExecuteNonQuery(string storedProcedureName, string[] Parameters)
    {
        Result result = new Result();
        try
        {
            command = CbDatabase.GetStoredProcCommand(storedProcedureName,
                                                       Parameters
                                                      );
            int rows = CbDatabase.ExecuteNonQuery(command);
            result.PegPayId = "" + rows;
            result.RequestId = "";
            result.StatusCode = "0";
            result.StatusDesc = "SUCCESS";
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    internal List<string> GetAccountsByUserId(string userId)
    {
        List<string> all = new List<string>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("GetAccountsByUserId",
                                                      userId
                                                     );
            DataTable dt = CbDatabase.ExecuteDataSet(command).Tables[0];

            if (dt.Rows.Count == 0)
            {
                all.Add("");
            }
            foreach (DataRow dr in dt.Rows)
            {
                string accNo = dr["AccNumber"].ToString();
                all.Add(accNo);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return all;
    }

    internal Bank[] GetAllBanks()
    {
        List<Bank> all = new List<Bank>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Banks_SelectAll"
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                foreach (DataRow dr in datatable.Rows)
                {
                    Bank bank = new Bank();
                    bank.BankCode = dr["BankCode"].ToString();
                    bank.BankContactEmail = dr["BankContactEmail"].ToString();
                    bank.BankId = dr["BankId"].ToString();
                    bank.BankName = dr["BankName"].ToString();
                    bank.BankPassword = dr["BankPassword"].ToString();
                    bank.IsActive = dr["IsActive"].ToString();
                    bank.ModifiedBy = dr["ModifiedBy"].ToString();
                    bank.PathToLogoImage = dr["PathToLogoImage"].ToString();
                    bank.PathToPublicKey = dr["PathToPublicKey"].ToString();
                    bank.StatusCode = "0";
                    bank.StatusDesc = "SUCCESS";
                    all.Add(bank);
                }
            }
            else
            {
                Bank bank = new Bank();
                bank.StatusCode = "100";
                bank.StatusDesc = "FAILED: NO BANKS FOUND";
                all.Add(bank);
            }
        }
        catch (Exception ex)
        {
            Bank bank = new Bank();
            bank.StatusCode = "100";
            bank.StatusDesc = "FAILED: " + ex.Message;
            all.Add(bank);
        }
        return all.ToArray();
    }

    internal BankBranch[] GetAllBankBranches(string bankCode)
    {
        List<BankBranch> all = new List<BankBranch>();
        try
        {
            command = CbDatabase.GetStoredProcCommand("BankBranches_SelectAll"
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                foreach (DataRow dr in datatable.Rows)
                {
                    BankBranch branch = new BankBranch();
                    branch.BankCode = dr["BankCode"].ToString();
                    branch.BankBranchId = dr["BranchId"].ToString();
                    branch.BranchCode = dr["BranchCode"].ToString();
                    branch.IsActive = dr["BranchManagerId"].ToString();
                    branch.BranchName = dr["BranchName"].ToString();
                    branch.Location = dr["Location"].ToString();
                    branch.ModifiedBy = dr["ModifiedBy"].ToString();
                    branch.StatusCode = "0";
                    branch.StatusDesc = "SUCCESS";
                    all.Add(branch);
                }
            }
            else
            {
                BankBranch branch = new BankBranch();
                branch.StatusCode = "100";
                branch.StatusDesc = "FAILED: NO BRANCHES FOUND";
                all.Add(branch);
            }
        }
        catch (Exception ex)
        {
            BankBranch branch = new BankBranch();
            branch.StatusCode = "100";
            branch.StatusDesc = "FAILED: " + ex.Message;
            all.Add(branch);
        }
        return all.ToArray();
    }

    internal Bank GetBankById(string objectId)
    {
        Bank bank = new Bank();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Banks_SelectRow",
                                                       objectId
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                bank.BankCode = dr["BankCode"].ToString();
                bank.BankContactEmail = dr["BankContactEmail"].ToString();
                bank.BankId = dr["BankId"].ToString();
                bank.BankName = dr["BankName"].ToString();
                bank.BankPassword = dr["BankPassword"].ToString();
                bank.IsActive = dr["IsActive"].ToString();
                bank.ModifiedBy = dr["ModifiedBy"].ToString();
                bank.PathToLogoImage = dr["PathToLogoImage"].ToString();
                bank.PathToPublicKey = dr["PathToPublicKey"].ToString();
                bank.BankThemeColor = dr["ThemeColor"].ToString();
                bank.TextColor = dr["NavbarTextColor"].ToString();
                bank.BankVaultAccNumber = dr["BankVaultAccNumber"].ToString();
                bank.StatusCode = "0";
                bank.StatusDesc = "SUCCESS";
            }
            else
            {
                bank.StatusCode = "100";
                bank.StatusDesc = "FAILED: BANK  [" + objectId + "] NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            bank.StatusCode = "100";
            bank.StatusDesc = "FAILED: " + ex.Message;
        }
        return bank;
    }

    internal TransactionCategory GetTransactionCategoryById(string objectId, string bankCode)
    {
        TransactionCategory category = new TransactionCategory();
        try
        {
            command = CbDatabase.GetStoredProcCommand("TransactionTypes_SelectRow",
                                                       objectId
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString().ToUpper();

                category.ApprovedBy = "";
                category.BankCode = dr["BankCode"].ToString();
                category.Description = dr["Description"].ToString();
                category.Id = dr["TranTypeId"].ToString();
                category.IsActive = dr["IsActive"].ToString();
                category.ModifiedBy = dr["ModifiedBy"].ToString();
                category.TranCategoryCode = dr["TranType"].ToString();
                category.TranCategoryName = dr["TranType"].ToString();
                category.StatusCode = "0";
                category.StatusDesc = "SUCCESS";

            }
            else
            {
                category.StatusCode = "100";
                category.StatusDesc = "FAILED: TRANSACTION CATEGORY:" + objectId + " NOT FOUND UNDER BANK:" + bankCode;
            }
        }
        catch (Exception ex)
        {
            category.StatusCode = "100";
            category.StatusDesc = "FAILED: " + ex.Message;
        }
        return category;
    }

    internal AccessRule GetAccessRuleById(string objectId, string bankCode)
    {
        AccessRule rule = new AccessRule();
        try
        {
            command = CbDatabase.GetStoredProcCommand("AccessRules_SelectRow",
                                                       objectId,
                                                       bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                rule.BranchCode = dr["BranchCode"].ToString();
                rule.BankCode = dr["BankCode"].ToString();
                rule.CanAccess = dr["CanAccess"].ToString();
                rule.Id = dr["RecordId"].ToString();
                rule.IsActive = dr["IsActive"].ToString();
                rule.ModifiedBy = dr["ModifiedBy"].ToString();
                rule.UserId = dr["UserId"].ToString();
                rule.UserType = dr["UserType"].ToString();
                rule.StatusCode = "0";
                rule.StatusDesc = "SUCCESS";
            }
            else
            {
                rule.StatusCode = "100";
                rule.StatusDesc = "FAILED: BANK NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            rule.StatusCode = "100";
            rule.StatusDesc = "FAILED: " + ex.Message;
        }
        return rule;
    }

    internal string SaveAccessRule(AccessRule rule, string BankCode)
    {
        try
        {
            DateTime ModifyDate = DateTime.Now;
            //string ModifyDate = CreateDate;
            command = CbDatabase.GetStoredProcCommand("AccessRules_Update",
                                                       rule.Id,
                                                       rule.RuleName,
                                                       rule.UserType,
                                                       rule.BankCode,
                                                       rule.CanAccess,
                                                       rule.UserId,
                                                       rule.BranchCode,
                                                       rule.IsActive,
                                                       ModifyDate,
                                                       rule.ModifiedBy
                                                        );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveTransactionRule(TransactionRule rule, string BankCode)
    {
        try
        {
            string CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
            string ModifyDate = CreateDate;
            command = CbDatabase.GetStoredProcCommand("TransactionRules_Update",
                                                      rule.Id,
                                                      rule.RuleName,
                                                      rule.RuleCode,
                                                      rule.RuleCode,
                                                      rule.RuleName,
                                                      rule.UserId,
                                                      rule.Description,
                                                      rule.MinimumAmount,
                                                      rule.MaximumAmount,
                                                      rule.IsActive,
                                                      rule.BankCode,
                                                      rule.BranchCode,
                                                      rule.ModifiedBy,
                                                      rule.Approver
                                                     );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[1];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal DataTable GetTransactionByBankId(string bankRef, string bankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("GetTransactionByBankId",
                                                       bankRef,
                                                       bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveChargeType(ChargeType chargeType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("ChargeTypes_Update",
                                                        chargeType.ChargeTypeCode,
                                                        chargeType.ChargeTypeName,
                                                        chargeType.ModifiedBy,
                                                        chargeType.BankCode,
                                                        chargeType.Description,
                                                        chargeType.IsActive
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal DataTable GetAccountSignatories(string accountNumber, string bankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("GetAccountSignatories",
                                                        accountNumber,
                                                        bankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string SaveCurrencyDetails(Currency currency)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("Currencies_Update",
                                                        currency.CurrencyName,
                                                        currency.CurrencyCode,
                                                        currency.BankCode,
                                                        currency.ModifiedBy,
                                                        currency.ValueInLocalCurrency
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal Currency GetCurrencyCodeById(string CurrencyCode, string BankCode)
    {
        Currency currency = new Currency();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Currencies_SelectRow",
                                                        CurrencyCode,
                                                        BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                currency.BankCode = dr["BankCode"].ToString();
                currency.CurrencyCode = dr["CurrencyCode"].ToString();
                currency.CurrencyName = dr["CurrencyName"].ToString();
                currency.ModifiedBy = dr["ModifiedBy"].ToString();
                currency.ValueInLocalCurrency = dr["ValueInLocalCurrency"].ToString();
                currency.StatusCode = "0";
                currency.StatusDesc = "SUCCESS";
            }
            else
            {
                currency.StatusCode = "100";
                currency.StatusDesc = "CURRENCY CODE NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            currency.StatusCode = "100";
            currency.StatusDesc = ex.Message;
        }
        return currency;
    }

    internal string SavePaymentType(PaymentType type)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("PaymentTypes_Update",
                                                        type.PaymentTypeCode,
                                                        type.PaymentTypeName,
                                                        type.BankCode,
                                                        type.ModifiedBy,
                                                        type.IsActive
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal PaymentType GetPaymentTypeById(string Id, string BankCode)
    {
        PaymentType type = new PaymentType();
        try
        {
            command = CbDatabase.GetStoredProcCommand("PaymentTypes_SelectRow",
                                                        Id,
                                                        BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                type.BankCode = dr["BankCode"].ToString();
                type.PaymentTypeCode = dr["PaymentTypeCode"].ToString();
                type.PaymentTypeName = dr["PaymentTypeName"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();
                type.StatusCode = "0";
                type.StatusDesc = "SUCCESS";
            }
            else
            {
                type.StatusCode = "100";
                type.StatusDesc = "PAYMENT TYPE NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            type.StatusCode = "100";
            type.StatusDesc = ex.Message;
        }
        return type;
    }


    internal string InsertIntoAuditLog(AuditLog log)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("InsertIntoAuditTrail",
                                                       log.ActionType,
                                                       log.TableName,
                                                       log.BankCode,
                                                       log.ModifiedBy,
                                                       log.Action
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal BankCharge GetBankChargeById(string objectId, string BankCode)
    {
        BankCharge charge = new BankCharge();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Charges_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString();

                charge.AccountType = dr["AccountType"].ToString();
                charge.BankCode = dr["BankCode"].ToString();
                charge.BankCode = dr["BankCode"].ToString();
                charge.ChargeAmount = dr["ChargeAmount"].ToString();
                charge.ChargeCode = dr["ChargeCode"].ToString();
                charge.IsActive = dr["IsActive"].ToString();
                charge.ChargeDescription = dr["ChargeDesc"].ToString();
                charge.ModifiedBy = dr["ModifiedBy"].ToString();
                charge.ChargeName = dr["ChargeName"].ToString();
                charge.ChargeType = dr["ChargeType"].ToString();
                charge.CommissionAccountNumber = dr["CommissionAccount"].ToString();
                charge.IsDebit = dr["IsDebit"].ToString();

                charge.StatusCode = "0";
                charge.StatusDesc = "SUCCESS";

            }
            else
            {
                charge.StatusCode = "100";
                charge.StatusDesc = "FAILED: CHARGE WITH CHARGE CODE:" + objectId + " NOT FOUND UNDER BANK: " + BankCode;
            }
        }
        catch (Exception ex)
        {
            charge.StatusCode = "100";
            charge.StatusDesc = "FAILED: " + ex.Message;
        }
        return charge;
    }

    internal ChargeType GetChargeTypeById(string objectId, string BankCode)
    {
        ChargeType type = new ChargeType();
        try
        {
            command = CbDatabase.GetStoredProcCommand("ChargeTypes_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString();

                type.BankCode = dr["BankCode"].ToString();
                type.ChargeTypeCode = dr["ChargeTypeCode"].ToString();
                type.ChargeTypeName = dr["ChargeTypeName"].ToString();
                type.IsActive = dr["IsActive"].ToString();
                type.Description = dr["Description"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();

                type.StatusCode = "0";
                type.StatusDesc = "SUCCESS";

            }
            else
            {
                type.StatusCode = "100";
                type.StatusDesc = "FAILED: CHARGE TYPE WITH CODE:" + objectId + " NOT FOUND UNDER BANK: " + BankCode;
            }
        }
        catch (Exception ex)
        {
            type.StatusCode = "100";
            type.StatusDesc = "FAILED: " + ex.Message;
        }
        return type;
    }

    internal BankBranch GetBankBranchById(string objectId, string BankCode)
    {
        BankBranch branch = new BankBranch();
        try
        {
            command = CbDatabase.GetStoredProcCommand("BankBranches_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString();

                branch.BankCode = dr["BankCode"].ToString();
                branch.BankBranchId = dr["BranchId"].ToString();
                branch.BranchCode = dr["BranchCode"].ToString();
                branch.IsActive = dr["IsActive"].ToString();
                branch.BranchName = dr["BranchName"].ToString();
                branch.ModifiedBy = dr["ModifiedBy"].ToString();
                branch.Location = dr["Location"].ToString();
                branch.BranchVaultAccNumber = dr["BranchVaultAccNumber"].ToString();
                branch.StatusCode = "0";
                branch.StatusDesc = "SUCCESS";

            }
            else
            {
                branch.StatusCode = "100";
                branch.StatusDesc = "FAILED: BANK BRANCH WITH CODE:" + objectId + " NOT FOUND UNDER BANK: " + BankCode;
            }
        }
        catch (Exception ex)
        {
            branch.StatusCode = "100";
            branch.StatusDesc = "FAILED: " + ex.Message;
        }
        return branch;
    }

    internal TransactionRule GetTransactionRuleById(string objectId, string BankCode)
    {
        TransactionRule rule = new TransactionRule();
        try
        {
            command = CbDatabase.GetStoredProcCommand("TransactionRules_SelectRow",
                                                       objectId,
                                                       BankCode
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString();

                rule.BankCode = dr["BankCode"].ToString();
                rule.Approver = dr["Approver"].ToString();
                rule.BranchCode = dr["BranchCode"].ToString();
                rule.IsActive = dr["IsActive"].ToString();
                rule.Description = dr["Description"].ToString();
                rule.MaximumAmount = dr["MaximumAmount"].ToString();
                rule.MinimumAmount = dr["MinimumAmount"].ToString();
                rule.RuleCode = dr["RuleCode"].ToString();
                rule.RuleName = dr["RuleName"].ToString();
                rule.UserId = dr["UserId"].ToString();
                rule.ModifiedBy = dr["ModifiedBy"].ToString();

                rule.StatusCode = "0";
                rule.StatusDesc = "SUCCESS";

            }
            else
            {
                rule.StatusCode = "100";
                rule.StatusDesc = "FAILED: TRANSACTION RULE WITH CODE:" + objectId + " NOT FOUND UNDER BANK: " + BankCode;
            }
        }
        catch (Exception ex)
        {
            rule.StatusCode = "100";
            rule.StatusDesc = "FAILED: " + ex.Message;
        }
        return rule;
    }


    internal void LogError(string Id, string BankCode, string msg)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("InsertIntoErrorLogs",
                                                      Id,
                                                      BankCode,
                                                      msg
                                                     );
            CbDatabase.ExecuteNonQuery(command);
        }
        catch (Exception)
        {
            //do nothing since at this stage we are just logging an error
        }
    }

    internal BankCustomer GetCustomerById(string objectId, string BankCode)
    {
        BankCustomer user = new BankCustomer();
        try
        {
            command = CbDatabase.GetStoredProcCommand("Customers_SelectRow",
                                                       objectId
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                string IsActive = dr["IsActive"].ToString().ToUpper();
                user.FirstName = dr["FirstName"].ToString();
                user.LastName = dr["LastName"].ToString();
                user.OtherName = dr["OtherName"].ToString();
                user.IsActive = IsActive;
                user.Password = dr["Password"].ToString();
                user.Id = dr["CustomerId"].ToString();
                user.Email = dr["Email"].ToString();
                user.PhoneNumber = dr["PhoneNumber"].ToString();
                user.BankCode = dr["BankCode"].ToString();
                user.BranchCode = dr["BranchCode"].ToString();
                user.Gender = dr["Gender"].ToString();
                user.DateOfBirth = dr["DateOfBirth"].ToString();
                user.ApprovedBy = dr["ApprovedBy"].ToString();
                user.StatusCode = "0";
                user.StatusDesc = "SUCCESS";

            }
            else
            {
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: USER WITH ID: " + objectId + " NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message + "";
        }
        return user;
    }
}
