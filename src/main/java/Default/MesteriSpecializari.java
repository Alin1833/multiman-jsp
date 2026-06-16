package Default;

public class MesteriSpecializari {
	int idSpecializare;
	int idMester;
	int idAdmin;
	byte[] document;
	String status;
	String nume;
	String prenume;
	String denumire;
	
	public int getIdSpecializare() {
		return idSpecializare;
	}
	public void setIdSpecializare(int idSpecializare) {
		this.idSpecializare = idSpecializare;
	}
	public int getIdMester() {
		return idMester;
	}
	public void setIdMester(int idMester) {
		this.idMester = idMester;
	}
	public int getIdAdmin() {
		return idAdmin;
	}
	public void setIdAdmin(int idAdmin) {
		this.idAdmin = idAdmin;
	}
	public byte[] getDocument() {
		return document;
	}
	public void setDocument(byte[] document) {
		this.document = document;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
    public String getNume() {
        return nume;
    }
    public void setNume(String nume) {
		this.nume = nume;
	}
	public void setPrenume(String prenume) {
		this.prenume = prenume;
	}
	public String getPrenume() {
        return prenume;
    }
	public String getDenumire() {
        return denumire;
    }
	public void setDenumire(String denumire) {
		this.denumire = denumire;
	}

}
