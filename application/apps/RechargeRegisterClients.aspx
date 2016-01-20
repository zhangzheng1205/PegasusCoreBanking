<%@ Page Language="C#" MasterPageFile="~/Recharge.master" AutoEventWireup="true" CodeFile="RechargeRegisterClients.aspx.cs" Inherits="RechargeRegisterClients" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <span style="text-decoration: underline"><strong>REGISTER CLIENTS</strong></span><br /><br />
    <table style="width: 90%; margin-left:5%; margin-right:5%">
        <tr>
            <td>
            </td>
            <td style="width:25%">
            </td>
            <td style="width:25%">
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                First Name</td>
            <td style="width:25%">
                <asp:TextBox ID="TextBox1" runat="server" Height="22px" Width="229px"></asp:TextBox></td>
            <td style="width:25%">
                Telephone Number</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" Height="22px" Width="229px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="width:25%">
            </td>
            <td style="width:25%">
            </td>
            <td>
            </td>
        </tr>
                <tr>
            <td>
                Last Name</td>
                    <td style="width:25%">
                        <asp:TextBox ID="TextBox5" runat="server" Height="22px" Width="229px"></asp:TextBox></td>
            <td style="width:25%">
                Meter Number</td>
            <td>
                <asp:TextBox ID="TextBox3" runat="server" Height="22px" Width="229px"></asp:TextBox></td>
        </tr>
                <tr>
            <td>
            </td>
                    <td style="width:25%">
                    </td>
            <td style="width:25%">
            </td>
            <td>
            </td>
        </tr>
                <tr>
            <td style="width:25%">
                Gender</td>
                    <td style="width:25%">
                        <asp:TextBox ID="TextBox6" runat="server" Height="22px" Width="229px"></asp:TextBox></td>
            <td style="width: 44px; height: 26px">
                </td>
            <td style="width:25%">
                </td>
        </tr>
                <tr>
            <td>
            </td>
                    <td style="width:25%">
                    </td>
            <td style="width:25%">
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="width: 273px">
            </td>
            <td style="width: 44px">
            </td>
            <td>
                <asp:Button ID="BUTTON" runat="server" Text="Register" Width="155px" /></td>
        </tr>
    </table>
</asp:Content>

