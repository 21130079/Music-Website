
package Controller.chart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

import database.DAOSong;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.awt.GradientPaint;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;
/**
 * Servlet implementation class TopSongsChartImage
 */
public class TopSongsChartImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopSongsChartImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		DAOSong daoSong = new DAOSong();
		for (Map.Entry<String, Integer> entry : daoSong.getTopSongs().entrySet()) {
			String key = entry.getKey();
			int val = entry.getValue();
			 dataset.addValue(val+1000,"Top Songs", key);
		}

        // Create chart
        JFreeChart chart = ChartFactory.createBarChart(
                "Top 5 Most Played Songs", // Chart title
                "Songs", // X-axis label
                "Number of Plays", // Y-axis label
                dataset // Dataset
        );

        // Customize the appearance of the chart
        chart.setBackgroundPaint(Color.WHITE);
        
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        plot.setBackgroundPaint(Color.lightGray);
        
        BarRenderer renderer = (BarRenderer) plot.getRenderer();
     // Đặt màu sắc của các cột
        renderer.setSeriesPaint(0, new Color(255, 102, 102)); // Màu đỏ

        // Đặt đường viền cho các cột
        renderer.setSeriesOutlinePaint(0, Color.BLACK); // Đường viền đen
        GradientPaint gp = new GradientPaint(0.0f, 0.0f, Color.WHITE, 0.0f, 0.0f, new Color(255, 102, 102));
        renderer.setSeriesPaint(0, gp);
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
