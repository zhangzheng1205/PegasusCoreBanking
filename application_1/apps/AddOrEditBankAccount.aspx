<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddOrEditBankAccount.aspx.cs" Inherits="AddOrEditBankAccount" Title="Save Bank Account Details" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="Server" EnableScriptGlobalization="true"
                EnableScriptLocalization="true" EnablePageMethods="true">
            </ajaxToolkit:ToolkitScriptManager>
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
                                <asp:DropDownList ID="ddAccountType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddAccountType_SelectedIndexChanged">
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
                                    <asp:ListItem>TRUE</asp:ListItem>
                                    <asp:ListItem>FALSE</asp:ListItem>
                                </asp:DropDownList>
                                <p class="help-block">True: Account is Active and can be used to Transact. False: Means its deactivated.</p>
                            </div>
                            <div class="col-lg-6" id="AddSignatorySection" runat="server">
                                <label>Save Customer Details</label>
                                <br />
                                <!-- Trigger the modal with a button -->
                                <asp:Button runat="server" ID="btnAddAccountSingatory" class="btn btn-default" Text="Add Account Signatory" OnClick="btnAddAccountSingatory_Click"></asp:Button>
                            </div>
                        </div>

                        <hr />



                        <!-- Modal -->
                        <div id="CaptureCustomerDetailsForm" runat="server">
                            <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Enter Customer Details Below</h4>
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
                                               <label>Next of Kin Full Name</label>
                                                <asp:TextBox ID="txtNextOfKinName" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">The name of the next of Kin</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Next of Kin Contact</label>
                                                <asp:TextBox ID="txtNextOfKinTel" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">Phone Number or Email or the next of Kin</p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <label>Marital Status</label>
                                                <asp:DropDownList ID="ddMaritalStatus" runat="server" CssClass="form-control">
                                                    <asp:ListItem>SINGLE</asp:ListItem>
                                                    <asp:ListItem>MARRIED</asp:ListItem>
                                                </asp:DropDownList>
                                                <p class="help-block">The Customers Marital Status</p>
                                            </div>
                                            <div class="col-lg-6">
                                                <label>Nationality</label>
                                                <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control" placeholder="Enter text" />
                                                <p class="help-block">The customers Nationality</p>
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
                                            <div class="col-lg-6" id="UploadProfilePicSection" runat="server">
                                                <label>Upload Individuals Picture</label>
                                                <!-- Trigger the modal with a button -->
                                                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" onclick="SetGlobal('Profile')">Take and Upload Picture</button>
                                                <p class="help-block">Profile Picture of the Individual. Will be used to identify the Customer.</p>
                                            </div>
                                            <div class="col-lg-6" id="UploadSignatureSection" runat="server">
                                                <label>Upload Individuals Signature</label>
                                                <!-- Trigger the modal with a button -->
                                                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" onclick="SetGlobal('Signature')">Take and Upload Picture</button>
                                                <p class="help-block">Image of Customers Signature.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer text-center">
                                        <asp:Button ID="btnSaveCustomerDetails" runat="server" Text="Save Customer Details" CssClass="btn btn-primary" OnClick="btnSaveCustomerDetails_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
                                    </div>
                                </div>

                            </div>
                        </div>

                        <%-- Save Bank Account Details --%>
                        <div class="row">
                            <div class="text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="200px" CssClass="btn btn-success btn-lg" OnClick="btnSubmit_Click" />
                            </div>
                        </div>

                        <%-- Add Account Signatory Form --%>
                        <div id="myModal" class="modal fade" role="dialog">
                            <div class="modal-dialog">

                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" onclick="StopCapture()">&times;</button>
                                        <h4 class="modal-title">Upload Customer Profile Picture</h4>
                                    </div>
                                    <div class="modal-body">


                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="container12">
                                                    <video autoplay></video>
                                                </div>
                                            </div>
                                            <div class="col-lg-2"></div>
                                            <div class="col-lg-4">
                                                <canvas width='140' height='190' style="border: 1px solid #d3d3d3;"></canvas>
                                            </div>
                                        </div>
                                        <div class="controls">
                                        </div>
                                        <script type="text/javascript">


                                            var localMediaStream = null;
                                            var video = document.querySelector('video');
                                            var canvas = document.querySelector('canvas');
                                            var UploadType = '';

                                            function upload() {
                                                var base64 = canvas.toDataURL('image/jpeg');
                                                __doPostBack('Upload', UploadType + '|' + base64);
                                                stopCapture();
                                            }

                                            function SetGlobal(PicName) {
                                                UploadType = PicName;
                                            }

                                            function takePhoto() {
                                                if (localMediaStream) {
                                                    var ctx = canvas.getContext('2d');
                                                    //ctx.drawImage(video, 0, 0, 320, 240); // original draw image
                                                    //ctx.drawImage(video, 0, 0, 640, 480, 0, 0, 320, 240); // entire image

                                                    //instead of
                                                    //ctx.drawImage(video, 90, 40, 140, 190, 0, 0, 140, 190);

                                                    // we double the source coordinates
                                                    ctx.drawImage(video, 180, 80, 280, 380, 0, 0, 140, 190);
                                                    document.querySelector('img').src = canvas.toDataURL('image/jpeg');
                                                }
                                            }

                                            navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
                                            window.URL = window.URL || window.webkitURL;

                                            function startCapture() {
                                                navigator.getUserMedia({ video: true }, function (stream) {
                                                    video.src = window.URL.createObjectURL(stream);

                                                    localMediaStream = stream;
                                                }, function (e) {
                                                    console.log(e);
                                                });
                                            }

                                            function stopCapture() {
                                                localMediaStream.getVideoTracks()[0].stop();
                                            }
                                        </script>
                                    </div>
                                    <div class="modal-footer">
                                        <div class="row">
                                            <div class="col-lg-2"><input type="button" class="btn btn-success" value="Start capture" onclick="startCapture()" /></div>
                                            <div class="col-lg-2"></div>
                                            <div class="col-lg-2"><input type="button" class="btn btn-primary" value="Take Picture" onclick="takePhoto()" /></div>
                                            <div class="col-lg-2"></div>                                            
                                            <div class="col-lg-2"><input type="button" class="btn btn-danger" value="Upload" onclick="upload()" /></div>
                                            <div class="col-lg-2"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <%-- Scripts--%>
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


            <style type="text/css">
                .container12 {
                    width: 320px;
                    height: 240px;
                    border: 1px solid #d3d3d3;
                }

                    .container12 video {
                        width: 100%;
                        height: 100%;
                    }

                    .container12 .photoArea {
                        border: 2px dashed white;
                        width: 140px;
                        height: 190px;
                        position: relative;
                        margin: 0 auto;
                    }

                canvas, img {
                    float: left;
                }

                .controls {
                    clear: both;
                }
            </style>
            <!-- /#page-wrapper -->
        </asp:View>
        <asp:View ID="View2" runat="server">
        </asp:View>
    </asp:MultiView>



</asp:Content>
