<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="Receipt" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PAYMENT RECEIPT</title>
    <link href="scripts/WQC_stylesheet.css" rel="stylesheet" type="text/css" />
    <link href="scripts/globalscape.css" rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet" />

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 2px;
        }
    </style>
</head>
<body style="width: 70%;">
    <form id="form1" runat="server">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <asp:Label ID="lblmsg" runat="server" Font-Bold="False" Font-Names="Arial Narrow"
                ForeColor="Red" Style="font: menu" Text="."></asp:Label><br />
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View2" runat="server">
                    <div class="text-center">
                        <table class="text-center" style="width: 70%;padding-left:10px;">
                            <tr>
                                <td style="text-align: center" class="auto-style1">
                                    <input id="Button3" accesskey="P" class="btn btn-success btn-lg" onclick="window.print();" size="20"
                                        value="Print Receipt" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 50px; text-align: center"></td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 150px; text-align: center">
                                    <table align="center" cellpadding="0" cellspacing="0" class="style12" style="border-right: #617da6 2px double; border-top: #617da6 2px double; border-left: #617da6 2px double; border-bottom: #617da6 2px double; height: 25px;">
                                        <tr>
                                            <td colspan="1" style="vertical-align: top; height: 5px; text-align: right">
                                                <img alt="" width="200" class="thumbnail" height="150" src="" id="logo1" runat="server" />
                                            </td>
                                            <td colspan="1" style="text-align: center;padding-right:100px;">
                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="X-Large" Text="UMEME LIMITTED">
                                                </asp:Label>
                                            </td>
                                            <td colspan="1" style="vertical-align: top; height: 5px; padding-left:100px">
                                                <img alt="" width="200" class="thumbnail" height="150" src="" id="logo2" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="vertical-align: top; height: 5px; text-align: center"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="vertical-align: top; height: 5px; text-align: center">
                                                <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Text="."></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="vertical-align: top; height: 2px; text-align: center"></td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align: top; width: 50%; height: 5px; text-align: left">
                                                <table align="center" cellpadding="10"  cellspacing="0" style="width: 90%;padding-left:20px;">
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Reciept No</td>
                                                        <td style="width: 2%; height: 20px;"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblRecieptno" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Bank Ref</td>
                                                        <td style="width: 2%"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblAgentRef" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Account No</td>
                                                        <td style="width: 2%">&nbsp;</td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblAccountRef" runat="server" Text="Label" Font-Size="Medium"></asp:Label>&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; height: 20px; text-align: justify; font-weight: bold; font-family: 'Courier New';">Customer Name</td>
                                                        <td style="width: 2%; height: 20px"></td>
                                                        <td style="width: 65%; height: 45px; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblCustname" runat="server" Text="Label"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Cashier</td>
                                                        <td style="width: 2%; height: 20px"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblcashier" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Payment Date</td>
                                                        <td style="width: 2%; height: 20px"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblPayDate" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="vertical-align: top; width: 2%; height: 10px; text-align: center"></td>
                                            <td style="vertical-align: top; width: 48%; height: 5px; text-align: center">
                                                <table align="center" cellpadding="0" cellspacing="0" style="width: 98%">
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">BankCode</td>
                                                        <td style="width: 2%"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblBankCode" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Amount Paid</td>
                                                        <td style="width: 2%">&nbsp;</td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblamount" runat="server" Text="Label" Font-Size="Medium"></asp:Label>&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Currency</td>
                                                        <td style="width: 2%">&nbsp;</td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblCurrency" runat="server" Text="Label" Font-Size="Medium"></asp:Label>&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-weight: bold; width: 35%; font-family: 'Courier New'; text-align: justify">Transaction Category</td>
                                                        <td style="width: 2%"></td>
                                                        <td style="font-weight: bold; width: 65%; font-family: 'Courier New'; text-align: justify">
                                                            <asp:Label ID="lblTranCategory" runat="server" Text="Label" Font-Size="Medium"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 35%; text-align: justify; font-weight: bold; font-family: 'Courier New';">Branch Code</td>
                                                        <td style="width: 2%"></td>
                                                        <td style="width: 65%; font-weight: bold; font-family: 'Courier New'; text-align: justify;">
                                                            <asp:Label ID="lblBranchCode" runat="server" Font-Size="Medium" Text="Label"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="height: 10px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-weight: bold; width: 35%; font-family: 'Courier New'; text-align: justify">Signiture</td>
                                                        <td style="width: 2%"></td>
                                                        <td style="font-weight: bold; width: 65%; font-family: 'Courier New'; text-align: justify">&nbsp;.................</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="vertical-align: top; height: 5px; text-align: center"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="vertical-align: top; height: 5px; text-align: center"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 50px; text-align: center"></td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 2px; text-align: center">
                                    <asp:Button ID="Button4" runat="server" class="btn-primary"
                                        OnClick="Button4_Click" Style="font: menu" Text="RETURN" Width="150px" /></td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 2px; text-align: center">
                                    <hr />
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lblcode" runat="server" Text="." Visible="False" Width="16px"></asp:Label><asp:Label ID="lblvendorcode"
                            runat="server" Text="." Visible="False"></asp:Label>
                    </div>
                </asp:View>
                <asp:View ID="View1" runat="server">
                    <table align="center" style="width: 90%">
                        <tr>
                            <td style="width: 100%; height: 2px; text-align: center">
                                <asp:Button ID="Button2" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                    OnClick="Button2_Click" Style="font: menu" Text="PRINT RECEIPT" Width="150px" /></td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 1px; text-align: center"></td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 10px; text-align: center">
                                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                                    BorderStyle="Solid" Style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 1px; text-align: center"></td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 2px; text-align: center">
                                <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="9pt" Height="23px"
                                    OnClick="Button4_Click" Style="font: menu" Text="RETURN" Width="150px" /></td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 2px; text-align: center">
                                <hr />
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="Label13" runat="server" Text="." Visible="False" Width="16px"></asp:Label><asp:Label
                        ID="Label14" runat="server" Text="." Visible="False"></asp:Label>
                </asp:View>
            </asp:MultiView>&nbsp;
        </div>
        <div class="col-lg-2"></div>
    </form>
</body>
</html>
