package Model;

import java.util.ArrayList;

public class Favorite {
	private ArrayList<Song> listSong;
	public Favorite(ArrayList<Song> listSong) {
		super();
		
		this.listSong = listSong;
	}
	
	public ArrayList<Song> getListSong() {
		return listSong;
	}
	public void setListSong(ArrayList<Song> listSong) {
		this.listSong = listSong;
	}
	
}
