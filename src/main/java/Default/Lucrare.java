package Default;
import java.time.LocalDateTime;

public class Lucrare {
	int idLucrare;
	LocalDateTime dataInceput;
	LocalDateTime dataFinalizare;
	int idAnunt;
	int idClient;
	char status;
	double pretFinal;
	int idAdresa;
	
	
	
	public int getIdLucrare() {
		return idLucrare;
	}



	public void setIdLucrare(int idLucrare) {
		this.idLucrare = idLucrare;
	}



	public LocalDateTime getDataInceput() {
		return dataInceput;
	}



	public void setDataInceput(LocalDateTime dataInceput) {
		this.dataInceput = dataInceput;
	}



	public LocalDateTime getDataFinalizare() {
		return dataFinalizare;
	}



	public void setDataFinalizare(LocalDateTime dataFinalizare) {
		this.dataFinalizare = dataFinalizare;
	}



	public int getIdAnunt() {
		return idAnunt;
	}



	public void setIdAnunt(int idAnunt) {
		this.idAnunt = idAnunt;
	}



	public int getIdClient() {
		return idClient;
	}



	public void setIdClient(int idClient) {
		this.idClient = idClient;
	}



	public char getStatus() {
		return status;
	}



	public void setStatus(char status) {
		this.status = status;
	}



	public double getPretFinal() {
		return pretFinal;
	}



	public void setPretFinal(double pretFinal) {
		this.pretFinal = pretFinal;
	}



	public int getIdAdresa() {
		return idAdresa;
	}



	public void setIdAdresa(int idAdresa) {
		this.idAdresa = idAdresa;
	}



	public String toString() {
		return "";
	}
}
