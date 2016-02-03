<%@ Page Language="C#" MasterPageFile="~/Main.master" Title="CAMERA CAPTURE" AutoEventWireup="true" CodeFile="CameraCaptureForm.aspx.cs" Inherits="CameraCaptureForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    &nbsp;
   <asp:HiddenField ID="ValueHiddenField"
       Value=""
       runat="server" />
    <asp:HiddenField ID="ValueHiddenFieldBranch"
        Value=""
        runat="server" />
    <div id="myDiv1" style="display: none; text-align: center;">
        <p>
            <label style="color: Red;">..........You must first Capture and Save Customer Photo to Proceed..........</label></p>
    </div>

    <div id="myDiv2" style="display: block; text-align: center;">
        <input type="button" value="Start Customer Enroll Photo Process" onclick="setPhotoCustomerDetails();" id="Button1" />
    </div>

    <div id="myDiv3" style="display: none; text-align: center;">
        <p>
            <label style="color: Gray;">Click proceed Button after successfully saving Customer Photo below.</label>
        </p>
        <p>
            <input type="button" value="Proceed to Capture FingerPrints" onclick="chechEmbeddedStatus();" id="Button3" />
        </p>


    </div>

    <div style="text-align: center; margin-top: 20px">

        <asp:Panel ID="Panel1" runat="server" GroupingText="Postbank Customer Photo Capture Tool" Font-Size="Small" Font-Bold="True" Height="1000px">
            <object id="WindowsControlLibraryForEmployeeImage" height="900" width="635" style="margin-top: 0%"
                classid="http:WindowsControlLibraryForEmployeeImage.dll#WindowsControlLibraryForEmployeeImage.UserControl1">
            </object>

            <ajaxToolkit:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            </ajaxToolkit:ScriptManager>

            <ajaxToolkit:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    Loading...
                </ProgressTemplate>
            </ajaxToolkit:UpdateProgress>
        </asp:Panel>
    </div>
    <script type="text/javascript">
        function setPhotoCustomerDetails() {
            //alert("Here Now");
            var recordedBy = document.getElementById('<%=ValueHiddenField.ClientID%>').value;
        var recordingBranch = document.getElementById('<%=ValueHiddenFieldBranch.ClientID%>').value;
        //alert(recordedBy);
        var custImage = document.getElementById("WindowsControlLibraryForEmployeeImage");
        custImage.SetUserDetails(recordedBy, recordingBranch);
        document.getElementById("myDiv3").style.display = 'block';
        document.getElementById("myDiv2").style.display = 'none';
        document.getElementById("myDiv1").style.display = 'none';
    }
    function GetParamaterValues(param) {
        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < url.length; i++) {
            var urlparam = url[i].split('=');
            if (urlparam[0] == param) {
                return urlparam[1];
            }
        }
    }
    function chechEmbeddedStatus() {
        var custImage = document.getElementById("WindowsControlLibraryForEmployeeImage");
        var newStat = custImage.checkWhetherCompleted();
        if (newStat == "1") {
            document.getElementById("myDiv3").style.display = 'block';
            document.getElementById("myDiv2").style.display = 'none';
            document.getElementById("myDiv1").style.display = 'block';

        }
        else {
            window.location.href = 'fingerprint.aspx?dix=' + newStat;
        }
    }
    function gret() {
        var custImage = document.getElementById("myDiv");
        custImage.style.display = 'block';
        alert(custImage.style.display)
    }


    </script>


    <asp:HiddenField runat="server" ID="JSStatusString" />

</asp:Content>

