<%@ Page Title="Signup Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="EventManagerWebApp.SignupPage" %>

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
        }
        .textbox {  
            height: 30px;      
            font-size: 18px;  
            width: 300px;  
        }
        .dropDownList {
            width: 300px;
            height: 30px;
        }
    </style>
    <h1>Signup</h1>
    <div class="jumbotron">
        <div style="width: 600px;">
            
            <table style="width: 76%;">
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                        </td>
                    <td style="width: 80px; height: 50px;">
                        <asp:Textbox ID="txtUsername" runat="server" CssClass="textbox"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                        </td>
                    <td style="width: 80px; height: 50px;">
                        <asp:Textbox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px">
                        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                    </td>
                    <td style="width: 80px; height: 50px">
                        <asp:Textbox ID="txtEmail" runat="server" CssClass="textbox"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblUniversity" runat="server" Text="University:"></asp:Label>
                    </td>
                    <td style="width: 83px; height: 50px;">
                        <asp:DropDownList ID="ddlUniversity" runat="server" DataTextField="name" DataValueField="id" CssClass="dropDownList"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px">

                    </td>
                    <td style="width: 80px; height: 50px">
                        <asp:Button ID="btnSignup" runat="server" Text="Signup" OnClick="btnSignup_Click" CssClass="button"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
