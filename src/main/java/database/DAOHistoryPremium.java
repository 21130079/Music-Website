package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}
