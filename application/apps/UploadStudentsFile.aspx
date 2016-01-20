<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="UploadStudentsFile.aspx.cs"
    Inherits="UploadStudentsFile" Title="CUSTOMER FILE UPLOAD" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Import Namespace="System.Threading" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ID="ScriptManager1" />
    <table cellpadding="0" cellspacing="0" class="style12" style="width: 90%">
        <tr>
            <td style="text-align: center; vertical-align: middle; height: 41px;">
                <table align="center" cellpadding="0" cellspacing="0" style="width: 50%">
                    <tr>
                        <td class="InterfaceHeaderLabel" style="height: 20px">
                            CUSTOMER/STUDENTS FILE UPLOAD</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" class="style12">
        <tr>
            <td style="width: 100%">
            </td>
        </tr>
    </table>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <strong>
                <table align="center" style="width: 90%">
                    <tr>
                        <td style="width: 100%; height: 2px; text-align: center">
                            <table align="center" cellpadding="0" cellspacing="0" class="style12" width="92%">
                                <tr>
                                    <td style="vertical-align: top; width: 50%; height: 5px; text-align: left">
                                        <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                            <tbody>
                                                <tr>
                                                    <td class="InterfaceHeaderLabel2" style="height: 18px">
                                                        SCHOOL CODE</td>
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
                                        FILE To process: SHOULD BE EXCEL FILE WITH COLUMNS<br />
                                                        NAME, UNIQUE ID(OPTIONAL), BALANCE(OPYIONAL)</td>
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
                                                    Select</td>
                                                <td class="InterFaceTableMiddleRowUp" style="width: 2%">
                                                </td>
                                                <td class="InterFaceTableRightRow">
                                                    <asp:DropDownList ID="cboUtility" runat="server" CssClass="InterfaceDropdownList"
                                                         Style="font: menu" Width="95%">
                                                    </asp:DropDownList></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="vertical-align: top; width: 2%; height: 10px; text-align: center">
                                    </td>
                                    <td style="vertical-align: top; width: 48%; height: 5px; text-align: left">
                                        <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                            <tr>
                                                <td class="InterFaceTableLeftRowUp">
                                                    Customer File</td>
                                                <td class="InterFaceTableMiddleRowUp">
                                                </td>
                                                <td class="InterFaceTableRightRow">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" /></td>
                                            </tr>
                                        </table>
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                Use this form to upload a file containing all the customers/students of your
                bussiness/School</strong>
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           
                <%--<table>
            <tr>
                <td style="width: 100%; text-align: center; height: 30px;" class="InterFaceTableLeftRowUp">--%>
                    <asp:Button ID="btnUpload" runat="server" Font-Size="9pt" Height="23px" Text="UPLOAD"
                        Width="200px" Font-Bold="True" OnClick="btnUpload_Click" Style="font: menu" />
                        <%--</td>
            </tr>
            </table>--%>
        </asp:View>
        &nbsp;&nbsp;
        <asp:View ID="View2" runat="server">
            <table style="width: 90%" align="center">
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <table align="center" style="border-right: #617da6 1px solid; border-top: #617da6 1px solid;
                            border-left: #617da6 1px solid; width: 70%; border-bottom: #617da6 1px solid">
                            <tr>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 20%; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="rdPdf" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="PDF" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 20%; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="rdExcel" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="EXCEL" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 30%; border-bottom: #617da6 1px solid">
                                    <asp:Button ID="Button3" runat="server" Font-Size="9pt" Height="23px" Text="CONVERT "
                                        Width="150px" Font-Bold="True" Style="font: menu" OnClick="Button3_Click" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 30%; border-bottom: #617da6 1px solid">
                                    <asp:Button ID="Button2" runat="server" Font-Size="9pt" Height="23px" Text="RETURN"
                                        Width="150px" Font-Bold="True" Style="font: menu" OnClick="Button2_Click" /></td>
                            </tr>
                        </table>
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 1px; text-align: center">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center; height: 2px;">
                        <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            Font-Bold="False" Font-Italic="False" Font-Names="Courier New" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" GridLines="Horizontal"
                            HorizontalAlign="Justify" PageSize="50" Style="border-right: #617da6 1px solid;
                            border-top: #617da6 1px solid; font: menu; border-left: #617da6 1px solid; width: 100%;
                            border-bottom: #617da6 1px solid; text-align: justify" Width="100%">
                            <FooterStyle BackColor="InactiveCaption" Font-Bold="False" ForeColor="White" />
                            <EditItemStyle BackColor="#999999" />
                            <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#003366" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center"
                                Mode="NumericPages" />
                            <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                            <ItemStyle BackColor="InactiveCaption" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundColumn DataField="No." HeaderText="No.">
                                    <HeaderStyle Width="5%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VendorRef" HeaderText="Agent Ref">
                                    <HeaderStyle Width="20%" />
                                    <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="PayDate" HeaderText="Pay Date">
                                    <HeaderStyle Width="15%" />
                                    <ItemStyle Width="120px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="TransactionAmount" HeaderText="Amount">
                                    <HeaderStyle Width="15%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Reason" HeaderText="Reason">
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Justify" Width="35%" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Justify" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="#FEFECE" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="Black" />
                        </asp:DataGrid></td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center; height: 30px;" class="InterFaceTableLeftRowUp">
                        <asp:Button ID="Button4" runat="server" Font-Size="9pt" Height="23px" Text="CONVERT TO PDF"
                            Width="150px" Font-Bold="True" Style="font: menu" />
                        <asp:Button ID="Button1" runat="server" Font-Size="9pt" Height="23px" Text="RETURN"
                            Width="150px" Font-Bold="True" Style="font: menu" /></td>
                </tr>
            </table>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <table style="width: 90%" align="center">
                <tr>
                    <td style="width: 100%; height: 2px; text-align: center">
                        <table align="center" style="border-right: #617da6 1px solid; border-top: #617da6 1px solid;
                            border-left: #617da6 1px solid; width: 70%; border-bottom: #617da6 1px solid">
                            <tr>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 20%; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="RadioButton1" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="PDF" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 20%; border-bottom: #617da6 1px solid">
                                    <asp:RadioButton ID="RadioButton2" runat="server" Font-Bold="True" GroupName="FileFormat"
                                        Text="EXCEL" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 30%; border-bottom: #617da6 1px solid">
                                    <asp:Button ID="Button5" runat="server" Font-Size="9pt" Height="23px" Text="CONVERT "
                                        Width="150px" Font-Bold="True" Style="font: menu" OnClick="Button5_Click" /></td>
                                <td style="border-right: #617da6 1px solid; border-top: #617da6 1px solid; border-left: #617da6 1px solid;
                                    width: 30%; border-bottom: #617da6 1px solid">
                                    <asp:Button ID="Button6" runat="server" Font-Size="9pt" Height="23px" Text="RETURN"
                                        Width="150px" Font-Bold="True" Style="font: menu" OnClick="Button6_Click" /></td>
                            </tr>
                        </table>
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; height: 1px; text-align: center">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center; height: 2px;">
                        <asp:DataGrid ID="DataGrid2" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            Font-Bold="False" Font-Italic="False" Font-Names="Courier New" Font-Overline="False"
                            Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" GridLines="Horizontal"
                            HorizontalAlign="Justify" PageSize="50" Style="border-right: #617da6 1px solid;
                            border-top: #617da6 1px solid; font: menu; border-left: #617da6 1px solid; width: 100%;
                            border-bottom: #617da6 1px solid; text-align: justify" Width="100%">
                            <FooterStyle BackColor="InactiveCaption" Font-Bold="False" ForeColor="White" />
                            <EditItemStyle BackColor="#999999" />
                            <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#003366" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="White" HorizontalAlign="Center"
                                Mode="NumericPages" />
                            <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                            <ItemStyle BackColor="InactiveCaption" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundColumn DataField="No." HeaderText="No.">
                                    <HeaderStyle Width="5%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VendorRef" HeaderText="Agent Ref">
                                    <HeaderStyle Width="20%" />
                                    <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="PayDate" HeaderText="Pay Date">
                                    <HeaderStyle Width="15%" />
                                    <ItemStyle Width="120px" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="TransactionAmount" HeaderText="Amount">
                                    <HeaderStyle Width="15%" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Reason" HeaderText="Reason">
                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Justify" Width="35%" />
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Justify" />
                                </asp:BoundColumn>
                            </Columns>
                            <HeaderStyle BackColor="#FEFECE" Font-Bold="True" Font-Italic="False" Font-Overline="False"
                                Font-Strikeout="False" Font-Underline="False" ForeColor="Black" />
                        </asp:DataGrid></td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center; height: 30px;" class="InterFaceTableLeftRowUp">
                        <asp:Button ID="Button7" runat="server" Font-Size="9pt" Height="23px" Text="CONVERT TO PDF"
                            Width="150px" Font-Bold="True" Style="font: menu" />
                        <asp:Button ID="Button8" runat="server" Font-Size="9pt" Height="23px" Text="RETURN"
                            Width="150px" Font-Bold="True" Style="font: menu" /></td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
    <asp:Label ID="lblCode" runat="server" Text="0" Visible="False"></asp:Label><br />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        Visible="False" />
</asp:Content>
