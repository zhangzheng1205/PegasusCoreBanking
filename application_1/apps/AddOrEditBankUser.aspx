﻿<%@ Page MasterPageFile="~/Main.master" Language="C#" AutoEventWireup="true" CodeFile="AddOrEditBankUser.aspx.cs" Inherits="AddOrEditBankUser" Title="Save Bank Admin Details" %>

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
                                <h4>Input Bank Users Details
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Bank User
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
                                            Hi. It Appears you want to create a Bank System User like a teller or Customer Service etc.
                                            Remember that the user must belong to a specific bank and a specific branch in that bank.
                                            Some User types require more details in comparison to others.
                                            Use the form below to supply the required details. 
                                        </div>
                                    </div>
                                    <div class="col-lg-2"></div>
                                </div>
                            </div>

                            <!-- /.row -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <label>First Name</label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The first Name(Given Name) of the User</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Last Name</label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">The Last Name(Surname) of the User</p>
                                </div>
                            </div>

                            <div class="row">
                                 <div class="col-lg-6">
                                    <label>Other Name</label>
                                    <asp:TextBox ID="txtOtherName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Any Other Names of the User</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>User Id</label>
                                    <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Unique Identifier of this User. It can be users Email or PhoneNumber etc.</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Bank</label>
                                    <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddBank_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">The Bank to which the user belongs</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Bank Branch</label>
                                    <asp:DropDownList ID="ddBankBranch" runat="server" CssClass="form-control">
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">The Bank to which the user belongs</p>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Email Address</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@gmail.com" />
                                    <p class="help-block">The email address of this Person</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Phone Number</label>
                                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Users Phone Number in International format. e.g 256</p>
                                </div>
                            </div>




                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Gender</label>
                                    <asp:DropDownList ID="ddGender" runat="server" CssClass="form-control">
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Users Sex</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>User type</label>
                                    <asp:DropDownList ID="ddUserType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddUserType_SelectedIndexChanged">
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Role of this User</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Send Email with Credentials</label>
                                    <asp:DropDownList ID="ddSendEmail" runat="server" CssClass="form-control">
                                        <asp:ListItem>NO</asp:ListItem>
                                        <asp:ListItem>YES</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Should an Email be sent to User with UserId and Password for access Web Portal directly</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Is Active</label>
                                    <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                        <asp:ListItem>TRUE</asp:ListItem>
                                        <asp:ListItem>FALSE</asp:ListItem>
                                    </asp:DropDownList>
                                    <p class="help-block">Activate or Deactivate Users Credentials</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Date Of Birth</label>
                                    <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Users Date of Birth. Format dd/MM/yyyy e.g 04/02/1991</p>
                                </div>
                                <div class="col-lg-6" id="TellersSection" runat="server">
                                    <label>Transaction Limit</label>
                                    <asp:TextBox ID="txtTranLimit" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">If User Type is Teller, Please supply a transaction limit</p>
                                </div>
                            </div>

                            <div class="row" id="CustomersSection" runat="server">
                                <div class="col-lg-6">
                                    <label>Upload Individuals Picture</label>
                                    <asp:FileUpload runat="server" accept="image/*" ID="fuProfilePic" type="file" />
                                    <p class="help-block">Profile Picture of the Individual.Will be used to identify the Customer.</p>
                                </div>
                                <div class="col-lg-6">
                                    <label>Upload Individuals Signature</label>
                                    <asp:FileUpload runat="server" accept="image/*" ID="fuCustomerSign" type="file" />
                                    <p class="help-block">Image of Customers Signature.</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="text-center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                </div>
                            </div>

                            <%-- Scripts--%>
                            <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="Server" EnableScriptGlobalization="true"
                                EnableScriptLocalization="true">
                            </ajaxToolkit:ToolkitScriptManager>
                            <br />
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" CssClass="cal_Theme1"
                                Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="txtDateOfBirth">
                            </ajaxToolkit:CalendarExtender>

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
                                This Bank User Already Exists! Are you sure you want to Update it.
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
