<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" Title="REPORTING" %>

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
                        <%-- <div class="col-lg-6">--%>

                        <%--<form runat="server" action="#" method="post">--%>
                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Search Criteria Below
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>View Transactions
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
                                    <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="ddBank_SelectedIndexChanged">
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
                                    <label>Teller</label>
                                    <asp:TextBox ID="txtTeller" runat="server" CssClass="form-control" placeholder="Enter text" />
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
                                    <label>Transaction Category</label>
                                    <asp:DropDownList ID="ddTranCategory" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-lg-2">
                                    <label>Bank Transaction Id</label>
                                    <asp:TextBox ID="txtBankTranId" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>PegPay Id</label>
                                    <asp:TextBox ID="txtPegPayId" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>From Date</label>
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>To Date</label>
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>Reason</label>
                                    <asp:TextBox ID="txtReason" runat="server" CssClass="form-control" placeholder="Enter text" />
                                </div>
                                <div class="col-lg-2">
                                    <label>Search</label>
                                    <div class="button-wrapper">
                                        <asp:Button ID="btnSubmit" Width="130px" Height="40px" runat="server" Text="Search" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <asp:MultiView runat="server" ID="Multiview2">
                            <asp:View runat="server" ID="resultView">
                                <div class="row">
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
                                            CssClass="btn-primary" Text="Export As" Width="85px" />
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Button ID="btnPrint" runat="server" Font-Size="9pt" Height="23px" OnClick="btnConvert_Click"
                                            CssClass="btn-primary" Text="Print Statement" />
                                    </div>
                                    <div class="col-lg-2"></div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="table-responsive">
                                        <asp:DataGrid runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults"></asp:DataGrid>
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
