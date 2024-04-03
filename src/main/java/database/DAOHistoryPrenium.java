package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.tomcat.jakartaee.commons.io.FileUtils;

import Model.Account;
import Model.HistoryPrenium;
import Model.Song;

public class DAOHistoryPrenium extends AbsDao<HistoryPrenium> {
	Connection connection = fileUtils.connectDb();
	@Override
	public int insert(HistoryPrenium t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<HistoryPrenium> selectAll() {
		ArrayList<HistoryPrenium>  result = new ArrayList<HistoryPrenium>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from history_prenium_accounts");
			
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Account account = new Account(rs.getString("username"), null, null, null, null, null);
			int type = rs.getInt("type_prenium");
			Date started_date = rs.getDate("started_date");
			Date finished_date = rs.getDate("finished_date");
			HistoryPrenium historyPrenium = new HistoryPrenium(account, type, started_date,finished_date);
			result.add(historyPrenium);
		}
		stmt.close();
		}catch(Exception e) {
			e.getStackTrace();
		}
	
		return result;
	}
	

	@Override
	public int update(HistoryPrenium t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(HistoryPrenium t) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
