package DatabaseHelper;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseHelper {
	private static final String URL = "jdbc:mysql://localhost:3306/multiman";
	private static final String USER = "root";
	private static final String PASSWORD = "";
	
	static {
		// Class.forName("org.mariadb.jdbc.Driver");
	}
	
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		final Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
		return connection;
	}
	
	public void closeConnections(final Connection connection, final Statement statement, final ResultSet resultSet) {
		closeResultSet(resultSet);
		closeStatement(statement);
		closeConnection(connection);
	}

	private void closeConnection(final Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (final SQLException e) {
			e.printStackTrace();
		}
	}

	private void closeStatement(final Statement statement) {
		try {
			if (statement != null) {
				statement.close();
			}
		} catch (final SQLException e) {
			e.printStackTrace();
		}
	}

	private void closeResultSet(final ResultSet resultSet) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (final SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
