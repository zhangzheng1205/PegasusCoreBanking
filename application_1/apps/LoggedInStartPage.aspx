<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="LoggedInStartPage.aspx.cs" Inherits="Admin" Title="START PAGE" %>
<%@ Import Namespace="InterLinkClass.CoreBankingApi"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <hr />
    <div class="row" style="padding-top:10px">
        <div class="col-md-5">
            <a href="portfolio-item.html">
                <img class="img-responsive img-thumbnail" style="height:300px" src="Images\<% Bank bank = (Bank)Session["UsersBank"]; Response.Write(bank.BankCode+@"\"+bank.PathToLogoImage); %>" alt="">
            </a>
        </div>
        <div class="col-md-7">
            <h3>Hi <asp:Label runat="server" ID="lblUsername">Username</asp:Label></h3>
            <h4>Nice to See you</h4>
            <p>Welcome to Bank OS, The Pegasus Online Banking Platform for Banks. </p>
            <p>For a quick Start, Use the links on your left to Navigate</p>
        </div>
    </div>
    <hr />
    <!-- Page Content -->
    <div class="container">

      
        <div class="row">
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-check"></i>Welcome to Modern Banking</h4>
                    </div>
                    <div class="panel-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                        <a href="#" class="btn btn-default">Learn More</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-gift"></i>Everything Done in The Cloud</h4>
                    </div>
                    <div class="panel-body">
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
                        <a href="#" class="btn btn-default">Learn More</a>
                    </div>
                </div>
            </div>

        </div>
        <!-- /.row -->
    </div>
    <!-- /.container -->





</asp:Content>

