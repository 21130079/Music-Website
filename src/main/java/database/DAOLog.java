package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import Model.ELevel;
import Model.Log;

public class DAOLog extends AbsDao<Log>{
	Connection connection = fileUtils.connectDb();

	@Override
	public int insert(Log t) {
		try {
			PreparedStatement stmt = connection.prepareStatement(
					"insert into logs (nationality,level_log,address_performing,pre_value,current_value,exec_status) values(?,?,?,?,?,?)");

			stmt.setString(1, t.getNationality());
			stmt.setString(2, t.getLevelLog());
			stmt.setString(3, t.getAddressPerforming());
			stmt.setString(4, t.getPreValue());
			stmt.setString(5, t.getCurrentValue());
			
			stmt.setString(6, t.getStatus());
			stmt.execute();
			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ArrayList<Log> selectAll() {
		// TODO Auto-generated method stub
		ArrayList<Log> result = new ArrayList<Log>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from logs ");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {

				String idlog = rs.getString("id_log");
				String nationality = rs.getString("nationality");
				String levelLog = rs.getString("level_log");
				String addressPerforming = rs.getString("address_performing");
				String preValue = rs.getString("pre_value");
				String currentValue = rs.getString("current_value");
				Timestamp updatedDate = rs.getTimestamp("updatedDate");
				String status = rs.getString("exec_status");
				
				boolean isSuccessed = false;
				if(status.equals("successed")) {
					isSuccessed = true;
				}
				Log account = new Log(idlog, nationality, ELevel.getLevelLog(levelLog), addressPerforming, preValue,
						currentValue, updatedDate,isSuccessed);
				result.add(account);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}

	@Override
	public int update(Log t) {
		try {
			PreparedStatement stmt = connection.prepareStatement(
					"update UPDATE logs\r\n" + "SET \r\n" + "    nationality = '?',\r\n" + "    level_log = '?',\r\n"
							+ "    address_performing = '?',\r\n" + "    pre_value = '?',\r\n"
							+ "    current_value = '?',\r\n" + "  exec_status = ? \r\n" + "WHERE id_log = '?';");

			stmt.setString(1, t.getNationality());
			stmt.setString(2, t.getLevelLog());
			stmt.setString(3, t.getAddressPerforming());
			stmt.setString(4, t.getPreValue());
			stmt.setString(5, t.getCurrentValue());
			stmt.setString(6, t.getStatus());
			stmt.setString(7, t.getIdLog());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Log t) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from logs where id_log=? ");
			stmt.setString(1, t.getIdLog());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	public static void main(String[] args) {
		System.out.println();;
	}

}
