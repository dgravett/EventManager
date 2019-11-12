<%@ Page Title="Login Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="EventManagerWebApp.LoginPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Login</h1>
    <div class="jumbotron">
        <div>

        <div>
            <table style="width: 97%; height: 143px;">
                <tr>
                    <td style="width: 103px">
                        <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                    </td>
                    <td>
                        <asp:Textbox ID="txtUsername" runat="server" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 103px">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                    </td>
                    <td>
                        <asp:Textbox ID="txtPassword" runat="server" TextMode="Password" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 103px">&nbsp;</td>
                    <td>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>

        </div>
    </div>
</asp:Content>
