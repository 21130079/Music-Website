package database;

import java.util.ArrayList;



public abstract class AbsDao<T> {
	protected String ipAddress = "";
	
	public abstract int insert(T t);
	public abstract ArrayList<T> selectAll();
	public abstract int update(T t);
	public abstract int delete(T t);
	
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	
}
