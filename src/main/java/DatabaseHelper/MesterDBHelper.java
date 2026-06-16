package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MesterDBHelper extends DatabaseHelper {

    public static void insertMester(String nume, String prenume, int idCont) throws ClassNotFoundException {
        DatabaseHelper db = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "INSERT INTO mester (nume, prenume, idCont) VALUES (?, ?, ?)";
        try {
            connection = db.getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, nume);
            statement.setString(2, prenume);
            statement.setInt(3, ContDBHelper.getIdContMax());
            statement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(connection, statement, null);
        }
    }
    
    
	    public static List<String[]> getLucrariInCursMester(int idMester) throws ClassNotFoundException {
	        List<String[]> lucrari = new ArrayList<>();
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	        DatabaseHelper db = new DatabaseHelper();
	
	        try {
	            conn = db.getConnection();
	            String query = "SELECT l.idLucrare, c.nume, c.prenume, a.titlu, l.dataInceput, l.dataFinalizare, l.pretFinal\r\n"
	            		+ "                FROM lucrare l\r\n"
	            		+ "                JOIN anunt a ON l.idAnunt = a.idAnunt\r\n"
	            		+ "                JOIN client c ON l.idClient = c.idClient\r\n"
	            		+ "                WHERE a.idMester = ? AND l.dataFinalizare IS NOT NULL\r\n"
	            		+ "                  AND l.status = 'in curs'";
	            stmt = conn.prepareStatement(query);
	            stmt.setInt(1, idMester);
	            rs = stmt.executeQuery();
	            while (rs.next()) {
	                lucrari.add(new String[] {
	                    rs.getString("idLucrare"),
	                    rs.getString("nume"),
	                    rs.getString("prenume"),
	                    rs.getString("titlu"),
	                    rs.getString("dataInceput"),
	                    rs.getString("dataFinalizare"),
	                    rs.getString("pretFinal")
	                });
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            db.closeConnections(conn, stmt, rs);
	        }
	
	        return lucrari;
	    }
	    
	    
	    public static List<String[]> getCereriMester(int idMester) throws ClassNotFoundException {
	        List<String[]> cereri = new ArrayList<>();
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	        DatabaseHelper db = new DatabaseHelper();
	
	        try {
	            conn = db.getConnection();
	            String query = "SELECT l.idLucrare, c.nume, c.prenume, a.titlu, l.dataInceput\r\n"
	            		+ "                FROM lucrare l\r\n"
	            		+ "                JOIN anunt a ON l.idAnunt = a.idAnunt\r\n"
	            		+ "                JOIN client c ON l.idClient = c.idClient\r\n"
	            		+ "                WHERE a.idMester = ? AND l.dataFinalizare IS NULL";
	            stmt = conn.prepareStatement(query);
	            stmt.setInt(1, idMester);
	            rs = stmt.executeQuery();
	            while (rs.next()) {
	                cereri.add(new String[] {
	                    rs.getString("idLucrare"),
	                    rs.getString("nume"),
	                    rs.getString("prenume"),
	                    rs.getString("titlu"),
	                    rs.getString("dataInceput")
	                });
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            db.closeConnections(conn, stmt, rs);
	        }
	
	        return cereri;
	    }

    public static int getIdAdresaFromMester(int idMester) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        DatabaseHelper db = new DatabaseHelper();
        int idAdresa = -1;

        try {
            conn = db.getConnection();
            String query = "SELECT idAdresa FROM cont WHERE idCont = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, idMester);
            rs = stmt.executeQuery();
            if (rs.next()) {
                idAdresa = rs.getInt("idAdresa");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, rs);
        }

        return idAdresa;
    }
    
    public static void finalizeazaLucrare(int idLucrare, double pretFinal) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        DatabaseHelper db = new DatabaseHelper();
        try {
            conn = db.getConnection();
            String query = "UPDATE lucrare SET pretFinal=?, status='finalizata' WHERE idLucrare=?";
            stmt = conn.prepareStatement(query);
            stmt.setDouble(1, pretFinal);
            stmt.setInt(2, idLucrare);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, null);
        }
    }
    
    
    public static void acceptaCerere(int idLucrare, String dataFinalizare) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        DatabaseHelper db = new DatabaseHelper();
        try {
            conn = db.getConnection();
            String query = "UPDATE lucrare SET dataFinalizare=?, status='in curs' WHERE idLucrare=?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, dataFinalizare);
            stmt.setInt(2, idLucrare);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, null);
        }
    }

    public static void refuzaCerere(int idLucrare) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        DatabaseHelper db = new DatabaseHelper();
        try {
            conn = db.getConnection();
            String query = "DELETE FROM lucrare WHERE idLucrare=?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, idLucrare);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, null);
        }
    }
}
