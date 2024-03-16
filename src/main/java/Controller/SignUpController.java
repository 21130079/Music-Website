package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

import Model.Account;
import database.DAOAccount;

/**
 * Servlet implementation class SignUpController
 */
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignUpController() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String errorSignUp = "";
		Account account = null;

		DAOAccount daoAccount = new DAOAccount();
		for (Account acc : daoAccount.selectAll()) {
			if (acc.getUsername().equals(username)) {
				errorSignUp = "Username already exists";
				break;
			}else if(acc.getEmail().equals(email)) {
				errorSignUp = "Email already exists";
				break;
			}
			else {
				if (username.trim().length() < 4 && username.trim().length() > 16) {
					errorSignUp = "Username must be from 4 to 16 characters";
					break;
				}

				if (password.trim().length() <= 6) {
					errorSignUp = "Password must be longer than 6 characters";
					break;
				}
				ArrayList<String> roles  = new ArrayList<String>();	
				roles.add("user");
				account = new Account(username, password, email,roles, null, null);
				daoAccount.insert(account);
			}
		}

		if (account == null) {
			request.setAttribute("message", errorSignUp);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		} else {

			HttpSession session = request.getSession();
			session.setAttribute("account", account);
			response.sendRedirect("index.jsp");
		}
	}

}
