<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="Save Access Control Settings" AutoEventWireup="true" CodeFile="AddOrEditAccessControl.aspx.cs" Inherits="AddOrEditAccessControl" %>

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
                                <h4>Input Account Type Details Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Account Type
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
                                <p class="help-block">The bank to which the Access Control Belongs</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Bank Branch</label>
                                <asp:DropDownList ID="ddBankBranch" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">Bank Branch whose Users will be affected</p>
                            </div>
                            
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>UserId</label>
                                <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Unique Identifier of the User.Can be left empty.</p>
                            </div>
                            <div class="col-lg-6">
                                <label>UserCategory</label>
                                <asp:DropDownList ID="ddUserType" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The User Category that will be affected by the Access rule.Can be ALL</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Rule Name</label>
                                <asp:TextBox ID="txtRuleName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Tabs the User Access</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Rule Code</label><br />
                                <asp:TextBox ID="txtRuleCode" runat="server" CssClass="form-control" placeholder="Enter text" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Access Areas</label>
                                <asp:DropDownList ID="ddAccessAreas" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">Tabs the User Access</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Add Access to This Area</label><br />
                                <asp:Button ID="btnAddAccessArea" runat="server" Text="Allow Access" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnAddAccessArea_Click" />
                            </div>
                        </div>

                          <div class="row">
                            <div class="col-lg-6">
                                <label>IsActive</label>
                                <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">Is this rule Active</p>
                            </div>
                           <div class="col-lg-6">
                                <label>Description</label>
                                 <asp:TextBox ID="txtAccessDesc" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Reason for this Access Rule</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Allowed Access Areas</label>
                                <asp:TextBox ID="txtAllowedAreas" TextMode="MultiLine" runat="server" CssClass="form-control" Enabled="false" />
                                <p class="help-block">The Areas to which you have allowed Access</p>
                            </div>
                        </div>


                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>

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
