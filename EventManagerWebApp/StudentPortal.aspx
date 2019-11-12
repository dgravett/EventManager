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

        <asp:Panel ID="PanelForm" runat="server" align="center" style="display:none">
            <div class="FormPopup">
                <div id="ModalHeader">
                    <br />
                    <br />
                    <h2>Create New RSO</h2>
                </div>

                <div>
                    <br />
                    RSO Name:   
                    <asp:TextBox ID="TextBoxRSOName" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    RSO Description:   
                    <asp:TextBox ID="TextBoxRSODescription" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    <br />
                </div>

                <div>
                    <asp:Button ID="ButtonModalSend" runat="server" Text="Done" UseSubmitBehavior="false" OnClick="ButtonCreateRSO_Click"/>
                    <input id="ButtonModalCancel" type="button" value="Cancel" />
                </div>
            </div>
        </asp:Panel>

        <asp:Button ID="ButtonModalOpen" runat="server" Text="Create RSO" align="center" Height="40px" Width="149px"/>

        <ajaxToolkit:ModalPopupExtender ID="ModalForm" runat="server" PopupControlID="PanelForm" TargetControlID="ButtonModalOpen" OkControlID="ButtonModalSend"
        CancelControlID="ButtonModalCancel" BackgroundCssClass="ModalPopupBG"></ajaxToolkit:ModalPopupExtender>

    </div>


    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <h1>Pending Events</h1>
                </td>
                <td>
                    <h1>Approved Events</h1>
                </td>
            </tr>
            <tr>
                <td><asp:Repeater ID="RepeaterRSOAvailable" runat="server">
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

                <td><asp:Repeater ID="RepeaterRSOJoined" runat="server">
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