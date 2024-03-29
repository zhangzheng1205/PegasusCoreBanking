﻿<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBank.aspx.cs" Inherits="AddOrEditBank" Title="Edit Bank" %>

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

                        <div class="container">
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-lg-2"></div>
                                    <div class="col-lg-8">
                                        <div class="alert alert-info">
                                            Hi. It Appears you want to create a Bank.
                                            To Create a fully functional Bank, you need to create the Bank,
                                            then at least one branch and a Bank Admin. 
                                            There after the Bank Admin will create other staff members like a Bussiness Admin,
                                            create more Branches with Branch Managers,Tellers,Customer Service etc
                                        </div>
                                    </div>
                                    <div class="col-lg-2"></div>
                                </div>
                            </div>

                            <!-- /.row -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <label>BankName</label>
                                    <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The Name of the Bank</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>BankCode</label>
                                    <asp:TextBox ID="txtBankCode" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The BankCode to be associated with the Bank. All transactions will be attached to Bank using Code</p>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Contact Email</label>
                                    <asp:TextBox ID="txtContactEmail" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The email of lead contact Person in Bank. This Email will recieve credentials</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Is Active</label>
                                    <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                        <asp:ListItem>TRUE</asp:ListItem>
                                        <asp:ListItem>FALSE</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Set whether the Bank is in Activated or Deactivated state</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Send Email with Credentials</label>
                                    <asp:DropDownList ID="ddSendEmail" runat="server" CssClass="form-control">
                                        <asp:ListItem>False</asp:ListItem>
                                        <asp:ListItem>True</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Should an Email be sent to Contact Person with BankCode and Password for access API directly</p>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Upload Bank public Key(.cer)</label>
                                    <asp:FileUpload runat="server" accept="*.cer" ID="fuPublicKey" type="file" />
                                    <p class="help-block">Public key of Bank in .cer format. This will be used to verify digital signatures of requests sent to the API</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Upload Bank Logo</label>
                                    <asp:FileUpload runat="server" accept="image/*" ID="fuBankLogo" type="file" />
                                    <p class="help-block">Logo Image of Bank in PNG or JPEG format.Will be used to customize look and feel of Bank OS</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Theme Color</label>
                                    <asp:TextBox ID="txtTheme" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The color of the navigation bar for this Bank</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>NavBarText Color</label>
                                    <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The color of text in the navigation bar</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="text-center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                </div>
                            </div>

                        </div>
                        <!-- /.container-fluid -->

                        <%-- Scripts--%>
                        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="Server" EnableScriptGlobalization="true"
                            EnableScriptLocalization="true">
                        </ajaxToolkit:ToolkitScriptManager>
                        <br />
                        <cdt:ColorPickerExtender ID="cpe1" runat="server"
                            TargetControlID="txtTheme"
                            PopupButtonID="txtTheme" />
                        <cdt:ColorPickerExtender ID="cpe2" runat="server"
                            TargetControlID="txtColor"
                            PopupButtonID="txtColor" />

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
                                This Bank Already Exists! Are you sure you want to Update it.
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
