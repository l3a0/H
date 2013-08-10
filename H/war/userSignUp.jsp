<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>

  <body>

	<p>Hello, please sign up!</p>

    <form action="/userSignUp" method="post">
      	<div>Username: <input type="text" name="username" value=""/></div>
     	<div>Email: <input type="email" name="email" value=""/></div>
     	<div>License plate: <input type="text" name="licensePlate" value=""/></div>
      	<div>Birthdate: <input type="text" name="birthdate" value=""/></div>
      	<div>Address: <input type="text" name="address" value=""/></div>
      	<div>About: <input type="text" name="description" value=""/></div>
      	<div><input type="submit" value="Sign up" /></div>
    </form>

	<div>
		Current signed up users:
		<%
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    		Query query = new Query("User").addSort("createDate", Query.SortDirection.ASCENDING);
    		List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    		if (users.isEmpty()) {
        %>
        		<p>(none)</p>
        <%
    		} else {
        		for (Entity user : users) {
            		pageContext.setAttribute("username", user.getProperty("username"));
            		pageContext.setAttribute("createDate", user.getProperty("createDate"));
        %>
                	<p><b>${fn:escapeXml(username)}</b>: (${fn:escapeXml(createDate)})</p>
        <%
        		}
    		}
		%>
	</div>
  </body>
</html>
