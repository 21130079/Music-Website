package Model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.Calendar;

public class HistoryPremium {
	private Account account;
	private int typePrenium;
	private Date startedDate;
	private Date finishedDate;
	private int countPremiumType;
	private int precious;
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
	 public String getTimeAsString() {
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	        return formatter.format(startedDate);
	    }
	 public Date changeStringToDate(String day) throws ParseException {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date utilDate = sdf.parse(day); 
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); 
            return sqlDate;
	 }
	 public Date getMonthInYear(int month, int year) throws ParseException {
		  Calendar calendar = Calendar.getInstance();
	        calendar.clear();
	        calendar.set(Calendar.YEAR, year); 
	        calendar.set(Calendar.MONTH, month - 1); 
	        java.util.Date utilDate = calendar.getTime();
	        return new Date(utilDate.getTime());
	 }
	 public Date getYear(String i) throws ParseException {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	        java.util.Date utilDate = sdf.parse(i); 
         java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime()); 
         return sqlDate;
	 }
	 public String monthString(int month, int year) {
		 return month+"/"+year;
	 }
	 public int getCountPremiumType() {
		return countPremiumType;
	}

	public void setCountPremiumType(int countPremiumType) {
		this.countPremiumType = countPremiumType;
	}

	public double getPriceByType(int type) {
		 double price;
			switch (type) {
			case 1: {

				return price = 15000;
			}
			case 2: {
				return price = 30000;

			}
			case 3: {
				return price = 55000;

			}
			case 4: {
				return price = 255000;

			}
			case 5: {
				return price = 45000;

			}
			case 6: {
				return price = 225000;

			}

			default:
				throw new IllegalArgumentException("Unexpected value: " + type);
			}
//			
	 }
	
	public int getPrecious() {
		return precious;
	}

	public void setPrecious(int precious) {
		this.precious = precious;
	}

	@Override
	public String toString() {
		
		return "Name: "+account.getUsername()+", type: "+typePrenium+", start date: "+getTimeAsString()+", end date: "+finishedDate ;
	}
	public static void main(String[] args) throws ParseException {
		System.out.println(new HistoryPremium(null, 0, null, null).getYear("2024"));
		Date result = new HistoryPremium(null, 0, null, null).getMonthInYear(5,2024);
		System.out.println(result);
		
	}
	
	
}
