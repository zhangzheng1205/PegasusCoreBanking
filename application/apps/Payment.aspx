<%@ Page Language="C#" MasterPageFile="~/PaymentMaster.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="Payment" Title="PAYMENTS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td class="InterFaceTableLeftRowUp" style="width: 100%; text-align: center; text-decoration: underline">
                ACCOUNTANT ROLE</td>
        </tr>
        <tr>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100%; text-align: center">
                <asp:Label ID="lblWelcome" runat="server" Font-Bold="True" Text="."></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 2px">
            </td>
        </tr>
        <tr>
            <td style="width: 100%; height: 2px; text-align: center">
                <asp:Label ID="lblUsage" runat="server" Font-Bold="True" Text="."></asp:Label></td>
        </tr>
        <hr />
    </table>
</asp:Content>

