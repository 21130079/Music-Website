package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Model.Song;
import database.DAOSong;

/**
 * Servlet implementation class ListSongController
 */
public class ListSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListSongController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String typelist = request.getParameter("typelist");
		String id  = request.getParameter("id");
		
		Song song = new DAOSong().selectById(id);
		
		request.setAttribute("song", song);
		if(typelist.equalsIgnoreCase("ranking")) {
			request.setAttribute("listSong", new DAOSong().getRanking());
		}else if(typelist.equalsIgnoreCase("trending")) {
			request.setAttribute("listSong", new DAOSong().getRanking());
		}
		
		request.setAttribute("id", id);
		
		request.getRequestDispatcher("/views/pages/navListSong.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
