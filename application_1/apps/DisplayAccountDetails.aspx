<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="VIEW ACCOUNT DETAILS" AutoEventWireup="true" CodeFile="DisplayAccountDetails.aspx.cs" Inherits="DisplayAccountDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">



                    <div class="row">

                        <%--<form runat="server" action="#" method="post">--%>

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Bank Account Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Bank Account Details
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
                        
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Account Number</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblAccountNumber" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Bank</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblBank" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Created at Branch</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblBankBranch" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Account Type</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblAccountType" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Account Balance</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblBalance" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Currency In Which Balances are stored</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblCurrency" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Is Activated</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblIsActive" runat="server" /></p>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 form-control-label">Account Signatories</label>
                            <div class="col-sm-10">
                                <p class="form-control-static">
                                    <asp:Label ID="lblSignatories" runat="server" /></p>
                            </div>
                        </div>

                        <hr />
                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="View Statement" Width="200px" CssClass="btn btn-success" OnClick="btnViewStatement_Click" />
                                <asp:Button ID="btnTransact" runat="server" Text="Funds Transfer" Width="200px" CssClass="btn btn-primary" OnClick="btnTransact_Click" />
                                <asp:Button ID="Button1" runat="server" Text="Deposit Funds" Width="200px" CssClass="btn btn-success" OnClick="btnDeposit_Click" />
                                <asp:Button ID="Button2" runat="server" Text="Withdraw Funds" Width="200px" CssClass="btn btn-primary" OnClick="btnWithdraw_Click" />
                            </div>
                        </div>
                        <hr />

                        <%-- </form>--%>
                        <%--</div>--%>
                        <!-- /.row -->

                    </div>
                    <!-- /.container-fluid -->

                </div>
            </div>
            <!-- /#page-wrapper -->
        </asp:View>
        <asp:View ID="View2" runat="server">
        </asp:View>
    </asp:MultiView>



</asp:Content>
