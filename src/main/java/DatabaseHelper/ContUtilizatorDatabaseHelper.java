package DatabaseHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContUtilizatorDatabaseHelper {
	public static String[] verificaUtilizator(String email, String parola) throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String[] rezultate = null;

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
                    "CASE WHEN idMester IS NOT NULL THEN mester.nume " +
                    "WHEN idClient IS NOT NULL THEN client.nume " +
                    "ELSE 'admin' END AS nume, " +
                    "CASE WHEN idMester IS NOT NULL THEN mester.prenume " +
                    "WHEN idClient IS NOT NULL THEN client.prenume " +
                    "ELSE 'admin' END AS prenume, " +
                    "CASE WHEN idMester IS NOT NULL THEN 'mester' " +
                    "WHEN idClient IS NOT NULL THEN 'client' " +
                    "ELSE 'admin' END AS rol, " +
                    "CASE WHEN idMester IS NOT NULL THEN mester.idMester " +
                    "WHEN idClient IS NOT NULL THEN client.idClient " +
                    "ELSE admin.idAdmin END AS id "+ 
                    "FROM cont " +
                    "LEFT JOIN client USING (idCont) " +
                    "LEFT JOIN mester USING (idCont) "
                    + "LEFT JOIN admin USING (idCont) " +
                    "WHERE email = ? AND parola = ?";

            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, parola);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String rol = resultSet.getString("rol");
                String id = resultSet.getString("id");

                rezultate = new String[] { nume, prenume, rol, id };
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return rezultate;
    }
	
	
	
	
	
	public static String[] verificaUtilizatorResetare(String email) throws SQLException, ClassNotFoundException {
		DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String[] rezultate = null;

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
                    "CASE WHEN idMester IS NOT NULL THEN mester.nume " +
                    "WHEN idClient IS NOT NULL THEN client.nume " +
                    "ELSE 'admin' END AS nume, " +
                    "CASE WHEN idMester IS NOT NULL THEN mester.prenume " +
                    "WHEN idClient IS NOT NULL THEN client.prenume " +
                    "ELSE 'admin' END AS prenume, parola " +
                    "FROM cont " +
                    "LEFT JOIN client USING (idCont) " +
                    "LEFT JOIN mester USING (idCont) " +
                    "WHERE email = ?;";

            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String parola = resultSet.getString("parola");

                rezultate = new String[] { nume, prenume, parola };
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return rezultate;
	}
	
	public static int verificareEmailCont(String email) throws SQLException, ClassNotFoundException {
		DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT * " +
                    "FROM cont " +
                    "WHERE email = ? ";

            statement = connection.prepareStatement(query);
            statement.setString(1, email);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {
            	return 1;
            } else {
            	return 0;
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

	}
	
	public static List<String[]> getIstoricLucrariClient(String id) throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String[] rezultate = null;
        List<String[]> listaLucrari = new ArrayList<>();

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT \r\n"
            		+ "    l.idLucrare, m.nume, m.prenume, a.titlu, a.descriere,\r\n"
            		+ "    s.denumire, ad.judet, ad.localitate, ad.strada,\r\n"
            		+ "    l.dataInceput, l.dataFinalizare, l.pretFinal,\r\n"
            		+ "    r.idRecenzie\r\n"
            		+ "FROM lucrare l\r\n"
            		+ "JOIN anunt a ON a.idAnunt = l.idAnunt\r\n"
            		+ "JOIN adresa ad ON l.idAdresa = ad.idAdresa\r\n"
            		+ "JOIN mester m ON a.idMester = m.idMester\r\n"
            		+ "JOIN specializare s ON a.idSpecializare = s.idSpecializare\r\n"
            		+ "LEFT JOIN recenzie r ON r.idLucrare = l.idLucrare\r\n"
            		+ "WHERE l.pretFinal IS NOT NULL AND l.idClient = ?\r\n"
            		+ "GROUP BY l.idLucrare\r\n";

            statement = connection.prepareStatement(query);
            statement.setString(1, id);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String idLucrare = resultSet.getString("idLucrare");
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String descriere = resultSet.getString("descriere");
                String specializare = resultSet.getString("denumire");
                String judet = resultSet.getString("judet");
                String localitate = resultSet.getString("localitate");
                String strada = resultSet.getString("strada");
                String dataInceput = resultSet.getString("dataInceput");
                String dataFinalizare = resultSet.getString("dataFinalizare");
                String pretFinal = resultSet.getString("pretFinal");
                String idRecenzie = resultSet.getString("idRecenzie");

                String adresaCompleta = judet + ", " + localitate + ", " + strada;
                String perioada = dataInceput + " - " + dataFinalizare;
                
                rezultate = new String[] {
                    nume, prenume, specializare, adresaCompleta, perioada,
                    descriere, pretFinal, idLucrare, idRecenzie
                };

                listaLucrari.add(rezultate);
            }


        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return listaLucrari;
    }
	
	
	public static String[] getContClient(String id) throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String[] rezultate = null;

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
            	    "COALESCE(SUM(l.pretFinal), 0) AS total, ct.idCont, c.nume, c.prenume, ct.telefon, ct.email, ct.dataInregistrare " +
            	    "FROM client c " +
            	    "JOIN cont ct ON c.idCont=ct.idCont " +
            	    "LEFT JOIN lucrare l ON c.idClient=l.idClient " +
            	    "WHERE c.idClient = ? " +
            	    "GROUP BY ct.idCont, c.nume, c.prenume, ct.telefon, ct.email, ct.dataInregistrare";

            statement = connection.prepareStatement(query);
            statement.setString(1, id);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	String total = resultSet.getString("total");
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String telefon = resultSet.getString("telefon");
                String email = resultSet.getString("email");
                String dataInregistrare = resultSet.getString("dataInregistrare");
                String idCont = resultSet.getString("idCont");
                
                rezultate = new String[] { total, nume, prenume, email, telefon, dataInregistrare, idCont};
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return rezultate;
    }
	
	public static List<String[]> getIstoricLucrariMester(String idMester) throws SQLException, ClassNotFoundException {
	    DatabaseHelper dbHelper = new DatabaseHelper();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    List<String[]> listaLucrari = new ArrayList<>();

	    try {
	        connection = dbHelper.getConnection();
	        String query = "SELECT l.idLucrare, c.nume AS numeClient, c.prenume AS prenumeClient, a.titlu, " +
	        	    "a.descriere, s.denumire, ad.judet, ad.localitate, ad.strada, " +
	        	    "l.pretFinal, l.dataInceput, l.dataFinalizare, r.idRecenzie " +
	        	    "FROM lucrare l " +
	        	    "JOIN anunt a ON l.idAnunt = a.idAnunt " +
	        	    "JOIN adresa ad ON l.idAdresa = ad.idAdresa " +
	        	    "JOIN client c ON l.idClient = c.idClient " +
	        	    "LEFT JOIN recenzie r ON r.idLucrare = l.idLucrare " +
	        	    "LEFT JOIN specializare s ON a.idSpecializare = s.idSpecializare " +
	        	    "WHERE l.dataFinalizare IS NOT NULL AND a.idMester = ? " +
	        	    "GROUP BY l.idLucrare";


	        statement = connection.prepareStatement(query);
	        statement.setString(1, idMester);
	        resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            String idLucrare = resultSet.getString("idLucrare");
	            String numeClient = resultSet.getString("numeClient");
	            String prenumeClient = resultSet.getString("prenumeClient");
	            String titlu = resultSet.getString("titlu");
	            String descriere = resultSet.getString("descriere");
	            String judet = resultSet.getString("judet");
	            String localitate = resultSet.getString("localitate");
	            String strada = resultSet.getString("strada");

	            String adresaCompleta = judet + ", " + localitate + ", " + strada;

	            String pretFinal = resultSet.getString("pretFinal");
	            String dataInceput = resultSet.getString("dataInceput");
	            String dataFinalizare = resultSet.getString("dataFinalizare");
	            String idRecenzie = resultSet.getString("idRecenzie");

	            String[] rezultate = new String[] {
	            	    idLucrare, numeClient, prenumeClient, titlu, descriere, adresaCompleta,
	            	    dataInceput, dataFinalizare, pretFinal, idRecenzie
	            	};


	            listaLucrari.add(rezultate);
	        }

	    } finally {
	        dbHelper.closeConnections(connection, statement, resultSet);
	    }

	    return listaLucrari;
	}
	
	
	public static String[] getContMester(String id) throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String[] rezultate = null;

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
            	    "COALESCE(SUM(l.pretFinal), 0) AS total, ct.idCont, m.nume, m.prenume, ct.telefon, ct.email, ct.dataInregistrare " +
            	    "FROM mester m " +
            	    "JOIN cont ct ON m.idCont=ct.idCont " +
            	    "LEFT JOIN anunt a ON a.idMester=m.idMester " +
            	    "LEFT JOIN lucrare l ON a.idAnunt=l.idAnunt " +
            	    "WHERE m.idMester = ? " +
            	    "GROUP BY ct.idCont, m.nume, m.prenume, ct.telefon, ct.email, ct.dataInregistrare";

            statement = connection.prepareStatement(query);
            statement.setString(1, id);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	String total = (resultSet.getString("total")==null) ? "0" : resultSet.getString("total");
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String telefon = resultSet.getString("telefon");
                String email = resultSet.getString("email");
                String dataInregistrare = resultSet.getString("dataInregistrare");
                String idCont = resultSet.getString("idCont");
                
                rezultate = new String[] { total, nume, prenume, email, telefon, dataInregistrare, idCont};
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return rezultate;
    }
	
	public static List<String[]> getTotiClientii() throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<String[]> clienti = new ArrayList<>();

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
            	    "COALESCE(SUM(l.pretFinal), 0) AS total, ct.idCont, c.nume, c.prenume, ct.telefon, ct.email, ct.dataInregistrare " +
            	    "FROM client c " +
            	    "JOIN cont ct ON c.idCont=ct.idCont " +
            	    "LEFT JOIN lucrare l ON c.idClient=l.idClient " +
            	    "GROUP BY ct.idCont, c.nume, c.prenume, ct.telefon, ct.email, ct.dataInregistrare "
            	    + "ORDER BY c.nume, c.prenume";

            statement = connection.prepareStatement(query);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	String total = resultSet.getString("total");
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String telefon = resultSet.getString("telefon");
                String email = resultSet.getString("email");
                String dataInregistrare = resultSet.getString("dataInregistrare");
                String idCont = resultSet.getString("idCont");
                
                clienti.add(new String[] {
                        total, nume, prenume, email, telefon, dataInregistrare, idCont
                    });
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return clienti;
    }
	
	public static List<String[]> getTotiMesterii() throws SQLException, ClassNotFoundException {
        DatabaseHelper dbHelper = new DatabaseHelper();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<String[]> mesteri = new ArrayList<>();

        try {
            connection = dbHelper.getConnection();
            String query = "SELECT " +
            	    "COALESCE(SUM(l.pretFinal), 0) AS total, ct.idCont, m.nume, m.prenume, ct.telefon, ct.email, ct.dataInregistrare " +
            	    "FROM mester m " +
            	    "JOIN cont ct ON m.idCont=ct.idCont " +
            	    "LEFT JOIN anunt a ON a.idMester=m.idMester " +
            	    "LEFT JOIN lucrare l ON a.idAnunt=l.idAnunt " +
            	    "GROUP BY ct.idCont, m.nume, m.prenume, ct.telefon, ct.email, ct.dataInregistrare "
            	    + "ORDER BY m.nume, m.prenume";

            statement = connection.prepareStatement(query);

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	String total = (resultSet.getString("total")==null) ? "0" : resultSet.getString("total");
                String nume = resultSet.getString("nume");
                String prenume = resultSet.getString("prenume");
                String telefon = resultSet.getString("telefon");
                String email = resultSet.getString("email");
                String dataInregistrare = resultSet.getString("dataInregistrare");
                String idCont = resultSet.getString("idCont");
                
                mesteri.add(new String[] {
                        total, nume, prenume, email, telefon, dataInregistrare, idCont
                    });
            }

        } finally {
            dbHelper.closeConnections(connection, statement, resultSet);
        }

        return mesteri;
    }
}
