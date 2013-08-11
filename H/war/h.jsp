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
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
    	<link type="text/css" rel="stylesheet" href="../css/autumn_v1.css" />
    	<link type="text/css" rel="stylesheet" href="../css/main.css" />
    	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    	<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
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
			<div data-role="content">...</div>
		</div>
	</body>
</html>