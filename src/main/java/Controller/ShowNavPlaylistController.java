package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.Account;
import Model.Playlist;
import database.DAOAccount;
import database.DAOPlaylist;

/**
 * Servlet implementation class ShowNavPlaylistController
 */
public class ShowNavPlaylistController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowNavPlaylistController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String idplaylist = request.getParameter("idplaylist");
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		Playlist playlist = new DAOPlaylist().selectById(idplaylist, account.getUsername());
		
		request.setAttribute("navPlaylistSongs",playlist.getListSong() );
		request.getRequestDispatcher("/views/pages/navPlaylist.jsp").forward(request, response);;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
