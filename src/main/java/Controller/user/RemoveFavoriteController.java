package Controller.user;

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
import Model.Song;
import database.DAOAccount;
import database.DAOFavorite;
import database.DAOPlaylist;
import database.DAOSong;

/**
 * Servlet implementation class RemoveFavoriteController
 */
public class RemoveFavoriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveFavoriteController() {
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
		String idsong = request.getParameter("idsong");
		
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
			new DAOFavorite().deleteById(idsong, account.getUsername());
			
//			String idPlaylist = request.getParameter("idPlaylist");
//			System.out.println(new DAOPlaylist().delete(idPlaylist, account.getUsername(), idsong));
		session.setAttribute("account", new DAOAccount().rereshAccount(account));
		
		 response.sendRedirect("/MusicWebsite/views/pages/favorite.jsp");

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
