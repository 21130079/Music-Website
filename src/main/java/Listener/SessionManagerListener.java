package Listener;

import java.util.concurrent.ConcurrentHashMap;

import Model.Account;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class SessionManagerListener
 *
 */
public class SessionManagerListener implements HttpSessionAttributeListener {

    /**
     * Default constructor. 
     */
	 private static final ConcurrentHashMap<String, HttpSession> sessions = new ConcurrentHashMap<>();

	    
	    @Override
	    public void attributeAdded(HttpSessionBindingEvent se)  { 
	    	
	    	Account account = (Account) se.getSession().getAttribute("account");
	    
	       if(account != null) {
	    	   sessions.put(account.getUsername(), se.getSession());
	       }
	    }
		

	    public static ConcurrentHashMap<String, HttpSession> getSessions() {
	        return sessions;
	    }

	
}
