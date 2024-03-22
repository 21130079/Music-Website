package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
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

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		boolean checkFAccount =false;
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		// khai bao cho insert logs
		 String ipAddress = request.getRemoteAddr();
		 if(ipAddress.equals("0:0:0:0:0:0:0:1")) {
			 ipAddress = IPAddress.getIPPublic();
			 System.out.println(IPAddress.getClientIpAddress(request));
		 }
		
		  Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		  
		String errorAccount="";
		Account ac = null;
		DAOAccount daoAccount = new DAOAccount();
		
		for (Account account : daoAccount.selectAll()) {
			if(username.equals(account.getUsername())&&password.equals(account.getPassword())) {
				checkFAccount = true;
				
				ac = daoAccount.selectByUsername(username);
				break;
			}
		}
		HttpSession session = request.getSession();
		if(!checkFAccount) {
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Accounts", null, "Login: " + username,currentTimestamp,false);
			new DAOLog().insert(log); 
			errorAccount = "Username or password is wrong";
			 request.setAttribute("errorAccount", errorAccount);
			 RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.include(request, response);
			
		}else {
			
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Accounts", null, "Login: " + ac,currentTimestamp,true);
			new DAOLog().insert(log);
			session.setAttribute("account", ac);
			response.sendRedirect("index.jsp");
		}
	}

}
