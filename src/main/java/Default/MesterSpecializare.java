package Default;

public class MesterSpecializare {
	int idSpecializare;
	int idMester;
	int idAdmin;
	byte[] document;
	char status;
	
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
	public char getStatus() {
		return status;
	}
	public void setStatus(char aprobat) {
		this.status = aprobat;
	}
	
	
}
