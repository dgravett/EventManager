<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EventManagerWebApp._Default" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>



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
        <h1>Event Manager</h1>
        <div>

            <asp:Label ID="LabelUserLevel" runat="server"></asp:Label>

        </div>
        <div id="RepeaterDiv" runat="server">
            Upcoming Events
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:300px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Description:</td><td> <%#Eval("description") %></td></tr>
                            <tr><td>Time:</td><td> <%#Eval("time") %></td></tr>
                            <tr><td>Location:</td><td> <%#Eval("location") %></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div></div>
    </div>

    </asp:Content>
