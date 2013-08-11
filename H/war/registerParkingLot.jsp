<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>

  <body>

	<p>Parking lot registration</p>

	<%
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		// get user
		String username = request.getParameter("username");
		Filter userFilter = new FilterPredicate("username", Query.FilterOperator.EQUAL, username);
		Query userQuery = new Query("User").setFilter(userFilter);
		Entity user = datastore.prepare(userQuery).asSingleEntity();
		pageContext.setAttribute("username", user.getProperty("username"));
	%>

    <form action="/registerParkingLot" method="post">
      	<div>Name: <input type="text" name="name" value=""/></div>
     	<div>Longitude: <input type="text" name="longitude" value=""/></div>
     	<div>Latitude: <input type="text" name="latitude" value=""/></div>
      	<div>Address: <input type="text" name="address" value=""/></div>
      	<div>Description: <input type="text" name="description" value=""/></div>
      	<input type="hidden" name="username" value="${fn:escapeXml(username)}"/>
      	<div><input type="submit" value="Register parking lot" /></div>
    </form>

	<div>
		Current list of parking lots for ${fn:escapeXml(username)}:
	</div>
  </body>
</html>
