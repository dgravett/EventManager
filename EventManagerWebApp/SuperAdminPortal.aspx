<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="SuperAdminPortal.aspx.cs" Inherits="EventManagerWebApp.SuperAdminPortal" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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
                                    <asp:Button ID="btnReject" runat="server" Text="Reject" UseSubmitBehavior="false" OnClick="btnReject_Click" CommandArgument='<%#Eval("id") %>'/>
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