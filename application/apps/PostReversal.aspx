<%@ Page Language="C#" MasterPageFile="~/PaymentMaster.master" AutoEventWireup="true" CodeFile="PostReversal.aspx.cs" Inherits="PostReversal" Title="POST REVERSAL" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
 <%@ Register 
 Assembly="AjaxControlToolkit" 
 Namespace="AjaxControlToolkit" 
 TagPrefix="ajaxToolkit" %>
 <%@ Import
  Namespace="System.Threading" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <ajaxToolkit:ToolkitScriptManager runat="Server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ID="ScriptManager1" />
    <asp:MultiView ID="MultiView2" runat="server">
        <asp:View ID="View3" runat="server">
            <table style="width: 90%" align="center">
                <tr>
                    <td class="InterFaceTableLeftRowUp" style="width: 100%; text-align: center">
                        <table align="center" cellpadding="0" cellspacing="0" style="width: 75%">
                            <tr>
                                <td class="InterFaceTableLeftRowUp" style="width: 35%; height: 20px; text-align: center">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tbody>
                                            <tr>
                                                <td class="InterfaceHeaderLabel2" style="height: 18px">
                                                    ENTER RECEIPT No TO REVERSE</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="InterFaceTableRightRow" colspan="2" style="height: 1px; text-align: center">
                                </td>
                            </tr>
                            <tr>
                                <td class="InterFaceTableLeftRowUp" style="width: 35%; text-align: center; height: 20px;">
                                    <asp:TextBox ID="txtreceiptno" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                        Font-Bold="True" Font-Size="Medium" Style="text-align: center" Width="90%"></asp:TextBox></td>
                                <td class="InterFaceTableRightRow" style="width: 20%; text-align: center; height: 20px;">
                                    <asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                            OnClick="Button2_Click" Style="font: menu" Text="IDENTIFY" Width="90%" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <hr />
        </asp:View>
    </asp:MultiView>
    <asp:MultiView ID="MultiView3" runat="server">
        <asp:View ID="View1" runat="server">
            <table align="center" style="width: 90%">
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <table align="center" cellpadding="0" cellspacing="0" class="style12" width="98%">
                            <tr>
                                <td style="vertical-align: top; width: 50%; height: 5px; text-align: left">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tbody>
                                            <tr>
                                                <td class="InterfaceHeaderLabel2" style="height: 18px">
                                                    CUstomer DETAILS</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td style="vertical-align: top; width: 2%; height: 5px; text-align: center">
                                </td>
                                <td style="vertical-align: top; width: 48%; height: 5px; text-align: left">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tbody>
                                            <tr>
                                                <td class="InterfaceHeaderLabel2" style="height: 18px">
                                                    PAYMENT DETAILS</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 4px; text-align: left">
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top; width: 50%; height: 5px; text-align: left">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Receipt No</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtviewReceiptno" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Agent Ref</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtAgentRef" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Account No</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtcode" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Width="75%" ReadOnly="True"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Name</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                                &nbsp;</td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtname" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Width="75%" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Type</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtCustType" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="vertical-align: top; width: 2%; height: 10px; text-align: center">
                                </td>
                                <td style="vertical-align: top; width: 48%; height: 5px; text-align: center">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp" style="width: 30%; height: 20px;">
                                                Pay Mode</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%; height: 20px;">
                                            </td>
                                            <td class="InterFaceTableRightRow" style="width: 70%; height: 20px;">
                                                <asp:TextBox ID="txtpaymode" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%"></asp:TextBox>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Pay Type</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                                &nbsp;</td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtpaytype" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%"></asp:TextBox>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Amount</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtAmount" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Font-Bold="True" Width="75%" ReadOnly="True"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Pay Date</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtpaydate" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Font-Bold="True" Width="75%" ReadOnly="True"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Cashier</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtcashier" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Font-Bold="True" Width="75%" ReadOnly="True"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 5px; text-align: center">
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                            OnClick="Button1_Click" Style="font: menu" Text="POST REVERSAL" Width="150px" /></td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <hr />
                    </td>
                </tr>
            </table>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <table align="center" style="width: 90%">
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <table align="center" cellpadding="0" cellspacing="0" class="style12" width="85%">
                            <tr>
                                <td class="InterfaceHeaderLabel2" colspan="3" style="vertical-align: top; height: 5px;
                                    text-align: center">
                                    REVERSAL CONFIRMATION</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 2px; text-align: center">
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top; width: 50%; height: 5px; text-align: left">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Receipt No</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtconfirmReceiptno" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%" Font-Bold="True"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Amount</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                                &nbsp;</td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtconfirmamount" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    ReadOnly="True" Width="75%" Font-Bold="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="vertical-align: top; width: 2%; height: 10px; text-align: center">
                                </td>
                                <td style="vertical-align: top; width: 48%; height: 5px; text-align: center">
                                    <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Pay Date</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtconfirmpaydate" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Font-Bold="True" ReadOnly="True" Width="75%"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td class="InterFaceTableLeftRowUp">
                                                Cashier</td>
                                            <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                            </td>
                                            <td class="InterFaceTableRightRow">
                                                <asp:TextBox ID="txtconfirmcashier" runat="server" CssClass="InterfaceTextboxLongReadOnly"
                                                    Font-Bold="True" ReadOnly="True" Width="75%"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 5px; text-align: center">
                                </td>
                            </tr>
                            <tr>
                                <td class="InterFaceTableLeftRowUp" colspan="3" style="vertical-align: top; height: 5px;
                                    text-align: center">
                                    ENTER NARATION
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 5px; text-align: center">
                                    <asp:TextBox ID="txtnaration" runat="server" TextMode="MultiLine" Width="395px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="vertical-align: top; height: 1px; text-align: center">
                                </td>
                            </tr>
                        </table>
                        &nbsp;<asp:Button ID="Button4" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                            OnClick="Button4_Click1" Style="font: menu" Text="CONTINUE TO REVERSE" Width="150px" />
                        <asp:Button ID="Button3" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                            OnClick="Button3_Click" Style="font: menu" Text="CANCEL" Width="150px" /></td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <hr />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
    &nbsp; &nbsp; &nbsp;<br />    
 <script type ="text/javascript">
 
 function Comma(Num)
 {
       Num += '';
       Num = Num.replace(',' , '');Num = Num.replace(',' , '');Num = Num.replace(',' , '');
       Num = Num.replace(',' , '');Num = Num.replace(',' , '');Num = Num.replace(',' , '');
       x = Num.split('.');
       x1 = x[0];
       x2 = x.length > 1 ? '.' + x[1] : '';
       var rgx = /(\d+)(\d{3})/;
       while (rgx.test(x1))
       x1 = x1.replace(rgx, '$1' + ',' + '$2');
       return x1 + x2;
 }    
   </script>

    <asp:Label ID="lblcode" runat="server" Text="0" Visible="False"></asp:Label><br />
    &nbsp;<ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
        TargetControlID="txtreceiptno" ValidChars="0123456789">
    </ajaxToolkit:FilteredTextBoxExtender>
</asp:Content>





