package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class AdresaDBHelper extends DatabaseHelper{
	 
		public static void insertAdresa(String judet,String localitate,String strada) throws ClassNotFoundException
		{
			DatabaseHelper db = new DatabaseHelper();
			Connection connection = null;
			PreparedStatement statement = null;
			String query = "INSERT INTO adresa (judet,localitate,strada) VALUES (?,?,?)";
			try{
				connection = db.getConnection();
				statement = connection.prepareStatement(query);
				statement.setString(1, judet);
				statement.setString(2, localitate);
				statement.setString(3, strada);
				statement.execute();
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				db.closeConnections(connection, statement, null);
			}
		}
		
		
		public static int getIdMaxAdresa()
		{
			String query="SELECT MAX(idAdresa) AS MaxID FROM adresa";
			DatabaseHelper dbHelper = null;
			Connection connection = null;
			PreparedStatement statement = null;
			ResultSet set = null;
			int idMax = 0;
			try {
				dbHelper = new DatabaseHelper();
				connection = dbHelper.getConnection();
				statement = connection.prepareStatement(query);
				set = statement.executeQuery();
				if(set.next())
					idMax = set.getInt("MaxID");
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				dbHelper.closeConnections(connection, statement, set);
			}
			return idMax;
		}
		
		public static List<String> getJudete() throws ClassNotFoundException{
			List<String> listaJudete=new ArrayList<>();
			DatabaseHelper db = new DatabaseHelper();
			Connection connection = null;
			PreparedStatement statement = null;
			ResultSet resultSet = null;
			String query = "SELECT \r\n"
					+ "	             ad.judet\r\n"
					+ "	        FROM anunt a\r\n"
					+ "	        LEFT JOIN adresa ad ON a.idAdresa = ad.idAdresa\r\n"
					+ "	        LEFT JOIN mester m ON a.idMester = m.idMester\r\n"
					+ "	        LEFT JOIN mesterspecializare ms ON m.idMester = ms.idMester\r\n"
					+ "	        LEFT JOIN specializare s ON ms.idSpecializare = s.idSpecializare"
					+ "			WHERE a.status='y'";
			try{
				connection = db.getConnection();
				statement = connection.prepareStatement(query);
				resultSet = statement.executeQuery();
				 while (resultSet.next()) {
					 if(!listaJudete.contains(resultSet.getString("judet"))) {
			           listaJudete.add(resultSet.getString("judet"));
					 }
			        }
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				db.closeConnections(connection, statement, null);
			}
			
			return listaJudete;
		}

}
