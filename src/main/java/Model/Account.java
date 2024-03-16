package Model;

import java.util.ArrayList;

public class Account {
	private String username;
	private String password;
	private String email;
	private ArrayList<String> roles;
	private ArrayList<Song> favoriteList;
	private ArrayList<Playlist> playlists;

	public Account(String username, String password, String email, ArrayList<String> roles,
			ArrayList<Song> favoriteList, ArrayList<Playlist> playlists) {
		super();

		this.username = username;
		this.password = password;
		this.email = email;
		this.roles = roles;
		this.favoriteList = favoriteList;
		this.playlists = playlists;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public ArrayList<Song> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(ArrayList<Song> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public ArrayList<Playlist> getPlaylists() {
		return playlists;
	}

	public void setPlaylists(ArrayList<Playlist> playlists) {
		this.playlists = playlists;
	}

	public void setRoles(ArrayList<String> roles) {
		this.roles = roles;
	}

	public ArrayList<String> getRoles() {
		return roles;
	}

	public boolean hasRole(String role) {
		if (roles.size() > 0) {
			for (String r : roles) {
				if (r.equals(role))
					return true;
			}
		}
		return false;
	}

	

	@Override
	public String toString() {
		return "Account [username=" + username + ", password=" + password + ", email=" + email + ", favoriteList="
				+ favoriteList + ", playlists=" + playlists + "]";
	}

	public Playlist getPlaylist(String idplaylist) {
		for (Playlist playlist : playlists) {
			if (playlist.getId_Playlist().equals(idplaylist)) {
				return playlist;
			}
		}
		return null;
	}

}
