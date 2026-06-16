package DatabaseHelper;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Default.MesteriSpecializari;

public class MesterSpecializareDBHelper {
	public static List<String> getSpecializari() throws ClassNotFoundException {
	    List<String> listaSpecializari = new ArrayList<>();
	    DatabaseHelper db = new DatabaseHelper();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;

	    String query = "SELECT DISTINCT s.denumire " +
	                   "FROM anunt a " +
	                   "JOIN specializare s ON a.idSpecializare = s.idSpecializare " +
	                   "WHERE a.status = 'y'";

	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        resultSet = statement.executeQuery();
	        while (resultSet.next()) {
	            listaSpecializari.add(resultSet.getString("denumire"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }

	    return listaSpecializari;
	}

	
	public static List<String[]> getSpecializariDisponibile(String idMester) throws ClassNotFoundException {
	    List<String[]> disponibile = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String query = "SELECT s.idSpecializare, s.denumire\r\n"
	        		+ "		            FROM specializare s\r\n"
	        		+ "		            WHERE s.idSpecializare NOT IN (\r\n"
	        		+ "		                SELECT ms.idSpecializare\r\n"
	        		+ "		                FROM mesterspecializare ms\r\n"
	        		+ "		                WHERE ms.idMester = ?\r\n"
	        		+ "		            )";

	        stmt = conn.prepareStatement(query);
	        stmt.setString(1, idMester);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            disponibile.add(new String[] {
	                rs.getString("idSpecializare"),
	                rs.getString("denumire")
	            });
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, rs);
	    }

	    return disponibile;
	}
	
	public static void insereazaCerereSpecializare(String idMester, String idSpecializare, InputStream document) throws Exception {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();
	    try {
	        conn = db.getConnection();
	        String sql = "INSERT INTO mesterspecializare (idSpecializare, idMester, document) VALUES (?, ?, ?)";
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, Integer.parseInt(idSpecializare));
	        stmt.setInt(2, Integer.parseInt(idMester));
	        stmt.setBlob(3, document);
	        stmt.execute();
	    }catch(SQLException | ClassNotFoundException e) {
	    	e.printStackTrace();
	    }
	    finally {
	    	
	    	db.closeConnections(conn, stmt, null);
	    }
	}

	
	
	public static List<String[]> getSpecializariMester(String idMester, String status) throws Exception {
	    List<String[]> lista = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection(); 
	        String sql = "SELECT s.idSpecializare, s.denumire " +
	                     "FROM mesterspecializare ms " +
	                     "JOIN specializare s ON ms.idSpecializare = s.idSpecializare " +
	                     "WHERE ms.idMester = ? AND ms.status = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, Integer.parseInt(idMester));
	        stmt.setString(2, status);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            lista.add(new String[] {
	                rs.getString("idSpecializare"),
	                rs.getString("denumire")
	            });
	        }
	    } finally {
	    	db.closeConnections(conn, stmt, rs);
	    }

	    return lista;
	}

	public static List<String[]> getToateSpecializarileMester(String idMester) throws Exception {
	    List<String[]> rezultat = new ArrayList<>();

	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();

	        String sql = "SELECT s.idSpecializare, s.denumire, ms.status\r\n"
	        		+ "	            FROM mesterspecializare ms\r\n"
	        		+ "	            LEFT JOIN specializare s ON s.idSpecializare = ms.idSpecializare WHERE ms.idMester = ?\r\n"
	        		+ "	            ORDER BY s.denumire ASC";

	        stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, Integer.parseInt(idMester));
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            String id = rs.getString("idSpecializare");
	            String nume = rs.getString("denumire");
	            String status = rs.getString("status");
	            rezultat.add(new String[] { id, nume, status });
	        }

	    } finally {
	    	db.closeConnections(conn, stmt, rs);
	    }

	    return rezultat;
	}

	public static List<MesteriSpecializari> getCereriSpecializari() throws Exception {
	    List<MesteriSpecializari> lista = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String sql = "SELECT m.idMester, m.nume, m.prenume, s.denumire, s.idSpecializare, ms.status, ms.document " +
	                     "FROM mesterspecializare ms " +
	                     "JOIN mester m ON ms.idMester = m.idMester " +
	                     "JOIN specializare s ON ms.idSpecializare = s.idSpecializare";
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	        	MesteriSpecializari ms = new MesteriSpecializari();
	        	ms.setDenumire(rs.getString("denumire"));
	        	ms.setDocument(rs.getBytes("document"));
	        	ms.setIdMester(rs.getInt("idMester"));
	        	ms.setNume(rs.getString("nume"));
	        	ms.setPrenume(rs.getString("prenume"));
	        	ms.setStatus(rs.getString("status"));
	        	ms.setIdSpecializare(rs.getInt("idSpecializare"));
	        	lista.add(ms);
	        }
	    } finally {
	    	db.closeConnections(conn, stmt, rs);
	    }

	    return lista;
	}

	
	public static void updateStatusSpecializare(String idMester, String idSpecializare, String status) throws Exception {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();
	    
	    try {
	        conn = db.getConnection();
	        String sql = "UPDATE mesterspecializare SET status = ? WHERE idMester = ? AND idSpecializare = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, status);
	        stmt.setInt(2, Integer.parseInt(idMester));
	        stmt.setInt(3, Integer.parseInt(idSpecializare));
	        stmt.executeUpdate();
	    } finally {
	    	db.closeConnections(conn, stmt, null);
	    }
	}

	
	public static byte[] getDocumentSpecializare(String idMester, String idSpecializare) {
	    byte[] data = null;
	    DatabaseHelper db = new DatabaseHelper();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    String sql = "SELECT document FROM mesterspecializare WHERE idMester = ? AND idSpecializare = ?";

	    try  {
	    	
	    	conn = db.getConnection();
	    	stmt = conn.prepareStatement(sql);
	        stmt.setString(1, idMester);
	        stmt.setString(2, idSpecializare);

	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            data = rs.getBytes("document");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    finally {
	    	db.closeConnections(conn, stmt, null);
	    }
	    return data;
	}

}
