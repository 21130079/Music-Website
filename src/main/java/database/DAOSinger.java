package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import Model.Account;
import Model.Singer;
import Model.Song;

public class DAOSinger{
	Connection connection = fileUtils.connectDb();

	public ArrayList<Singer> selectAll() {
		// TODO Auto-generated method stub
		ArrayList<Singer> result = new ArrayList<Singer>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from singers");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_singer = rs.getString("id_singer");
				String name_Singer = rs.getString("name_singer");

				Singer singer = new Singer(id_singer, name_Singer);
				result.add(singer);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public HashMap<String, ArrayList<Song>> getSongsOfSinger() {
		HashMap<String, ArrayList<Song>> result = new HashMap<String, ArrayList<Song>>();
		ArrayList<Song> tracks = new DAOSong().selectAll();
		ArrayList<String> namesingers = new ArrayList<String>();
		for (Singer singer : selectAll()) {
			StringTokenizer singers = new StringTokenizer(singer.getName_Singer(), ",");
			while (singers.hasMoreTokens()) {
				String nameSinger = singers.nextToken().trim();
				namesingers.add(nameSinger);

			}

		}
		for (String nameSinger : namesingers) {
			ArrayList<Song> songs = new ArrayList<Song>();
			for (Song song : tracks) {
				StringTokenizer singers_songs = new StringTokenizer(song.getSinger().getName_Singer(), ",");
				while (singers_songs.hasMoreTokens()) {
					if (singers_songs.nextToken().trim().equals(nameSinger)) {
						songs.add(song);
					}
				}

			}
			result.put(nameSinger, songs);
		}

		return result;
	}


	public Singer selectById(String t) {
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from singers where id_singer=?");
			stmt.setString(1, t);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_singer = rs.getString("id_singer");
				String name_Singer = rs.getString("name_singer");

				Singer singer = new Singer(id_singer, name_Singer);
				return singer;
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return null;
	}
	
	public Singer selectByName(String t) {
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from singers where name_singer=?");
			stmt.setString(1, t);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_singer = rs.getString("id_singer");
				String name_Singer = rs.getString("name_singer");

				Singer singer = new Singer(id_singer, name_Singer);
				return singer;
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return null;
	}

	public int insert(Singer t) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection.prepareStatement("insert into singers(name_singer) values(?)");
			stmt.setString(1, t.getName_Singer());

			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}





//	public int deleteAll() {
//		// TODO Auto-generated method stub
//		int count=0;
//		try {
//			count=deleteAll(selectAll());
//			PreparedStatement stmt = connection.prepareStatement("delete from singer");
//			stmt.execute();
//			
//			return count;
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.getStackTrace();
//		}
//			return 0;
//	}



	public static void main(String[] args) {
		
		

	}

}
