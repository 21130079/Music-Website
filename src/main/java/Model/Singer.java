package Model;

public class Singer {
	private String id_Singer;
	private String name_Singer;
	

	public Singer(String id_Singer, String name_Singer) {
		super();
		this.id_Singer = id_Singer;
		this.name_Singer = name_Singer;
		
	}

	public String getId_Singer() {
		return id_Singer;
	}

	public void setId_Singer(String id_Singer) {
		this.id_Singer = id_Singer;
	}

	public String getName_Singer() {
		return name_Singer;
	}

	public void setName_Singer(String name_Singer) {
		this.name_Singer = name_Singer;
	}

	@Override
	public String toString() {
		return "Singer [id_Singer=" + id_Singer + ", name_Singer=" + name_Singer + "]";
	}

	
	
	
}
