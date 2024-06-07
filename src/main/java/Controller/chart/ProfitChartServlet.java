package Controller.chart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import database.DAOHistoryPremium;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

/**
 * Servlet implementation class ProfitChartServlet
 */
public class ProfitChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfitChartServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOHistoryPremium daoHistoryPremium = new DAOHistoryPremium();
        int currentMonth = LocalDate.now().getMonthValue();
        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        JSONArray labels = new JSONArray();
        JSONArray data = new JSONArray();

        for (int i = 1; i <= 12; i++) {
            labels.put(months[i - 1]);
            if (i <= currentMonth) {
                data.put(daoHistoryPremium.getProfitForMonth(i));
            } else {
                data.put(JSONObject.NULL);
            }
        }

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("labels", labels);
        jsonResponse.put("data", data);

        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
