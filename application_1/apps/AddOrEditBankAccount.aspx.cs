﻿using InterLinkClass.CoreBankingApi;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddOrEditBankAccount : System.Web.UI.Page
{
    BankUser user;
    Service client = new Service();
    Bussinesslogic bll = new Bussinesslogic();
    string BankCode = "";
    string UserId = "";
    string Id = "";
    string BranchCode = "";
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            user = Session["User"] as BankUser;
            Session["IsError"] = null;

            //----------------------------------
            //Check If this is an Edit Request
            Id = Request.QueryString["Id"];
            BankCode = Request.QueryString["BankCode"];
            UserId = Request.QueryString["UserId"];
            BranchCode = Request.QueryString["BranchCode"];
            Msg = Request.QueryString["Msg"];

            //Session is invalid
            if (user == null)
            {
                Response.Redirect("Default.aspx");
            }
            else if (IsPostBack)
            {

            }
            //create customers bank account request
            else if (UserId != null) 
            {
                LoadData();
                DisableControls(UserId);
                MultiView1.ActiveViewIndex = 0;
                bll.ShowMessage(lblmsg, Msg, false, Session);
            }
            //this is an edit bank account request
            else if (Id != null)
            {
                LoadData();
                DisableControls(Id);
                LoadAccountData(Id, BankCode);
                MultiView1.ActiveViewIndex = 0;

            }
            //this is a normal create account request
            else
            {
                LoadData();
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }

    private void DisableControls(string UserId)
    {
        ddBank.SelectedValue = BankCode;
        ddBankBranch.SelectedValue = BranchCode;
        ddBank.Enabled = false;
        ddIsActive.Text = "False";
        ddIsActive.Enabled = false;
        txtUserId.Text = UserId;
        txtUserId.Enabled = false;
        if (Msg.Contains("CUSTOMER"))
        {
            ExistingAccountSection.Visible = true;
        }
        else 
        {
            ExistingAccountSection.Visible = false;
        }
        
    }

    private void LoadAccountData(string Id, string BankCode)
    {
        BankAccount account = client.GetById("BANKACCOUNT", Id, BankCode, bll.BankPassword) as BankAccount;
        if (account.StatusCode == "0")
        {
            this.ddAccountType.SelectedValue = account.AccountType;
            this.ddBank.SelectedValue = account.BankCode;
            this.ddBankBranch.SelectedValue = account.BranchCode;
            this.txtUserId.Text = account.UserId;
            this.ddIsActive.Text = account.IsActive;
        }
        else 
        {
            string msg = account.StatusDesc;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private void LoadData()
    {
        bll.LoadBanksIntoDropDown(user, ddBank);
        bll.LoadBanksBranchesIntoDropDown(user.BankCode, ddBankBranch, user);
        bll.LoadAccountTypesIntoDropDown(user.BankCode, ddAccountType, user);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            BankAccount account = GetBankAccount();
            Result result = client.SaveBankAccountDetails(account, user.BankCode, bll.BankPassword);
            if (result.StatusCode == "0")
            {
                if (string.IsNullOrEmpty(UserId))
                {
                    //create account request
                    string msg = "SUCCESS: BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] SAVED SUCCESSFULLY";
                    bll.ShowMessage(lblmsg, msg, false, Session);
                }
                else 
                {
                    //create customer request
                    string msg = "SUCCESS: USER ID:"+UserId+" BANK ACCOUNT WITH ACCOUNT NUMBER [" + result.PegPayId + "] CREATED SUCCESSFULLY";
                    bll.ShowMessage(lblmsg, msg, false, Session);
                }
            }
            else
            {
                string msg = result.StatusDesc;
                bll.ShowMessage(lblmsg, msg, true, Session);
            }
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }

    private BankAccount GetBankAccount()
    {
        BankAccount account = new BankAccount();
        account.AccountBalance = "0";
        account.AccountId = "";
        account.BranchCode = ddBankBranch.SelectedValue;
        account.AccountNumber = GenerateAccountNumber();
        account.AccountType = ddAccountType.SelectedValue;
        account.IsActive = ddIsActive.Text;
        account.BankCode = ddBank.SelectedValue;
        account.UserId = txtUserId.Text;
        account.ModifiedBy = user.Id;
        return account;
    }

    private string GenerateAccountNumber()
    {
        return DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }

    protected void btnAddSignatory_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("GetAccountDetails.aspx?CustomerId=" + UserId + "&BankCode=" + BankCode + "&BranchCode=" + BranchCode);
        }
        catch (Exception ex)
        {
            string msg = "FAILED: " + ex.Message;
            bll.ShowMessage(lblmsg, msg, true, Session);
        }
    }
}