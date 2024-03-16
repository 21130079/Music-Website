package Model;

import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class Playlist {
	private String id_Playlist;
	private String name;
	private ArrayList<Song> listSong;

	public Playlist(String id_Playlist, String name, ArrayList<Song> listSong) {
		super();
		this.id_Playlist = id_Playlist;
		this.name = name;
		this.listSong = listSong;

	}

	public String getId_Playlist() {
		return id_Playlist;
	}

	public void setId_Playlist(String id_Playlist) {
		this.id_Playlist = id_Playlist;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<Song> getListSong() {
		return listSong;
	}

	public void setListSong(ArrayList<Song> listSong) {
		this.listSong = listSong;
	}

	public String getUrl_Img() {
	    if (listSong != null && !listSong.isEmpty()) {
	        int randomIndex = ThreadLocalRandom.current().nextInt(listSong.size());
	        return listSong.get(randomIndex).getUrl_Img();
	    }
	    return "assets/img/Other/nullPlaylist.jpg";
	}

	@Override
	public String toString() {
		return "Playlist [id_Playlist=" + id_Playlist + ", name=" + name + ", listSong=" + listSong + "]";
	}
	

}
