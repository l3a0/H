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
    <link type="text/js" rel="javascript" href="/js/paypal-button.min.js" />
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
			         	<td>Parking lot name</td>
			         	<td>Parking lot address</td>
			         	<td>Parking lot longitude</td>
			         	<td>Parking lot latitude</td>
			         	<td>Purchase</td>
			        </tr>
	    	<%
	        		for (Entity parkingSpot : parkingSpots) {
	        			// get parking lot
	        			Key parkingLotKey = parkingSpot.getParent();
	        			Filter parkingLotFilter = new FilterPredicate(Entity.KEY_RESERVED_PROPERTY, Query.FilterOperator.EQUAL, parkingLotKey);
	        			Query parkingLotQuery = new Query("ParkingLot").setFilter(parkingLotFilter);
	        			Entity parkingLot = datastore.prepare(parkingLotQuery).asSingleEntity();

	        			if (parkingLot != null) {
	        				pageContext.setAttribute("parkingLotName", parkingLot.getProperty("name"));
		        			pageContext.setAttribute("parkingLotAddress", parkingLot.getProperty("address"));
		        			pageContext.setAttribute("parkingLotLongitude", parkingLot.getProperty("longitude"));
		        			pageContext.setAttribute("parkingLotLatitude", parkingLot.getProperty("latitude"));
	        			}
	        			pageContext.setAttribute("maxSpots", parkingSpot.getProperty("maxSpots"));
	            		pageContext.setAttribute("occupiedSpots", parkingSpot.getProperty("occupiedSpots"));
	            		pageContext.setAttribute("day", parkingSpot.getProperty("day"));
	            		pageContext.setAttribute("hour", parkingSpot.getProperty("hour"));
	            		pageContext.setAttribute("rate", parkingSpot.getProperty("rate"));
	       	%>
	       				<tr>
		                	<p>
		                		<td><b>${fn:escapeXml(maxSpots)}</b></td>
		                		<td>${fn:escapeXml(occupiedSpots)}</td>
		                		<td>${fn:escapeXml(day)}</td>
		                		<td>${fn:escapeXml(hour)}</td>
		                		<td>${fn:escapeXml(rate)}</td>
		                		<td>${fn:escapeXml(parkingLotName)}</td>
		                		<td>${fn:escapeXml(parkingLotAddress)}</td>
		                		<td>${fn:escapeXml(parkingLotLongitude)}</td>
		                		<td>${fn:escapeXml(parkingLotLatitude)}</td>
		                		<td>
			                		<script src="js/paypal-button.min.js?merchant=jwkilin@gmail.com" 
				                	    data-button="buynow" 
				                	    data-name=${fn:escapeXml(parkingLotName)}
				                	    data-quantity="1" 
				                	    data-amount=${fn:escapeXml(rate)}
				                	    data-currency="USD" 
				                	    data-shipping="0" 
				                	    data-tax="0"
				                	    data-callback="http://localhost:8080/paymentConfirmation?customerPhoneNumber=2068396960"
				                	    data-return="http://localhost:8080/paymentConfirmation?customerPhoneNumber=2068396960"
				                	    data-env="sandbox">
			                		</script>
		                		</td>
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
