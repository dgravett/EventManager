<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="StudentPortal.aspx.cs" Inherits="EventManagerWebApp.StudentPortal" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server"> 
        <style type="text/css">
        .rptr table
        {
            background: #eee;
            font: 14px seqoe ui;
            border-collapse: collapse;
            width: 100%;
            margin: 5px;
            float: left;
        }
        .rptr table th
        {
            padding: 8px 10px;
            text-align: left;
        }
        .rptr table td
        {
            padding: 5px 10px;
        }
    </style>
    <div style="margin-top:20px">
        <asp:Label ID="LabelHeader" runat="server" Text="Label" Font-Size="XX-Large"></asp:Label>
    </div>
    <div class="jumbotron">
        <div>
            <asp:Label ID="LabelUserLevel" runat="server" Text="Label"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LabelUserUni" runat="server" Text="Label"></asp:Label>
        </div>

    </div>

    <div>
        <table style="width: 100%;">
            <tr>
                <td><h1>Available</h1> <asp:Repeater ID="RepeaterRSOAvailable" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:600px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Description:</td><td><%#Eval("description") %></td></tr>
                            <tr><td><asp:Button ID="JoinButton" runat="server" Text="Join RSO" UseSubmitBehavior="false" OnClick="ButtonJoin_Click" CommandArgument='<%#Eval("id") %>'/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>

                <td><h1>Joined</h1> <asp:Repeater ID="RepeaterRSOJoined" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:600px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Description:</td><td><%#Eval("description") %></td></tr>
                            <tr><td><asp:Button ID="LeaveButton" runat="server" Text="Leave RSO" UseSubmitBehavior="false" OnClick="ButtonLeave_Click" CommandArgument='<%#Eval("id") %>'/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>
            </tr>
        </table>
    </div>
         

</asp:Content>