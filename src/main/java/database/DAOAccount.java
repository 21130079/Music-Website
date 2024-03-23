package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Model.*;
import Model.ELevel.Level;

public class DAOAccount extends AbsDao<Account>  {
	
	
	Connection connection = fileUtils.connectDb();
	DAOLog daoLog = new DAOLog();
	
	@Override
	public int insert(Account t) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("insert into accounts (username,password_account,email) values(?,?,?)");

			stmt.setString(1, t.getUsername());
			stmt.setString(2, t.getPassword());
			stmt.setString(3, t.getEmail());
			stmt.execute();
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.ALERT, "Accounts", null,
					t.toString(), null, false);
			daoLog.insert(log);
			return 1;
			
		} catch (Exception e) {
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.ALERT, "Accounts", null,
					t.toString(), null, true);
			daoLog.insert(log);
		}
		return 0;
	}

	@Override
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
	
	@Override
	public int update(Account t) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update accounts set email=? and password_account=? where usename=? ");
			stmt.setString(1, t.getEmail());
			stmt.setString(2, t.getPassword());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	
	@Override
	public int delete(Account t) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("delete from accounts where usename=? ");
			stmt.setString(1, t.getUsername());
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}

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
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Accounts", null, "Login: " + account,null,false);
			daoLog.insert(log); 
		} catch (Exception e) {
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.INFO, "Accounts", null, "Login: " + username,null,true);
			daoLog.insert(log);
		}
		return account;

	}
	
	public int updateRoles(String username, String newRoles) {
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update accounts set roles=? where usename=? ");
			stmt.setString(1, newRoles);
			stmt.setString(2, username);
			stmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	
	public int updatePassword(String email, String newPass) {
		Account acc = selectByEmail(email);
		try {
			PreparedStatement stmt = connection
					.prepareStatement("update accounts set password_account=? where email=? ");
			stmt.setString(1, newPass);
			stmt.setString(2, email);
			stmt.executeUpdate();
			Account newacc = selectByEmail(email);
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.WARNING, "Accounts", acc.toString(), newacc.toString(),null,true);
			daoLog.insert(log);
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			Log log = new Log("", IPAddress.getNameCountry(ipAddress), Level.ALERT, "Accounts", acc.toString(), null,null,false);
			daoLog.insert(log);
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
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Account rereshAccount(Account account) {	
		return selectByUsername(account.getUsername());
	}

	
}