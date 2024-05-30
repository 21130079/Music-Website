package Listener;

import java.util.HashSet;
import java.util.Set;

import Model.Account;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;


public class LoginListener implements HttpSessionListener {

    /**
     * Default constructor. 
     */
    public LoginListener() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // Khởi tạo tập hợp người dùng đang hoạt động nếu chưa có
        ServletContext context = se.getSession().getServletContext();
        synchronized (context) {
            Set<Account> activeUsers = (Set<Account>) context.getAttribute("activeUsers");
            if (activeUsers == null) {
                activeUsers = new HashSet<>();
                context.setAttribute("activeUsers", activeUsers);
            }
         
        }
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        // Xóa người dùng khỏi tập hợp người dùng đang hoạt động
        ServletContext context = se.getSession().getServletContext();
        synchronized (context) {
            Set<Account> activeUsers = (Set<Account>) context.getAttribute("activeUsers");
            if (activeUsers != null) {
            	Account acc = (Account) se.getSession().getAttribute("account");
                if (acc != null) {
                    activeUsers.remove(acc);
                    context.setAttribute("activeUsers", activeUsers);
                }
            }
        }
    }
	
}
