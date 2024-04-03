package Model;

import java.sql.Date;

public class HistoryPrenium {
	private Account account;
	private String typePrenium;
	private Date startedDate;
	private Date finishedDate;
	public HistoryPrenium(Account account, int typePrenium, Date startedDate, Date finishedDate) {
		super();
		this.account = account;
		switch (typePrenium) {
		case 1: {
			this.typePrenium ="Mini";
			break;
		}
		case 2:{
			this.typePrenium ="Individual";
			break;
		}case 3:{
			this.typePrenium ="Student";
			break;
		}
		default:
			this.typePrenium = null;
		}
		this.startedDate = startedDate;
		this.finishedDate = finishedDate;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public String getTypePrenium() {
		return typePrenium;
	}
	public void setTypePrenium(String typePrenium) {
		this.typePrenium = typePrenium;
	}
	public Date getStartedDate() {
		return startedDate;
	}
	public void setStartedDate(Date startedDate) {
		this.startedDate = startedDate;
	}
	public Date getFinishedDate() {
		return finishedDate;
	}
	public void setFinishedDate(Date finishedDate) {
		this.finishedDate = finishedDate;
	}
	
	
}
