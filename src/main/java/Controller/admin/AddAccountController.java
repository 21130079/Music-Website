package Controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import Model.Account;
import Model.IPAddress;
import database.DAOAccount;

/**
 * Servlet implementation class AddAccountController
 */
public class AddAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAccountController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String spAdminPassword = request.getParameter("spAdminPassword");
		HttpSession session = request.getSession();
		Account adminaccount = (Account) session.getAttribute("account");
		if(!adminaccount.getPassword().equals(passwordHashing(spAdminPassword))) {

			response.sendRedirect("/MusicWebsite/views/admin/admin_account.jsp?errorAccount=your password is wrong!");
			return;
		}else {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		username = username.trim();
		password = passwordHashing(password.trim());
		email = email.trim();

        String roleUser = request.getParameter("user"); 
        String roleAdmin = request.getParameter("admin"); 
        ArrayList<String> roles = new ArrayList<String>();
        if(roleUser!=null) {
        	roles.add(roleUser);
        }
        if(roleAdmin!=null) {
        	roles.add(roleAdmin);
        }
        
		String errorAccount = null;
		Account account = null;
		DAOAccount daoAccount = new DAOAccount();
		// lay ipaddress
		String ipAddress = request.getRemoteAddr();
		if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
			ipAddress = IPAddress.getIPPublic();
		}
		daoAccount.setIpAddress(ipAddress);

		
		for (Account acc : daoAccount.selectAll()) {
			if (acc.getUsername().equals(username)) {
				errorAccount = "Username already exists";
				break;
			} else if (acc.getEmail().equals(email)) {
				errorAccount = "Email already exists";
				break;
			} else {
				if (username.trim().length() < 4 && username.trim().length() > 16) {
					errorAccount = "Username must be from 4 to 16 characters";
					break;
				}

				if (password.trim().length() <= 8) {
					errorAccount = "Password must be longer than 8 characters";
					break;
				}
				
				account = new Account(username, password, email, roles, null, null);
				daoAccount.insert(account);
			}
		}
		if(errorAccount!= null) {
			response.sendRedirect("/MusicWebsite/views/admin/admin_account.jsp?errorAccount="+errorAccount);
		}else {
			response.sendRedirect("/MusicWebsite/views/admin/admin_account.jsp");
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
