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

	<p>Parking spot registration</p>

	<%
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		// get user
		String username = request.getParameter("username");
		Filter userFilter = new FilterPredicate("username", Query.FilterOperator.EQUAL, username);
		Query userQuery = new Query("User").setFilter(userFilter);
		Entity user = datastore.prepare(userQuery).asSingleEntity();
		pageContext.setAttribute("username", user.getProperty("username"));
		
		// get parking lot
		String parkingLotName = request.getParameter("parkingLotName");
		Filter parkingLotFilter = new FilterPredicate("name", Query.FilterOperator.EQUAL, parkingLotName);
		Query parkingLotQuery = new Query("ParkingLot").setFilter(parkingLotFilter);
		Entity parkingLot = datastore.prepare(parkingLotQuery).asSingleEntity();
		pageContext.setAttribute("parkingLotName", parkingLot.getProperty("name"));
	%>

    <form action="/registerParkingSpot" method="post">
     	<div>Max spots: <input type="text" name="maxSpots" value=""/></div>
      	<div>Day (0-6): <input type="text" name="day" value=""/></div>
      	<div>Hour (0-23): <input type="text" name="hour" value=""/></div>
      	<div>Rate: <input type="text" name="rate" value=""/></div>
      	<input type="hidden" name="occupiedSpots" value="0"/>
      	<input type="hidden" name="username" value="${fn:escapeXml(username)}"/>
      	<input type="hidden" name="parkingLotName" value="${fn:escapeXml(parkingLotName)}"/>
      	<div><input type="submit" value="Register parking spot" /></div>
    </form>

	<div>
		Current list of parking spots for ${fn:escapeXml(username)}'s ${fn:escapeXml(parkingLotName)}:
		<table>
			<%
	    		Query parkingSpotsQuery = new Query("ParkingSpot").setAncestor(parkingLot.getKey()).addSort("createDate", Query.SortDirection.ASCENDING);
	    		List<Entity> parkingSpots = datastore.prepare(parkingSpotsQuery).asList(FetchOptions.Builder.withDefaults());

	    		if (parkingSpots.isEmpty()) {
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
