package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.Account;
import database.DAOFavorite;
import database.DAOPlaylist;

/**
 * Servlet implementation class SendToAddSongController
 */
public class SendToAddSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendToAddSongController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		DAOFavorite favorite = new DAOFavorite();
		String type = request.getParameter("type");
		request.setAttribute("type", type);
		if (type.equals("favorite")) {
			request.setAttribute("listNotInType", favorite.selectSongNotInAcc(account.getUsername()));
		}else if(type.equals("playlist")) {
			String idplaylist = request.getParameter("idplaylist");
			request.setAttribute("idplaylist", idplaylist);
			request.setAttribute("listNotInType", new DAOPlaylist().selectSongNotInAcc(account.getUsername(), idplaylist));
		}
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/views/pages/addSong.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
