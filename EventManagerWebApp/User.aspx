<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="EventManagerWebApp.User" %>

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
            <asp:Label ID="LabelUserName" runat="server" Text="Label"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LabelUserUni" runat="server" Text="Label"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LabelUserLevel" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
     <div id="RepeaterDiv" runat="server" class="rptr" style="height:800px">
            <h1>RSOs Joined
            </h1>
            <div>
            </div>
        </div>
    

</asp:Content>
