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
import com.google.appengine.api.datastore.Key;

import java.util.Date;

@SuppressWarnings("serial")
public class RegisterParkingSpotServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("RegisterParkingSpotServlet - doGet");
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

		String parkingLotName = req.getParameter("parkingLotName");
		if (parkingLotName == null) {
			resp.sendRedirect("/registerParkingLot.jsp?username=" + username);
		}
		Filter parkingLotFilter = new FilterPredicate("name", Query.FilterOperator.EQUAL, parkingLotName);
		Query parkingLotQuery = new Query("ParkingLot").setFilter(parkingLotFilter);
		PreparedQuery pqParkingLot = datastore.prepare(parkingLotQuery);
		Entity parkingLot = pqParkingLot.asSingleEntity();
		if (parkingLot == null) {
			resp.sendRedirect("/registerParkingLot.jsp?username=" + username);
		}
		
		String maxSpots = req.getParameter("maxSpots");
		String day = req.getParameter("day");
		String hour = req.getParameter("hour");
		String rate = req.getParameter("rate");
		String occupiedSpots = req.getParameter("occupiedSpots");
		Date createDate = new Date();

		Entity parkingSpot = new Entity("ParkingSpot", parkingLot.getKey());
		parkingSpot.setProperty("maxSpots", maxSpots);
		parkingSpot.setProperty("day", day);
		parkingSpot.setProperty("hour", hour);
		parkingSpot.setProperty("rate", rate);
		parkingSpot.setProperty("occupiedSpots", occupiedSpots);
		parkingSpot.setProperty("createDate", createDate);

		datastore.put(parkingSpot);

		// redirect to parking spot registration (for other spots)
		resp.sendRedirect("/registerParkingSpot.jsp?username=" + username + "&parkingLotName=" + parkingLotName);
	}
}
