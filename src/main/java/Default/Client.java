package Default;

import java.util.Objects;

public class Client implements Comparable<Client>{
	int idClient;
	String nume;
	String prenume;
	int idCont;
	
	public Client(int idClient, String nume, String prenume, int idCont) {
        this.idClient = idClient;
        this.nume = nume;
        this.prenume = prenume;
        this.idCont = idCont;
    }

    public int getIdClient() {
        return idClient;
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

    public void setIdClient(int idClient) {
		this.idClient = idClient;
	}

	public void setNume(String nume) {
		this.nume = nume;
	}

	public void setPrenume(String prenume) {
		this.prenume = prenume;
	}

	public void setIdCont(int idCont) {
		this.idCont = idCont;
	}

	public String toString() {
        return "idClient=" + idClient +
                ", nume='" + nume + "'" +
                ", prenume='" + prenume + "'" +
                ", idCont=" + idCont;
    }
	
	public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Client)) return false;
        Client alt = (Client) o;
        return this.nume==alt.nume && this.prenume==alt.prenume;
	}

    public int hashCode() {
        return Objects.hash(nume, prenume);
    }
    
    public int compareTo(Client alt) {
		 return this.toString().compareTo(alt.toString());
	}
}
