package database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
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
			PreparedStatement stmt = connection.prepareStatement("insert into history_premium_accounts(username,type_premium,started_date)"
																+ "values(?,?,?)");
			
		stmt.setString(1, t.getAccount().getUsername());
		stmt.setInt(2, t.getTypePrenium());
		
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		stmt.setDate(3,sqlDate);
		stmt.execute();
		return 1;
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	
		System.out.println(t.getAccount().getUsername());
		return 0;
	}

	@Override
	public ArrayList<HistoryPremium> selectAll() {
		ArrayList<HistoryPremium>  result = new ArrayList<HistoryPremium>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from history_premium_accounts");
			
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Account account = new Account(rs.getString("username"), null, null, null, null, null);
			int type = rs.getInt("type_Premium");
			Date started_date = rs.getDate("started_date");
			Date finished_date = rs.getDate("finished_date");
			HistoryPremium historyPremium = new HistoryPremium(account, type, started_date,finished_date);
			result.add(historyPremium);
		}
		stmt.close();
		}catch(Exception e) {
			e.getStackTrace();
		}
	
		return result;
	}
	public boolean checkPremium(Account account) {
	    try {
	        PreparedStatement stmt = connection.prepareStatement("SELECT * FROM history_premium_accounts WHERE username = ? AND GETDATE() BETWEEN started_date AND finish_date;");
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
	public double getIncomeInThisMonth() {
		 int currentMonth = LocalDate.now().getMonthValue();
		 return getProfitForMonth(currentMonth); 
	}
	public double getAvgRevenue(){
		double total = 0;
		 int currentMonth = LocalDate.now().getMonthValue();
		for (int i = 1; i < 12; i++) {
			if(i<currentMonth) {
				total += getProfitForMonth(i);
			}
		}
		return total/(currentMonth-1);
	}
	public static void main(String[] args) {
		System.out.println(new DAOHistoryPremium().getProfitForMonth(6));;
	}
}
