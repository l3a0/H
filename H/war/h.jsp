<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css" />
    	<link type="text/css" rel="stylesheet" href="../css/autumn_v1.css" />
    	<link type="text/css" rel="stylesheet" href="../css/main.css" />
    	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    	<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
	</head>
	<body>
		<div data-role="page" id="page1">
		    <div data-role="header" >
		        <h1>
		            SeaPark
		        </h1>
		    </div>
		    <div data-role="content">
		    	<label for="text-7" style="display:none;">Username</label>
		    	<input type="text" data-clear-btn="true" name="text-7" id="text-7" value="" placeholder="Enter username">
		    	<a href="index.html" data-role="button" data-icon="arrow-r" data-iconpos="notext" class="">Sign in</a>
		    </div>
		</div>
	</body>
</html>