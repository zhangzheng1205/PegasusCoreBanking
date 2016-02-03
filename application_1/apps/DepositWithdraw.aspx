<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="DepositWithdraw.aspx.cs" Inherits="DepositWithdraw" Title="DEPOSIT/WITHDRAW PAGE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">


                    <%-- form beegins --%>
                    <div class="row">

                        <%-- <form runat="server" action="#" method="post">--%>

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Transaction Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Transact
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
                                <label>To AccountNumber</label>
                                <asp:TextBox ID="txtToAccount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The account number to which money is to be transfered</p>
                            </div>
                            <div class="col-lg-6">
                                <label>From AccountNumber</label>
                                <asp:TextBox ID="txtFromAccount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The account number from which money is to be transfered</p>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-6">
                                <label>Customers Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The customers name</p>
                            </div>
                            <div class="col-lg-6">
                                <div class="col-lg-8" style="padding-left: 0px;">
                                    <label>Amount</label>
                                    <div class="form-group input-group">
                                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter Amount" />
                                        <span class="input-group-addon">.00</span>
                                    </div>
                                    <p class="help-block">The Transaction Amount eg: 500</p>
                                </div>
                                <div class="col-lg-4">
                                    <label>Currency</label>
                                    <asp:DropDownList ID="ddCurrency" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-6">
                                <label>Reason</label>
                                <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">A brief reason for this transaction</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Transaction Category</label>
                                <asp:DropDownList ID="ddTranCategory" runat="server" CssClass="form-control">
                                    <asp:ListItem>* TRANSFER</asp:ListItem>
                                    <asp:ListItem>EXTERNAL TRANSFER</asp:ListItem>
                                    <asp:ListItem>CHEQUE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The Category to which this transaction belongs</p>
                            </div>
                        </div>



                        <div class="row">
                            <div class="col-lg-6">
                                <label>Payment Type</label>
                                <asp:DropDownList ID="ddPaymentType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddPaymentType_SelectedIndexChanged">
                                    <asp:ListItem>* TRANSFER</asp:ListItem>
                                    <asp:ListItem>EXTERNAL TRANSFER</asp:ListItem>
                                    <asp:ListItem>CHEQUE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">How is this transaction being effected.i.e cash,cheque etc</p>
                            </div>
                            <div class="col-lg-6" id="ChequeNumberSec" runat="server">
                                <label>Cheque Number</label>
                                <asp:TextBox ID="txtChequeNumber" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The Cheque Number.</p>
                            </div>
                        </div>


                        <hr />
                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Transact" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                        <hr />

                        <%-- </form>--%>
                        <%-- /form --%>
                    </div>
                    <!-- /.form row -->

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
