package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

import Model.IPAddress;
import Model.Log;
import Model.Account;
import Model.ELevel.Level;
import database.DAOLog;

/**
 * Servlet implementation class LogOutController
 */
public class LogOutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LogOutController() {
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
		 String ipAddress = request.getRemoteAddr();
		 if(ipAddress.equals("0:0:0:0:0:0:0:1")) {
			 ipAddress = IPAddress.getIPPublic();
			 System.out.println(ipAddress);
		 }
		HttpSession session = request.getSession();
		Account ac = (Account) session.getAttribute("account");
	
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		
		Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Accounts",null ,"LogOut: " + ac ,currentTimestamp,true);
		new DAOLog().insert(log);
		
		
		response.sendRedirect(request.getHeader("referer"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
