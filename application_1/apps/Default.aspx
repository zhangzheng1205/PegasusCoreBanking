<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="Default.aspx.cs"
    Inherits="_Default"
    EnableEventValidation="false"
    Culture="auto"
    UICulture="auto" %>

<<%--%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<%@ Import
    Namespace="System.Threading" %>--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PEGPAY - BANK OS</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />


    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="css/PutCustomCssHere.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet" />

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />



</head>
<body style="background-color:#06283D;">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-md-4 col-md-offset-4">

                <a href="#" class="text-center new-account" style="font-size:large">
                    <asp:Label ID="lblmsg" runat="server">
                            BANK OS: A New way of Banking
                    </asp:Label>
                </a>

                <hr />

                <div class="account-wall">
                    <img id="logoImage" runat="server" class="profile-img" src="Images/PEGASUS/Billing.jpg" alt="" />
                    <form runat="server" action="#" class="form-signin">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" required="true" autofocus="true" />
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="password" class="form-control" placeholder="Password" required="true" />
                        <asp:Button runat="server" Text="Sign in" CssClass="btn btn-lg btn-success btn-block" ID="btnLogin" OnClick="btnLogin_Click"></asp:Button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function DisableButtons() {
            var inputs = document.getElementsByTagName("INPUT");
            for (var i in inputs) {
                if (inputs[i].type == "button" || inputs[i].type == "submit") {
                    inputs[i].disabled = true;
                }
            }
        }
        window.onbeforeunload = DisableButtons;
        </script>
</body>

</html>
