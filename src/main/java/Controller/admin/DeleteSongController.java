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

import Model.Song;
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
		// TODO Auto-generated method stub
		DAOSong daoSong = new DAOSong();
		String idSong = request.getParameter("idSong");
		Song song = daoSong.selectById(idSong);
		// xóa file trong sql server
		daoSong.delete(idSong);
		// xóa file trog cấu trúc thư mục
		String realpathImg = request.getServletContext().getRealPath(song.getUrl_Img());

		try {
			File imgF = new File(realpathImg);
			imgF.delete();
		} catch (NullPointerException e) {
			// TODO: handle exception
		}
		

		String realpathAudio = request.getServletContext().getRealPath(song.getUrl_Audio());

		
		try {
			File audioF = new File(realpathAudio);
			audioF.delete();
		} catch (NullPointerException e) {
			// TODO: handle exception
		}
		
		
		// xoa thu muc trống trong cấu trúc thư mục
		File emptyDicImg = new File(request.getServletContext().getRealPath("/assets/img/"+song.getGenre()));	
		if(emptyDicImg.listFiles()==null || emptyDicImg.listFiles().length==0) {
			emptyDicImg.delete();
		}
		File emptyDicAudio = new File(request.getServletContext().getRealPath("/assets/audio/"+song.getGenre()));	
		if(emptyDicAudio.listFiles()==null || emptyDicAudio.listFiles().length==0) {
			
			emptyDicAudio.delete();
		}
		
		response.sendRedirect("/MusicWebsite/views/admin/admin.jsp");
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
