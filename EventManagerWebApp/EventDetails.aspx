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
    <div>
        
    </div>
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
        <div>
            <asp:Label ID="LabelLocation" runat="server" Text="Label"></asp:Label>
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
                            <tr><td><asp:Button ID="ButtonEditComment" runat="server" Text="Edit Comment" UseSubmitBehavior="false" OnClientClick="return false" CommandArgument='<%#Eval("id") %>' CssClass="button" Visible='<%# CheckUserId((string)Eval("userName")) %>'/></td><td><asp:Button ID="ButtonDeleteComment" runat="server" Text="Delete Comment" UseSubmitBehavior="false" OnClick="ButtonDeleteComment_Click" CommandArgument='<%#Eval("id") + ";" + Eval("userName") %>' CssClass="button" Visible='<%# CheckUserId((string)Eval("userName")) %>'/></td></tr>
                        </table>
                        <asp:Panel ID="PanelForm" runat="server" align="center" style="display:none">
                            <div class="FormPopup">
                                <div id="ModalHeader">
                                    <br />
                                    <br />
                                    <h2>Edit Comment</h2>
                                </div>

                                <div>
                                    <br /> 
                                    <asp:TextBox ID="TextBoxComment" runat="server" Text='<%#Eval("commentText") %>' TextMode="MultiLine" Height="100px" Width="500px"></asp:TextBox>
                                    <br />
                                    <br />
                                </div>

                                <div>
                                    <asp:Button ID="ButtonModalSend" runat="server" Text="Done" UseSubmitBehavior="false" OnClick="ButtonModalSend_Click" CommandArgument='<%#Eval("id") + ";" + Eval("userName") %>'/>
                                    <input id="ButtonModalCancel" type="button" value="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                        <ajaxToolkit:ModalPopupExtender ID="ModalForm" runat="server" PopupControlID="PanelForm" TargetControlID="ButtonEditComment" OkControlID="ButtonModalSend"
                        CancelControlID="ButtonModalCancel" BackgroundCssClass="ModalPopupBG"></ajaxToolkit:ModalPopupExtender>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
</asp:Content>
