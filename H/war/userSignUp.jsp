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
      	<div>Password: <input type="password" name="password" value=""/></div>
     	<div>Email: <input type="email" name="email" value=""/></div>
     	<div>License plate: <input type="text" name="licensePlate" value=""/></div>
      	<div>Birthdate: <input type="text" name="birthdate" value=""/></div>
      	<div>Address: <input type="text" name="address" value=""/></div>
      	<div>About: <input type="text" name="description" value=""/></div>
      	<div><input type="submit" value="Sign up" /></div>
    </form>

	<div>
		Current signed up users:
		<table>
			<%
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    			Query query = new Query("User").addSort("createDate", Query.SortDirection.ASCENDING);
	    		List<Entity> users = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
	    		if (users.isEmpty()) {
	        %>
	        		<tr>
	        			<td>
	        				<p>(none)</p>
	        			</td>
	        		</tr>
	        <%
	    		} else {
	    	%>
	    			<tr>
	    				<td>Username</td>
	    				<td>Email</td>
		               	<td>Create date</td>
		                <td>License plate</td>
		             	<td>Address</td>
		                <td>Description</td>
		                <td>Birth date</td>
		            </tr>
	    	<%
	        		for (Entity user : users) {
	       	%>
	       				<tr>
	       	<%
		               		pageContext.setAttribute("username", user.getProperty("username"));
		               		pageContext.setAttribute("email", user.getProperty("email"));
		            		pageContext.setAttribute("createDate", user.getProperty("createDate"));
		            		pageContext.setAttribute("licensePlate", user.getProperty("licensePlate"));
		            		pageContext.setAttribute("address", user.getProperty("address"));
		            		pageContext.setAttribute("description", user.getProperty("description"));
		            		pageContext.setAttribute("birthdate", user.getProperty("birthdate"));
		    %>
		                	<p>
		                		<td><b>${fn:escapeXml(username)}</b></td>
		                		<td>${fn:escapeXml(email)}</td>
		                		<td>${fn:escapeXml(createDate)}</td>
		                		<td>${fn:escapeXml(licensePlate)}</td>
		                		<td>${fn:escapeXml(address)}</td>
		                		<td>${fn:escapeXml(description)}</td>
		                		<td>${fn:escapeXml(birthdate)}</td>
		                	</p>
		                </tr>
	        <%
	        		}
	    		}
			%>
		</table>
	</div>
  </body>
</html>
