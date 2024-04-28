package Controller.chart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import  org.jfree.chart.*;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.ui.TextAnchor;
import org.jfree.data.category.DefaultCategoryDataset;

import database.DAOHistoryPremium;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;


/**
 * Servlet implementation class ProfitChartServlet
 */

@WebServlet("/profitChartImage")
public class ProfitChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfitChartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 // Create a dataset
		DAOHistoryPremium daoHistoryPremium = new DAOHistoryPremium();
		 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		 int currentMonth = LocalDate.now().getMonthValue();
		
		        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
		       
		
	        for (int i = 1; i <= 12; i++) {
				if(i<=currentMonth) {
					 dataset.addValue(daoHistoryPremium.getProfitForMonth(i), "Profit", months[i-1]);
				}else {
					   dataset.addValue(null, "Profit", months[i-1]);
				}
			}
	        // Create chart
	        JFreeChart chart = ChartFactory.createLineChart(
	                "Monthly Profit", // Chart title
	                "Month",          // X-axis label
	                "Profit ($)",     // Y-axis label
	                dataset           // Dataset
	        );
		 chart.setBackgroundPaint(Color.WHITE);

	        // Get the plot (where the chart data is visualized)
	        CategoryPlot plot = (CategoryPlot) chart.getPlot();

	        // Customize the appearance of the plot
	        plot.setBackgroundPaint(new Color(230, 230, 230)); // Light gray background color
	        plot.setRangeGridlinePaint(Color.WHITE); // White gridlines
	        plot.setRangeGridlinesVisible(true);

	        // Customize the appearance of the line
	        LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot.getRenderer();
	        renderer.setSeriesPaint(0, new Color(33, 150, 243)); // Blue line color
	        renderer.setDefaultItemLabelPaint(Color.BLACK); // Black label color
	        renderer.setDefaultPositiveItemLabelPosition(new ItemLabelPosition(
	                ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));

	        // Set response content type
	        response.setContentType("image/png");

	        // Send the chart as PNG to the client
	        OutputStream out = response.getOutputStream();
	        ChartUtils.writeChartAsPNG(out, chart, 880, 600); 
//	        response.sendRedirect("/MusicWebsite/views/admin/admin-pane.jsp.jsp?url=" + imageURL);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
