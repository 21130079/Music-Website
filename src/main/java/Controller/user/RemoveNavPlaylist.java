package Controller.user;

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
 * Servlet implementation class RemoveNavPlaylist
 */
public class RemoveNavPlaylist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveNavPlaylist() {
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
		String idplaylist = request.getParameter("idplaylist");
		
		
		
try {
	ArrayList<Song> currentSongs = new DAOPlaylist().selectById(idplaylist, account.getUsername()).getListSong();
	new DAOPlaylist().delete(idplaylist, account.getUsername(), idsong);
			session.setAttribute("account", new DAOAccount().rereshAccount(account) );
			request.setAttribute("idplaylist", idplaylist);
			request.setAttribute("navPlaylistSongs", currentSongs);
		}catch (	Exception e) {
			
		}
	
		request.getRequestDispatcher("/views/pages/navPlaylist.jsp").forward(request, response);
		
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
