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

	public Bussinesslogic()
	{

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
        string[] parameters={ tran.CustomerName,
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
        DataSet ds = dh.ExecuteSelect("SaveTranRequest",parameters);
        DataTable dt = ds.Tables[0];
        DataRow dr = dt.Rows[0];
        string InsertedId = dr[0].ToString();
        return InsertedId;
    }
}