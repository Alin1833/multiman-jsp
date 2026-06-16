package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SpecializareDBHelper {
	public static List<String[]> getToateSpecializarile() throws SQLException, ClassNotFoundException {
	    DatabaseHelper db = new DatabaseHelper();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<String[]> specializari = new ArrayList<>();

	    try {
	        conn = db.getConnection();
	        String query = "SELECT idSpecializare, denumire FROM specializare ORDER BY denumire";

	        stmt = conn.prepareStatement(query);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            String id = rs.getString("idSpecializare");
	            String denumire = rs.getString("denumire");

	            specializari.add(new String[] { id, denumire });
	        }

	    } finally {
	        db.closeConnections(conn, stmt, rs);
	    }

	    return specializari;
	}

	
	public static void adaugaSpecializare(String denumire) throws SQLException, ClassNotFoundException {
	    DatabaseHelper dbHelper = new DatabaseHelper();
	    Connection connection = null;
	    PreparedStatement statement = null;

	    try {
	        connection = dbHelper.getConnection();
	        String query = "INSERT INTO specializare (denumire) VALUES (?)";
	        statement = connection.prepareStatement(query);
	        statement.setString(1, denumire);
	        statement.executeUpdate();
	    } finally {
	        dbHelper.closeConnections(connection, statement, null);
	    }
	}

}
