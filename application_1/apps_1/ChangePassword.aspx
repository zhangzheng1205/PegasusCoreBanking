<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="Change Password" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel" style="padding-top:50px">
        <div class="panel-body">
            <div class="col-lg-3">
            </div>
            <div class="col-lg-6">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <asp:Label ID="lblMsg" runat="server">Change Password Using Form Below</asp:Label>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-6">
                                <label>
                                    Old Password</label>
                                <asp:TextBox runat="server" ID="txtOldPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <p class="help-block">
                                    Your current Password</p>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-lg-6">
                                <label>
                                    New Password</label>
                                <asp:TextBox runat="server" ID="txtNewPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <p class="help-block">
                                    Your New Password</p>
                            </div>
                            <div class="col-lg-6">
                                <label>
                                    Confirm Password</label>
                                <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <p class="help-block">
                                    Confirm Your New Password. Renter it.</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSave" CssClass="btn btn-success" Text="Save Details" Width="200"
                                    runat="server" OnClick="btnSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
            </div>
        </div>
    </div>
</asp:Content>
