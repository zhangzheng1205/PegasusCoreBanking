<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ViewAll.aspx.cs" Inherits="ViewAll" Title="View All" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">

                    <div class="row">

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
                                <div class="col-lg-2"></div>
                                <div class="col-lg-2">
                                    <label>Bank</label>
                                    <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-2">
                                    <label>Report Category</label>
                                    <asp:DropDownList ID="ddReporttype" runat="server" CssClass="form-control">
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-2">
                                    <label>Id</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                    <p class="help-block">Unique Identifier of that Category. e.g UserType Code,Account Number etc</p>
                                </div>
                                <div class="col-lg-2">
                                    <label>Search</label>
                                    <div class="button-wrapper">
                                        <asp:Button ID="Button1" Width="130px" Height="40px" runat="server" Text="Search" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                                <div class="col-lg-2"></div>

                                <div class="col-lg-2"></div>


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
                                            <asp:Button ID="btnConvert" runat="server" OnClick="btnConvert_Click"
                                                CssClass="btn-primary" Text="Convert" />
                                        </div>
                                        <div class="col-lg-2"></div>
                                        <div class="col-lg-2"></div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <%--<div class="table-responsive">--%>
                                        <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults">
                                            <AlternatingRowStyle BackColor="#BFE4FF" />
                                            <HeaderStyle BackColor="#0375b7" Font-Bold="false" ForeColor="white" Font-Italic="False"
                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Height="30px" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:HyperLink runat="server" Text='Edit'
                                                            NavigateUrl='<%# "ViewAll.aspx?EditType=" + ddReporttype.SelectedValue+    
                                                                                 "&Id=" + DataBinder.Eval(Container.DataItem,"Id").ToString()+    
                                                                                 "&BankCode=" +ddBank.SelectedValue  %>'
                                                            ID="EditColumn" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <%-- </div>--%>
                                    </div>
                                </asp:View>
                                <asp:View runat="server" ID="EmptyView"></asp:View>
                            </asp:MultiView>
                            <%-- /row --%>

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
