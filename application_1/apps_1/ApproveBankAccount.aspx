<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="APPROVE BANK ACCOUNT" AutoEventWireup="true" CodeFile="ApproveBankAccount.aspx.cs" Inherits="ApproveBankAccount" %>

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
                                <h4>Check for Bank Users Pending Approval
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Approve Users
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
                            <div class="row">
                                <div class="col-lg-2">
                                    <label>Bank</label>
                                    <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-2">
                                    <label>Branch</label>
                                    <asp:DropDownList ID="ddBankBranch" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-2">
                                    <label>Account Number</label>
                                    <asp:TextBox ID="txtAccount" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>Customer Name</label>
                                    <asp:TextBox ID="txtCustName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-lg-2">
                                    <label>From Date</label>
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>To Date</label>
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>

                                <div class="col-lg-2">
                                    <label>Search</label>
                                    <div class="button-wrapper">
                                        <asp:Button ID="btnSubmit" Width="130px" Height="40px" runat="server" Text="Search" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                </div>
                                <div class="col-lg-2">
                                </div>
                                <div class="col-lg-2">
                                </div>
                            </div>
                        </div>
                        <hr />
                        <asp:MultiView runat="server" ID="Multiview2">
                            <asp:View runat="server" ID="resultView">
                                <div class="row">
                                    <div class="col-lg-4"></div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="btnApprove" runat="server" OnClick="btnApprove_Click" CssClass="btn btn-primary" Text="Approve BankAccount(s)" />
                                        <asp:Button ID="btnReject" runat="server" OnClick="btnReject_Click" CssClass="btn btn-danger" Text="Reject BankAccount(s)" />
                                    </div>
                                    <div class="col-lg-4"></div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="table-responsive">
                                        <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults" OnSelectedIndexChanged="dataGridResults_SelectedIndexChanged">
                                            <AlternatingRowStyle BackColor="#BFE4FF" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Approve">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkboxSelectAll" Text="Approve All" runat="server" AutoPostBack="true" OnCheckedChanged="dataGridResults_SelectedIndexChanged" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="CheckBox" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View runat="server" ID="EmptyView"></asp:View>
                        </asp:MultiView>
                        <%-- /row --%>

                        <%-- Scripts--%>
                        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="Server" EnableScriptGlobalization="true"
                            EnableScriptLocalization="true">
                        </ajaxToolkit:ToolkitScriptManager>
                        <br />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" CssClass="cal_Theme1"
                            Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="txtFromDate">
                        </ajaxToolkit:CalendarExtender>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" CssClass="cal_Theme1"
                            Format="dd/MM/yyyy" PopupPosition="BottomRight" TargetControlID="txtToDate">
                        </ajaxToolkit:CalendarExtender>
                        <%--/Scripts
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
