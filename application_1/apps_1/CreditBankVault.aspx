<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="Credit Bank" AutoEventWireup="true" CodeFile="CreditBankVault.aspx.cs" Inherits="CreditBankVault" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <div class="row">

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Bank Details
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>AddOrEdit Bank
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
                                <label>BankName</label>
                               <asp:DropDownList ID="ddBanks" runat="server" CssClass="form-control">
                                    <asp:ListItem>False</asp:ListItem>
                                    <asp:ListItem>True</asp:ListItem>
                                </asp:DropDownList><p class="help-block">The Name of the Bank</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Amount</label>
                                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Amount to Credit</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- /#page-wrapper -->
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="container">
                <div class="text-center">
                </div>
            </div>
        </asp:View>
    </asp:MultiView>

</asp:Content>
