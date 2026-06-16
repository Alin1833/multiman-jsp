package Default;
import java.sql.Date;

public class Cont {
    int idCont;
    String email;
    String parola;
    String telefon;
    Date dataInregistrare;
    int idAdresa;

    public Cont(int idCont, String email, String parola, String telefon, Date dataInregistrare, int idAdresa) {
        this.idCont = idCont;
        this.email = email;
        this.parola = parola;
        this.telefon = telefon;
        this.dataInregistrare = dataInregistrare;
        this.idAdresa = idAdresa;
    }

    public int getIdCont() {
        return idCont;
    }

    public void setIdCont(int idCont) {
        this.idCont = idCont;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getParola() {
        return parola;
    }

    public void setParola(String parola) {
        this.parola = parola;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public Date getDataInregistrare() {
        return dataInregistrare;
    }

    public void setDataInregistrare(Date dataInregistrare) {
        this.dataInregistrare = dataInregistrare;
    }

    public int getIdAdresa() {
        return idAdresa;
    }

    public void setIdAdresa(int idAdresa) {
        this.idAdresa = idAdresa;
    }

    public String toString() {
        return "idCont=" + idCont +
                ", email='" + email + '\'' +
                ", parola='" + parola + '\'' +
                ", telefon='" + telefon + '\'' +
                ", dataInregistrare=" + dataInregistrare +
                ", idAdresa=" + idAdresa;
    }
}
