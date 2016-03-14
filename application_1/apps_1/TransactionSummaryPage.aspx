<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="SUMMARY OF THE TRANSACTION" AutoEventWireup="true" CodeFile="TransactionSummaryPage.aspx.cs" Inherits="TransactionSummaryPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">


                    <%-- form beegins --%>
                    <div class="row">
                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>See Summary below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Summary
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

                        <div class="row text-center">
                            <h4><b>Transaction Details below #<asp:Label ID="lblTitle" runat="server">234556</asp:Label></b></h4>
                        </div>
                        <hr />

                        <!-- /.row -->
                        <div class="row" style="padding-left: 40%;">
                            <table cellpadding="10">
                                <tr style="height: 15px;">
                                    <th scope="row">Bank Name</th>
                                    <td>
                                        <asp:Label ID="lblBankName" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">Transaction Date</th>
                                    <td>
                                        <asp:Label ID="lblDate" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">Customer Name</th>
                                    <td>
                                        <asp:Label ID="lblCustName" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">To Account</th>
                                    <td>
                                        <asp:Label ID="lblToAccount" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">From Account</th>
                                    <td>
                                        <asp:Label ID="lblFromAccount" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="padding-top: 15px;">
                                    <th scope="row"><b>Amount</b></th>
                                    <td>
                                        <asp:Label ID="lblAmount" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="padding-top: 15px;">
                                    <th scope="row"><b>Currency</b></th>
                                    <td>
                                        <asp:Label ID="lblCurrency" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">Transaction Category</th>
                                    <td>
                                        <asp:Label ID="lblTranCategory" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                 <tr style="height: 15px;">
                                    <th scope="row">Teller </th>
                                    <td>
                                        <asp:Label ID="lblTeller" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                                <tr style="height: 15px;">
                                    <th scope="row">Reason</th>
                                    <td>
                                        <asp:Label ID="lblReason" runat="server">N Large Postal</asp:Label></td>
                                </tr>
                            </table>
                        </div>

                        <div class="row" style="height: 10px"></div>
                        <hr />
                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Confirm Transaction" CssClass="btn btn-success btn-md" OnClick="btnSubmit_Click" />
                                <asp:Button ID="Button1" runat="server" Text="Go Back And Edit" CssClass="btn btn-primary btn-md" OnClick="btnCancel_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel Transaction" CssClass="btn btn-danger btn-md" OnClick="btnCancel_Click" />
                            </div>
                        </div>
                        <hr />

                        <%-- /form --%>
                    </div>
                    <!-- /.form row -->

                </div>
                <!-- /.container-fluid -->
            </div>

            <!-- /#page-wrapper -->
        </asp:View>
        <asp:View ID="View2" runat="server">
        </asp:View>
    </asp:MultiView>
    

    <style>
        th, td {
            padding: 7px;
        }
    </style>
</asp:Content>
