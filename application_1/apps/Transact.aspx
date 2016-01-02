<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Transact.aspx.cs" Inherits="Transact" Title="TRANSACT PAGE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <h4 class="page-header">
                                <asp:Label ID="lblmsg" runat="server">Input Transaction Details below</asp:Label>
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
                    <!-- /.row -->

                    <div class="row">
                        <div class="col-lg-6">

                            <form runat="server" action="#" method="post">
                                <div class="form-group">
                                    <label>To AccountNumber</label>
                                    <asp:TextBox ID="txtToAccount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The account number to which money is to be transfered</p>
                                </div>

                                <div class="form-group">
                                    <label>From AccountNumber</label>
                                    <asp:TextBox ID="txtFromAccount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The account number from which money is to be transfered</p>
                                </div>

                                <div class="form-group">
                                    <label>Customers Name</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The customers name</p>
                                </div>

                                <div class="form-group">
                                    <label>Amount</label>
                                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>

                                <div class="form-group">
                                    <label>Reason</label>
                                    <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>

                                <div class="form-group">
                                    <label>Transaction Category</label>
                                    <asp:DropDownList ID="ddTranCategory" runat="server" CssClass="form-control">
                                        <asp:ListItem>* TRANSFER</asp:ListItem>
                                        <asp:ListItem>EXTERNAL TRANSFER</asp:ListItem>
                                        <asp:ListItem>CHEQUE</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit Button" CssClass="btn btn-default" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset Button" CssClass="btn btn-default" />

                            </form>
                        </div>
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
