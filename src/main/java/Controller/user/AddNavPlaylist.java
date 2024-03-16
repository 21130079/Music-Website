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
import database.DAOPlaylist;
import database.DAOSong;

/**
 * Servlet implementation class AddNavPlaylist
 */
public class AddNavPlaylist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNavPlaylist() {
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
		// lay para tu cai list dc nguoi dung chonn
		String[] idSongs = request.getParameterValues("idSong");
		// tao danh sach moi de add cac bai hat duoc tim thay vao
		ArrayList<Song> chosenSongs = new ArrayList<Song>();

		// tien hanh tim kiem
		ArrayList<Song> allSong = new DAOSong().selectAll();
		for (String idSong : idSongs) {
			for (Song song : allSong) {
				if (idSong.equals(song.getId_Song())) {
					chosenSongs.add(song);
				}
			}
		}
		// insert all bai hat tim dc
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		String idplaylist = request.getParameter("idplaylist");
		DAOPlaylist daoPlaylist = new DAOPlaylist();
		
		try {
			daoPlaylist.insertAllSong(idplaylist, account.getUsername(), chosenSongs);
			session.setAttribute("account", new DAOAccount().rereshAccount(account) );
		}catch (NullPointerException e) {
			
		}
		
		request.setAttribute("idplaylist", idplaylist);
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
