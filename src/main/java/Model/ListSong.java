package Model;

import java.util.List;

public class ListSong {
	private List<Song> songs;

	public ListSong(List<Song> songs) {
		super();
		this.songs = songs;
	}

	public List<Song> getSongs() {
		return songs;
	}

	public void setSongs(List<Song> songs) {
		this.songs = songs;
	}
	
}
