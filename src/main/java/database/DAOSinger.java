package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import Model.Singer;
import Model.Song;

public class DAOSinger extends AbsDao<Singer> {
	Connection connection = fileUtils.connectDb();

	@Override
	public int insert(Singer t) {
		try {
			PreparedStatement stmt = connection.prepareStatement("insert into singers(name_singer) values(?)");
			stmt.setString(1, t.getName_Singer());

			stmt.execute();
			return 1;

		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	
	@Override
	public ArrayList<Singer> selectAll() {
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
	
	public ArrayList<Singer> selectNext3Singers(int quantity) {
		ArrayList<Singer> result = new ArrayList<Singer>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from singers order by id_singer offset ? rows fetch next 3 rows only");
			stmt.setInt(1, quantity);
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

	@Override
	public int update(Singer t) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update singers set name_singer=? where id_singer=? ");
			stmt.setString(1, t.getName_Singer());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Singer t) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("delete from singers where id_singer=? ");
			stmt.setString(1, t.getId_Singer());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}

	public HashMap<String, ArrayList<Song>> getSongsOfSinger(int quantity) {
		HashMap<String, ArrayList<Song>> result = new HashMap<String, ArrayList<Song>>();
		ArrayList<Song> tracks = new DAOSong().selectAll();
		ArrayList<String> namesingers = new ArrayList<String>();
		for (Singer singer : selectNext3Singers(quantity)) {
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
}
