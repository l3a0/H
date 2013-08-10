package excelsior.battlehack.h;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@SuppressWarnings("serial")
public class UserSignUpServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("UserSignUpServlet - doGet");
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String licensePlate = req.getParameter("licensePlate");
		String address = req.getParameter("address");
		String description = req.getParameter("description");
		DateFormat formatter = new SimpleDateFormat("MM-dd-yy");
		Date birthdate;
		try {
			birthdate = formatter.parse(req.getParameter("birthdate"));
		} catch (Exception e) {
			birthdate = new Date();
		}
		Date createDate = new Date();

		Key userKey = KeyFactory.createKey("User", username);
		Entity user = new Entity("User", userKey);
		user.setProperty("username", username);
		user.setProperty("email", email);
		user.setProperty("licensePlate", licensePlate);
		user.setProperty("address", address);
		user.setProperty("description", description);
		user.setProperty("birthdate", birthdate);
		user.setProperty("createDate", createDate);

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(user);

		// redirect to user sign up confirmation
		resp.sendRedirect("/userSignUp.jsp?username=" + username);
	}
}
