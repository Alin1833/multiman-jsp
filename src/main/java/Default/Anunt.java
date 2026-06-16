package Default;

public class Anunt {
	int idAnunt;
	int idMester;
	String titlu;
	String descriere;
	double pretOra;
	String status;
	int idAdresa;
	int idAdmin;
	int idSpecializare;
	
	
	public int getIdAnunt() {
		return idAnunt;
	}


	public void setIdAnunt(int idAnunt) {
		this.idAnunt = idAnunt;
	}


	public int getIdMester() {
		return idMester;
	}


	public void setIdMester(int idMester) {
		this.idMester = idMester;
	}


	public String getTitlu() {
		return titlu;
	}


	public void setTitlu(String titlu) {
		this.titlu = titlu;
	}


	public String getDescriere() {
		return descriere;
	}


	public void setDescriere(String descriere) {
		this.descriere = descriere;
	}


	public double getPretOra() {
		return pretOra;
	}


	public void setPretOra(double pretOra) {
		this.pretOra = pretOra;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public int getIdAdresa() {
		return idAdresa;
	}


	public void setIdAdresa(int idAdresa) {
		this.idAdresa = idAdresa;
	}


	public int getIdAdmin() {
		return idAdmin;
	}


	public void setIdAdmin(int idAdmin) {
		this.idAdmin = idAdmin;
	}
	
	public int getIdSpecializare() {
		return idSpecializare;
	}


	public void setIdSpecializare(int idSpecializare) {
		this.idSpecializare = idSpecializare;
	}


	public String toString() {
		return "idMester:"+idMester+
				"; titlu:"+titlu+
				"; descriere:"+descriere+
				"; pret pe ora(RON):"+pretOra;
	}
}
