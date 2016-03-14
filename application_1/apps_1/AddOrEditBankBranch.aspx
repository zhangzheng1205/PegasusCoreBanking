<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBankBranch.aspx.cs" Inherits="AddOrEditBankBranch" Title="Save Branch Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <div class="row">

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Branch Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Branch Details
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
                                <p class="help-block">The bank to Which the Branch belongs</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Branch Name</label>
                                <asp:TextBox ID="txtBranchName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The Name of the Branch</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Branch Code</label>
                                <asp:TextBox ID="txtBranchCode" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Unique Identifier of this Branch.</p>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-6">
                                <label>Is Active</label>
                                <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Branch is Active and will be applied. False: Means its deactivated.</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Loaction</label>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Explain a bit more about this Branch.</p>
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
            <div id="page-wrapper">
                <div class="container">
                    <div class="text-center">
                        <div class="row" style="padding-top: 70px;">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8">
                                <div class="alert alert-info">
                                    This Bank Branch Already Exists! Are you sure you want to Update it.
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
            </div>
        </asp:View>
    </asp:MultiView>



</asp:Content>
