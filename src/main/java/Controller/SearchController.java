package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;

import Model.Song;
import database.DAOSong;

/**
 * Servlet implementation class SearchController
 */
public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		String searchInput = request.getParameter("search-input");
//		request.setAttribute("searchInput", searchInput);
//		
//		request.getRequestDispatcher("/views/pages/search.jsp").forward(request, response);

		String searchInput = request.getParameter("search-input");
		ArrayList<Song> songs = new DAOSong().selectAllBySearch(searchInput);
		PrintWriter out = response.getWriter();
		
		System.out.println(123);

		for (Song song : songs) {
			out.println("<div class=\"item all-music-item\">\r\n"
					+ "									<div class=\"inner-table\" id=\"" + song.getId_Song() + "\">\r\n"
					+ "										<div class=\"inner-td\">\r\n"
					+ "											<img src=\"" + song.getUrl_Img() + "\" width=75px height=75px\r\n"
					+ "												alt=\"...\">\r\n"
					+ "											<button type=\"button\" class=\"btn btn-music\" id=\"" + song.getId_Song() + "\"\r\n"
					+ "												onclick=\"playMusic(this.id, '" + song.getName_Song() + "', '" + song.getSinger().getName_Singer() + "', '" + song.getUrl_Img() + "')\">\r\n"
					+ "												<audio src=\"" + song.getUrl_Audio() + "\" class=\"au" + song.getId_Song() + "\"></audio>\r\n"
					+ "												<i class=\"bi" + song.getId_Song() + " bi-play-circle\"></i>\r\n"
					+ "											</button>\r\n"
					+ "										</div>\r\n"
					+ "										<div class=\"song-singer inner-td\">\r\n"
					+ "											<b>" + song.getName_Song() + "</b> <br> <a href=\"\" class=\"singer\">" + song.getName_Song() + "\r\n"
					+ "											</a>\r\n"
					+ "										</div>\r\n"
					+ "										<div class=\"inner-td\">\r\n"
					+ "											<button class=\"btn btn-inner-td\">\r\n"
					+ "												<i class=\"bi bi-share\" style=\"color: white; font-size: 13px\"></i>\r\n"
					+ "											</button>\r\n"
					+ "											<br>\r\n"
					+ "											<button class=\"btn btn-inner-td\">\r\n"
					+ "												<i class=\"bi bi-download\"\r\n"
					+ "													style=\"color: white; font-size: 13px\"></i>\r\n"
					+ "											</button>\r\n"
					+ "										</div>\r\n" + "									</div>\r\n"
					+ "								</div>");
		}
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
