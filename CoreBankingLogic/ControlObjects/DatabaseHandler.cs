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

    public string SaveCustomer(BankCustomer cust,string BankCode) 
    {
        string format = "dd/MM/yyyy";
        DateTime birthDate = DateTime.ParseExact(cust.DateOfBirth,format,CultureInfo.InvariantCulture);
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
                                                        bank.ModifiedBy
                );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            return datatable.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    internal string SaveBankBranch(BankBranch branch,string BankCode)
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
                                                       branch.BranchManagerId,
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
	                                                   charge.TransactionType,
	                                                   charge.IsDebit,
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

    internal string SaveTransactionType(TransactionType tranType, string BankCode)
    {
        try
        {
            command = CbDatabase.GetStoredProcCommand("TransactionTypes_Update",
                                                       tranType.Id,
                                                       tranType.TranType,
                                                       tranType.Description,
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
                                                       user.BranchCode
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
                                                       userType.Usertype,
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

    internal BankUser GetUserById(string objectId,string BankCode)
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
                user.FullName = dr["FullName"].ToString();
                user.IsActive = dr["IsActive"].ToString();
                user.Password = dr["Password"].ToString();
                user.Id = dr["UserId"].ToString();
                user.Email = dr["Username"].ToString();
                user.Usertype = dr["Usertype"].ToString();
                user.StatusCode = "0";
                user.StatusDesc = "SUCCESS";
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
            user.StatusDesc = "FAILED: "+ex.Message;
        }
        return user;
    }

    internal UserType GetUserTypeById(string objectId, string BankCode)
    {
        UserType user = new UserType();
        try
        {
            command = CbDatabase.GetStoredProcCommand("UserTypes_SelectRow",
                                                       objectId
                                                      );
            DataTable datatable = CbDatabase.ExecuteDataSet(command).Tables[0];
            if (datatable.Rows.Count > 0)
            {
                DataRow dr = datatable.Rows[0];
                user.Description = dr["Description"].ToString();
                user.Id = dr["UserTypeId"].ToString();
                user.Role = dr["Role"].ToString();
                user.Usertype = dr["UserType"].ToString();
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
                    user.Email = dr["Username"].ToString();
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
            user.StatusDesc = "FAILED: "+ex.Message;
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
                    user.Usertype = dr["UserType"].ToString();
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
}
