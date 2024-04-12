package Model;

import java.sql.Time;

import database.DAOAccount;
import database.DAOSong;

public class Song {
	private String id_Song;
	private String name_Song;
	private String genre;
	private Time duration;
	private Singer singer;
	private String url_Img;
	private String url_Audio;
	private long songView;

	public Song(String id_Song, String name_Song,Time duration,String genre, Singer singer, String url_Img,
			String url_Audio, long songView) {
		super();
		
		this.id_Song = id_Song;
		this.name_Song = name_Song;
		this.genre = genre;
		this.duration = duration;
		this.singer = singer;
		this.url_Img = url_Img;
		this.url_Audio = url_Audio;
		this.songView = songView;
		
	}
	

	public long getSongView() {
		return songView;
	}


	public void setSongView(int songView) {
		this.songView = songView;
	}


	public String getId_Song() {
		return id_Song;
	}

	public void setId_Song(String id_Song) {
		this.id_Song = id_Song;
	}

	public String getName_Song() {
		return name_Song;
	}

	public void setName_Song(String name_Song) {
		this.name_Song = name_Song;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public Time getDuration() {
		return duration;
	}

	public void setDuration(Time duration) {
		this.duration = duration;
	}

	public Singer getSinger() {
		return singer;
	}

	public void setSinger(Singer singer) {
		this.singer = singer;
	}

	public String getUrl_Img() {
		return url_Img;
	}

	public void setUrl_Img(String url_Img) {
		this.url_Img = url_Img;
	}

	public String getUrl_Audio() {
		return url_Audio;
	}

	public void setUrl_Audio(String url_Audio) {
		this.url_Audio = url_Audio;
	}

	public String getSongViewUpdate() {
		String result="";
		long view1 = 0;
		if(songView < 1000) {
			result+=songView+" lượt nghe";
		}else if (songView>=1000&& songView <=999999) {
			 view1 =songView/1000;
			result += view1 +"k lượt nghe";
		}else if(songView >= 1000000 && songView <= 999999999) {
			view1 = songView/1000000;
			result+=view1 +"tr lượt nghe";
		}else {
			view1 = songView/ 1000000000;
			result+=view1+"T lượt nghe";
		}
		return result;
	}
	@Override
	public String toString() {
		return "Song [id_Song=" + id_Song + ", name_Song=" + name_Song + ", genre=" + genre + ", duration=" + duration
				+ ", singer=" + singer + ", url_Img=" + url_Img + ", url_Audio=" + url_Audio + "]\n";
	}

}
