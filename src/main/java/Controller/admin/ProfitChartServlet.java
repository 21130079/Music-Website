package Controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import  org.jfree.chart.*;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;

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
		  DefaultPieDataset<String> dataset = new DefaultPieDataset<String>();
	        dataset.setValue("Doanh thu", 10000);
	        dataset.setValue("Chi phí", 5000);
	        dataset.setValue("Lợi nhuận", 5000);

	        // Tạo biểu đồ lợi nhuận
	        JFreeChart chart = ChartFactory.createPieChart(
	                "Biểu đồ Lợi Nhuận",
	                dataset,
	                true,
	                true,
	                false
	        );

	        // Tùy chỉnh màu sắc
	        chart.setBackgroundPaint(Color.white);
	        chart.getTitle().setPaint(Color.black);

	        PiePlot plot = (PiePlot) chart.getPlot();
	        plot.setLabelFont(new Font("Arial", Font.PLAIN, 12));
	        plot.setNoDataMessage("Không có dữ liệu để hiển thị");

	        // Tạo thư mục tạm thời để lưu trữ hình ảnh
	        String tempDirPath = getServletContext().getRealPath("/temp");
	        File tempDir = new File(tempDirPath);
	        if (!tempDir.exists()) {
	            tempDir.mkdirs();
	        }

	        // Tạo tên tệp cho hình ảnh
	        String fileName = "profit_chart.png";
	        String filePath = tempDirPath + File.separator + fileName;

	        // Lưu trữ hình ảnh
	        BufferedImage bufferedImage = chart.createBufferedImage(400, 300);
	        ImageIO.write(bufferedImage, "png", new File(filePath));

	        // Tạo URL cho hình ảnh
	        String imageURL = request.getContextPath() + "/temp/" + fileName;

	        // Chuyển hướng đến trang JSP để hiển thị hình ảnh
	        response.sendRedirect("/MusicWebsite/views/admin/admin-pane.jsp.jsp?url=" + imageURL);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
