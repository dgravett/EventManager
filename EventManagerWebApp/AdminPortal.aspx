<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPortal.aspx.cs" Inherits="EventManagerWebApp.AdminPortal" %>




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
        .ltMsg{
            color:red;
        }
    </style>


    <h2><%: Title %>Hello You!</h2>
    <h3>Welcome to Admin Portal.</h3>
    <p>Fill out the form below to create an event.</p>
    <div>
        <label>Event Name</label><br/>
        <asp:TextBox ID="eventName" runat ="server" />
    </div>
    <div>
        <label>Description</label><br/>
        <asp:TextBox ID="eventDescription" runat ="server" />
    </div>
    <div>
        <label>Location</label><br/>
        <asp:TextBox ID="eventLocation" runat ="server" />
    </div>
    <div>
        <label>Event Date</label><br/>
        <asp:Calendar ID="eventDate" runat="server"></asp:Calendar>
    </div>
    
    <div>
        <label>Contact Number</label><br/>
        <asp:TextBox ID="eventNumber" runat ="server" />
    </div>
    <div>
        <label>Contact Email</label><br/>
        <asp:TextBox ID="eventEmail" runat ="server" />
    </div>

    <div><br/>
        <label>Event Type</label><br />
        <asp:DropDownList ID="ddlType" runat="server">
            <asp:ListItem Text="Public" Value="Public" />
            <asp:ListItem Text="Private" Value="Private" />
            <asp:ListItem Text="RSO" Value="RSO" />
        </asp:DropDownList>
    </div>
    <div><br/>
        <label>RSO</label><br />
        <asp:DropDownList ID="DropDownList1" runat="server">

        </asp:DropDownList>
    </div>
    <div><br/>
        <asp:Button ID="createEvent" runat="server" Text="Create Event" OnClick ="createEvent_Click"/>
    </div>


    <div class="ltMsg">
        <asp:Literal ID="ltMessage"  runat="server" />
    </div>

    <br />
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
    

</asp:Content>