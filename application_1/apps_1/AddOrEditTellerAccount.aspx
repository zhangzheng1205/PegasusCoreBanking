<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="Edit Teller Account" AutoEventWireup="true" CodeFile="AddOrEditTellerAccount.aspx.cs" Inherits="AddOrEditTellerAccount" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <div class="row">

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Bank Teller Account Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Bank Teller's Account Details
                                    </li>
                                </ol>
                            </div>
                        </div>

                        <%-- Message Label --%>
                        <div class="row">
                            <div class="text-center">
                                <% 
                                    string IsError = Session["IsError"] as string;
                                    if (IsError == null)
                                    {
                                        Response.Write("<div>");

                                    }
                                    else if (IsError == "True")
                                    {
                                        Response.Write("<div class=\"alert alert-danger\">");

                                    }
                                    else
                                    {
                                        Response.Write("<div class=\"alert alert-success\">");
                                    } 
                                %>
                                <strong>
                                    <asp:Label ID="lblmsg" runat="server"></asp:Label></strong>
                                <%Response.Write("</div>"); %>
                            </div>
                        </div>

                        <!-- /.row -->
                        <div class="row">
                            <div class="col-lg-6">
                                <label>Bank</label>
                                <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The bank to Which the Account belongs</p>
                            </div>

                            <div class="col-lg-6">
                                <label>Bank Branch</label>
                                <asp:DropDownList ID="ddBankBranch" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The bank branch to Which this Account belongs</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Account Type</label>
                                <asp:DropDownList ID="ddAccountType" runat="server" CssClass="form-control" >
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">e.g Savings, Current Account</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Currency</label>
                                <asp:DropDownList ID="ddCurrency" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">Currency  in which the Acount Balance is stored</p>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-6">
                                <label>Is Active</label>
                                <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Account is Active and can be used to Transact. False: Means its deactivated.</p>
                            </div>
                            <div class="col-lg-6" id="AddSignatorySection" runat="server">
                                <label>Pick Teller</label>
                                <asp:DropDownList ID="ddTellers" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddTellers_SelectedIndexChanged">
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <p class="help-block">Pick Teller to whom account will belong.</p>
                        </div>

                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </asp:View>
    </asp:MultiView>
</asp:Content>
