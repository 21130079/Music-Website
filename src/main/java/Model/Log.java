package Model;


import java.sql.Date;
import java.sql.Timestamp;

import Model.ELevel.Level;


public class Log {
	private String idLog ;
	private String nationality;
	private Level levelLog;
	private String addressPerforming;
	private String preValue;
	private String currentValue;
	private Timestamp updatedDate;
	private String status;
	public Log(String idLog, String nationality, Level levelLog, String addressPerforming, String preValue,
			String currentValue, Timestamp updatedDate,boolean isSuccessed) {
		
		this.idLog = idLog;
		this.nationality = nationality;
		this.levelLog = levelLog;
		this.addressPerforming = addressPerforming;
		this.preValue = preValue;
		this.currentValue = currentValue;
		this.updatedDate = updatedDate;
		if(isSuccessed) {
			this.status="successed";
		}else {
			this.status ="failed";
		}
	}
	public String getIdLog() {
		return idLog;
	}
	public void setIdLog(String idLog) {
		this.idLog = idLog;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getLevelLog() {
		return levelLog.toString();
	}
	public void setLevelLog(Level levelLog) {
		this.levelLog = levelLog;
	}
	public String getAddressPerforming() {
		return addressPerforming;
	}
	public void setAddressPerforming(String addressPerforming) {
		this.addressPerforming = addressPerforming;
	}
	public String getPreValue() {
		return preValue;
	}
	public void setPreValue(String preValue) {
		this.preValue = preValue;
	}
	public String getCurrentValue() {
		return currentValue;
	}
	public void setCurrentValue(String currentValue) {
		this.currentValue = currentValue;
	}
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	public String getStatus() {
		return status;
	}
	
	
	
	
}
