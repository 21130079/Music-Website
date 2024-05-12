package Model;

import java.sql.Timestamp;

import Model.ELevel.Level;

public class Notification {
	private String idNotification;
	private String username;
	private Level levelNotification;
	private String descript;
	private Timestamp timeExecute;
	
	public Notification(String idNotification, String username, Level levelNotification, String descript,
			Timestamp timeExecute) {
		super();
		this.idNotification = idNotification;
		this.username = username;
		this.levelNotification = levelNotification;
		this.descript = descript;
		this.timeExecute = timeExecute;
	}

	public String getIdNotification() {
		return idNotification;
	}

	public void setIdNotification(String idNotification) {
		this.idNotification = idNotification;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLevelNotification() {
		return levelNotification.toString();
	}

	public void setLevelNotification(Level levelNotification) {
		this.levelNotification = levelNotification;
	}

	public String getDescript() {
		return descript;
	}

	public void setDescript(String descript) {
		this.descript = descript;
	}

	public Timestamp getTimeExecute() {
		return timeExecute;
	}

	public void setTimeExecute(Timestamp timeExecute) {
		this.timeExecute = timeExecute;
	}
}
