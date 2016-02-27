<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="EDIT CUSTOMER" AutoEventWireup="true" CodeFile="AddOrEditCustomer.aspx.cs" Inherits="AddOrEditCustomer" %>

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
                                <h4>Input Bank Customers' Details
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
                        <!-- /.row -->
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
                                <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddBank_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The Bank to which the Customer belongs</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Bank Branch</label>
                                <asp:DropDownList ID="ddBankBranch" runat="server" CssClass="form-control">
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
                                <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">Activate or Deactivate Customers' Credentials</p>
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
                            Format="dd/MM/yyyy" PopupPosition="BottomRight" OnClientShown="calendarShown" TargetControlID="txtDateOfBirth">
                        </ajaxToolkit:CalendarExtender>

                        <script type="text/javascript" language="javascript">
                            function calendarShown(sender, args)
                            {
                                sender._popupBehavior._element.style.zIndex = 10005;
                            }
                        </script>

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
                                This Customer Already Exists! Are you sure you want to Update Him/Her.
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