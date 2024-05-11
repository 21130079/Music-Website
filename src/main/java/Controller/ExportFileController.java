package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;

import Model.HistoryPremium;
import database.DAOHistoryPremium;

/**
 * Servlet implementation class ExportFileController
 */
public class ExportFileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExportFileController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		DAOHistoryPremium daohistory = new DAOHistoryPremium();
		ArrayList<HistoryPremium> historyList = daohistory.selectAll();
		response.setContentType("text/csv");

		response.setHeader("Content-Disposition", "attachment; filename=\"statistical_file.csv\"");

		String exportType = request.getParameter("exportTypeInput");
		// theo ngày
		if (exportType.equalsIgnoreCase("export1")) {
			writer.println("Statistical sell today");
			writer.println("Type,User,Price type,Time");
			for (HistoryPremium historyPremium : historyList) {

				writer.println(writeTypePremium(historyPremium.getTypePrenium()) + ","
						+ historyPremium.getAccount().getUsername().toString() + ","
						+ historyPremium.getPriceByType(historyPremium.getTypePrenium()) + ","
						+ historyPremium.getTimeAsString());

			}
			writer.print("Tổng tiền: " + "," + "," + "," + daohistory.getProfitForToday());
		} else {
			String bestType = request.getParameter("bestType");
			if (bestType.equalsIgnoreCase("day")) {
				String dayValue = request.getParameter("dayValue");
				try {

					HistoryPremium dayPremium = daohistory.getBestTypeInDay(dayValue);
					if (dayPremium != null) {
						Date date = dayPremium.changeStringToDate(dayValue);
						ArrayList<HistoryPremium> dayPremiums = daohistory.selectAllBestInDay(date);
						double totalPrice = daohistory.getProfitForTime(dayPremium.getStartedDate(), 0, 0,
								dayPremium.getTypePrenium(), bestType,0);
						writer.println("Statistical best-selling in day: " + dayValue);
						writer.println("Type,Quantity,Total price,Date");
						writer.println(writeTypePremium(dayPremium.getTypePrenium()) + "," + dayPremium.getCountPremiumType() + ","
								+ totalPrice + "," + dayPremium.getTimeAsString());
						writer.println("Type,User,Price type,Time");
						for (HistoryPremium historyPremium : dayPremiums) {

							writer.println(writeTypePremium(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getAccount().getUsername().toString() + ","
									+ historyPremium.getPriceByType(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getTimeAsString());

						}
					} else {
						writer.println("Type,Quantity,Total price,Date");
					}

				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			} else if (bestType.equalsIgnoreCase("month")) {
				String monthValue = request.getParameter("monthValue");
				int month = Integer.parseInt(monthValue);

				String yearValue = request.getParameter("yearValue");
				int year = Integer.parseInt(yearValue);

				try {
					HistoryPremium monthPremium = daohistory.getBestTypeInMonth(month, year);

					if (monthPremium != null) {
						ArrayList<HistoryPremium> monthPremiums = daohistory.selectAllBestInMonth(month, year);
						double totalPrice = daohistory.getProfitForTime(null, month, year,
								monthPremium.getTypePrenium(), bestType,0);
						;
						writer.println("Statistical best-selling in month: " + month+"/"+year);
						writer.println("Type,Quantity,Total price,Date");
						writer.println(writeTypePremium(monthPremium.getTypePrenium()) + "," + monthPremium.getCountPremiumType() + ","
								+ totalPrice + "," + monthPremium.monthString(month, year));
						writer.println("Type,User,Price type,Time");
						for (HistoryPremium historyPremium : monthPremiums) {

							writer.println(writeTypePremium(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getAccount().getUsername().toString() + ","
									+ historyPremium.getPriceByType(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getTimeAsString());

						}
					} else {
						writer.println("Type,Quantity,Total price,Date");
					}
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			} else if (bestType.equalsIgnoreCase("year")) {

				String yearValue = request.getParameter("yearValue");
				int year = Integer.parseInt(yearValue);

				try {
					HistoryPremium yearPremium = daohistory.getBestTypeInYear(year);
					if (yearPremium != null) {
						ArrayList<HistoryPremium> yearPremiums = daohistory.selectAllBestInYear(year);
						double totalPrice = daohistory.getProfitForTime(null, 0, year, yearPremium.getTypePrenium(),
								bestType,0);
						writer.println("Statistical best-selling in year: " +year);
						writer.println("Type,Quantity,Total price,Date");
						writer.println(writeTypePremium(yearPremium.getTypePrenium()) + "," + yearPremium.getCountPremiumType() + ","
								+ totalPrice + "," + year);
						writer.println("Type,User,Price type,Time");
						for (HistoryPremium historyPremium : yearPremiums) {

							writer.println(writeTypePremium(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getAccount().getUsername().toString() + ","
									+ historyPremium.getPriceByType(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getTimeAsString());

						}
					} else {
						writer.println("Type,Quantity,Total price,Date");
					}
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}else {
				String preciousValue = request.getParameter("preciousValue");
				int precious = Integer.parseInt(preciousValue);
				
				String yearValue = request.getParameter("yearValue");
				int year = Integer.parseInt(yearValue);

				try {
					HistoryPremium preciousPremium = daohistory.getBestTypeInPrecious(precious,year);
					if (preciousPremium != null) {
						ArrayList<HistoryPremium> premiumsPremiums = daohistory.selectAllBestInPrecious(precious, year);
						double totalPrice = daohistory.getProfitForTime(null, 0, year, preciousPremium.getTypePrenium(),
								bestType,precious);
						writer.println("Statistical best-selling in precious: " +precious);
						writer.println("Type,Quantity,Total price,Precious");
						writer.println(writeTypePremium(preciousPremium.getTypePrenium()) + "," + preciousPremium.getCountPremiumType() + ","
								+ totalPrice + "," + preciousPremium.getPrecious());
						writer.println("Type,User,Price type,Time");
						for (HistoryPremium historyPremium : premiumsPremiums) {

							writer.println(writeTypePremium(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getAccount().getUsername().toString() + ","
									+ historyPremium.getPriceByType(historyPremium.getTypePrenium()) + ","
									+ historyPremium.getTimeAsString());

						}
					} else {
						writer.println("Type,Quantity,Total price,Date");
					}
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

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

	private String writeTypePremium(int type) {
		String str = "";
		switch (type) {
		case 1: {

			return str += "Mini: 1 week";
		}
		case 2: {
			return str += "Mini: 2 weeks";

		}
		case 3: {
			return str += "Individual: 1 month";

		}
		case 4: {
			return str += "Individual: 6 months";

		}
		case 5: {
			return str += "Student: 1 month";

		}
		case 6: {
			return str += "Student: 6 months";

		}

		default:
			throw new IllegalArgumentException("Unexpected value: " + type);
		}
	}

}
