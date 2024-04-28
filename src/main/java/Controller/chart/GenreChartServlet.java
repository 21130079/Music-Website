package Controller.chart;

import jakarta.servlet.ServletException;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

import database.DAOSong;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.awt.Color;
import java.io.OutputStream;
import java.util.Map;
/**
 * Servlet implementation class GenreChartServlet
 */

@WebServlet("/GenreChartImage")
public class GenreChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenreChartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DefaultPieDataset dataset = new DefaultPieDataset();
		DAOSong daoSong = new DAOSong();
		for (Map.Entry<String, Integer> entry : daoSong.getAllGenres().entrySet()) {
			String key = entry.getKey();
			Integer val = entry.getValue();
			 dataset.setValue(key, val);
		}
      
        // Create chart
        JFreeChart chart = ChartFactory.createPieChart(
                "Music Genre Distribution", // Chart title
                dataset, // Dataset
                true, // Include legend
                true, // Include tooltips
                false // Exclude URLs
        );

        // Customize the appearance of the chart
        chart.setBackgroundPaint(Color.WHITE);

        // Set response content type
        response.setContentType("image/png");

        // Send the chart as PNG to the client
        OutputStream out = response.getOutputStream();
        ChartUtils.writeChartAsPNG(out, chart, 430, 300);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
