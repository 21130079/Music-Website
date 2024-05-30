package Controller.admin;

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
import java.util.List;
import java.util.Map;

import Listener.LoginListener;
import Model.Account;
import database.DAOAccount;

/**
 * Servlet implementation class UpdateAccountController
 */
public class UpdateAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccountController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String spAdminPassword = request.getParameter("spAdminPassword");
		HttpSession session = request.getSession();
		Account adminaccount = (Account) session.getAttribute("account");
	
		if(adminaccount.getPassword().equals(passwordHashing(spAdminPassword))) {
		
		 String username = request.getParameter("username");
			Account acc = new DAOAccount().selectByUsername(username);
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String roleUser = request.getParameter("user"); 
	        String roleAdmin = request.getParameter("admin"); 
	        ArrayList<String> roles = new ArrayList<String>();
	        if(roleUser!=null) {
	        	roles.add(roleUser);
	        }
	        if(roleAdmin!=null) {
	        	roles.add(roleAdmin);
	        }
	        Account account = new Account(username, passwordHashing(password), email, roles,acc.getFavoriteList(), acc.getPlaylists());
	        new DAOAccount().update(account);
	        for (Map.Entry<String, HttpSession> entry :LoginListener.getSessions().entrySet()) {
				String key = entry.getKey();
				HttpSession val = entry.getValue();	
				if(key.equals(username)) {
					val.invalidate();
					LoginListener.getSessions().remove(key);
				}
							
			}
	       
		}
	        response.sendRedirect("/MusicWebsite/views/admin/admin_account.jsp");
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
