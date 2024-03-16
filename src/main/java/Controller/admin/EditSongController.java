	package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import Model.Singer;
import Model.Song;
import database.DAOSong;

/**
 * Servlet implementation class EditSongController
 */
public class EditSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditSongController() {
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
		String idSong = request.getParameter("idSong");
		Song song = new DAOSong().selectById(idSong);
		request.setAttribute("song", song);
		String pathImg = request.getServletContext().getRealPath(song.getUrl_Img());
		String pathAudio = request.getServletContext().getRealPath(song.getUrl_Audio());
		request.setAttribute("pathImg", pathImg);
		request.setAttribute("pathAudio", pathAudio);
		request.getRequestDispatcher("/views/admin/admin_edit.jsp").forward(request, response);
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
