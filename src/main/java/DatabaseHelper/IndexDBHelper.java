package DatabaseHelper;

import Default.AnuntIndex;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class IndexDBHelper extends DatabaseHelper{
	public static List<AnuntIndex> getAnunturiPostari() throws ClassNotFoundException{
		List<AnuntIndex> listaAnunturiIndex = new ArrayList<>();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();

	    String query = "SELECT a.idAnunt, a.idMester, m.nume, m.prenume, a.titlu, a.descriere, \r\n"
	    		+ "a.pretOra, a.status, a.idAdresa, a.idAdmin, ad.judet, s.denumire\r\n"
	    		+ "FROM anunt a\r\n"
	    		+ "LEFT JOIN adresa ad ON a.idAdresa = ad.idAdresa\r\n"
	    		+ "LEFT JOIN mester m ON a.idMester = m.idMester\r\n"
	    		+ "LEFT JOIN mesterspecializare ms ON m.idMester = ms.idMester\r\n"
	    		+ "LEFT JOIN specializare s ON ms.idSpecializare = s.idSpecializare WHERE a.status='y'\r\n"
	    		+ "GROUP BY idAnunt";

	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            AnuntIndex ai = new AnuntIndex();

	            ai.setIdAnunt(resultSet.getInt("idAnunt"));
	            ai.setIdMester(resultSet.getInt("idMester"));
	            ai.setNume(resultSet.getString("nume"));
	            ai.setPrenume(resultSet.getString("prenume"));
	            ai.setTitlu(resultSet.getString("titlu"));
	            ai.setDescriere(resultSet.getString("descriere"));
	            ai.setPretOra(resultSet.getDouble("pretOra"));
	            ai.setStatus(resultSet.getString("status"));
	            ai.setIdAdresa(resultSet.getInt("idAdresa"));
	            ai.setIdAdmin(resultSet.getInt("idAdmin"));
	            ai.setJudet(resultSet.getString("judet"));
	            ai.setDenumire(resultSet.getString("denumire"));

	            listaAnunturiIndex.add(ai);
	        }
	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }

	    return listaAnunturiIndex;
	}
	
	public static List<AnuntIndex> getIstoricClient() throws ClassNotFoundException{
		List<AnuntIndex> listaAnunturiIndex = new ArrayList<>();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();

	    String query = "SELECT \r\n"
	    		+ "	            a.idAnunt, a.idMester, m.nume, m.prenume, a.titlu, a.descriere, \r\n"
	    		+ "	            a.pretOra, a.status, a.idAdresa, a.idAdmin, ad.judet, s.denumire\r\n"
	    		+ "	        FROM anunt a\r\n"
	    		+ "	        LEFT JOIN adresa ad ON a.idAdresa = ad.idAdresa\r\n"
	    		+ "	        LEFT JOIN mester m ON a.idMester = m.idMester\r\n"
	    		+ "	        LEFT JOIN mesterspecializare ms ON m.idMester = ms.idMester\r\n"
	    		+ "	        LEFT JOIN specializare s ON ms.idSpecializare = s.idSpecializare"
	    		+ " 		WHERE a.status='y' AND ";

	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            AnuntIndex ai = new AnuntIndex();

	            ai.setIdAnunt(resultSet.getInt("idAnunt"));
	            ai.setIdMester(resultSet.getInt("idMester"));
	            ai.setNume(resultSet.getString("nume"));
	            ai.setPrenume(resultSet.getString("prenume"));
	            ai.setTitlu(resultSet.getString("titlu"));
	            ai.setDescriere(resultSet.getString("descriere"));
	            ai.setPretOra(resultSet.getDouble("pretOra"));
	            ai.setStatus(resultSet.getString("status"));
	            ai.setIdAdresa(resultSet.getInt("idAdresa"));
	            ai.setIdAdmin(resultSet.getInt("idAdmin"));
	            ai.setJudet(resultSet.getString("judet"));
	            ai.setDenumire(resultSet.getString("denumire"));

	            listaAnunturiIndex.add(ai);
	        }
	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }

	    return listaAnunturiIndex;
	}
	
	public static List<AnuntIndex> getFilteredAnunturi(List<String> judete, List<String> specializari, Double pretMin, Double pretMax) throws ClassNotFoundException {
	    List<AnuntIndex> anunturi = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        StringBuilder query = new StringBuilder(
	            "SELECT a.idAnunt, a.idMester, m.nume, m.prenume, a.titlu, a.descriere, " +
	            "a.pretOra, a.status, a.idAdresa, a.idAdmin, ad.judet, s.denumire " +
	            "FROM anunt a " +
	            "JOIN adresa ad ON a.idAdresa = ad.idAdresa " +
	            "JOIN mester m ON a.idMester = m.idMester " +
	            "JOIN specializare s ON a.idSpecializare = s.idSpecializare " +
	            "WHERE a.status = 'y' "
	        );

	        if (judete != null && !judete.isEmpty()) {
	            String placeholders = String.join(", ", Collections.nCopies(judete.size(), "?"));
	            query.append("AND ad.judet IN (").append(placeholders).append(") ");
	        }

	        if (specializari != null && !specializari.isEmpty()) {
	            String placeholders = String.join(", ", Collections.nCopies(specializari.size(), "?"));
	            query.append("AND s.denumire IN (").append(placeholders).append(") ");
	        }

	        if (pretMin != null) {
	            query.append("AND a.pretOra >= ? ");
	        }

	        if (pretMax != null) {
	            query.append("AND a.pretOra <= ? ");
	        }

	        query.append("ORDER BY a.dataPostare DESC");

	        stmt = conn.prepareStatement(query.toString());

	        int paramIndex = 1;

	        if (judete != null && !judete.isEmpty()) {
	            for (String judet : judete) {
	                stmt.setString(paramIndex++, judet);
	            }
	        }

	        if (specializari != null && !specializari.isEmpty()) {
	            for (String specializare : specializari) {
	                stmt.setString(paramIndex++, specializare);
	            }
	        }

	        if (pretMin != null) {
	            stmt.setDouble(paramIndex++, pretMin);
	        }

	        if (pretMax != null) {
	            stmt.setDouble(paramIndex++, pretMax);
	        }

	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            AnuntIndex anunt = new AnuntIndex();
	            anunt.setIdAnunt(rs.getInt("idAnunt"));
	            anunt.setIdMester(rs.getInt("idMester"));
	            anunt.setNume(rs.getString("nume"));
	            anunt.setPrenume(rs.getString("prenume"));
	            anunt.setTitlu(rs.getString("titlu"));
	            anunt.setDescriere(rs.getString("descriere"));
	            anunt.setPretOra(rs.getDouble("pretOra"));
	            anunt.setStatus(rs.getString("status"));
	            anunt.setIdAdresa(rs.getInt("idAdresa"));
	            anunt.setIdAdmin(rs.getInt("idAdmin"));
	            anunt.setJudet(rs.getString("judet"));
	            anunt.setDenumire(rs.getString("denumire"));
	            anunturi.add(anunt);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, rs);
	    }

	    return anunturi;
	}

	
	

}
