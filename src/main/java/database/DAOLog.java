package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
			PreparedStatement stmt = connection.prepareStatement("select * from logs order by updated_date desc  ");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {

				String idlog = rs.getString("id_log");
				String nationality = rs.getString("nationality");
				String levelLog = rs.getString("level_log");
				String addressPerforming = rs.getString("address_performing");
				String preValue = rs.getString("pre_value");
				String currentValue = rs.getString("current_value");
				Timestamp updatedDate = rs.getTimestamp("updated_date");
				String status = rs.getString("exec_status");
				
				
				if(preValue == null) {
					preValue +="";
				}
				Log log = new Log(idlog, nationality, ELevel.getLevelLog(levelLog), addressPerforming, preValue,
						currentValue, updatedDate,status);
				result.add(log);
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

	public int deleteById(String idLog) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from logs where id_log=? ");
			stmt.setString(1,idLog);
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	public void deleteListLogByID(String[] idsToDelete) {
	    PreparedStatement stmt = null;
	    try {
	        if (idsToDelete != null && idsToDelete.length > 0) {
	            // Prepare SQL statement
	            String sql = "DELETE FROM logs WHERE id_log IN (";
	            for (int i = 0; i < idsToDelete.length; i++) {
	                if (i > 0) {
	                    sql += ",";
	                }
	                sql += "?";
	            }
	            sql += ")";

	            stmt = connection.prepareStatement(sql);

	            // Set values for placeholders
	            for (int i = 0; i < idsToDelete.length; i++) {
	                stmt.setString(i + 1, idsToDelete[i]);
	            }

	            // Execute the DELETE statement
	            stmt.executeUpdate();
	        }


	    } catch (Exception e) {
	        System.out.println("Error: " + e.getMessage());
	    } finally {
	        // Close resources
	        try {
	            if (stmt != null) stmt.close();
	        } catch (SQLException e) {
	            System.out.println("Error closing database connection: " + e.getMessage());
	        }
	    }
	}
	
	

}
