<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="SuperAdminPortal.aspx.cs" Inherits="EventManagerWebApp.SuperAdminPortal" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
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
        }
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
        .textbox {  
            height: 30px;      
            font-size: 16px;  
            width: 175px;  
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
    </style>
    <div style="margin-top:20px; font-size: xx-large;">
        <asp:Label ID="lblUserName" runat="server" Text="UserName" Font-Size="XX-Large"></asp:Label>
    </div>
    <div class="jumbotron">
        <div>
            <asp:Label ID="lblUserType" runat="server" Text="UserType"></asp:Label>
        </div>
        <div>
            <asp:Label ID="lblUniversity" runat="server" Text="University"></asp:Label>
        </div>
    </div>

    <div>
        <asp:Panel ID="PanelForm" runat="server" align="center" style="display:none">
            <div class="FormPopup">
                <div id="ModalHeader">
                    <br />
                    <br />
                    <h2>Create New University</h2>
                </div>

                <div>
                    <table style="width:350px; height:150px">
                        <tr>
                            <td style="width: 50%; margin-left:150px">University Name:</td>
                            <td style="width: 50%"><asp:TextBox ID="txtUniversityName" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; margin-left:150px">University Description:</td>
                            <td style="width: 50%"><asp:TextBox ID="txtUniversityDescription" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; margin-left:150px">Location:</td>
                            <td style="width: 50%"><asp:TextBox ID="txtUniversityLocation" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 50%; margin-left:150px">Number of Students:</td>
                            <td style="width: 50%"><asp:TextBox ID="txtMaximumStudents" runat="server" CssClass="textbox"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>

                <div>
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" UseSubmitBehavior="false" OnClick="btnConfirm_Click" CssClass="button"/>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="button" />
                </div>
                <br />
                <br />
                <br />
            </div>
        </asp:Panel>

        <asp:Button ID="btnCreateUniversity" runat="server" Text="Create University" align="center" Height="40px" Width="149px" CssClass="button"/>

        <ajaxToolkit:ModalPopupExtender ID="ModalForm" runat="server" PopupControlID="PanelForm" TargetControlID="btnCreateUniversity" OkControlID="btnConfirm"
        CancelControlID="btnCancel" BackgroundCssClass="ModalPopupBG"></ajaxToolkit:ModalPopupExtender>

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
                <td style="width:50%;"><asp:Repeater ID="rptrPending" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="margin-bottom:5px">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td style="width:50%">Description:</td><td style="width:50%"><%#Eval("description") %></td></tr>
                            <tr><td colspan="2"><asp:Button ID="btnApprove" runat="server" Text="Approve" UseSubmitBehavior="false" OnClick="btnApprove_Click" CommandArgument='<%#Eval("id") %>' CssClass="button" Height="25px"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>

                <td style="width:50%"><asp:Repeater ID="rptrApproved" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="margin-bottom:10px">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td style="width:50%">Description:</td><td style="width:50%"><%#Eval("description") %></td></tr>
                            <tr><td colspan="2"><asp:Button ID="btnRevoke" runat="server" Text="Revoke" UseSubmitBehavior="false" OnClick="btnRevoke_Click" CommandArgument='<%#Eval("id") %>' CssClass="button"  Height="25px"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>
            </tr>
        </table>
    </div>

    </asp:Content>