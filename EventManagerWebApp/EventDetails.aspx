<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="EventDetails.aspx.cs" Inherits="EventManagerWebApp.EventDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .rptr table
        {
            background: #eee;
            font: 14px seqoe ui;
            width: 100%;
            margin: 5px;
            float: left;
            border:thin;
            border-color:black;
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
        .button{
            border: 0.1em #333336 solid;
            border-radius: 0.2em;
            text-decoration: none;
            color: black;
            padding: 0.5em 1em;
            background-color: #f3f3f3;
            vertical-align:middle;
            line-height:5px;
            height:25px;
        }
    </style>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBmsjtqUy3YtAN1fS-XWHZw1CVVlFjMEaI&callback=initialize"></script>  
    <script>  
        var mapcode;  
        var diag;  
        function initialize() {  
            mapcode = new google.maps.Geocoder();  
            var lnt = new google.maps.LatLng(<%=lat%>, <%=lng%>);  
            var diagChoice = {  
                zoom: 15,  
                center: lnt,  
                diagId: google.maps.MapTypeId.ROADMAP  
            }
            var diag = new google.maps.Map(document.getElementById('map_populate'), diagChoice);  
            var marker = new google.maps.Marker({
                position: lnt,
                map: diag,
                title: '<%=locationName%>'
            });
        }  
    </script>
    <div style="margin-top:20px">
        <asp:Label ID="LabelHeader" runat="server" Text="Label" Font-Size="XX-Large"></asp:Label>
    </div>
    <div class="jumbotron">
        <div>
            <asp:Label ID="LabelDescription" runat="server" Text="Label"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LabelType" runat="server" Text="Label"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LabelTime" runat="server" Text="Label"></asp:Label>
        </div>
        <div id="map_populate" style="width:100%; height:500px; border: 5px solid #5E5454;"></div>
    </div>
    <div id="RepeaterDiv" runat="server" class="rptr" style="height:800px">
            <h1>Comments</h1>
            <div><asp:TextBox ID="TextBoxComment" runat="server" Width="400px" Wrap="true" TextMode="MultiLine" Height="100px"></asp:TextBox></div>
            <div>
                <asp:Button ID="ButtonAddComment" runat="server" Text="Add Comment" OnClick="ButtonAddComment_Click" CssClass="button"/>
                <input id="star1" runat="server" name="rating_star" type="radio" class="rating_star" value="1" />
                <input id="star2" runat="server" name="rating_star" type="radio" class="rating_star" value="2" />
                <input id="star3" runat="server" name="rating_star" type="radio" class="rating_star" value="3" />
                <input id="star4" runat="server" name="rating_star" type="radio" class="rating_star" value="4" />
                <input id="star5" runat="server" name="rating_star" type="radio" class="rating_star" value="5" />
            </div>
        <span id="rating"></span>
            <asp:Repeater ID="RepeaterComments" runat="server">
                <ItemTemplate>
                    <div class="rptr" style="width:700px;">
                        <table>
                            <tr><th colspan="2"><%#Eval("commentText") %></th></tr>
                            <tr><td>Rating:</td><td><%#Eval("rating") %> Stars</td></tr>
                            <tr><td><%#Eval("userName") %></td><td><%#Eval("date") %></td></tr>
                            <tr><td><asp:Button ID="ButtonEditComment" runat="server" Text="Edit Comment" UseSubmitBehavior="false" OnClick="ButtonEditComment_Click" CommandArgument='<%#Eval("id") %>' CssClass="button"/></td><td><asp:Button ID="ButtonDeleteComment" runat="server" Text="Delete Comment" UseSubmitBehavior="false" OnClick="ButtonDeleteComment_Click" CommandArgument='<%#Eval("id") + ";" + Eval("userName") %>' CssClass="button"/></td></tr>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
</asp:Content>
