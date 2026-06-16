package Default;

public class Mester {
	int idMester;
	String nume;
	String prenume;
	int idCont;
	
	public Mester(int idMester, String nume, String prenume, int idCont) {
        this.idMester = idMester;
        this.nume = nume;
        this.prenume = prenume;
        this.idCont = idCont;
    }

    public int getIdMester() {
        return idMester;
    }

    public String getNume() {
        return nume;
    }

    public String getPrenume() {
        return prenume;
    }

    public int getIdCont() {
        return idCont;
    }

    public String toString() {
        return "nume='" + nume + "'" +
                ", prenume='" + prenume + "'" +
                ", idCont=" + idCont;
    }
}
