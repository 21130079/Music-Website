package Controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import database.DAOAccount;

/**
 * Servlet implementation class ConfirmEmailController
 */
public class ConfirmEmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmEmailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		String errorEmail = "";
		
		boolean isSent = new DAOAccount().checkEmailExist(email);
		
		System.out.println(isSent);

		if (isSent) {
			sendVerifyEmail(email);
		} else {
			errorEmail = "Email does not exist in database !";
		}

		session.setAttribute("errorEmail", errorEmail);
		session.setAttribute("isSent", isSent);
		session.setAttribute("isVerify", false);
		session.setAttribute("email", email);

		request.getRequestDispatcher("/views/pages/changePassword.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void sendVerifyEmail(String email) {
		final String username = "21130079@st.hcmuaf.edu.vn";
		final String password = "gmiu tbcc plmi neuu";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail sử dụng SMTP
		props.put("mail.smtp.port", "587"); // Cổng SMTP của Gmail

		Session session = Session.getInstance(props, new Authenticator() {
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("21130079@st.hcmuaf.edu.vn"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

			message.setSubject("Verify Your KDMusic Email Account !");
			message.setContent("<p>Please click the link below to <b>verify your email</b> and see your <b>new password</b>:</p>"
					+ "<h4 style='color:red'>Note that when you click, your password will be changed</h4>"
					+ "<a href='http://localhost:8080/MusicWebsite/ChangePasswordController'>VERIFY</a>", "text/html");

			Transport.send(message);
			System.out.println(message.toString());
			System.out.println("Email sent successfully!");
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}
