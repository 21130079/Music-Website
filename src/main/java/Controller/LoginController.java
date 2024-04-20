package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;

import Model.Account;
import Model.IPAddress;
import Model.Log;
import Model.ELevel.Level;
import database.DAOAccount;
import database.DAOLog;

/**
 * Servlet implementation class LoginController
 */

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_LOGIN_TIMES = 5;
	private static final long THROTTLE_TIME = 300000;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		boolean checkFAccount = false;
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		username = username.trim();
		password = passwordHashing(password.trim());
		DAOAccount daoAccount = new DAOAccount();
		// ip address
		String ipAddress = request.getRemoteAddr();
		if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
			ipAddress = IPAddress.getIPPublic();
		}
		daoAccount.setIpAddress(ipAddress);

		String errorAccount = "";
		Account ac = null;

		for (Account account : daoAccount.selectAll()) {
			if (username.equals(account.getUsername()) && password.equals(account.getPassword())) {
				checkFAccount = true;

				ac = daoAccount.selectByUsername(username);
				break;
			}
		}

		HttpSession session = request.getSession();
		
		
		//get throttle time
		Long throttleTime = (Long) session.getAttribute("throttleTime");
		
		if (throttleTime != null && (System.currentTimeMillis() - throttleTime) < THROTTLE_TIME) {
			long minute = ((THROTTLE_TIME - (System.currentTimeMillis() - throttleTime)) / (1000 * 60)) % 60;
			long second = ((THROTTLE_TIME - (System.currentTimeMillis() - throttleTime)) / 1000) % 60;
			
			errorAccount = "Please wait " + minute + " minutes " + second + " seconds to continue";
			request.setAttribute("errorAccount", errorAccount);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.include(request, response);
		} else {
			//get login times
			Integer loginTimes = (Integer) session.getAttribute("loginTimes");
			if (loginTimes == null) {
				loginTimes = 0;
			}
			
			if (!checkFAccount) {
				loginTimes += 1;
				
				//login fail 5 times
				if (loginTimes >= MAX_LOGIN_TIMES) {
					//start throttle time
					Long currentTime = System.currentTimeMillis();
					session.setAttribute("throttleTime", currentTime);
					
					errorAccount = "Please wait 5 minutes to continue";
					session.setAttribute("loginTimes", 0);
				} else {
					errorAccount = "Username or password is wrong";
					session.setAttribute("loginTimes", loginTimes);
				}
				
				request.setAttribute("errorAccount", errorAccount);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.include(request, response);
			} else {
				session.setAttribute("account", ac);
				response.sendRedirect("index.jsp");
			}
		}
	}
	
	public String passwordHashing(String password) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA");
			byte[] resultBytes = messageDigest.digest(password.getBytes());
			StringBuilder sb = new StringBuilder();
			
            for (byte b : resultBytes) {
                sb.append(String.format("%02x", b));
            }
            
            return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			
			return null;
		}
	}

}
