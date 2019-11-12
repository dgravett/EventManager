<%@ Page Title="Signup Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="EventManagerWebApp.SignupPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Signup</h1>
        <div style="width: 717px; height: 320px;">
            
            <table style="width: 76%; height: 316px;">
                <tr>
                    <td style="width: 83px; height: 46px;">
                        <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                        </td>
                    <td style="width: 80px; height: 46px;">
                        <asp:Textbox ID="txtUsername" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 74px;">
                        <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                        </td>
                    <td style="width: 80px; height: 74px;">
                        <asp:Textbox ID="txtPassword" runat="server" TextMode="Password" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px">
                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td style="width: 80px">
                        <asp:Textbox ID="txtEmail" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px; height: 50px;">
                        <asp:Label ID="lblUniversity" runat="server" Text="University"></asp:Label>
                    </td>
                    <td style="width: 60px; height: 50px;">
                        <asp:DropDownList ID="ddlUniversity" runat="server" DataTextField="name" DataValueField="id" Width="270px" Height="50px"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 83px">

                    </td>
                    <td style="width: 80px">
                        <asp:Button ID="btnSignup" runat="server" Text="Signup" OnClick="btnSignup_Click" />
                    </td>
                </tr>
                </table>
        </div>
    </div>
</asp:Content>
