package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import Model.Singer;
import Model.Song;
import database.DAOSinger;
import database.DAOSong;

/**
 * Servlet implementation class LazyLoadingController
 */
public class LazyLoadingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LazyLoadingController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int num;
		
		if (session.getAttribute("num") == null) {
			num = 3;
		} else {
			num = (int) session.getAttribute("num");
		}
		
		HashMap<String, ArrayList<Song>> singers = new DAOSinger().getSongsOfSinger(num);
		session.setAttribute("num", num + 3);
		
		PrintWriter out = response.getWriter();
		
		for (Map.Entry<String, ArrayList<Song>> singer : singers.entrySet()) {
			out.println("<div class=\"table-allMusic\">\r\n"
					+ "			<h1 class=\"topic-music\">\r\n"
					+ "				<b>" + singer.getKey() + "</b>\r\n"
					+ "			</h1>\r\n"
					+ "			<div class=\"trendingTable\">");
			
			for (Song song : singer.getValue()) {
				out.println("<div class=\"item trending-box\">\r\n"
						+ "						<div class=\"card background-music\">\r\n"
						+ "							<div class=\"img-form\">\r\n"
						+ "								<img src=\"" + song.getUrl_Img() + "\" class=\"card-img-top\" alt=\"...\">\r\n"
						+ "								<div class=\"icon-in-img\">\r\n"
						+ "\r\n"
						+ "									<a class=\"inner-icon-in-img\" href=\"navListSong.jsp\"><i\r\n"
						+ "										style=\"font-size: 50px\" class=\"bi-play-circle\"></i></a>\r\n"
						+ "\r\n"
						+ "\r\n"
						+ "								</div>\r\n"
						+ "							</div>\r\n"
						+ "							<div>\r\n"
						+ "								<h5 class=\"title-trending\">\r\n"
						+ "									<b>" + song.getName_Song() + "</b>\r\n"
						+ "								</h5>\r\n"
						+ "								<h6 class=\"title-trending\">\r\n"
						+ "									<b>" + song.getSinger().getName_Singer() + "</b>\r\n"
						+ "								</h6>\r\n"
						+ "							</div>\r\n"
						+ "						</div>\r\n"
						+ "					</div>");
			}
			
			out.println("</div>\r\n"
					+ "		</div>");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
