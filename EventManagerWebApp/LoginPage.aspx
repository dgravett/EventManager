<%@ Page Title="Login Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="EventManagerWebApp.LoginPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .button{
            border: 0.1em #333336 solid;
            border-radius: 0.2em;
            text-decoration: none;
            color: black;
            padding: 0.5em 1em;
            background-color: #f3f3f3;
            vertical-align:middle;
            line-height:5px;
            height:30px;
            margin-left: 20px;
        }
        .textbox {  
            height: 30px;      
            font-size: 18px;  
            width: 300px;  
            margin-left: 20px;
        }
    </style>
    <h1>Login</h1>
    <div class="jumbotron">
        <div style="width: 600px;">
            <table style="width: 76%;">
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                    </td>
                    <td style="width: 80px; height: 50px;">
                        <asp:Textbox ID="txtUsername" runat="server" CssClass="textbox"/></td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                    </td>
                    <td style="width: 80px; height: 50px;">
                        <asp:Textbox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox"/></td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px;">
                    <td>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"  CssClass="button"/>
                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                    <td style="width: 80px; height: 50px;">
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
