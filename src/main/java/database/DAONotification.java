package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import Model.ELevel;
import Model.Notification;

public class DAONotification extends AbsDao<Notification> {
	Connection connection = fileUtils.connectDb();

	@Override
	public int insert(Notification t) {
		try {
			PreparedStatement stmt = connection.prepareStatement(
					"insert into notifications(id_notification, username, level_notification, descript) values(?,?,?,?)");

			stmt.setString(1, t.getIdNotification());
			stmt.setString(2, t.getUsername());
			stmt.setString(3, t.getLevelNotification());
			stmt.setString(4, t.getDescript());

			stmt.execute();
			return 1;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ArrayList<Notification> selectAll() {
		ArrayList<Notification> result = new ArrayList<Notification>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from notifications order by time_execute desc");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String idNotification = rs.getString("id_notification");
				String username = rs.getString("username");
				String levelNotification = rs.getString("level_notification");
				String descript = rs.getString("descript");
				Timestamp timeExecute = rs.getTimestamp("time_execute");
				
				Notification notification = new Notification(idNotification, username, ELevel.getLevelLog(levelNotification), descript, timeExecute);
				
				result.add(notification);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public ArrayList<Notification> selectByUsername(String usernameChecked) {
		ArrayList<Notification> result = new ArrayList<Notification>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from notifications where username = ? order by time_execute desc");
			
			stmt.setString(0, usernameChecked);
			
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				String idNotification = rs.getString("id_notification");
				String username = rs.getString("username");
				String levelNotification = rs.getString("level_notification");
				String descript = rs.getString("descript");
				Timestamp timeExecute = rs.getTimestamp("time_execute");
				
				Notification notification = new Notification(idNotification, username, ELevel.getLevelLog(levelNotification), descript, timeExecute);
				
				result.add(notification);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public ArrayList<Notification> selectByLevel(String levelChecked) {
		ArrayList<Notification> result = new ArrayList<Notification>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from notifications where level_notification = ? order by time_execute desc");
			
			stmt.setString(0, levelChecked);
			
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) {
				String idNotification = rs.getString("id_notification");
				String username = rs.getString("username");
				String levelNotification = rs.getString("level_notification");
				String descript = rs.getString("descript");
				Timestamp timeExecute = rs.getTimestamp("time_execute");
				
				Notification notification = new Notification(idNotification, username, ELevel.getLevelLog(levelNotification), descript, timeExecute);
				
				result.add(notification);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}

	@Override
	public int update(Notification t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Notification t) {
		// TODO Auto-generated method stub
		return 0;
	}
}
