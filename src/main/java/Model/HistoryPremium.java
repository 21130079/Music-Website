package Model;

import java.sql.Date;

public class HistoryPremium {
	private Account account;
	private int typePrenium;
	private Date startedDate;
	private Date finishedDate;
	public HistoryPremium(Account account, int typePrenium, Date startedDate, Date finishedDate) {
		super();
		this.account = account;
		this.typePrenium =typePrenium;
	
		this.startedDate = startedDate;
		this.finishedDate = finishedDate;
	}
	
	public double getPriceMini_1day() {
		return 2.000;
	}
	public double getPriceMini_1week() {
		return 8.000;
	}
	
	public double getPriceInvi_2month() {
		return 50.000;
	}
	public double getPriceInvi_6month() {
		return 265.000;
	}
	
	public double getPriceStu_2month() {
		return 40.000;
	}
	public double getPriceStu_6month() {
		return 225.000;
	}
	
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public int getTypePrenium() {
		return typePrenium;
	}
	public void setTypePrenium(int typePrenium) {
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
