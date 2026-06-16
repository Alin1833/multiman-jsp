package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Default.Anunt;

public class AnuntDBHelper extends DatabaseHelper {
	public static List<Anunt> getAnunturi() throws ClassNotFoundException {
	    List<Anunt> listaAnunturi = new ArrayList<>();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();

	    String query = "SELECT * FROM anunt";
	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            Anunt anuntNou = new Anunt();

	            anuntNou.setIdAnunt(resultSet.getInt("idAnunt"));
	            anuntNou.setIdMester(resultSet.getInt("idMester"));
	            anuntNou.setTitlu(resultSet.getString("titlu"));
	            anuntNou.setDescriere(resultSet.getString("descriere"));
	            anuntNou.setPretOra(resultSet.getDouble("pretOra"));
	            anuntNou.setStatus(resultSet.getString("status"));
	            anuntNou.setIdAdresa(resultSet.getInt("idAdresa"));
	            anuntNou.setIdAdmin(resultSet.getInt("idAdmin"));
	            anuntNou.setIdSpecializare(resultSet.getInt("idSpecializare"));
	            
	            listaAnunturi.add(anuntNou);
	        }
	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }

	    return listaAnunturi;
	}

	public static void insertAnunt(Anunt anunt) throws ClassNotFoundException {
		Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();

	    String query = "INSERT INTO anunt (idMester, titlu, descriere, pretOra, dataPostare, "
	    		+ "idAdresa, idSpecializare) VALUES (?, ?, ?, ?, CURDATE(), ?, ?) ";
	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
            statement.setInt(1, anunt.getIdMester());
            statement.setString(2, anunt.getTitlu());
            statement.setString(3, anunt.getDescriere());
            statement.setDouble(4, anunt.getPretOra());
            statement.setInt(5, MesterDBHelper.getIdAdresaFromMester(anunt.getIdMester()));
            statement.setInt(6, anunt.getIdSpecializare());
            statement.execute();

	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }
	}
	
	
	public static List<String[]> getAnunturiMester(int idMester) throws ClassNotFoundException {
	    List<String[]> anunturi = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String query = "SELECT a.idAnunt, a.titlu, a.descriere, a.pretOra, a.status, s.denumire\r\n"
	        		+ "	            FROM anunt a LEFT JOIN specializare s ON s.idSpecializare=a.idSpecializare\r\n"
	        		+ "	            WHERE idMester = ?";
	        stmt = conn.prepareStatement(query);
	        stmt.setInt(1, idMester);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            anunturi.add(new String[]{
	                rs.getString("idAnunt"),
	                rs.getString("titlu"),
	                rs.getString("descriere"),
	                rs.getString("pretOra"),
	                rs.getString("status"),
	                rs.getString("denumire")
	            });
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, rs);
	    }

	    return anunturi;
	}
	
	public static void rejectAnunt(int idAnunt, int idAdmin) throws ClassNotFoundException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String query = "UPDATE anunt SET status = 'n', idAdmin = ? WHERE idAnunt=?";
	        stmt = conn.prepareStatement(query);
	        stmt.setInt(1, idAdmin);
	        stmt.setInt(2, idAnunt);
	        stmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw new RuntimeException("Eroare la ștergerea anunțului.");
	    } finally {
	        db.closeConnections(conn, stmt, null);
	    }
	}
	
	public static List<String[]> getToateAnunturile() throws ClassNotFoundException {
	    List<String[]> lista = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String query = "SELECT a.idAnunt, a.titlu, a.descriere, a.pretOra, a.status, s.denumire\r\n"
	        		+ "	            FROM anunt a LEFT JOIN specializare s ON s.idSpecializare=a.idSpecializare\r\n";
	        
	        stmt = conn.prepareStatement(query);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            lista.add(new String[] {
	                rs.getString("idAnunt"),
	                rs.getString("titlu"),
	                rs.getString("descriere"),
	                rs.getString("pretOra"),
	                rs.getString("status"),
	                rs.getString("denumire")
	            });
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, rs);
	    }

	    return lista;
	}

	
	public static void updateStatusAnunt(int idAnunt, String status, int idAdmin) throws ClassNotFoundException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String sql = "UPDATE anunt SET status = ?, idAdmin = ? WHERE idAnunt = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, status);
	        stmt.setInt(2, idAdmin);
	        stmt.setInt(3, idAnunt);
	        stmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, null);
	    }
	}
	
	public static Anunt getAnuntById(String idAnunt) {
        Anunt anunt = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        DatabaseHelper db = new DatabaseHelper();

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM anunt WHERE idAnunt = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, idAnunt);
            rs = stmt.executeQuery();

            if (rs.next()) {
                anunt = new Anunt();
                anunt.setIdAnunt(rs.getInt("idAnunt"));
                anunt.setIdMester(rs.getInt("idMester"));
                anunt.setTitlu(rs.getString("titlu"));
                anunt.setDescriere(rs.getString("descriere"));
                anunt.setPretOra(rs.getDouble("pretOra"));
                anunt.setStatus(rs.getString("status"));
                anunt.setIdAdresa(rs.getInt("idAdresa"));
                anunt.setIdAdmin(rs.getInt("idAdmin"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, rs);
        }

        return anunt;
    }

	public static void updateAnunt(int idAnunt, String titlu, String descriere, double pretOra, int idSpecializare) {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String sql = "UPDATE anunt SET titlu = ?, descriere = ?, pretOra = ?, idSpecializare = ?, status = NULL, idAdmin = NULL WHERE idAnunt = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, titlu);
	        stmt.setString(2, descriere);
	        stmt.setDouble(3, pretOra);
	        stmt.setInt(4, idSpecializare);
	        stmt.setInt(5, idAnunt);

	        stmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, null);
	    }

	}

}
