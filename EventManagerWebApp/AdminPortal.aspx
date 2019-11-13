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
        .textbox {  
            height: 30px;      
            font-size: 16px;  
            width: 470px;  
        }  
        .dropDownList {
            width: 300px;
            height: 30px;
        }
    </style>
    <asp:HiddenField ID="hf_Lat" Value="28.6024" runat="server" />
    <asp:HiddenField ID="hf_Lng" Value="-81.2001" runat="server" />
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBmsjtqUy3YtAN1fS-XWHZw1CVVlFjMEaI&callback=initialize"></script>  
    <script>  
        var mapcode;
        var diag;
        var oldMarker;
        function initialize() {
            var val = $dropDownList = $('[id*="DropDownList"]'), $labelRSO = $('[id*="labelRSO"]');
            $dropDownList.hide();
            $labelRSO.hide();
            mapcode = new google.maps.Geocoder();
            var lnt = new google.maps.LatLng(<%=hf_Lat.Value%>, <%=hf_Lng.Value%>);
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
            google.maps.event.addListener(diag, 'click', function (event) {
                document.getElementById('<%= hf_Lat.ClientID %>').value = event.latLng.lat();
                document.getElementById('<%= hf_Lng.ClientID %>').value = event.latLng.lng();

                var lll = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());
                marker.setPosition(lll);
            });
            function placeMarker(location) {
                marker = new google.maps.Marker({
                    position: location,
                    map: diag,
                    animation: google.maps.Animation.DROP,
                });
                if (oldMarker != undefined) {
                    oldMarker.setMap(null);
                }
                oldMarker = marker;
                map.setCenter(location);
            }
        }
    </script>
    <script>
        $(function () {
            $('[id*="ddlType"]').on('change', function () {
                var val = this.value, $dropDownList = $('[id*="DropDownList"]'), $labelRSO = $('[id*="labelRSO"]');

                if (val == 3) {
                    $dropDownList.show();
                    $labelRSO.show();
                } else {
                    $dropDownList.hide();
                    $labelRSO.hide();
                }
            });
        });
    </script>
    <h1>Create Event</h1>
    <div class="jumbotron">
        <div id="map_populate" style="width:60%; height:500px; border: 5px solid #5E5454;float:right;"></div>
        <div>
            <label>Event Name</label><br/>
            <asp:TextBox ID="eventName" runat ="server" CssClass="textbox"/>
        </div>
        <div>
            <label>Description</label><br/>
            <asp:TextBox ID="eventDescription" runat ="server" CssClass="textbox" TextMode="MultiLine" Height="90px"/>
        </div>
        <div>
            <label>Location</label><br/>
            <asp:TextBox ID="eventLocation" runat ="server" CssClass="textbox"/>
        </div>
        <div>
            <label>Contact Number</label><br/>
            <asp:TextBox ID="eventNumber" runat ="server" CssClass="textbox"/>
        </div>
        <div>
            <label>Contact Email</label><br/>
            <asp:TextBox ID="eventEmail" runat ="server" CssClass="textbox"/>
        </div>

        <div>
            <label>Event Type</label><br />
            <asp:DropDownList ID="ddlType" runat="server" CssClass="dropDownList">
                <asp:ListItem Text="Public" Value="2" />
                <asp:ListItem Text="Private" Value="1" />
                <asp:ListItem Text="RSO" Value="3" />
            </asp:DropDownList>
        </div>
        <div>
            <asp:Label ID="labelRSO" runat="server" Text="RSO" Font-Bold="true"></asp:Label><br />
            <asp:DropDownList ID="DropDownList" runat="server" DataTextField="name" DataValueField="id" Width="300px" CssClass="dropDownList"></asp:DropDownList>
        </div>
        <div>
            <label>Event Date</label><br/>
            <asp:Calendar ID="eventDate" runat="server"></asp:Calendar>
        </div>
        <div>
            <asp:Button ID="createEvent" runat="server" Text="Create Event" OnClick ="createEvent_Click" CssClass="button" Height="35px"/>
        </div>
    </div>
    

</asp:Content>