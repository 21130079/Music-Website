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
import Model.IPAddress;
import Model.Log;
import Model.Song;
import Model.ELevel.Level;
import database.DAOAccount;
import database.DAOFavorite;
import database.DAOLog;
import database.DAOPlaylist;
import database.DAOSong;

/**
 * Servlet implementation class AddFavoriteController
 */
public class AddFavoriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddFavoriteController() {
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

		
		// insert all bai hat tim dc
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		// tien hanh tim kiem
		ArrayList<Song> allSong = new DAOSong().selectAll();
		for (String idSong : idSongs) {
			for (Song song : allSong) {
				if (idSong.equals(song.getId_Song())) {

					chosenSongs.add(song);
				}
			}
		}

		DAOFavorite daoFavorite = new DAOFavorite();
		daoFavorite.insertAll(chosenSongs, account.getUsername());
		
//		//log
//		String ipAddress = request.getRemoteAddr();
//		if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
//			ipAddress = IPAddress.getIPPublic();
//
//		}
//		for (Song song : chosenSongs) {
//			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Favorites", null,
//					"username=" + account.getUsername() + ", id_song=" + song.getId_Song(), null, true);
//			new DAOLog().insert(log);
//		}

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
