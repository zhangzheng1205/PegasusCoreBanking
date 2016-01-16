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
                                                       cust.FullName,
                                                       cust.Usertype,
                                                       cust.Password,
                                                       cust.IsActive,
                                                       BankCode,
                                                       cust.ModifiedBy,
                                                       cust.ModifiedBy,
                                                       cust.CanHaveAccount,
                                                       cust.PhoneNumber,
                                                       cust.BranchCode,
                                                       cust.DateOfBirth
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
                                                        bank.PathToPublicKey
                );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
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
                                                       branch.BankCode,
                                                       branch.Location,
                                                       branch.IsActive,
                                                       BankCode,
                                                       CreateDate,
                                                       ModifyDate,
                                                       branch.CreatedBy,
                                                       branch.ModifiedBy

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
                                                       teller.FullName,
                                                       teller.Usertype,
                                                       teller.Password,
                                                       teller.IsActive,
                                                       teller.ModifiedBy,//because he who creates either also modifies
                                                       teller.ModifiedBy,
                                                       teller.CanHaveAccount,
                                                       teller.BranchCode,
                                                       teller.DateOfBirth,
                                                       teller.PhoneNumber,
                                                       teller.Gender,
                                                       teller.TellerAccountNumber,
                                                       BankCode);
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
            command = CbDatabase.GetStoredProcCommand("Accounts_Update",
                                                        account.AccountId,
                                                        account.AccountBalance,
                                                        account.UserId,
                                                        account.AccountNumber,
                                                        account.AccountType,
                                                        BankCode,
                                                        account.ModifiedBy,
                                                        account.BranchCode,
                                                        account.IsActive
                );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
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
                                                        tranRequest.CustomerId,
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
                                                        tranRequest.BranchCode
                                                      );
            DataSet ds = CbDatabase.ExecuteDataSet(command);
            int index = ds.Tables.Count - 1;
            return ds.Tables[index].Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    internal string Reverse(string BankId, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("ReverseTransaction",
                                                        BankId,
                                                        BankCode
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
                                                       BankCode,
                                                       charge.ModifiedBy,
                                                       charge.ModifiedOn,
                                                       charge.ChargeDescription,
                                                       charge.ChargeName,
                                                       charge.ChargeCode,
                                                       charge.IsActive
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
                                                       BankCode,
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

    internal string SaveCustomerType(CustomerType custType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("UserTypes_Update",
                                                       custType.Id,
                                                       custType.CustType,
                                                       "CUSTOMER",
                                                       custType.Description,
                                                       BankCode
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
                                                       user.FullName,
                                                       user.Usertype,
                                                       user.Password,
                                                       user.IsActive,
                                                       BankCode,
                                                       user.ModifiedBy,
                                                       user.ModifiedBy,
                                                       user.CanHaveAccount,
                                                       user.PhoneNumber,
                                                       user.BranchCode,
                                                       user.DateOfBirth,
                                                       user.Gender
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
                                                       BankCode
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
                                                       BankCode,
                                                       accountType.IsDebitable,
                                                       accountType.Description,
                                                       accountType.ModifiedBy,
                                                       accountType.IsActive
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
                if (IsActive == "TRUE")
                {
                   
                    user.FullName = dr["FullName"].ToString();
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
                    user.CanHaveAccount = dr["CanHaveAccount"].ToString();
                    user.StatusCode = "0";
                    user.StatusDesc = "SUCCESS";
                }
                else 
                {
                    user.StatusCode = "100";
                    user.StatusDesc = "FAILED: USER SPECIFIED IS DEACTIVATED.";
                }
            }
            else
            {
                user.StatusCode = "100";
                user.StatusDesc = "FAILED: USER NOT FOUND";
            }
        }
        catch (Exception ex)
        {
            user.StatusCode = "100";
            user.StatusDesc = "FAILED: " + ex.Message;
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
                type.ModifiedOn = dr["ModifiedOn"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();
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



    internal BankAccount GetBankAccountById(string objectId, string BankCode)
    {
        BankAccount type = new BankAccount();
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
                type.AccountBalance = dr["AccBal"].ToString();
                type.AccountId = dr["AccountId"].ToString();
                type.BankCode = dr["BankCode"].ToString();
                type.AccountNumber = dr["AccNumber"].ToString();
                type.AccountType = dr["AccType"].ToString();
                type.IsActive = dr["IsActive"].ToString();
                type.BranchCode = dr["BranchCode"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();
                type.ModifiedBy = dr["ModifiedBy"].ToString();
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
                    user.FullName = dr["FullName"].ToString();
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
                    branch.CreatedBy = dr["CreatedBy"].ToString();
                    branch.CreatedOn = dr["CreatedOn"].ToString();
                    branch.ModifiedOn = dr["ModifiedOn"].ToString();
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

    internal BaseObject GetBankById(string objectId)
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
                bank.StatusCode = "0";
                bank.StatusDesc = "SUCCESS";
            }
            else
            {
                bank.StatusCode = "100";
                bank.StatusDesc = "FAILED: BANK NOT FOUND";
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
                category.StatusDesc = "FAILED: BANK NOT FOUND";
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
                rule.ModifiedOn = dr["ModifiedOn"].ToString();
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
                                                      rule.ModifiedOn,
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
}
