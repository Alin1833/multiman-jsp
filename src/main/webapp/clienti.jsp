<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
<%@ page import="java.util.*" %>
<%
	String id = (String) session.getAttribute("id");
	String rol = (String) session.getAttribute("rol");
	if (id == null || !rol.equals("admin")) {
	    response.sendRedirect("index.jsp");
	    return;
	}
    List<String[]> clienti = ContUtilizatorDatabaseHelper.getTotiClientii(); 
%>
<!DOCTYPE html>
<html lang="ro">
<head>
  <meta charset="UTF-8">
  <title>Listă Clienți - Statistici</title>
  <link rel="stylesheet" href="listaAdmin.css">
  <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#tabelClienti').DataTable({
                "language": {
                    "search": "Căutare:",
                    "lengthMenu": "Afișează _MENU_ înregistrări",
                    "zeroRecords": "Niciun client găsit",
                    "info": "Pagina _PAGE_ din _PAGES_",
                    "infoEmpty": "Fără date disponibile",
                    "infoFiltered": "(filtrate din _MAX_ înregistrări)"
                },
                "paging": true,
                "ordering": true
            });
        });
    </script>

</head>
<body>
	<header>
    <div class="logo">
      	<a href="indexAdmin.jsp">
  			<img src="imagini/Logo.png" alt="Multiman Logo">
		</a>
    </div>
    <div>
      <button class="butoane" onclick="location.href='gestionareAnunturi.jsp'">Anunțuri</button>
      <button class="butoane" onclick="location.href='mesteri.jsp'">Meșteri</button>
      <button class="butoane" onclick="location.href='mesteriSpecializari.jsp'">Cereri specializări</button>
      <button class="butoane" onclick="location.href='gestionareSpecializari.jsp'">Specializări</button>
      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
    </div>
    
	<div id="notification"></div>
  </header>
  <main class="container">
    <h2>Clienți și Statistici</h2>
    <table id="tabelClienti" class="display">
      <thead>
        <tr>
          <th onclick="sortTable(0)">Nume</th>
          <th onclick="sortTable(1)">Prenume</th>
          <th onclick="sortTable(2)">Email</th>
          <th onclick="sortTable(3)">Telefon</th>
          <th onclick="sortTable(4)">Data Înregistrare</th>
          <th onclick="sortTable(5)">Total Plăți (RON)</th>
        </tr>
      </thead>
      <tbody>
        <% for (String[] c : clienti) { %>
          <tr>
            <td><%= c[1] %></td>
            <td><%= c[2] %></td>
            <td><%= c[3] %></td>
            <td><%= c[4] %></td>
            <td><%= c[5] %></td>
            <td><%= c[0] %></td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </main>
</body>
</html>
