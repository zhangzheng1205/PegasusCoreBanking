<%@ Page Language="C#" AutoEventWireup="true" 
CodeFile="Default.aspx.cs" 
Inherits="_Default"
EnableEventValidation="false"
Culture="auto" 
UICulture="auto" %>

 <%@ Register 
 Assembly="AjaxControlToolkit" 
 Namespace="AjaxControlToolkit" 
 TagPrefix="ajaxToolkit" %>
 <%@ Import
  Namespace="System.Threading" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title> PEGPAY - PAYMENTS INTERFACE PORTAL </title>
    
    <link href="scripts/WQC_stylesheet.css" rel="stylesheet" type="text/css" />
    
    <link href="scripts/globalscape.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="ddtabmenufiles/ddtabmenu.js">

/***********************************************
* DD Tab Menu script- � Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

    </script>
    

<!-- CSS for Tab Menu #4 -->
<link rel="stylesheet" type="text/css" href="ddtabmenufiles/ddcolortabs_First.css" />

<script type="text/javascript">
//SYNTAX: ddtabmenu.definemenu("tab_menu_id", integer OR "auto")
ddtabmenu.definemenu("ddtabs1", 0) //initialize Tab Menu #1 with 1st tab selected
ddtabmenu.definemenu("ddtabs2", 1) //initialize Tab Menu #2 with 2nd tab selected
ddtabmenu.definemenu("ddtabs3", 1) //initialize Tab Menu #3 with 2nd tab selected
ddtabmenu.definemenu("ddtabs4", 2) //initialize Tab Menu #4 with 3rd tab selected
ddtabmenu.definemenu("ddtabs5", -1) //initialize Tab Menu #5 with NO tabs selected (-1)

</script>
    
    <style type="text/css">
        
        .style12
        {
            width: 100%;
        }
         .style13
        {
            width: 99%;
        }
    
        </style>
    
</head>
<body bgcolor ="#EFFBF5">
    <form id="form1" runat="server">
     
     
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ID="ScriptManager1" />
        
    <table cellpadding="0" cellspacing="0" class="style12">
        <tr>
            <td style="vertical-align: top; text-align: center; background-color: white;">
               
               <table style="border: 1px solid #EEEEEE; width: 100%; background-color: #ffffff; padding-top: 0px; margin-top: 0px;">
            <tr>
                <td style="border-right: thin solid #ebf3ff; background-color: #acbd29; padding-right: 0px; margin-right: 0px; height: 2px;" 
                    colspan="2">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 1%; height: 54px;">
                </td>
                <td style="width: 99%; height: 54px;">
                    <img alt="" src="Images/Billing.png" style="width: 340px; height: 52px" /></td>
            </tr>
            <tr>
                <td style="width: 1%">
                </td>
                <td style="width: 99%">
                
  <div id="ddtabs5" class="ddcolortabs">
<ul>
</ul>
</div>

<div class="ddcolortabsline" style="height: 1px; background-color: #990033">&nbsp;</div>
                </td>
            </tr>
            <tr>
                <td style="width: 1%">
                    &nbsp;</td>
                <td style="width: 99%; text-align: center; vertical-align: middle;">
                    &nbsp;<asp:Label ID="lblmsg" runat="server" Font-Bold="False" Font-Names="Arial Narrow"
                        ForeColor="Red" Style="font: menu" Text="."></asp:Label></td>
            </tr>
                   <tr>
                       <td style="width: 1%">
                       
                       </td>
                       <td style="vertical-align: middle; width: 99%; height: 1px; text-align: center">
                       <hr />
                       </td>
                   </tr>
            <tr>
                <td style="width: 1%">
                    &nbsp;</td>
                <td style="width: 99%">
                    <table align="left" class="style13" style="padding-right: 3px; padding-left: 3px; padding-bottom: 3px; margin: 3px; padding-top: 3px;
                        height: 300px; background-color: #fafafa; border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6; border-bottom-width: 1px; border-bottom-color: #617da6; border-top-color: #617da6; border-right-width: 1px; border-right-color: #617da6;">
                        <tr>
                            <td style="vertical-align: top; text-align: center">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="vertical-align: top; text-align: center">
                                            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                                <asp:View ID="View2" runat="server">
                                                    &nbsp;
                                                <asp:Panel ID="Panel1" runat="server" CssClass="roundedPanel"  Width="100%" >
                                <table align="center" cellpadding="0" cellspacing="0" style="width: 35%; border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid; border-bottom: #617da6 1px solid;">
                                    <tr>
                                        <td style="text-align: center; vertical-align: top;" colspan="3">
                                            <table align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="InterfaceHeaderLabel">
                                                        System log in</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 2px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="InterFaceTableRightLogin" style="width: 29%; height: 30px;">
                                            Username:</td>
                                        <td class="InterFaceTableMiddleRow" style="width: 1%; height: 30px;">
                                            &nbsp;</td>
                                        <td class="InterFaceTableRightLogin" style="width: 50%; height: 30px;">
                                            <asp:TextBox ID="txtUsername" runat="server" Width="60%" onblur="Change(this, event)" onfocus="Change(this, event)"
                                             ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="InterFaceTableRightLogin" style="width: 29%; height: 29px;">
                                            Password:</td>
                                        <td class="InterFaceTableMiddleRow" style="width: 1%; height: 29px;">
                                            &nbsp;</td>
                                        <td class="InterFaceTableRightLogin" style="width: 50%; height: 29px;">
                                            <asp:TextBox ID="txtpassword" runat="server" Width="60%" TextMode="Password" 
                                            ></asp:TextBox>
                                                    </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 1px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 29%; height: 21px;">
                                            &nbsp;</td>
                                        <td style="width: 1%; height: 21px;">
                                            &nbsp;</td>
                                          <td style="width: 50%; text-align: left; vertical-align: middle; height: 21px;" class="InterFaceTableRightLogin">
                            <asp:Button ID="Btnlogin" runat="server" Font-Size="9pt" Height="23px" Text="Login" 
                                Width="110px" onclick="Btnlogin_Click" Font-Bold="True" />
                                <asp:Button ID="ButtonForgotPassword" runat="server" Font-Size="9pt" Height="23px" Text="Forgot Password" 
                                Width="119px" onclick="BtnForgotPassword_Click" Font-Bold="True" />
                                        </td>
                                    </tr>
                                    </table>
                                    </asp:Panel>
                                                    <asp:Label ID="lblMessage" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label></asp:View>
                                                <asp:View ID="View1" runat="server">
                                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 45%; border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid; border-bottom: #617da6 1px solid;">
                                                        <tr>
                                                            <td colspan="3">
                                                                <table align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                                                    <tr>
                                                                        <td class="InterfaceHeaderLabel">
                                                                            CHANGE YOUR SYSTEM PASSWORD</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 20px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterFaceTableLeftRow">
                                                                New Password</td>
                                                            <td class="InterFaceTableMiddleRow">
                                                            </td>
                                                            <td class="InterFaceTableRightRow">
                                                                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                                    TextMode="Password" Width="60%"  onKeyDown="return DisableControlKey(event)" onMouseDown="return DisableControlKey(event)"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterFaceTableLeftRow">
                                                                Confirm Password</td>
                                                            <td class="InterFaceTableMiddleRow">
                                                            </td>
                                                            <td class="InterFaceTableRightRow">
                                                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                                    TextMode="Password" Width="60%"   onKeyDown="return DisableControlKey(event)" onMouseDown="return DisableControlKey(event)"></asp:TextBox></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterFaceTableLeftRow">
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td style="vertical-align: middle; text-align: left" class="InterFaceTableLeftRow">
                                                                <asp:Button ID="BtnSave" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                                                    OnClick="BtnSave_Click" Text="Save" Width="99px" />
                                                                <asp:Button ID="btnCancel" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                                                    OnClick="btnCancel_Click" Text="Cancel" Width="90px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                                <asp:Label ID="Label1" runat="server" Text="0" Visible="False"></asp:Label>
                                                                <asp:Label ID="Label2" runat="server" Text="0" Visible="False"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterfaceItemSeparator" colspan="3" style="height: 1px">
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:View>
                                                &nbsp;&nbsp;
                                                 <asp:View ID="View4" runat="server">
                                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 45%; border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid; border-bottom: #617da6 1px solid;">
                                                        <tr>
                                                            <td colspan="3">
                                                                <table align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                                                    <tr>
                                                                        <td class="InterfaceHeaderLabel">
                                                                             RESET PASSWORD</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 20px">
                                                            </td>
                                                        </tr>
                                        <tr>
                                        <td class="InterFaceTableRightLogin" style="width: 29%; height: 30px;">
                                          Enter  Username:</td>
                                        <td class="InterFaceTableMiddleRow" style="width: 1%; height: 30px;">
                                            &nbsp;</td>
                                        <td class="InterFaceTableRightLogin" style="width: 50%; height: 30px;">
                                            <asp:TextBox ID="TextBoxUsername" runat="server" Width="60%" onblur="Change(this, event)" onfocus="Change(this, event)"
                                             ></asp:TextBox>
                                        </td>
                                    </tr> 
                                        <tr>
                                        <td class="InterFaceTableRightLogin" style="width: 29%; height: 30px;">
                                          Enter  Email:</td>
                                        <td class="InterFaceTableMiddleRow" style="width: 1%; height: 30px;">
                                            &nbsp;</td>
                                        <td class="InterFaceTableRightLogin" style="width: 50%; height: 30px;">
                                            <asp:TextBox ID="TextBoxEmail" runat="server" Width="60%" onblur="Change(this, event)" onfocus="Change(this, event)"
                                             ></asp:TextBox>
                                        </td>
                                    </tr> 
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterFaceTableLeftRow">
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td style="vertical-align: middle; text-align: left" class="InterFaceTableLeftRow">
                                                                <asp:Button ID="Button1289" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                                                    OnClick="BtnResetUserPassword_Click" Text="Reset" Width="99px" />
                                                                    <asp:Button ID="Button1Cancel" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                                                    OnClick="btnCancel_Click" Text="Cancel" Width="90px" />
                                                             <!--   <asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                                                    OnClick="btnCancel_Click" Text="Cancel" Width="90px" />  -->  </td> 
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="height: 21px">
                                                                <asp:Label ID="Label3" runat="server" Text="0" Visible="False"></asp:Label>
                                                                <asp:Label ID="Label4" runat="server" Text="0" Visible="False"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterfaceItemSeparator" colspan="3" style="height: 1px">
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:View>
                                                 &nbsp;&nbsp;
                                                <asp:View ID="View3" runat="server">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="width: 100px">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="InterFaceTableLeftRowUp" style="width: 100%; text-align: center">
                                                                <asp:Label ID="lblQn" runat="server" Font-Bold="True" ForeColor="Maroon" Text="."></asp:Label><asp:Button
                                                                    ID="btnYes" runat="server" OnClick="btnYes_Click" Text="Yes" Font-Bold="True" Width="53px" />&nbsp;
                                                                <asp:Button ID="btnNo"
                                                                        runat="server" OnClick="btnNo_Click" Text="No" Font-Bold="True" Width="52px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:View>
                                                &nbsp;
                                            </asp:MultiView></td>
                                    </tr>
                                </table>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; text-align: center">
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 1%">
                    &nbsp;</td>
                <td style="width: 99%; vertical-align: top; text-align: center;">
                    &nbsp;
                </td>
            </tr>
                   <tr>
                       <td style="width: 1%">
                       </td>
                       <td style="vertical-align: top; width: 99%; text-align: center">
                                            </td>
                   </tr>
            
            </table>
               
               &nbsp;</td>
        </tr>
       
        <tr>
            <td style="font-family: Tahoma; font-size: 13px; vertical-align: top; text-align: center; background-color: #EEEEEE; height: 45px;">
                <div id="copyinfo" style="padding: 10px 0pt 20px; background-color: #acbd29; text-transform: uppercase; color: white; font-weight: bold; font-family: 'Courier New';">� 2012, PEGASUS TECHNOLOGIES</div>
                </td>
        </tr>       
    </table>
        <br />
        &nbsp;

    </form>
</body>
<script language="javascript" type="text/javascript">
//Function to disable Cntrl key/right click
function DisableControlKey(e) {
// Message to display
var message = "Cntrl key/ Right Click Option disabled";
// Condition to check mouse right click / Ctrl key press
if (e.which == 17 || e.button == 2) {
alert(message);
return false;
}
}

    function changeButtonText(button) {

        button.value = "Please Wait...";

    }
</script>
</html>
