package Controller.user;

import java.io.IOException;

import Model.Account;
import database.DAOAccount;
import database.DAOPlaylist;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class EditNamePlaylistController
 */
public class EditNamePlaylistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditNamePlaylistController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String id_Playlist = request.getParameter("id_Playlist");
		String newName = request.getParameter("newName");
		Account account = (Account) session.getAttribute("account");
		
	new DAOPlaylist().update(id_Playlist, newName, account.getUsername());
		
		session.setAttribute("account", new DAOAccount().rereshAccount(account) );
		response.sendRedirect("/MusicWebsite/views/pages/playlist.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
