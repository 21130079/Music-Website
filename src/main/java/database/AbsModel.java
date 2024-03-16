package database;

import java.util.ArrayList;

public abstract class AbsModel<T> {
	public abstract int insert(T t);
	public abstract ArrayList<T> selectAll();
	public abstract int update(T t);
	public abstract int delete(T t);
	
}
