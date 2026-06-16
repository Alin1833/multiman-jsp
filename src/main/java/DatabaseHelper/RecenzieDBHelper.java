package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Default.Recenzie;


public class RecenzieDBHelper {
	public static void insertRecenzie(Recenzie recenzie) throws ClassNotFoundException{
		Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();

	    String query = "INSERT INTO recenzie (comentariu, dataRecenzie, idLucrare, rating) VALUES "
	    		+ "(?, CURDATE(), ?, ?)";
	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        statement.setString(1, recenzie.getComentariu());
	        statement.setInt(2, recenzie.getIdLucrare());
	        statement.setInt(3, recenzie.getRating());
	        statement.execute();

	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }
	}
	
	public static String[] getRecenzie(String id) throws ClassNotFoundException{
		Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    DatabaseHelper db = new DatabaseHelper();
	    String[] rezultat = null;

	    String query = "SELECT comentariu, dataRecenzie, rating  FROM recenzie WHERE idRecenzie= ?";
	    try {
	        connection = db.getConnection();
	        statement = connection.prepareStatement(query);
	        statement.setString(1, id);
	        resultSet = statement.executeQuery();
	        
	        if (resultSet.next()) {
            	String comentariu = resultSet.getString("comentariu");
                String rating = resultSet.getString("rating");
                String dataRecenzie = resultSet.getString("dataRecenzie");
                
                rezultat = new String[] { comentariu, dataRecenzie, rating };
            }
	    } catch (SQLException e) {
	        System.out.println("A aparut o eroare la conectarea cu baza de date!!!");
	        e.printStackTrace();
	    } finally {
	        db.closeConnections(connection, statement, resultSet);
	    }
	    return rezultat;
	}
	
}
