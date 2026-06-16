package Default;

public class Specializare {
    int idSpecializare;
    String denumire;

    public Specializare(int idSpecializare, String denumire) {
        this.idSpecializare = idSpecializare;
        this.denumire = denumire;
    }
    
    public Specializare() { }

    public int getIdSpecializare() {
        return idSpecializare;
    }

    public String getDenumire() {
        return denumire;
    }

	public void setIdSpecializare(int idSpecializare) {
		this.idSpecializare = idSpecializare;
	}

	public void setDenumire(String denumire) {
		this.denumire = denumire;
	}
	
    public String toString() {
        return "idSpecializare=" + idSpecializare +
                ", denumire='" + denumire + "'";
    }
}
