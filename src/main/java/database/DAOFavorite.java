package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Model.Favorite;
import Model.Playlist;
import Model.Song;

public class DAOFavorite  {
	Connection connection = fileUtils.connectDb();
	
	public ArrayList<Song> selectAll(String usernameAccount) {
		// TODO Auto-generated method stub
		ArrayList<Song>  result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from favorites where username=?");
			stmt.setString(1, usernameAccount);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			String id_song = rs.getString("id_song");
			Song song = new DAOSong().selectById(id_song);
			result.add(song);
		}
		stmt.close();
		}catch(Exception e) {
			e.getStackTrace();
		}
	
		return result;
	}
	public ArrayList<Song> selectSongNotInAcc(String username){
		ArrayList<Song>  result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection.prepareStatement("SELECT * from songs\r\n"
					+ "	where id_song not in (select id_song from favorites join accounts\r\n"
					+ "							on accounts.username=favorites.username\r\n"
					+ "							where accounts.username = ?)");
			stmt.setString(1, username);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			String id_song = rs.getString("id_song");
			Song song = new DAOSong().selectById(id_song);
			result.add(song);
		}
		stmt.close();
		}catch(Exception e) {
			e.getStackTrace();
		}
	
		return result;
	}
	
	public Song selectById(String t) {
		// TODO Auto-generated method stub
		return null;
	}
	public boolean deleteById(String idSong,String username) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from favorites where id_song=? and username=?");
			stmt.setString(1, idSong);
			stmt.setString(2, username);
			stmt.execute();
			return true;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return false;
	}


	
	public int insert(String id_song, String username) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection.prepareStatement("insert into favorites values(?,?)");
			stmt.setString(1,id_song);
			stmt.setString(2, username);
			stmt.execute();
		
			return 1;
	
		
		}catch(Exception e) {
			e.getStackTrace();
		}
		return 0;
	}

	
	public int insertAll(ArrayList<Song> arr,String username) {
		// TODO Auto-generated method stub
		int count =0;
		for (Song song : arr) {
			insert(song.getId_Song(), username);
			count++;
			}
		return count;
	}


	
}
