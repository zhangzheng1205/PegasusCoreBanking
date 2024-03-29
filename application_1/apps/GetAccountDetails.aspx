﻿<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="View Account Details" AutoEventWireup="true" CodeFile="GetAccountDetails.aspx.cs" Inherits="GetAccountDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">



                    <div class="row">

                        <%-- <form runat="server" action="#" method="post">--%>

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>View Account Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Account Details
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
                            <div class="col-sm-3">
                                <label>Bank</label>
                                <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The bank to which the Account Belongs</p>
                            </div>
                            <div class="col-md-3">
                                <label>Account Number</label>
                                <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The Account Number</p>
                            </div>
                            <div class="col-sm-3">
                                <label>Customers Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The Customers Name. Can be empty</p>
                            </div>
                            <div class="col-sm-3"></div>
                        </div>

                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Search" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                        <hr />
                        <asp:MultiView runat="server" ID="Multiview2">
                            <asp:View runat="server" ID="resultView">
                                <div class="row">
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-2">
                                        <asp:RadioButton ID="rdPdf" runat="server" Font-Bold="True" GroupName="FileFormat"
                                            Text=" PDF" />
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:RadioButton ID="rdExcel" runat="server" Font-Bold="True" GroupName="FileFormat"
                                            Text=" EXCEL" />
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Button ID="btnConvert" runat="server" Font-Size="9pt" Height="23px" OnClick="btnConvert_Click"
                                            CssClass="btn-primary" Text="Convert" Width="85px" />
                                    </div>
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-2"></div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="table-responsive">
                                        <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults">
                                            <Columns>
                                                <asp:TemplateField HeaderText="View Details">
                                                    <ItemTemplate>
                                                        <asp:HyperLink runat="server" Text='View Details'
                                                            NavigateUrl='<%# "DisplayAccountDetails.aspx?Id=" + DataBinder.Eval(Container.DataItem,"AccNumber").ToString()+    
                                                                                 "&BankCode=" +ddBank.SelectedValue  %>'
                                                            ID="EditColumn" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View runat="server" ID="EmptyView">
                            </asp:View>
                            <asp:View runat="server" ID="AddSignatoryView">
                                <div class="row">
                                    <div class="table-responsive">
                                        <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults2">
                                            
                                        </asp:GridView>
                                    </div>
                                </div>
                            </asp:View>
                        </asp:MultiView>
                        <%--</form>--%>
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
