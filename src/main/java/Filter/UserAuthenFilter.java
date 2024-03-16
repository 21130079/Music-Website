package Filter;

import java.io.IOException;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import Model.Account;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class UserAuthenFilter
 */

public class UserAuthenFilter extends HttpFilter {

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public UserAuthenFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		Account account = (Account) session.getAttribute("account");

		if (account == null) {
			String errorAccount = "*Please log in to your account to continue";
			req.setAttribute("errorAccount", errorAccount);
			 req.getServletContext().getRequestDispatcher("/index.jsp").forward(req, res);
				return;
		}else
		
		if (!account.hasRole("user") ) {
			res.sendRedirect("/MusicWebsite/views/errors/403-error.jsp");
			return;
		}

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
