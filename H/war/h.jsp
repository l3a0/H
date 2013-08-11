<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<title>SeaPark</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
		<link type="text/css" rel="stylesheet" href="../css/autumn_v1.css" />
		<link type="text/css" rel="stylesheet" href="../css/main.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
		<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbCo9UaR61P10x0MGR4ae1m2jvC-uMl9c&sensor=true"></script>
	</head>
	<body>
		<div data-role="page" id="page1">
			<div data-role="header" >
				<h1>SeaPark</h1>
			</div>
			<div data-role="content">
				<div style="text-align: center;">
					<h4>Connect to Facebook to find parking</h4>
					<a href="#page2"><img src="../images/facebook_connect_button.png" /></a>
				</div>
			</div>
		</div>
		
		<div data-role="page" id="page2">
			<div data-role="header">
				<h1>Account Info</h1>
			</div>
			<div data-role="content">
				<h4>Looks like it is your first time. Let's build trust. We won't spam and tell.</h4>
				
				<a href="#page3" data-role="button">Save</a>
			</div>
		</div>
		
		<div data-role="page" id="page3">
			<div data-role="header">
				<h1>Nearby Parking</h1>
			</div>
			<div data-role="content">
				<div id="map-canvas"/>
			</div>
		</div>
		<script type="text/javascript">
			function initialize(myLatlng) {
				var mapOptions = {
					center: myLatlng,
					zoom: 17,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				};
			
				var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

				var marker = new google.maps.Marker({
					position: myLatlng,
					title:"Hello World!"
				});
				
				// To add the marker to the map, call setMap();
				marker.setMap(map);

				google.maps.event.addListener(marker, 'click', function() {
					window.location = "/findParkingSpot.jsp";
				});
			}
			
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(success, error);
			} else {
				error('geolocation not supported');
			}
			
			function success(position) {
				// variable to store the coordinates
				var myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
				initialize(myLatlng);
			}
			
			function error(msg) {
				error('geolocation not supported');
			}
		</script>
	</body>
</html>