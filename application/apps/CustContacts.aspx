<%@ Page Language="C#" MasterPageFile="~/ReportMaster.master" AutoEventWireup="true" CodeFile="CustContacts.aspx.cs" Inherits="CustContacts" Title="CUSTOMER CONTACTS" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register 
 Assembly="AjaxControlToolkit" 
 Namespace="AjaxControlToolkit" 
 TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 98%; height: 2px">
                <table align="center" cellpadding="0" cellspacing="0" style="width: 50%">
                    <tr>
                        <td class="InterfaceHeaderLabel">
                            CUSTOMER contacts FILE</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 98%; height: 1px">
            </td>
        </tr>
        <tr>
            <td style="width: 98%; height: 5px">
                <table align="center" cellpadding="0" cellspacing="0" style="width: 98%; border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid; border-bottom: #617da6 1px solid;">
                    <tr>
                        <td class="InterfaceHeaderLabel2" style="vertical-align: middle; width: 20%; height: 18px;
                            text-align: center">
                            Phone No.</td>
                        <td class="InterfaceHeaderLabel2" style="vertical-align: middle; width: 20%; height: 18px;
                            text-align: center">
                            ACCOUNT No</td>
                        <td class="InterfaceHeaderLabel2" colspan="3" style="vertical-align: middle; width: 20%;
                            height: 18px; text-align: center">
                            From date</td>
                        <td class="InterfaceHeaderLabel2" colspan="1" style="vertical-align: middle; width: 20%;
                            height: 18px; text-align: center">
                            To date</td>
                        <td class="InterfaceHeaderLabel2" colspan="1" style="vertical-align: middle; width: 20%;
                            height: 18px; text-align: center">
                        </td>
                    </tr>
                    <tr>
                        <td class="ddcolortabsline2" colspan="1" style="vertical-align: middle; height: 1px;
                            text-align: center">
                        </td>
                        <td class="ddcolortabsline2" colspan="1" style="vertical-align: middle; height: 1px;
                            text-align: center">
                        </td>
                        <td class="ddcolortabsline2" colspan="3" style="vertical-align: middle; text-align: center; height: 1px;">
                        </td>
                        <td class="ddcolortabsline2" colspan="1" style="vertical-align: middle; height: 1px;
                            text-align: center">
                        </td>
                        <td class="ddcolortabsline2" colspan="1" style="vertical-align: middle; height: 1px;
                            text-align: center">
                        </td>
                    </tr>
                    <tr>
                        <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            width: 20%; border-top-color: #617da6; height: 23px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                            <asp:TextBox ID="txtPhone" runat="server" Style="font: menu" Width="90%"></asp:TextBox></td>
                        <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            width: 20%; border-top-color: #617da6; height: 23px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                            <asp:TextBox ID="txtaccountno" runat="server" Style="font: menu" Width="90%"></asp:TextBox></td>
                        <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            width: 20%; border-top-color: #617da6; height: 23px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                            <asp:TextBox ID="txtfromdate" runat="server" Style="font: menu" Width="90%"></asp:TextBox>&nbsp;</td>
                        <td colspan="1" style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            width: 20%; border-top-color: #617da6; height: 23px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                            <asp:TextBox ID="txttodate" runat="server" Style="font: menu" Width="90%"></asp:TextBox></td>
                        <td colspan="1" style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            width: 20%; border-top-color: #617da6; height: 23px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                            <asp:Button ID="btnOK" runat="server" Font-Size="9pt" Height="23px" OnClick="btnOK_Click"
                                Text="Search" Width="85px" style="font: menu" /></td>
                    </tr>
                    <tr>
                        <td colspan="7" style="border-top-width: 1px; border-left-width: 1px; border-left-color: #617da6;
                            border-bottom-width: 1px; border-bottom-color: #617da6; vertical-align: middle;
                            border-top-color: #617da6; height: 1px; text-align: center; border-right-width: 1px;
                            border-right-color: #617da6">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 98%; height: 1px">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                        <table align="center" style="border-right: #617da6 1px solid; border-top: #617da6 1px solid;
                            border-left: #617da6 1px solid; width: 50%; border-bottom: #617da6 1px solid">
                            <tr>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 100px; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="rdPdf" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="PDF" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 100px; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="rdExcel" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="EXCEL" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 100px; border-bottom: #617da6 1px solid">
                                    <asp:Button ID="btnConvert" runat="server" Font-Size="9pt" Height="23px" OnClick="btnConvert_Click"
                                        Style="font: menu" Text="Convert" Width="85px" /></td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView></td>
        </tr>
        <tr>
            <td style="width: 98%; height: 1px;">
            <hr />
            </td>
        </tr>
        <tr>
            <td style="width: 98%; height: 2px">
                <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False"
                    CellPadding="4" ForeColor="#333333" GridLines="Horizontal" OnItemCommand="DataGrid1_ItemCommand"
                    OnPageIndexChanged="DataGrid1_PageIndexChanged" Width="100%" style="text-align: justify; font: menu; border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid; border-bottom: #617da6 1px solid; width: 100%;" Font-Bold="False" Font-Italic="False" Font-Names="Courier New" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Justify" AllowPaging="True">
                    <FooterStyle BackColor="InactiveCaption" Font-Bold="False" ForeColor="White" />
                    <EditItemStyle BackColor="#999999" />
                    <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#003366" ForeColor="White" HorizontalAlign="Center" Mode="NumericPages" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                    <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                    <ItemStyle BackColor="InactiveCaption" ForeColor="#333333" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                    <Columns>
                        <asp:BoundColumn DataField="No." HeaderText="No.">
                            <HeaderStyle Width="5%" />
                            <ItemStyle Width="5%" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="CustomerRef" HeaderText="Account">
                            <HeaderStyle Width="20%" />
                            <ItemStyle Width="10%" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Phone" HeaderText="Phone">
                            <HeaderStyle Width="20%" />
                            <ItemStyle Width="10%" />
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="Name" HeaderText="Name">
                            <HeaderStyle Width="55%" />
                            <ItemStyle Width="20%" />
                        </asp:BoundColumn>
                    </Columns>
                    
                    <HeaderStyle BackColor="#FEFECE" Font-Bold="True" ForeColor="Black" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                </asp:DataGrid></td>
        </tr>
    </table>
    <br />
    <ajaxToolkit:ToolkitScriptManager id="ScriptManager1" runat="Server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true">
    </ajaxToolkit:ToolkitScriptManager>
    &nbsp;<ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
        TargetControlID="txtaccountno" ValidChars="0123456789">
    </ajaxToolkit:FilteredTextBoxExtender>
    &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
        TargetControlID="txtPhone" ValidChars="0123456789">
    </ajaxToolkit:FilteredTextBoxExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" CssClass="MyCalendar"
        Format="dd MMMM yyyy" PopupPosition="TopLeft" TargetControlID="txttoDate">
    </ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" CssClass="MyCalendar"
        Format="dd MMMM yyyy" PopupPosition="TopLeft" TargetControlID="txtfromDate">
    </ajaxToolkit:CalendarExtender>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        Visible="False" />
    <br />
</asp:Content>

