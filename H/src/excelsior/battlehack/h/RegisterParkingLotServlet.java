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

import java.util.Date;

@SuppressWarnings("serial")
public class RegisterParkingLotServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("RegisterParkingLotServlet - doGet");
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		String username = req.getParameter("username");
		if (username == null) {
			resp.sendRedirect("/userSignUp.jsp");
		}
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter usernameFilter = new FilterPredicate("username", Query.FilterOperator.EQUAL, username);
		Query query = new Query("User").setFilter(usernameFilter);
		PreparedQuery pq = datastore.prepare(query);
		Entity user = pq.asSingleEntity();
		if (user == null) {
			resp.sendRedirect("/userSignUp.jsp");
		}
		
		String name = req.getParameter("name");
		String latitude = req.getParameter("latitude");
		String longitude = req.getParameter("longitude");
		String address = req.getParameter("address");
		String description = req.getParameter("description");
		Date createDate = new Date();

		Entity parkingLot = new Entity("ParkingLot", user.getKey());
		parkingLot.setProperty("name", name);
		parkingLot.setProperty("latitude", latitude);
		parkingLot.setProperty("longitude", longitude);
		parkingLot.setProperty("address", address);
		parkingLot.setProperty("description", description);
		parkingLot.setProperty("createDate", createDate);

		datastore.put(parkingLot);

		// redirect to user sign up confirmation
		resp.sendRedirect("/registerParkingLot.jsp?username=" + username);
	}
}
