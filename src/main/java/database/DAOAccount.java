package database;

import java.net.URISyntaxException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Model.Account;
import Model.Playlist;
import Model.Song;

public class DAOAccount {
	Connection connection = fileUtils.connectDb();

	public Account selectByEmail(String email) {
	
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from accounts where email=?");
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String username = rs.getString("username");
				String password = rs.getString("password_account");
				
				Account account = new Account(username, password, email, null, null, null);
				return account;
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}

		return null;
	}

	public Account selectByUsername(String username) {
		Account account = null;
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from accounts where accounts.username = ?");
			stmt.setString(1, username);
			String password = "";
			String email = "";
			
			
			
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				password = rs.getString("password_account");
				email = rs.getString("email");
				
				account = new Account(username, password, email, null, null, null);
			}
			
			stmt.close();

			PreparedStatement stmtFavorite = connection.prepareStatement(
					"select * from accounts join favorites on favorites.username = accounts.username where accounts.username = ?");
			stmtFavorite.setString(1, username);
			ResultSet rsFavorite = stmtFavorite.executeQuery();
			ArrayList<Song> favorite = new ArrayList<Song>();
			while (rsFavorite.next()) {
				
				String id_song = rsFavorite.getString("id_song");
				favorite.add(new DAOSong().selectById(id_song));
				account = new Account(username, password, email, null, favorite, null);
			}
			stmtFavorite.close();

			PreparedStatement stmtPlaylist = connection.prepareStatement(
					"select * from accounts join playlists on playlists.username = accounts.username where accounts.username = ?");
			stmtPlaylist.setString(1, username);
			ResultSet rsPlaylist = stmtPlaylist.executeQuery();
			ArrayList<Playlist> playlists = new ArrayList<Playlist>();
			while (rsPlaylist.next()) {
				String id_playlist = rsPlaylist.getString("id_playlist");
				playlists.add(new DAOPlaylist().selectById(id_playlist,username));
				
			}
			
			account = new Account(username, password, email, null, favorite, playlists);
			
			stmtPlaylist.close();
			//roles
			ArrayList<String> roles = new ArrayList<String>();
			stmt = connection.prepareStatement("select * from roles_accounts where username = ?");
			stmt.setString(1, username);
			
			rs = stmt.executeQuery();
			while (rs.next()) {
				String roleUser = rs.getString("roleUser");
				roles.add(roleUser);
				
			}
			account = new Account(username, password, email, roles, favorite, playlists);
			stmt.close();

		} catch (Exception e) {
			e.getStackTrace();
		}
		return account;

	}

	public ArrayList<Account> selectAll() {
		ArrayList<Account> result = new ArrayList<Account>();
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from accounts ");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {

				String username = rs.getString("username");
				String password = rs.getString("password_account");
				String email = rs.getString("email");
				
				Account account = new Account(username, password, email, null, null, null);
				result.add(account);
			}
			stmt.close();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;

	}

	public int insert(Account t) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection
					.prepareStatement("insert into accounts (username,password_account,email) values(?,?,?)");

			stmt.setString(1, t.getUsername());
			stmt.setString(2, t.getPassword());
			stmt.setString(3, t.getEmail());
			stmt.execute();
			return 1;

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}

	public int delete(Account t) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public int updateRoles(String username, String newRoles) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update accounts set roles=? where usename=? ");
			stmt.setString(1, newRoles);
			stmt.setString(2, username);
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}
	
	public int updatePassword(String email, String newPass) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update accounts set password_account=? where email=? ");
			stmt.setString(1, newPass);
			stmt.setString(2, email);
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return 0;
	}
	
	public boolean checkEmailExist(String email) {
		try {
			PreparedStatement stmt = connection.prepareStatement("select * from accounts where email = ?");
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				return true;
			}
			
			stmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Account rereshAccount(Account account) {	
		return selectByUsername(account.getUsername());
	}
	public static void main(String[] args) {
		System.out.println(new DAOAccount().updatePassword("21130022@st.hcmuaf.edu.vn", "123456"));;
	}

}