package Default;

public class Adresa {
	int idAdresa;
	String judet;
	String localitate;
	String strada;
	
	
	
	public int getIdAdresa() {
		return idAdresa;
	}



	public void setIdAdresa(int idAdresa) {
		this.idAdresa = idAdresa;
	}



	public String getJudet() {
		return judet;
	}



	public void setJudet(String judet) {
		this.judet = judet;
	}



	public String getLocalitate() {
		return localitate;
	}



	public void setLocalitate(String localitate) {
		this.localitate = localitate;
	}



	public String getStrada() {
		return strada;
	}



	public void setStrada(String strada) {
		this.strada = strada;
	}



	public String toString() {
		return "judet="+judet+", localitate="+localitate
				+", strada="+strada;
	}
}
