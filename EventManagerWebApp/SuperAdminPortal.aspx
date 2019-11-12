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
                    <br />
                    University Name:   
                    <asp:TextBox ID="txtUniversityName" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    University Description:   
                    <asp:TextBox ID="txtUniversityDescription" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    Location:
                    <asp:TextBox ID="txtUniversityLocation" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    Maximum Students:
                    <asp:TextBox ID="txtMaximumStudents" runat="server"></asp:TextBox>
                    <br />
                    <br />
                </div>

                <div>
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" UseSubmitBehavior="false" OnClick="btnConfirm_Click"/>
                    <input id="btnCancel" type="button" value="Cancel" />
                </div>
            </div>
        </asp:Panel>

        <asp:Button ID="btnCreateUniversity" runat="server" Text="Create University" align="center" Height="40px" Width="149px"/>

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
                <td><asp:Repeater ID="rptrPending" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:400px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Description:</td><td><%#Eval("description") %></td></tr>
                            <tr><td><asp:Button ID="btnApprove" runat="server" Text="Approve" UseSubmitBehavior="false" OnClick="btnApprove_Click" CommandArgument='<%#Eval("id") %>'/>
                            </td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>

                <td><asp:Repeater ID="rptrApproved" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:400px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("name") %></th></tr>
                            <tr><td>Description:</td><td><%#Eval("description") %></td></tr>
                            <tr><td><asp:Button ID="btnRevoke" runat="server" Text="Revoke" UseSubmitBehavior="false" OnClick="btnRevoke_Click" CommandArgument='<%#Eval("id") %>'/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater></td>
            </tr>
        </table>
    </div>

    </asp:Content>