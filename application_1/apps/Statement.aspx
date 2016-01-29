<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Statement.aspx.cs" Inherits="Statement" %>

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

<body style="font-size:9px;">
    <form runat="server">
        <div class="container" style="padding: 10px;">

            <%-- Print Button --%>
            <div class="row" style="padding: 10px;">
                <div class="text-center">
                    <input id="Button3" accesskey="P" class="btn btn-success" onclick="window.print();"
                        value="Print Statement" />
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
                    <img class="img-responsive img-thumbnail" alt="" src="Images/StanbicLogo.png" style="height: 250px; width: 350px; border: 1px solid gray;" />
                </div>

                <%-- printing details --%>
                <div class="col-lg-8" style="vertical-align: bottom">
                    <h1>TESTBANK Statement</h1>
                    <h4>Printed By: Nsubuga Kasozi</h4>
                    <h4>Role:       Teller</h4>
                    <h4>Printed On: 29/01/2016 10:16 a.m</h4>
                    <h4>BranchName: TestBranch</h4>
                </div>
            </div>

            <%-- title section --%>
            <div class="row" style="padding: 15px; border: 1px solid gray; border-top: none;">
                <div class="text-center">
                    <h4>BANK STATEMENT FOR TRANSACTIONS DONE FROM 17/02/1991 to 21/02/1991</h4>
                </div>
            </div>

            <%-- data set section --%>
            <div class="row" style="padding: 15px; border: 1px solid gray; border-top: none;">
                <div class="table-responsive">
                    <asp:GridView runat="server" Width="100%" CssClass="table table-bordered table-hover" ID="dataGridResults">
                        <AlternatingRowStyle BackColor="#BFE4FF" />
                        <HeaderStyle BackColor="#115E9B" Font-Bold="false" ForeColor="white" Font-Italic="False"
                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Height="30px" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
