package excelsior.battlehack.h;

import java.io.IOException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class HServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
	}
}
