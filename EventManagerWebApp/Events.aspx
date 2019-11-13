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
            width: 50%;
        }
        .button{
            border: 0.1em #333336 solid;
            border-radius: 0.2em;
            text-decoration: none;
            color: black;
            padding: 0.5em 1em;
            background-color: #f3f3f3;
            vertical-align:middle;
            line-height:5px;
        }
        .dropDownList{
            width: 500px;
            height: 30px;
            align-items: center;
        }
        .checkBox{
            margin-right: 5px;
        }
        .textBox{
            margin-left: 5px;
            height: 30px;
        }
    </style>
    <h1>Upcoming Events</h1>
    <div class="jumbotron">
        <div style="margin-left:10px; margin-right:10px;">
            <asp:Label ID="LabelFilter" runat="server" Text="Filter:"></asp:Label>
            <asp:TextBox ID="TextBoxFilter" runat="server" CssClass="textBox"></asp:TextBox>    
        <div style="width: 400px;">
            <asp:DropDownList ID="DropDownList" runat="server" DataTextField="name" DataValueField="id" CssClass="dropDownList"></asp:DropDownList>
        </div>
        <div>
            <asp:CheckBox ID="CheckBoxPrivate" runat="server" Text="Private" CssClass="checkBox"/>
            <asp:CheckBox ID="CheckBoxPublic" runat="server" Text="Public" CssClass="checkBox"/>
            <asp:CheckBox ID="CheckBoxRSO" runat="server" Text="RSO" CssClass="checkBox"/>  
            <asp:Button ID="ButtonFilter" runat="server" Text="Filter" OnClick="ButtonFilter_Click" CssClass="button" Height="25px" Font-Size="Medium"/>
        </div>
        </div>
        <div id="RepeaterDiv" runat="server">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:325px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Time:</td><td> <%#Eval("time") %></td></tr>
                            <tr><td>Type:</td><td> <%#Eval("EventType") %></td></tr>
                            <tr><td colspan="2"><asp:Button ID="ButtonViewEvent" runat="server" Text="View Event" UseSubmitBehavior="false" OnClick="ButtonViewEvent_Click" CommandArgument='<%#Eval("id") %>' CssClass="button" Height="25px" Font-Size="Medium"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

