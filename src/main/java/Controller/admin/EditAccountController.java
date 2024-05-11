package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import Model.Account;
import database.DAOAccount;

/**
 * Servlet implementation class UpdateAccountController
 */
public class EditAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditAccountController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String username = request.getParameter("username");
		 
		  		Account account = new DAOAccount().selectByUsername(username);
		  		if (account != null) {
	                // Chuyển đổi mảng roles thành một chuỗi JSON
	                JsonArray rolesArray = new JsonArray();
	                for (String role : account.getRoles()) {
	                    rolesArray.add(role);
	                }

	                // Tạo đối tượng JSON để chứa thông tin tài khoản và mảng roles
	                JsonObject responseDataJson = new JsonObject();
	                responseDataJson.addProperty("username", account.getUsername());
	                responseDataJson.addProperty("email", account.getEmail());
	                responseDataJson.addProperty("password", account.getPassword());
	                responseDataJson.add("roles", rolesArray);

	                // Chuyển đổi đối tượng JSON thành chuỗi JSON
	                String responseData = new Gson().toJson(responseDataJson);

	                response.setContentType("application/json");
	                PrintWriter out = response.getWriter();
	                out.print(responseData);
	                out.flush();
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
