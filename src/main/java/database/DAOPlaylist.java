package database;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Model.Playlist;
import Model.Song;

public class DAOPlaylist extends AbsDao<Playlist>{
	Connection connection = fileUtils.connectDb();

	@Override
	public int insert(Playlist t) {
		return 0;
	}


	@Override
	public ArrayList<Playlist> selectAll() {
		return null;
	}


	@Override
	public int update(Playlist t) {
		return 0;
	}


	@Override
	public int delete(Playlist t) {
		return 0;
	}
	public int deleteByUsername (String username) {
		try {
			PreparedStatement stmt = connection.prepareStatement("delete from playlists_songs where username = ?");
			stmt.setString(1, username);
			
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}
	public Playlist selectById(String id_playlist, String username) {
		Playlist playlist = null;
		try {
			PreparedStatement stmt = connection
					.prepareStatement("select * from playlists where id_playlist=? and username =?");
			stmt.setString(1, id_playlist);
			stmt.setString(2, username);
			ResultSet rs = stmt.executeQuery();
			String name_playlist="";
			if (rs.next()) {
				name_playlist = rs.getString("name_playlist");
				playlist = new Playlist(id_playlist, name_playlist, null);

			}
			rs.close();
			stmt.close();
			
			PreparedStatement stmtSong = connection
					.prepareStatement("select * from playlists_songs where id_playlist= ? and username = ?");
			stmtSong.setString(1, id_playlist);
			stmtSong.setString(2, username);
			ResultSet rsSong = stmtSong.executeQuery();
			ArrayList<Song> songs = new ArrayList<>();
			while (rsSong.next()) {
				String id_Song = rsSong.getString("id_song");
				songs.add(new DAOSong().selectById(id_Song));
				
			}
			if(songs!=null) {
				playlist.setListSong(songs);
			}
			
			stmtSong.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return playlist;
	}
	
		
	public ArrayList<Song> selectSongNotInAcc(String username, String id_playlist) {
		ArrayList<Song> result = new ArrayList<Song>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from songs where id_song not in(select id_song from playlists_songs\r\n"
					+ "												where username =? and id_playlist=?)");
			stmt.setString(1, username);
			stmt.setString(2, id_playlist);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String id_song = rs.getString("id_song");
				Song song = new DAOSong().selectById(id_song);
				result.add(song);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return result;
	}

	public int insertPlaylist(String name_playlist, String username) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("insert into playlists(name_playlist,username) values(?,?)");
			stmt.setString(1, name_playlist);
			stmt.setString(2, username);
			stmt.execute();
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int insertSong(String id_playlist, String username, String id_song) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection.prepareStatement("insert into playlists_songs values(?,?,?)");
			stmt.setString(1, username);
			stmt.setString(2, id_playlist);
			stmt.setString(3, id_song);
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}

	public int insertAllSong(String id_playlist, String username, ArrayList<Song> songs) {
		int count = 0;
		for (Song song : songs) {
			insertSong(id_playlist, username, song.getId_Song());
			count++;
		}
		return count;
	}
	
	public int update(String id_Playlist, String name_Playlist, String username) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection.prepareStatement("update playlists set name_playlist = ? where id_playlist = ? and username = ?");
			stmt.setString(1, name_Playlist);
			stmt.setString(2, id_Playlist);
			stmt.setString(3, username);
			
			stmt.executeUpdate();
			
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	public int delete(String id_playlist, String username, String id_song) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection
					.prepareStatement("delete from playlists_songs where id_playlist = ? and username = ? and id_song = ?");
			stmt.setString(1, id_playlist);
			stmt.setString(2, username);
			stmt.setString(3, id_song);
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}
	public int deleteSong(String id_song) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("delete from playlists_songs where id_song = ?");
			stmt.setString(1, id_song);
			stmt.execute();
			return 1;

		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	public int deletePlaylist(String idPlaylist,String username) {
		try {
			PreparedStatement stmtPS = connection
					.prepareStatement("delete from playlists_songs where id_playlist = ? and username = ?");
			stmtPS.setString(1, idPlaylist);
			stmtPS.setString(2, username);
			stmtPS.execute();
			stmtPS.close();
			
			PreparedStatement stmt = connection
					.prepareStatement("delete from playlists where id_playlist = ? and username = ?");
			stmt.setString(1, idPlaylist);
			stmt.setString(2, username);
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}
}
