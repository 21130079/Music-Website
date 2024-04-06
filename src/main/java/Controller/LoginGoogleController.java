package Controller;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import Model.Account;
import Model.GooglePojo;
import Model.IPAddress;
import database.DAOAccount;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginGoogleController
 */
public class LoginGoogleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public static String GOOGLE_CLIENT_ID = "635263821596-utj1bf1e28i9jcc36vsampol1hbj4gmv.apps.googleusercontent.com";
	public static String GOOGLE_CLIENT_SECRET = "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";
	public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/MusicWebsite/LoginGoogleController";
	public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
	public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
	public static String GOOGLE_GRANT_TYPE = "authorization_code";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginGoogleController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("code");
		if (code == null || code.isEmpty()) {
			RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
			dis.forward(request, response);
		} else {
			String accessToken = getToken(code);
			GooglePojo googlePojo = getUserInfo(accessToken);
			Account account = null;
			for (Account acc : new DAOAccount().selectAll()) {
				if (acc.getEmail().equalsIgnoreCase(googlePojo.getEmail())) {
					account = acc;
					break;
				}
			}

			DAOAccount daoAccount = new DAOAccount();

			// ip address
			String ipAddress = request.getRemoteAddr();
			if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
				ipAddress = IPAddress.getIPPublic();
			}
			daoAccount.setIpAddress(ipAddress);

			HttpSession session = request.getSession();
			session.setAttribute("account", account);
			response.sendRedirect("index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public static String getToken(final String code) throws ClientProtocolException, IOException {
		String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
				.bodyForm(Form.form().add("client_id", GOOGLE_CLIENT_ID).add("client_secret", GOOGLE_CLIENT_SECRET)
						.add("redirect_uri", GOOGLE_REDIRECT_URI).add("code", code).add("grant_type", GOOGLE_GRANT_TYPE)
						.build())
				.execute().returnContent().asString();
		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}

	public static GooglePojo getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
		String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();
		GooglePojo googlePojo = new Gson().fromJson(response, GooglePojo.class);
		return googlePojo;
	}
}
