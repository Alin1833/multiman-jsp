<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper, DatabaseHelper.RecenzieDBHelper" %>
<%@ page import="java.util.*" %>

<%
String id = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id == null || !rol.equals("mester")) {
    response.sendRedirect("index.jsp");
    return;
}
    List<String[]> lucrari = ContUtilizatorDatabaseHelper.getIstoricLucrariMester(id);
%>

<!DOCTYPE html>
<html lang="ro">
<head>
  <meta charset="UTF-8">
  <title>Istoric Lucrări</title>
  <link rel="stylesheet" href="styleCont.css">
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- DataTables CSS -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
  <!-- DataTables JS -->
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

  <script>
    $(document).ready(function () {
      $('#tabelLucrari').DataTable({
        "language": {
          "search": "Căutare:",
          "lengthMenu": "Afișează _MENU_ lucrări",
          "zeroRecords": "Nicio lucrare găsită",
          "info": "Pagina _PAGE_ din _PAGES_",
          "infoEmpty": "Fără lucrări disponibile",
          "infoFiltered": "(filtrate din _MAX_ lucrări)"
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
      <a href="indexMester.jsp">
        <img src="imagini/Logo.png" alt="Multiman Logo">
      </a>
    </div>
    <div>
      <button class="butoane" onclick="location.href='specializari.jsp'">Specializări</button>
      <button class="butoane" onclick="location.href='lucrari&cereri.jsp'">Lucrări și cereri</button>
      <button class="butoane" onclick="location.href='anunturi.jsp'">Anunțuri</button>
      <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
    </div>
    <div id="notification"></div>
  </header>

    <h2>Lucrări finalizate</h2><br><br>
  <main class="container">
    <table id="tabelLucrari" class="display">
      <thead>
        <tr>
          <th>Nume Client</th>
          <th>Tip Lucrare</th>
          <th>Adresă</th>
          <th>Perioadă</th>
          <th>Preț (RON)</th>
          <th>Recenzie</th>
          <th>Rating</th>
        </tr>
      </thead>
      <tbody>
        <% for (String[] l : lucrari) {
             String[] recenzie = (l[9] != null) ? RecenzieDBHelper.getRecenzie(l[9]) : null;
        %>
          <tr>
			  <td><%= l[1] %> <%= l[2] %></td>
			  <td><%= l[3] %></td>
			  <td><%= l[5] %></td>
			  <td><%= l[6] %> - <%= l[7] %></td>
			  <td><%= l[8] %></td>
			  <td><%= recenzie != null ? recenzie[0] : "Fără recenzie" %></td>
			  <td><%= recenzie != null ? recenzie[2] + " / 5" : "-" %></td>
			</tr>

        <% } %>
      </tbody>
    </table>
  </main>
</body>
</html>
