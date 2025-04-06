<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Foodie.User.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script>
    function initializeMap() {
        var mapProp = {
            center: new google.maps.LatLng(7.067546367645264, 125.59199523925781), // Updated center coordinates
            zoom: 17,
        };
        var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

        // Add a marker to the map
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(7.067546367645264, 125.59199523925781), // Updated marker position
            map: map,
            title: "Nanay's Pizza Haven"
        });
    }

    // Load Google Maps API script asynchronously
    function loadScript() {
        var script = document.createElement("script");
        script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyAhUOF_tiZkx09aQkhsXeEFd07kapAt-wY&callback=initializeMap";
        document.head.appendChild(script);
    }

    // Call the loadScript function when the page finishes loading
    window.onload = loadScript;
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <section class="book_section layout_padding">
    <div class="container">
        <div class="heading_container">
            <h2>Visit Us</h2>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="description_container" style="background-color: #f9f9f9; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <p style="font-size: 18px; line-height: 1.6; color: #333;">
                        Come visit Foodie Haven! We are situated at UM Matina Campus, Flavor Town. Our cozy and welcoming atmosphere is perfect for family dinners, dates, and gatherings with friends. Enjoy our delicious food and excellent service.
                    </p>
                    <p style="font-size: 16px; line-height: 1.6; color: #555;">
                        <strong>Address:</strong> UM Main Campus<br>
                        <strong>Phone:</strong> +63 9291612931<br>
                        <strong>Email:</strong> <a href="mailto:jackeylovee29@gmail.com" style="color: #e74c3c; text-decoration: none;">j.onita.525850@umindanao.edu.ph</a>
                    </p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="map_container" style="position: relative; padding-top: 56.25%; height: 0; overflow: hidden; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 10px;">
                    <div id="googleMap" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
                </div>
            </div>
        </div>
    </div>
</section>
</asp:Content>