package Controller.user;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;



/**
 * Servlet implementation class upgradeSelectorController
 */
public class UpgradeSelectorController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpgradeSelectorController() {
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
		String type = request.getParameter("type");

		if (type.equals("mini")) {
			request.setAttribute("title", "Mini");
			request.setAttribute("color", "#CFF56A");
			request.setAttribute("optionText1", "1 Week");
			request.setAttribute("optionText2", "2 Week");

			request.setAttribute("optionPrice1", "15000");
			request.setAttribute("optionPrice2", "30000");
		} else if (type.equals("individual")) {
			request.setAttribute("color", "#FFD2D7");
			request.setAttribute("title", "Individual");
			request.setAttribute("optionText1", "1 months");
			request.setAttribute("optionText2", "6 months");

			request.setAttribute("optionPrice1", "55000");
			request.setAttribute("optionPrice2", "255000");
		} else if (type.equals("student")) {
			request.setAttribute("color", "#C4B1D4");
			request.setAttribute("title", "Student");
			request.setAttribute("optionText1", "1 months");
			request.setAttribute("optionText2", "6 months");

			request.setAttribute("optionPrice1", "45000");
			request.setAttribute("optionPrice2", "225000");
		}
		
		request.getRequestDispatcher("/views/pages/upgrade_selector.jsp").forward(request, response);
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
