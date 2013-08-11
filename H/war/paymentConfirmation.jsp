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

	<p>Payment received!</p>
	<script src="//static.twilio.com/libs/twiliojs/1.1/twilio.js"></script>
	<script type="text/javascript">
		function getParameterByName(name) {
		    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		        results = regex.exec(location.search);
		    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}

		var token = "912978d4675b81444bb1fc1e103da937";
		var account = "AC673a2693c2954f994088ef10af51ba76";
		Twilio.Device.setup(token);
		Twilio.Device.connect();

		var client = TwilioRestClient(account, token);
		var message = cleint.SendSmsMessage("+2063168815", "+" + getParameterByName("customerPhoneNumber"), "Your reservation has been confirmed!");
		
	</script>
  </body>
</html>
