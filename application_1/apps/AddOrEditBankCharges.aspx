<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBankCharges.aspx.cs" Inherits="AddOrEditBankCharges" Title="Save Bank Charge" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">
                <div class="container-fluid">

                    <div class="row">

                        <!-- Page Heading -->
                        <div class="row">
                            <div class="col-lg-12">
                                <h4>Input Bank Charge Details
                                </h4>
                                <ol class="breadcrumb">
                                    <li>
                                        <i class="fa fa-dashboard"></i>Dashboard
                                    </li>
                                    <li class="active">
                                        <i class="fa fa-edit"></i>Edit Bank Charge
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
                                <asp:DropDownList ID="ddBank" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddBank_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The bank to Which the charge belongs</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Charge Name</label>
                                <asp:TextBox ID="txtChargeName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">The Name of the Charge</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Charge Code</label>
                                <asp:TextBox ID="txtChargeCode" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Unique Identifier of this Charge.</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Commission Account</label>
                                <asp:DropDownList ID="ddComAccount" runat="server" CssClass="form-control">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The commission Account Number attached to this charge</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Transaction Category</label>
                                <asp:DropDownList ID="ddTranCategory" runat="server" CssClass="form-control">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The Transaction Category that will be affected by the charge</p>
                            </div>
                        </div>



                        <div class="row">
                            <div class="col-lg-6">
                                <label>Charge Amount</label>
                                <asp:TextBox ID="txtChargeAmount" runat="server" CssClass="form-control" placeholder="1000" />
                                <p class="help-block">Amount to charge Transaction</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Charge Description</label>
                                <asp:TextBox ID="txtChargeDesc" runat="server" CssClass="form-control" placeholder="Enter text" />
                                <p class="help-block">Explain a bit more about this charge.</p>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-lg-6">
                                <label>Is A Debit</label>
                                <asp:DropDownList ID="ddIsDebit" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Means this charge is a debit. False: Means its a Credit</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Is Active</label>
                                <asp:DropDownList ID="ddIsActive" runat="server" CssClass="form-control">
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Charge is Active and will be applied. False: Means its deactivated.</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <label>Account Type</label>
                                <asp:DropDownList ID="ddAccountType" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">The Account Type this charge affects. Can be left empty if targetting Transaction Categories</p>
                            </div>
                            <div class="col-lg-6">
                                <label>Charge Type</label>
                                <asp:DropDownList ID="ddChargeType" runat="server" CssClass="form-control">
                                    <asp:ListItem>True</asp:ListItem>
                                    <asp:ListItem>False</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">What Type of charge is this. Flat fee,percentage etc</p>
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
                                This Bank Charge Already Exists! Are you sure you want to Update it.
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
