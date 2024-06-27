package Listener;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import Model.Account;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;

/**
 * Application Lifecycle Listener implementation class SessionManagerListener
 *
 */
public class LoginListener implements HttpSessionAttributeListener {

    /**
     * Default constructor. 
     */
	 private static ConcurrentHashMap<String, HttpSession> sessions = new ConcurrentHashMap<>();

	    
	    @Override
	    public void attributeAdded(HttpSessionBindingEvent se)  { 
	    	
	    	Account account = (Account) se.getSession().getAttribute("account");
	    
	       if(account != null) {
	    	   sessions.put(account.getUsername(), se.getSession());
	    	   ServletContext context = se.getSession().getServletContext();

	            Set<Account> activeUsers = (Set<Account>) context.getAttribute("activeUsers");
	            if (activeUsers == null) {
	                activeUsers = new HashSet<>();
	                
	            }else {
	            	activeUsers.add(account);
	            }
	            context.setAttribute("activeUsers", activeUsers);
	       }
	       
	        
	         
	       
	    }
		

	    public static ConcurrentHashMap<String, HttpSession> getSessions() {
	        return sessions;
	    }

	
}
