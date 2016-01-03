<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBank.aspx.cs" Inherits="AddOrEditBank" Title="Add_Or_Edit_Bank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div id="page-wrapper">

                <div class="container-fluid">



                    <div class="row">
                        <%-- <div class="col-lg-6">--%>

                        <form runat="server" action="#" method="post">
                            <!-- Page Heading -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <h4>
                                        Input Bank Details
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
                            <div class="row">
                                <div class="text-center">
                                     <h4 class="text-success"><asp:Label ID="lblmsg" runat="server"></asp:Label></h4>
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
                                        <asp:ListItem>True</asp:ListItem>
                                        <asp:ListItem>False</asp:ListItem>
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

                                <div class="col-lg-6">
                                    <label>Upload Bank public Key(.cer)</label>
                                    <asp:FileUpload runat="server" accept="*.cer" ID="fuPublicKey" type="file" />
                                    <p class="help-block">Public key of Bank in .cer format. This will be used to verify digital signatures of requests sent to the API</p>
                                </div>
                            </div>

                            <div class="row">
                                 <div class="col-lg-6"></div>
                                <div class="col-lg-6">
                                    <label>Upload Bank Logo</label>
                                    <asp:FileUpload runat="server" accept="image/*" ID="fuBankLogo" type="file" />
                                    <p class="help-block">Logo Image of Bank in PNG or JPEG format.Will be used to customize look and feel of Bank OS</p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="text-center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                                </div>
                            </div>


                        </form>
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
