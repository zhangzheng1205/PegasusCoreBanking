﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.master" Title="EDIT PAYMENT TYPE" CodeFile="AddOrEditPaymentType.aspx.cs" Inherits="AddOrEditPaymentType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <div class="row">

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Payment Type Details
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Payment Type
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

                        <div class="container">
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-8">
                                        <div class="alert alert-info">
                                            Hi. It Appears you want to create a Payment Type.
                                            A Payment Type is a way a user can make a payment e.g cash, chequue, eft
                                            Use the form below to create the payment type
                                        </div>
                                    </div>
                                    <div class="col-lg-2"></div>
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
                                    <p class="help-block">The bank to Which the Payment Type belongs</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Payment Type Name</label>
                                    <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The Name of the Payment Type</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Payment Type Code</label>
                                    <asp:TextBox ID="txtPaymentTypeCode" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Unique Identifier of this Payment Type.</p>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Is Active</label>
                                    <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                        <asp:ListItem>TRUE</asp:ListItem>
                                        <asp:ListItem>FALSE</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">True: Type is Active. False: Means its deactivated.</p>
                                </div>
                            </div>


                            <div class="row">
                                <div class="text-center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                </div>
                            </div>

                        </div>
                        <!-- /.container-fluid -->

                    </div>
                </div>
            <!-- /#page-wrapper -->
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="container">
                <div class="text-center">
                    <div class="row" style="padding-top: 70px;">
                        <div class="col-lg-2"></div>
                        <div class="col-lg-8">
                            <div class="alert alert-info">
                                This Payment Type Already Exists! Are you sure you want to Update it.
                            </div>
                        </div>
                        <div class="col-lg-2"></div>
                    </div>
                    <hr />
                    <div class="row">
                        <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-success" Text="Confirm Operation" OnClick="btnConfirm_Click" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Cancel Operation" OnClick="btnCancel_Click" />
                    </div>
                </div>
                <hr />
            </div>
        </asp:View>
    </asp:MultiView>



</asp:Content>
