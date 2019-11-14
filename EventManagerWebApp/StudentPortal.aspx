<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="StudentPortal.aspx.cs" Inherits="EventManagerWebApp.StudentPortal" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

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
        .ModalPopupBG
        {
            background-color: #d0ddf2;
            filter: alpha(opacity=50);
            opacity: 0.7;
        }
        .FormPopup
        {
            min-width:400px;
            min-height:300px;
            background:white;
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
            height:30px;
            width:75px;
            margin-top:10px;
        }
        .textbox {  
            height: 30px;      
            font-size: 16px;  
            width: 175px;  
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

        <asp:Panel ID="PanelForm" runat="server" align="center" style="display:none;">
            <div class="FormPopup">
                <div id="ModalHeader">
                    <br />
                    <br />
                    <h2>Create New RSO</h2>
                </div>

                <div>
                    <table style="width:300px; height:80px">
                        <tr>
                            <td style="width: 50%; margin-left:150px">RSO Name:</td>
                            <td style="width: 50%"><asp:TextBox ID="TextBoxRSOName" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; margin-left:150px">RSO Description:</td>
                            <td style="width: 50%"><asp:TextBox ID="TextBoxRSODescription" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>

                <div>
                    <asp:Button ID="ButtonModalSend" runat="server" Text="Done" UseSubmitBehavior="false" OnClick="ButtonCreateRSO_Click" CssClass="button"/>
                    <asp:Button ID="ButtonModalCancel" runat="server" Text="Cancel" CssClass="button"/>
                </div>
            </div>
        </asp:Panel>

        <asp:Button ID="ButtonModalOpen" runat="server" Text="Create RSO" align="center" Height="40px" Width="149px" CssClass="button"/>

        <ajaxToolkit:ModalPopupExtender ID="ModalForm" runat="server" PopupControlID="PanelForm" TargetControlID="ButtonModalOpen" OkControlID="ButtonModalSend"
        CancelControlID="ButtonModalCancel" BackgroundCssClass="ModalPopupBG"></ajaxToolkit:ModalPopupExtender>

    </div>


    <div>
        <table>
            <tr>
                <td>
                    <h1>Available RSOs</h1>
                </td>
                <td>
                    <h1>Joined RSOs</h1>
                </td>
            </tr>
            <tr>
                <td style="width: 50%"><asp:Repeater ID="RepeaterRSOAvailable" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:580px">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td style="width: 50%">Description:</td><td style="width: 50%"><%#Eval("description") %></td></tr>
                            <tr><td style="width: 50%">Number of Members:</td><td style="width: 50%"><%#Eval("NumMembers") %></td></tr>
                            <tr><td><asp:Button ID="JoinButton" runat="server" Text="Join RSO" UseSubmitBehavior="false" OnClick="ButtonJoin_Click" CommandArgument='<%#Eval("id") %>' CssClass="button" Width="120px"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>

                <td style="width: 50%"><asp:Repeater ID="RepeaterRSOJoined" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:580px">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td style="width: 50%">Description:</td><td style="width: 50%"><%#Eval("description") %></td></tr>
                            <tr><td style="width: 50%">Number of Members:</td><td style="width: 50%"><%#Eval("NumMembers") %></td></tr>
                            <tr><td><asp:Button ID="LeaveButton" runat="server" Text="Leave RSO" UseSubmitBehavior="false" OnClick="ButtonLeave_Click" CommandArgument='<%#Eval("id") %>' CssClass="button" Width="120px"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>
            </tr>
        </table>
    </div>
         

</asp:Content>