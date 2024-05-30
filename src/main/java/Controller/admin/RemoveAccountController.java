package Controller.admin;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;

import Listener.SessionManagerListener;
import Model.Account;
import database.DAOAccount;

@WebServlet("/remove-account")
public class RemoveAccountController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName= request.getParameter("username");
        new DAOAccount().deleteByUsername(userName);
        

    	for (Map.Entry<String, HttpSession> entry :SessionManagerListener.getSessions().entrySet()) {
			String key = entry.getKey();
			HttpSession val = entry.getValue();	
			if(key.equals(userName)) {
				val.invalidate();
				SessionManagerListener.getSessions().remove(key);
			}
						
		}
       

        response.sendRedirect("/MusicWebsite/views/admin/admin_account.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
