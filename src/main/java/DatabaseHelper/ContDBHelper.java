package DatabaseHelper;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ContDBHelper extends DatabaseHelper{
	public static void resetareParola(String email, String parola) throws ClassNotFoundException {
		DatabaseHelper db = new DatabaseHelper();
		Connection connection = null;
		PreparedStatement statement = null;
		String query = "UPDATE cont SET parola=? WHERE email=?";
		try{
			connection = db.getConnection();
			statement = connection.prepareStatement(query);
			statement.setString(1, parola);
			statement.setString(2, email);
			statement.execute();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			db.closeConnections(connection, statement, null);
		}
	}
	
	public static void insertCont(String email, String parola, String telefon, Date dataInregistrare, int idAdresa) 
			throws ClassNotFoundException {
	        DatabaseHelper db = new DatabaseHelper();
	        Connection connection = null;
	        PreparedStatement statement = null;
	        String query = "INSERT INTO cont (email, parola, telefon, dataInregistrare, idAdresa) VALUES (?, ?, ?, ?, ?)";
	        try {
	            connection = db.getConnection();
	            statement = connection.prepareStatement(query);
	            statement.setString(1, email);
	            statement.setString(2, parola);
	            statement.setString(3, telefon);
	            statement.setDate(4, dataInregistrare);
	            statement.setInt(5, AdresaDBHelper.getIdMaxAdresa());
	            statement.execute();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            db.closeConnections(connection, statement, null);
	        }
	    }

	  public static int getIdContMax() {
	        String query = "SELECT MAX(idCont) AS MaxID FROM cont";
	        DatabaseHelper dbHelper = null;
	        Connection connection = null;
	        PreparedStatement statement = null;
	        ResultSet result = null;
	        int idMax = 0;
	        try {
	            dbHelper = new DatabaseHelper();
	            connection = dbHelper.getConnection();
	            statement = connection.prepareStatement(query);
	            result = statement.executeQuery();
	            if (result.next()) {
	                idMax = result.getInt("MaxID");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            dbHelper.closeConnections(connection, statement, result);
	        }
	        return idMax;
	    }
	  
	  public static void updateCont(String idCont, String nume, String prenume, String email, String telefon
			  , String rol) throws ClassNotFoundException {
			DatabaseHelper db = new DatabaseHelper();
			Connection connection = null;
			PreparedStatement statement = null;
			String query = null;
			if(rol.equals("client")) {
				query = "UPDATE cont ct\r\n"
						+ "JOIN client c ON c.idCont = ct.idCont\r\n"
						+ "SET \r\n"
						+ "    c.nume = ?,\r\n"
						+ "    c.prenume = ?,\r\n"
						+ "    ct.email = ?,\r\n"
						+ "    ct.telefon = ?\r\n"
						+ "WHERE ct.idCont = ?;";
			}
			else if(rol.equals("mester")) {
				query = "UPDATE cont ct\r\n"
						+ "JOIN mester m ON m.idCont = ct.idCont\r\n"
						+ "SET \r\n"
						+ "    m.nume = ?,\r\n"
						+ "    m.prenume = ?,\r\n"
						+ "    ct.email = ?,\r\n"
						+ "    ct.telefon = ?\r\n"
						+ "WHERE ct.idCont = ?;";
			}
			
			try{
				connection = db.getConnection();
				statement = connection.prepareStatement(query);
				statement.setString(1, nume);
				statement.setString(2, prenume);
				statement.setString(3, email);
				statement.setString(4, telefon);
				statement.setString(5, idCont);
				
				statement.execute();
				
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				db.closeConnections(connection, statement, null);
			}
		}
}
