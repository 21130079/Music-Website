package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import Model.ELevel.Level;
import Model.IPAddress;
import Model.Log;
import Model.Song;
import database.DAOLog;
import database.DAOPlaylist;
import database.DAOSong;

/**
 * Servlet implementation class DeleteSongController
 */
public class DeleteSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteSongController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DAOSong daoSong = new DAOSong();
		String idSong = request.getParameter("idSong");
		Song song = daoSong.selectById(idSong);
		// xóa file trong sql server
		daoSong.delete(song);

		// LOG
		String ipAddress = request.getRemoteAddr();
		if (ipAddress.equals("0:0:0:0:0:0:0:1")) {
			ipAddress = IPAddress.getIPPublic();

		}
		daoSong.setIpAddress(ipAddress);
		
		
		// xóa file trog cấu trúc thư mục
		String realpathImg = request.getServletContext().getRealPath(song.getUrl_Img());

		File imgF = new File(realpathImg);
		imgF.delete();
		String realpathAudio = request.getServletContext().getRealPath(song.getUrl_Audio());

		File audioF = new File(realpathAudio);
		audioF.delete();

		// xoa thu muc trống trong cấu trúc thư mục
		File emptyDicImg = new File(request.getServletContext().getRealPath("/assets/img/" + song.getGenre()));
		if (emptyDicImg.listFiles() == null || emptyDicImg.listFiles().length == 0) {
			emptyDicImg.delete();
		}
		File emptyDicAudio = new File(request.getServletContext().getRealPath("/assets/audio/" + song.getGenre()));
		if (emptyDicAudio.listFiles() == null || emptyDicAudio.listFiles().length == 0) {

			emptyDicAudio.delete();
		}

		response.sendRedirect("/MusicWebsite/views/admin/admin_song.jsp");
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
