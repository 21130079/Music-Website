package database;

import java.io.Console;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;

import Model.Account;
import Model.HistoryPremium;

public class DAOHistoryPremium extends AbsDao<HistoryPremium> {
	Connection connection = fileUtils.connectDb();

	@Override
	public int insert(HistoryPremium t) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection.prepareStatement(
					"insert into history_premium_accounts(username,type_premium,started_date)" + "values(?,?,?)");

			stmt.setString(1, t.getAccount().getUsername());
			stmt.setInt(2, t.getTypePrenium());

			java.util.Date utilDate = new java.util.Date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			stmt.setDate(3, sqlDate);
			stmt.execute();
			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(t.getAccount().getUsername());
		return 0;
	}

	@Override
	public ArrayList<HistoryPremium> selectAll() {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from history_premium_accounts");

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	//lấy ra danh sách ngày đã chọn
	public ArrayList<HistoryPremium> selectAllBestInDay(Date date) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "FROM history_premium_accounts\r\n"
							+ "WHERE type_premium = (\r\n"
							+ "    SELECT TOP 1 type_premium\r\n"
							+ "    FROM history_premium_accounts\r\n"
							+ "    GROUP BY type_premium\r\n"
							+ "    ORDER BY COUNT(*) DESC\r\n"
							+ ") and 	 started_date = ?");

			stmt.setDate(1, date);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public ArrayList<HistoryPremium> selectAllInDay(Date date) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "FROM history_premium_accounts\r\n"
							+ "WHERE started_date = ?");

			stmt.setDate(1, date);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	//lấy ra danh sách tháng đã chọn
	public ArrayList<HistoryPremium> selectAllBestInMonth(int month, int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "FROM history_premium_accounts\r\n"
							+ "WHERE type_premium = (\r\n"
							+ "    SELECT TOP 1 type_premium\r\n"
							+ "    FROM history_premium_accounts\r\n"
							+ "    GROUP BY type_premium\r\n"
							+ "    ORDER BY COUNT(*) DESC\r\n"
							+ ") and 	MONTH(started_date) =? and  YEAR(started_date) =? ;");

			stmt.setInt(1, month);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	
	public ArrayList<HistoryPremium> selectAllInMonth(int month, int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "FROM history_premium_accounts\r\n"
							+ "WHERE MONTH(started_date) =? and  YEAR(started_date) =? ;");

			stmt.setInt(1, month);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	public ArrayList<HistoryPremium> selectAllBestInYear(int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "	FROM history_premium_accounts\r\n"
							+ "	WHERE type_premium = (\r\n"
							+ "	    SELECT TOP 1 type_premium\r\n"
							+ "	    FROM history_premium_accounts\r\n"
							+ "	    GROUP BY type_premium\r\n"
							+ "	    ORDER BY COUNT(*) DESC\r\n"
							+ "	) and  YEAR(started_date) = ?");

			stmt.setInt(1, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	public ArrayList<HistoryPremium> selectAllInYear(int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT *\r\n"
							+ "	FROM history_premium_accounts\r\n"
							+ "	WHERE YEAR(started_date) = ?");

			stmt.setInt(1, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	public ArrayList<HistoryPremium> selectAllBestInPrecious(int precious,int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT * FROM getPreciousPremiumList(?,?)");

			stmt.setInt(1, precious);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	
	public ArrayList<HistoryPremium> selectAllInPrecious(int precious,int year) {
		ArrayList<HistoryPremium> result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = 
					connection.prepareStatement("SELECT * FROM GetPremiumByPrecious(?,?)");

			stmt.setInt(1, precious);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Account account = new Account(rs.getString("username"), null, null, null, null, null);
				int type = rs.getInt("type_premium");
				Date started_date = rs.getDate("started_date");
				Date finished_date = rs.getDate("finish_date");
				HistoryPremium historyPremium = new HistoryPremium(account, type, started_date, finished_date);
				result.add(historyPremium);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	public boolean checkPremium(Account account) {
		try {
			PreparedStatement stmt = connection.prepareStatement(
					"SELECT * FROM history_premium_accounts WHERE username = ? AND GETDATE() BETWEEN started_date AND finish_date;");
			stmt.setString(1, account.getUsername());
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return true;
			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public int update(HistoryPremium t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(HistoryPremium t) {
		// TODO Auto-generated method stub
		return 0;
	}

	public double getProfitForMonth(int month) {

		try (CallableStatement stmt = connection.prepareCall("{ ? = call dbo.CalculateProfitForMonth(?) }")) {
			stmt.registerOutParameter(1, Types.FLOAT); // Đăng ký loại dữ liệu của tham số trả về
			stmt.setInt(2, month); // Thiết lập tham số đầu vào

			// Thực hiện gọi hàm
			stmt.execute();

			// Lấy kết quả từ tham số đầu ra
			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;
	}

	public HistoryPremium getBestTypeInDay(String day) throws ParseException {
		HistoryPremium result = null;
		try {
			String sql = "SELECT TOP 1 type_premium, COUNT(type_premium) AS count_premium\r\n"
					+ "FROM history_premium_accounts \r\n" + "WHERE started_date = ?\r\n" + "group by type_premium\r\n"
					+ "ORDER BY count_premium DESC";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setString(1, day);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int type = rs.getInt("type_premium");
				int count = rs.getInt("count_premium");
				result = new HistoryPremium(null, type, null, null);
				Date date = result.changeStringToDate(day);
				result.setStartedDate(date);
				result.setCountPremiumType(count);

			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public HistoryPremium getBestTypeInMonth(int month, int year) throws ParseException {
		HistoryPremium result = null;
		try {
			String sql = "SELECT TOP 1 type_premium, COUNT(type_premium) AS count_premium\r\n"
					+ "FROM history_premium_accounts \r\n"
					+ "WHERE MONTH(history_premium_accounts.started_date) = ? AND YEAR(history_premium_accounts.started_date) = ?\r\n"
					+ "group by type_premium\r\n" + "ORDER BY count_premium DESC";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, month);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int type = rs.getInt("type_premium");
				int count = rs.getInt("count_premium");
				result = new HistoryPremium(null, type, null, null);
				Date date = result.getMonthInYear(month, year);
				result.setStartedDate(date);
				result.setCountPremiumType(count);

			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public HistoryPremium getBestTypeInYear(int year) throws ParseException {
		HistoryPremium result = null;
		try {
			String sql = "SELECT TOP 1 type_premium, COUNT(type_premium) AS count_premium\r\n"
					+ "FROM history_premium_accounts \r\n"
					+ "WHERE  YEAR(history_premium_accounts.started_date) = ?\r\n" + "group by type_premium\r\n"
					+ "ORDER BY count_premium DESC";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int type = rs.getInt("type_premium");
				int count = rs.getInt("count_premium");
				result = new HistoryPremium(null, type, null, null);

				Date date = result.getYear(year + "");
				result.setStartedDate(date);
				result.setCountPremiumType(count);

			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public HistoryPremium getBestTypeInPrecious(int precious, int year) throws ParseException {
		HistoryPremium result = null;
		try {
			String sql = "SELECT * FROM GetPremiumCounts(?,?)";
			PreparedStatement stmt = connection.prepareStatement(sql);
			stmt.setInt(1, precious);
			stmt.setInt(2, year);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int type = rs.getInt("type_premium");
				int count = rs.getInt("count_premium");
				result = new HistoryPremium(null, type, null, null);
				result.setCountPremiumType(count);

				result.setPrecious(precious);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public double getProfitForToday() {
		try (CallableStatement stmt = connection.prepareCall("{ ? = call dbo.CalculateProfitForToday() }")) {
			stmt.registerOutParameter(1, Types.FLOAT);

			stmt.execute();

			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;
	}

	public double getProfitForDay(Date day, int type) {
		try (CallableStatement stmt = connection.prepareCall("{ ? = call dbo.CalculateTotalAmountForDate(?,?) }")) {
			stmt.setDate(2, day);
			stmt.setInt(3, type);
			stmt.registerOutParameter(1, Types.FLOAT);

			stmt.execute();

			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;

	}

	public double getProfitForMonth(int month, int year, int type) {
		try (CallableStatement stmt = connection.prepareCall("{ ? = call dbo.CalculateTotalAmountForMonth(?,?,?) }")) {
			stmt.setInt(2, month);
			stmt.setInt(3, year);
			stmt.setInt(4, type);
			stmt.registerOutParameter(1, Types.FLOAT);

			stmt.execute();

			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;
	}

	public double getProfitForPrecious(int year, int precious, int type) {
		try (CallableStatement stmt = connection
				.prepareCall("{ ? = call dbo.CalculateTotalAmountForPrecious(?,?,?) }")) {
			stmt.setInt(2, year);
			stmt.setInt(3, precious);
			stmt.setInt(4, type);
			stmt.registerOutParameter(1, Types.FLOAT);

			stmt.execute();

			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;
	}

	public double getProfitForYear(int year, int type) {
		try (CallableStatement stmt = connection.prepareCall("{ ? = call dbo.CalculateTotalAmountForYear(?,?) }")) {
			stmt.setInt(2, year);
			stmt.setInt(3, type);
			stmt.registerOutParameter(1, Types.FLOAT);

			stmt.execute();

			int profit = stmt.getInt(1);

			return profit;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return 0;
	}

	public double getProfitForTime(Date date, int month, int year, int type, String time, int precious) {
		if (time.equalsIgnoreCase("day")) {
			return getProfitForDay(date, type);
		} else if (time.equalsIgnoreCase("month")) {
			return getProfitForMonth(month, year, type);
		} else if (time.equalsIgnoreCase("year")) {
			return getProfitForYear(year, type);
		} else if (time.equalsIgnoreCase("precious")) {
			return getProfitForPrecious(year, precious, type);
		}
		return 0;
	}
	
	public double getProfitForTime2(Date date, int month, int year, String time, int precious) {
		double rs = 0 ;
		if (time.equalsIgnoreCase("day")) {
			for (int i =1 ; i<=6; i++) {
				rs +=getProfitForDay(date, i);
			}
			return rs;
		} else if (time.equalsIgnoreCase("month")) {
			for (int i =1 ; i<=6; i++) {
				rs += getProfitForMonth(month, year, i);
			}
			return rs;
		} else if (time.equalsIgnoreCase("year")) {
			for (int i =1 ; i<=6; i++) {
				rs += getProfitForYear(year, i);
			}
			return rs;
		} else if (time.equalsIgnoreCase("precious")) {
			for (int i =1 ; i<=6; i++) {
				rs += getProfitForPrecious(year, precious, i);
			}
			return rs;
		}
		return 0;
	}


	public double getIncomeInThisMonth() {
		int currentMonth = LocalDate.now().getMonthValue();
		return getProfitForMonth(currentMonth);
	}

	public double getAvgRevenue() {
		double total = 0;
		int currentMonth = LocalDate.now().getMonthValue();
		for (int i = 1; i < 12; i++) {
			if (i <= currentMonth) {
				total += getProfitForMonth(i);
			}
		}
		return total / currentMonth;
	}
	public int deleteByUsername (String username) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from history_premium_accounts where username = ?");
			stmt.setString(1, username);
			
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}
	public static void main(String[] args) throws ParseException {
		HistoryPremium hs = new HistoryPremium(new Account("pldat"), 1, null, null);
		Date date = hs.changeStringToDate("2024-5-11");
		System.out.println(new DAOHistoryPremium().selectAllBestInPrecious(2, 2024));
	}
}
