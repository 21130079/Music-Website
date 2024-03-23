package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.Account;
import Model.IPAddress;
import Model.Log;
import Model.ELevel.Level;
import database.DAOAccount;
import database.DAOLog;

/**
 * Servlet implementation class NewPasswordController
 */
public class NewPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewPasswordController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Account acc = (Account) session.getAttribute("account");
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		String messageOldPass = null;
		String messageNewPass = null;
		session.setAttribute("account", acc);
		
		DAOAccount daoAccount = new DAOAccount();
		//get ip adrress
		 String ipAddress = request.getRemoteAddr();
		 if(ipAddress.equals("0:0:0:0:0:0:0:1")) {
			 ipAddress = IPAddress.getIPPublic();
			
		 }
		 daoAccount.setIpAddress(ipAddress);
		 boolean isValid = false;
		
		if (acc.getPassword().equals(oldPass)) {
			if (newPass.trim().length() <= 6) {
				
				messageNewPass = "New password must be longer than 6 characters";
				request.setAttribute("messageOldPass", null);
				request.setAttribute("messageNewPass", messageNewPass);
				
			
			} else {
				isValid =true;
				request.setAttribute("messageOldPass", null);
				request.setAttribute("messageNewPass", null);
				daoAccount.updatePassword(acc.getEmail(), newPass);
				
			}
		} else {
			
			messageOldPass = "Invalid current password !";
			request.setAttribute("messageOldPass", messageOldPass);
			request.setAttribute("messageNewPass", null);
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		if (isValid) {
		
			response.sendRedirect("/MusicWebsite/index.jsp");
		}else {
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		session.setAttribute("account", acc);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
