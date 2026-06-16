package Default;
import java.time.LocalDateTime;

public class Recenzie {
	int idRecenzie;
	String comentariu;
	LocalDateTime dataRecenzie;
	int idLucrare;
	int rating;
	
	public int getIdRecenzie() {
		return idRecenzie;
	}
	public void setIdRecenzie(int idRecenzie) {
		this.idRecenzie = idRecenzie;
	}
	public String getComentariu() {
		return comentariu;
	}
	public void setComentariu(String comentariu) {
		this.comentariu = comentariu;
	}
	public LocalDateTime getDataRecenzie() {
		return dataRecenzie;
	}
	public void setDataRecenzie(LocalDateTime dataRecenzie) {
		this.dataRecenzie = dataRecenzie;
	}
	public int getIdLucrare() {
		return idLucrare;
	}
	public void setIdLucrare(int idLucrare) {
		this.idLucrare = idLucrare;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	
}
