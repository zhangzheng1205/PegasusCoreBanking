<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Statement.aspx.cs" Inherits="Statement" %>

<%@ Import Namespace="InterLinkClass.CoreBankingApi" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!DOCTYPE html>
<html lang="en">

<head id="Head1" runat="server">

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>BANK_OS</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <%--<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw==" crossorigin="anonymous">--%>

    <!-- Custom CSS -->
    <link href="css/PutCustomCssHere.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet" />

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

</head>

<body style="font-size: 12px;">
    <form runat="server">
        <div class="container" style="padding: 10px;">

            <%-- Print Button --%>
            <div class="row" style="padding: 10px;">
                <div class="text-center">
                    <input id="Button3" accesskey="P" class="btn btn-success" onclick="window.print();"
                        value="Print Statement" />
                    <asp:Button ID="btnReturn" Text="Return" runat="server" CssClass="btn btn-primary" OnClick="btnReturn_Click" />
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

            <%-- Header Section --%>
            <div class="row" style="padding: 15px; border: 1px solid gray;">
                <%-- company logo --%>
                <div class="col-lg-4" style="padding-left: 10px;">
                    <img class="img-responsive img-thumbnail" alt="" src="Images\<% Bank bank = (Bank)Session["UsersBank"]; Response.Write(bank.BankCode + @"\" + bank.PathToLogoImage); %>" style="height: 250px; width: 350px; border: 1px solid gray;" />
                </div>

                <%-- printing details --%>
                <div class="col-lg-8" style="vertical-align: bottom">
                    <h1>
                        <asp:Label ID="lblTitle" runat="server">TESTBANK Statement</asp:Label>

                    </h1>
                    <h4>
                        <asp:Label ID="lblPrintedBy" runat="server">Printed By: Nsubuga Kasozi</asp:Label>

                    </h4>
                    <h4>
                        <asp:Label ID="lblUserId" runat="server">Printed By: Nsubuga Kasozi</asp:Label>
                    </h4>
                    <h4>
                        <asp:Label ID="lblRole" runat="server">Role:       Teller</asp:Label>
                    </h4>
                    <h4>Printed On: <%Response.Write(DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")); %>

                    </h4>
                    <h4>
                        <asp:Label ID="lblBranchName" runat="server">BranchName: TestBranch</asp:Label>
                    </h4>
                </div>
            </div>

            <%-- title section --%>
            <div class="row" style="padding: 15px; border: 1px solid gray; border-top: none;">
                <div class="text-center">
                    <h4><asp:Label ID="lblHeading" runat="server"></asp:Label></h4>
                </div>
            </div>

            <%-- data set section --%>
            <div class="row" style="padding: 15px; border: 1px solid gray; border-top: none;">
                <div class="table-responsive">
                    <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults">
                        <HeaderStyle BackColor="#115E9B" Font-Bold="false" ForeColor="white" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Height="30px" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
