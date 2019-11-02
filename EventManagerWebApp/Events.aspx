<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Events.aspx.cs" Inherits="EventManagerWebApp.Events" %>

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
            background: #f90;
            color: #fff;
            padding: 8px 10px;
            text-align: left;
        }
        .rptr table td
        {
            padding: 5px 10px;
        }
    </style>
    <div class="jumbotron">
        <div id="RepeaterDiv" runat="server">
            <h1>Upcoming Events</h1>
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:300px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Time:</td><td> <%#Eval("time") %></td></tr>
                            <tr><td>Type:</td><td> <%#Eval("EventType") %></td></tr>
                            <tr><td colspan="2"><asp:Button ID="ButtonViewEvent" runat="server" Text="View Event" UseSubmitBehavior="false" OnClick="ButtonViewEvent_Click" CommandArgument='<%#Eval("id") %>'/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

