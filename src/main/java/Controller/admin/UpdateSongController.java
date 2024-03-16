package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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
 * Servlet implementation class UpdateSongController
 */
@MultipartConfig
public class UpdateSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateSongController() {
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

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		DAOSong daoSong = new DAOSong();
		// getpara của các thuộc tính
		String idSong = request.getParameter("idSong");
		Song song = daoSong.selectById(idSong);
		String nameSong = request.getParameter("name-song");
		String nameSinger = request.getParameter("name-singer");
		String duration = request.getParameter("duration");
		String genre = request.getParameter("genre");
		Part fileImg = request.getPart("image");
		Part fileAudio = request.getPart("audio");

		// xử lí đối tuog
		String fileNameImg = "";
		String fileNameAudio = "";
		// Chuyển đổi LocalTime thành java.sql.Time
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		LocalTime localTime = LocalTime.parse(duration, formatter);
		Time duratime = Time.valueOf(localTime);
		String url_Img = "assets/img/" + genre + "/" + fileNameImg;
		String url_Audio = "assets/audio/" + genre + "/" + fileNameAudio;
		if (fileImg.getSubmittedFileName().isEmpty()) {
			url_Img = song.getUrl_Img();
				
		} else {
			fileNameImg = Path.of(fileImg.getSubmittedFileName()).getFileName().toString();
			url_Img = "assets/img/" + genre + "/" + fileNameImg;
		}

		if (fileAudio.getSubmittedFileName().isEmpty()) {
			url_Audio = song.getUrl_Audio();
		} else {
			fileNameAudio = Path.of(fileAudio.getSubmittedFileName()).getFileName().toString();
			 url_Audio = "assets/audio/" + genre + "/" + fileNameAudio;
		}
		
		
		Song newSong = new Song(idSong, nameSong, duratime, genre,
				new Singer(song.getSinger().getId_Singer(), nameSinger), url_Img, url_Audio, song.getSongView());
		System.out.println(newSong);
		// update
		System.out.println(daoSong.update(newSong));

		// xóa cấu trúc thư mục cũ
		if (!fileImg.getSubmittedFileName().isEmpty()) {
			String realpathImg = request.getServletContext().getRealPath(song.getUrl_Img());

			File imgF = new File(realpathImg);
			imgF.delete();

			// xoa thu muc trống trong cấu trúc thư mục
			File emptyDicImg = new File(request.getServletContext().getRealPath("/assets/img/" + song.getGenre()));

			if (emptyDicImg == null || emptyDicImg.listFiles().length == 0) {
				emptyDicImg.delete();
			}

			String newrealpathImg = request.getServletContext().getRealPath("/assets/img/") + genre;

			if (!Files.exists(Path.of(newrealpathImg))) {
				Files.createDirectory(Path.of(newrealpathImg));
			}
			String path_Img = newrealpathImg + "\\" + fileNameImg;
			fileImg.write(path_Img);
		}

		if (!fileAudio.getSubmittedFileName().isEmpty()) {
			String realpathAudio = request.getServletContext().getRealPath(song.getUrl_Audio());
			File audioF = new File(realpathAudio);
			audioF.delete();

			File emptyDicAudio = new File(request.getServletContext().getRealPath("/assets/audio/" + song.getGenre()));
			if (emptyDicAudio == null|| emptyDicAudio.listFiles().length == 0) {
				emptyDicAudio.delete();
			}

			String newrealpathAudio = request.getServletContext().getRealPath("/assets/audio/") + genre;
			// add cấu trúc thư mục mới
			try {

				if (!Files.exists(Path.of(newrealpathAudio))) {
					Files.createDirectory(Path.of(newrealpathAudio));
				}
				String path_Audio = newrealpathAudio + "\\" + fileNameAudio;
				fileAudio.write(path_Audio);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		response.sendRedirect("/MusicWebsite/views/admin/admin.jsp");
	}

}
