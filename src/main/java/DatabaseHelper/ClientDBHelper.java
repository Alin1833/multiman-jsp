package DatabaseHelper;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Default.Client;

public class ClientDBHelper {
	public static void insertClient(String nume, String prenume, int idCont) throws ClassNotFoundException {
        DatabaseHelper db = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        String query = "INSERT INTO client (nume, prenume, idCont) VALUES (?, ?, ?)";
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
	
	public static List<Client> getClienti() throws ClassNotFoundException {
    	List<Client> listaClienti = new ArrayList<Client>();
    	Connection connection = null;
    	PreparedStatement statement=null;
    	ResultSet resultSet=null;
    	DatabaseHelper db = new DatabaseHelper();
    	
    	  String query  = "SELECT * FROM client";
    	  try {

    		  connection = db.getConnection();
    		  statement = connection.prepareStatement(query);
    		  resultSet = statement.executeQuery();
    		  
              while(resultSet.next()) {
                  int idClient = resultSet.getInt("idClient");
                  String nume = resultSet.getString("nume");
                  String prenume = resultSet.getString("prenume");
                  int idCont = resultSet.getInt("idCont");

                  Client clientNou = new Client(idClient,nume,prenume,idCont);
                  listaClienti.add(clientNou);
                  }
          }catch(SQLException e) {
              System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
              e.printStackTrace();
          } finally {
        	  db.closeConnections(connection, statement, resultSet);
          }
    	
    	return listaClienti;
    }
	
	public static boolean clientAreLucrareInData(int idClient, Date data) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean existaLucrare = false;
        DatabaseHelper db = new DatabaseHelper();

        try {
            conn = db.getConnection();
            String query = "SELECT COUNT(*) FROM lucrare WHERE idClient = ? AND ? BETWEEN dataInceput AND dataFinalizare";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, idClient);
            stmt.setDate(2, data);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                existaLucrare = (count > 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnections(conn, stmt, rs);
        }

        return existaLucrare;
    }
	
	public static void insereazaProgramare(int idAnunt, int idClient, Date data) throws ClassNotFoundException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    DatabaseHelper db = new DatabaseHelper();

	    try {
	        conn = db.getConnection();
	        String insert = "INSERT INTO lucrare (dataInceput, idAnunt, idClient, status, idAdresa) " +
	                        "VALUES (?, ?, ?, 'in asteptare', (SELECT idAdresa FROM anunt WHERE idAnunt = ?))";
	        stmt = conn.prepareStatement(insert);
	        stmt.setDate(1, data);
	        stmt.setInt(2, idAnunt);
	        stmt.setInt(3, idClient);
	        stmt.setInt(4, idAnunt);

	        stmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(conn, stmt, null);
	    }
	}
}
