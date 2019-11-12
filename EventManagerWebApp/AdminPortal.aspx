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
    <asp:HiddenField ID="hf_Lat" Value="" runat="server" />
    <asp:HiddenField ID="hf_Lng" Value="" runat="server" />
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBmsjtqUy3YtAN1fS-XWHZw1CVVlFjMEaI&callback=initialize"></script>  
    <script>  
        var mapcode;
        var diag;
        var oldMarker;
        function initialize() {
            mapcode = new google.maps.Geocoder();
            var lnt = new google.maps.LatLng(<%=lat%>, <%=lng%>);
            var diagChoice = {
                zoom: 15,
                center: { lat: 28.6024, lng: -81.2001},//lnt,
                diagId: google.maps.MapTypeId.ROADMAP
            }
            var diag = new google.maps.Map(document.getElementById('map_populate'), diagChoice);
<%--            var marker = new google.maps.Marker({
                position: { lat: 28.6024, lng: -81.2001 },//lnt,
                map: diag,
                title: '<%=locationName%>'
            });
            marker.addListener('click', function () {
                diag.setCenter(marker.getPosition());
            });--%>
            var marker = new google.maps.Marker({
                position: { lat: 28.6024, lng: -81.2001 },//lnt,
                map: diag,
                title: '<%=locationName%>'
            });
            google.maps.event.addListener(diag, 'click', function (event) {
                //placeMarker(event.LatLng);
                document.getElementById('latclicked').innerHTML = event.latLng.lat();
                document.getElementById('longclicked').innerHTML = event.latLng.lng();
                document.getElementById('<%= hf_Lat.ClientID %>').value = event.latLng.lat();
                document.getElementById('<%= hf_Lng.ClientID %>').value = event.latLng.lng();

                var lll = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());
                marker.setPosition(lll);

                //var marker = new google.maps.Marker({
                //    position: lnt,
                //    //position: { lat: event.LatLng.lat(), lng: event.LatLng.lng() },//lnt,
                //    map: diag,
                    
                //});
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
            //marker.addListener(diag, 'click', function (event)){
            //    placeMarker(event.LatLng);
            //});
            //function placeMarker(location) {
            //    marker.setPosition(location);
            //}
            
        }
    </script>

    <div id="latclicked"></div>
    <div id="longclicked"></div>
    <h2><%: Title %>Hello You!</h2>
    <div id="map_populate" style="width:60%; height:500px; border: 5px solid #5E5454;float:right;"></div>
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
            <asp:ListItem Text="Public" Value="2" />
            <asp:ListItem Text="Private" Value="1" />
            <asp:ListItem Text="RSO" Value="3" />
        </asp:DropDownList>
    </div>
    <div><br/>
        <label>RSO</label><br />
            <asp:DropDownList ID="DropDownList" runat="server" DataTextField="name" DataValueField="id" Width="300px"></asp:DropDownList>
    </div>
    <div><br/>
        <asp:Button ID="createEvent" runat="server" Text="Create Event" OnClick ="createEvent_Click"/>
    </div>


    <div class="ltMsg">
        <asp:Literal ID="ltMessage"  runat="server" />
    </div>
    

</asp:Content>