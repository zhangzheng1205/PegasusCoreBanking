﻿<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBankAccount.aspx.cs" Inherits="AddOrEditBankAccount" Title="Save Bank Account Details" %>

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
                                <asp:DropDownList ID="ddAccountType" runat="server" CssClass="form-control">
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
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Account is Active and can be used to Transact. False: Means its deactivated.</p>
                            </div>
                           <div class="col-lg-6" id="AddSignatorySection" runat="server">
                                <label>Save Customer Details</label>
                                <br />
                                <!-- Trigger the modal with a button -->
                                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal">Add Account Signatory</button>
                            </div>
                        </div>

                        <hr />



                        <!-- Modal -->
                        <div id="myModal" class="modal fade" role="dialog">
                            <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Edit Customer Details</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Full Name</label>
                                                <asp:TextBox ID="txtBankUsersName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">The Name of the User</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Customer Id</label>
                                                <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">Unique Identifier of this Customer. It can be Customers' Email or PhoneNumber etc.</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Bank</label>
                                                <asp:DropDownList ID="ddBank2" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddBank_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">The Bank to which the Customer belongs</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Bank Branch</label>
                                                <asp:DropDownList ID="ddBankBranches2" runat="server" CssClass="form-control">
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">The Branch at which the Customer is Opening up their account</p>
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
                                                <p class="help-block">Customers' Phone Number in International format. e.g 256</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Gender</label>
                                                <asp:DropDownList ID="ddGender" runat="server" CssClass="form-control">
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">Customers' Sex</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Date Of Birth</label>
                                                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">Customers' Date of Birth. Format dd/MM/yyyy e.g 04/02/1991</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Send Email with Credentials</label>
                                                <asp:DropDownList ID="ddSendEmail" runat="server" CssClass="form-control">
                                                    <asp:ListItem>False</asp:ListItem>
                                                    <asp:ListItem>True</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">Should an Email be sent to User with CustomerId and Password for access Web Portal directly</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Is Active</label>
                                                <asp:DropDownList ID="ddIsActive2" runat="server" CssClass="form-control">
                                                    <asp:ListItem>True</asp:ListItem>
                                                    <asp:ListItem>False</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">Activate or Deactivate Customers' Credentials</p>
                                            </div>
                                        </div>

                                        <div class="row" id="CustomersSection" runat="server">
                                            <div class="col-lg-6">
                                                <label>Upload Individuals Picture</label>
                                                <asp:FileUpload runat="server" accept="image/*" ID="fuProfilePic" type="file" />
                                                <p class="help-block">Profile Picture of the Individual. Will be used to identify the Customer.</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Upload Individuals Signature</label>
                                                <asp:FileUpload runat="server" accept="image/*" ID="fuCustomerSign" type="file" />
                                                <p class="help-block">Image of Customers Signature.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnSaveCustomerDetails" runat="server" Text="Save Customer Details" CssClass="btn btn-primary" OnClick="btnSaveCustomerDetails_Click" />
                                    </div>
                                </div>

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
                            Format="dd/MM/yyyy" PopupPosition="BottomRight" OnClientShown="calendarShown" TargetControlID="txtDateOfBirth">
                        </ajaxToolkit:CalendarExtender>

                        <script type="text/javascript" language="javascript">
                            function calendarShown(sender, args) {
                                sender._popupBehavior._element.style.zIndex = 10005;
                            }
                        </script>
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
