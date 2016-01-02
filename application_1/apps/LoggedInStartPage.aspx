<%@ Page Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="LoggedInStartPage.aspx.cs" Inherits="Admin" Title="START PAGE" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- Heading Row -->
    <div class="row">

        <!-- /.col-md-8 -->
        <div class="col-md-4">
            <h1>Hi [Username]</h1>
            <p>A Warm Welcome to you from the Pegasus Team.</p>
            <p>Please use the links on your left to navigate!</p>
        </div>
        <div class="col-md-8" >
            <a href="#" class="thumbnail">
                <img class="img-responsive img-rounded" src="Images/StanbicLogo.png" style="width: 700px; height: 192px;" alt=""/>
            </a>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <hr />

    <!-- Call to Action Well -->
    <div class="row">
        <div class="col-lg-12">
            <div class="well text-center">
                Bank OS: A new way of Banking
            </div>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <hr />
</asp:Content>

