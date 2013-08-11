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

	<div>
		Current list of available parking spots:
		<table>
			<%
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Filter parkingSpotsFilter = new FilterPredicate("occupiedSpots", Query.FilterOperator.GREATER_THAN, 0);
				Query parkingSpotsQuery = new Query("ParkingSpot").setFilter(parkingSpotsFilter);
	    		List<Entity> parkingSpots = datastore.prepare(parkingSpotsQuery).asList(FetchOptions.Builder.withDefaults());

	    		if (parkingSpots == null || parkingSpots.isEmpty()) {
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
						<td>Max spots</td>
						<td>Occupied Spots</td>
			           	<td>Day</td>
			            <td>Hour</td>
			         	<td>Rate (per hour)</td>
			        </tr>
	    	<%
	        		for (Entity parkingSpot : parkingSpots) {
	       	%>
	       				<tr>
	       	<%
		               		pageContext.setAttribute("maxSpots", parkingSpot.getProperty("maxSpots"));
		            		pageContext.setAttribute("occupiedSpots", parkingSpot.getProperty("occupiedSpots"));
		            		pageContext.setAttribute("day", parkingSpot.getProperty("day"));
		            		pageContext.setAttribute("hour", parkingSpot.getProperty("hour"));
		            		pageContext.setAttribute("rate", parkingSpot.getProperty("rate"));
		    %>
		                	<p>
		                		<td><b>${fn:escapeXml(maxSpots)}</b></td>
		                		<td>${fn:escapeXml(occupiedSpots)}</td>
		                		<td>${fn:escapeXml(day)}</td>
		                		<td>${fn:escapeXml(hour)}</td>
		                		<td>${fn:escapeXml(rate)}</td>
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
