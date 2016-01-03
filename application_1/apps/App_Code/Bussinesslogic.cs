using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Bussinesslogic
/// </summary>
public class Bussinesslogic
{
    DatabaseHandler dh = new DatabaseHandler();
    public string BankPassword = "TEST";
    Service client = new Service();

    public Bussinesslogic()
    {

    }

    public void LoadBanksBranchesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetBankBranchesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["BranchName"].ToString();
            string BranchCode = dr["BranchCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }
    }

    public void LoadAccountTypesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetAccountTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string BranchName = dr["AccTypeName"].ToString();
            string BranchCode = dr["AccTypeCode"].ToString();
            ddlst.Items.Add(new ListItem(BranchName, BranchCode));
        }
    }

    public void LoadUsertypesIntoDropDowns(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetUserTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string UserTypeName = dr["UserType"].ToString();
            string UserTypeCode = dr["UserType"].ToString();
            ddlst.Items.Add(new ListItem(UserTypeName, UserTypeCode));
        }
    }

    public void LoadBanksIntoDropDown(BankUser user, DropDownList ddLst)
    {

        List<Bank> banks = new List<Bank>();
        BaseObject[] bo = client.GetAll("Bank", user.BankCode, BankPassword);
        ddLst.Items.Clear();
        foreach (BaseObject obj in bo)
        {
            Bank bank = obj as Bank;
            if (bank.StatusCode == "0")
            {
                ddLst.Items.Add(new ListItem(bank.BankName, bank.BankCode));
                banks.Add(bank);
            }
        }
        if (user.Usertype.ToUpper() != "SYS_ADMIN")
        {
            //ddBank.Enabled = true;
            int index = banks.FindIndex(delegate(Bank p) { return p.BankCode == user.BankCode; });
            ddLst.SelectedIndex = index;
            ddLst.Enabled = false;
        }
    }

    public void CreateFolderPathIfItDoesntExist(string folderPath)
    {
        bool exists = Directory.Exists(folderPath);

        if (!exists)
        {
            Directory.CreateDirectory(folderPath);
        }
    }

    public string GenerateBankPassword()
    {
        return "TEST";
    }

    public void ShowMessage(Label lblmsg, string msg, bool IsError)
    {
        lblmsg.Text = msg;
        if (IsError)
        {
            lblmsg.ForeColor = Color.Red;
        }
        else
        {
            lblmsg.ForeColor = Color.Green;
        }
    }



    public string SaveTranRequest(TransactionRequest tran)
    {
        string[] parameters ={ tran.CustomerName,
                              tran.ToAccount,
                              tran.FromAccount,
                              tran.TranAmount,
                              tran.TranCategory,
                              tran.PaymentDate,
                              tran.Teller,
                              tran.ApprovedBy,
                              tran.BankCode,
                              tran.BranchCode,
                              tran.Narration};
        DataSet ds = dh.ExecuteSelect("SaveTranRequest", parameters);
        DataTable dt = ds.Tables[0];
        DataRow dr = dt.Rows[0];
        string InsertedId = dr[0].ToString();
        return InsertedId;
    }

    public void LoadTransactionTypesIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetTransactionTypesByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string TranType = dr["TranType"].ToString();
            string TranTypeName = dr["TranType"].ToString();
            ddlst.Items.Add(new ListItem(TranTypeName, TranType));
        }
    }

    public void LoadCommissionAccountsIntoDropDown(string bankCode, DropDownList ddlst, BankUser user)
    {
        string[] parameters = { bankCode };
        DataSet ds = dh.ExecuteSelect("GetCommissionAccountsByBankCode", parameters);
        DataTable dt = ds.Tables[0];

        ddlst.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            string AccName = dr["AccNumber"].ToString();
            string AccNumber = dr["AccNumber"].ToString();
            ddlst.Items.Add(new ListItem(AccName, AccNumber));
        }
    }

    public void ShowMessage(Label lblmsg, string msg, bool IsError, System.Web.SessionState.HttpSessionState Session)
    {
        lblmsg.Text = msg;
        if (IsError)
        {
            Session["IsError"] = "True";
            lblmsg.ForeColor = Color.Red;
        }
        else
        {
            Session["IsError"] = "False";
            lblmsg.ForeColor = Color.Green;
        }
    }

    public bool TransactionRequiresApproval(ref TransactionRequest tran)
    {
        string[] parameters={tran.BankCode,tran.BranchCode,tran.Teller,tran.TranAmount};
        DataSet ds = dh.ExecuteSelect("CheckIfItViolatesRules", parameters);
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            tran.StatusCode = "100";
            tran.StatusDesc = dt.Rows[0]["Description"].ToString();
            return true;
        }
        else 
        {
            return false;
        }
    }

    public void SendToSupervisorForApproval(TransactionRequest tran)
    {
        
    }
}