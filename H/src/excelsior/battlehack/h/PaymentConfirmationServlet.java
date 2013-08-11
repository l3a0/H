package excelsior.battlehack.h;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.SmsFactory;
import com.twilio.sdk.resource.instance.Sms;
import com.twilio.sdk.resource.list.SmsList;
import java.util.HashMap;
import java.util.Map;

import java.util.Date;

@SuppressWarnings("serial")
public class PaymentConfirmationServlet extends HttpServlet {
	public static final String ACCOUNT_SID = "AC673a2693c2954f994088ef10af51ba76";
	public static final String AUTH_TOKEN = "912978d4675b81444bb1fc1e103da937";
	public static final String SENDER_NUMBER = "+12063168815";

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
		
		String toNumber = req.getParameter("customerPhoneNumber");
	    // Build a filter for the SmsList
	    Map<String, String> params = new HashMap<String, String>();
	    params.put("Body", "Payment received, reservation confirmed!");
	    params.put("To", "+1" + toNumber);
	    params.put("From", SENDER_NUMBER);

	    SmsFactory messageFactory = client.getAccount().getSmsFactory();
	    Sms message;
	    try {
	    	message = messageFactory.create(params);
	    } catch (Exception e) {
	    }

		resp.setContentType("text/plain");
		resp.getWriter().println("PaymentConfirmation - doGet");
	}
}
