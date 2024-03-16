package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.net.URL;
import java.nio.file.FileAlreadyExistsException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.CodeSource;
import java.security.ProtectionDomain;
import java.sql.Time;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import Model.Singer;
import Model.Song;
import database.DAOSong;

/**
 * Servlet implementation class AddSongController
 */
@MultipartConfig
public class AddSongController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddSongController() {
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
		response.setContentType("text/html;charset=UTF-8");
		try {
			// XU LI LƯU DỮ LIỆU
			String genre = request.getParameter("genre");
			Part fileImg = request.getPart("image");
			Part fileAudio = request.getPart("audio");

			String realpathImg = request.getServletContext().getRealPath("/assets/img/") + genre;

			String fileNameImg = Path.of(fileImg.getSubmittedFileName()).getFileName().toString();
			if (!Files.exists(Path.of(realpathImg))) {
				Files.createDirectory(Path.of(realpathImg));
			}
			String path_Img = realpathImg + "\\" + fileNameImg;
			fileImg.write(path_Img);

			String realpathAudio = request.getServletContext().getRealPath("/assets/audio/") + genre;
			String fileNameAudio = Path.of(fileAudio.getSubmittedFileName()).getFileName().toString();
			if (!Files.exists(Path.of(realpathAudio))) {
				Files.createDirectory(Path.of(realpathAudio));
			}
			String path_Audio = realpathAudio + "\\" + fileNameAudio;
			fileAudio.write(path_Audio);

			// XỬ LÝ ADD ĐỐI TƯỢNG SONG VÀO DATABASE
			String nameSong = request.getParameter("name-song");
			String nameSinger = request.getParameter("name-singer");
			String duration = request.getParameter("duration");
			String url_Img = "assets/img/" + genre + "/" + fileNameImg;
			String url_Audio = "assets/audio/" + genre + "/" + fileNameAudio;

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
			LocalTime localTime = LocalTime.parse(duration, formatter);

			// Chuyển đổi LocalTime thành java.sql.Time
			Time sqlTime = Time.valueOf(localTime);
			int minute = sqlTime.getHours();
			int second = sqlTime.getMinutes();

			Song song = new Song(null, nameSong, new Time(0, minute, second), genre, new Singer(null, nameSinger),
					url_Img, url_Audio, 0);

			new DAOSong().insert(song);
			response.sendRedirect("/MusicWebsite/views/admin/admin.jsp");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		String realpathImg = "C:\\Users\\MSI DAT\\eclipse-workspace-jee\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MusicWebsite\\assets\\img\\ass";
		 
        if (!Files.exists(Paths.get(realpathImg))) {
            try { System.out.println("success");
                Files.createDirectories(Paths.get(realpathImg));
                System.out.println("success");
            } catch (FileAlreadyExistsException e) {
                // Handle if the directory was created by another thread/process
                System.out.println("Directory already exists: " + realpathImg);
            } catch (IOException e) {
                // Handle other IO exceptions
                e.printStackTrace();
            }
        }
	}
}
