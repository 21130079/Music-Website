
package Controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.UUID;

import Model.Account;
import Model.ELevel.Level;
import Model.Notification;
import database.DAOAccount;
import database.DAONotification;

/**
 * Servlet implementation class ChangePasswordController
 */
public class ChangePasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePasswordController() {
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
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		Account acc = (Account) session.getAttribute("account");

		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		SecureRandom secureRandom = new SecureRandom();
		StringBuilder sb = new StringBuilder(15);

		for (int i = 0; i < 15; i++) {
			int randomIndex = secureRandom.nextInt(characters.length());
			char randomChar = characters.charAt(randomIndex);
			sb.append(randomChar);
		}

		request.setAttribute("newPass", sb.toString());
		request.setAttribute("isSent", false);
		request.setAttribute("isVerify", true);
		new DAOAccount().updatePassword(email, sb.toString());;

		new DAONotification().insert(new Notification(UUID.randomUUID().toString(), acc.getUsername(), Level.INFO,
		 		"Change password successfully", null));
		
		request.getRequestDispatcher("/views/pages/changePassword.jsp").forward(request, response);
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
