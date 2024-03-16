package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;

import Model.Account;
import Model.Singer;
import Model.Song;

public class DAOSong {
	Connection connection = fileUtils.connectDb();

	public ArrayList<Song> selectAll() {
		// TODO Auto-generated method stub
		ArrayList<Song> result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from songs");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_song = rs.getString("id_song");
				String name_song = rs.getString("name_song");
				Time duration = rs.getTime("duration");
				String genre = rs.getString("genre");
				String urlImg = rs.getString("urlImg");
				String urlAudio = rs.getString("urlAudio");
				int songview = rs.getInt("songview");
				String id_singer = rs.getString("id_singer");

				DAOSinger daoSinger = new DAOSinger();
				Singer singer = daoSinger.selectById(id_singer);

				Song song = new Song(id_song, name_song, duration, genre, singer, urlImg, urlAudio, songview);

				result.add(song);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public ArrayList<Song> selectAllBySearch(String t) {
		// TODO Auto-generated method stub
		ArrayList<Song> result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection
					.prepareStatement("select * from songs " + "where songs.name_song like ?");

			stmt.setString(1, "%" + t + "%");

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_song = rs.getString("id_song");
				String name_song = rs.getString("name_song");
				Time duration = rs.getTime("duration");
				String genre = rs.getString("genre");
				String urlImg = rs.getString("urlImg");
				String urlAudio = rs.getString("urlAudio");
				int songview = rs.getInt("songview");
				String id_singer = rs.getString("id_singer");
				DAOSinger daoSinger = new DAOSinger();
				Singer singer = daoSinger.selectById(id_singer);
				Song song = new Song(id_song, name_song, duration, genre, singer, urlImg, urlAudio, songview);
				result.add(song);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public Song selectById(String id) {
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from songs where id_song=?");
			stmt.setString(1, id);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String id_song = rs.getString("id_song");
				String name_song = rs.getString("name_song");
				Time duration = rs.getTime("duration");
				String genre = rs.getString("genre");
				String urlImg = rs.getString("urlImg");
				String urlAudio = rs.getString("urlAudio");
				int songview = rs.getInt("songview");
				String id_singer = rs.getString("id_singer");
				DAOSinger daoSinger = new DAOSinger();
				Singer singer = daoSinger.selectById(id_singer);

				Song song = new Song(id_song, name_song, duration, genre, singer, urlImg, urlAudio, songview);
				return song;
			}

		} catch (Exception e) {
			e.getStackTrace();
		}

		return null;
	}

	public boolean delete(String idSong) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from songs where id_song=?");
			
			stmt.setString(1, idSong);
			stmt.execute();
			return true;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return false;
	}

	public ArrayList<Song> getRanking() {
		ArrayList<Song> result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select top(12) * from songs order by songview DESC");

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String id_song = rs.getString("id_song");
				String name_song = rs.getString("name_song");
				Time duration = rs.getTime("duration");
				String genre = rs.getString("genre");
				String urlImg = rs.getString("urlImg");
				String urlAudio = rs.getString("urlAudio");
				int songview = rs.getInt("songview");
				String id_singer = rs.getString("id_singer");

				DAOSinger daoSinger = new DAOSinger();
				Singer singer = daoSinger.selectById(id_singer);

				Song song = new Song(id_song, name_song, duration, genre, singer, urlImg, urlAudio, songview);

				result.add(song);
			}
			stmt.close();

		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public boolean insert(Song song) {
		
		try {
			if (new DAOSinger().selectByName(song.getName_Song()) == null) {
				new DAOSinger().insert(song.getSinger());
			}

			PreparedStatement stmt = connection.prepareStatement(
					"insert into songs (name_song,duration,genre,urlImg,urlAudio,songview,id_singer)\r\n"
							+ " values(?,?,?,?,?,?,?)");

			stmt.setString(1, song.getName_Song());
			stmt.setTime(2, song.getDuration());
			stmt.setString(3, song.getGenre());
			stmt.setString(4, song.getUrl_Img());
			stmt.setString(5, song.getUrl_Audio());
			stmt.setLong(6, song.getSongView());
			Singer singer = new DAOSinger().selectByName(song.getSinger().getName_Singer());
			System.out.println(singer);
			stmt.setString(7, singer.getId_Singer());

			stmt.execute();
			return true;

		} catch (Exception e) {
			e.getStackTrace();
		}
		return false;
	}

	public boolean update(Song song) {

		try {
			PreparedStatement stmt;
			if (new DAOSinger().selectByName(song.getSinger().getName_Singer()) == null) {
				stmt = connection.prepareStatement("insert into singers(name_singer) values(?)");
				stmt.setString(1, song.getSinger().getName_Singer());
				stmt.executeUpdate();
			}

			stmt = connection.prepareStatement(
					"update songs set name_song = ?, duration = ?, genre = ?, urlImg = ?, urlAudio = ?, songview = ?,id_singer =  ? where id_song = ?");
			stmt.setString(1, song.getName_Song());
			stmt.setTime(2, song.getDuration());
			stmt.setString(3, song.getGenre());
			stmt.setString(4, song.getUrl_Img());
			stmt.setString(5, song.getUrl_Audio());
			stmt.setLong(6, song.getSongView());
			stmt.setString(7, new DAOSinger().selectByName(song.getSinger().getName_Singer()).getId_Singer());
			stmt.setString(8, song.getId_Song());
			stmt.executeUpdate();
			return true;

		} catch (Exception e) {
			e.getStackTrace();
		}
		return false;
	}
	public boolean updateViewSong(Song song) {
		PreparedStatement stmt;
		try {
			stmt = connection.prepareStatement("update songs set songview = songview + 1 where id_song =?");
			stmt.setString(1, song.getId_Song());
			stmt.executeUpdate();
			return true;	
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	
	public ArrayList<Song> selectRecommendedSongs(Account acc) {
		if (acc.getFavoriteList()==null) {
			return new ArrayList<Song>();
		}
		
		ArrayList<Song> result = new ArrayList<Song>();
		
		PreparedStatement stmt;
		try {
			stmt = connection.prepareStatement("select top 10 * from songs \r\n"
											+ " where songs.genre in (select distinct songs.genre \r\n"
											+ "						from songs join favorites on songs.id_song=favorites.id_song\r\n"
											+ "						where favorites.username= ?)\r\n"
											+ " order by songview desc");
			stmt.setString(1, acc.getUsername());
			
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String id_song = rs.getString("id_song");
				String name_song = rs.getString("name_song");
				Time duration = rs.getTime("duration");
				String genre = rs.getString("genre");
				String urlImg = rs.getString("urlImg");
				String urlAudio = rs.getString("urlAudio");
				int songview = rs.getInt("songview");
				String id_singer = rs.getString("id_singer");

				DAOSinger daoSinger = new DAOSinger();
				Singer singer = daoSinger.selectById(id_singer);

				Song song = new Song(id_song, name_song, duration, genre, singer, urlImg, urlAudio, songview);

				result.add(song);
			}
			stmt.close();
			return result;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
}
