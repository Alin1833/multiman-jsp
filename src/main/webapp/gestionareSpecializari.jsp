<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DatabaseHelper.SpecializareDBHelper" %>
<%@ page import="java.util.List" %>
<%
String id = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id == null || !rol.equals("admin")) {
    response.sendRedirect("index.jsp");
    return;
}
    List<String[]> specializari = SpecializareDBHelper.getToateSpecializarile();
    String succes = request.getParameter("succes");
    String eroare = request.getParameter("eroare");
%>
<!DOCTYPE html>
<html lang="ro">
<head>
  <meta charset="UTF-8">
  <title>Lista Specializări</title>
  <link rel="stylesheet" href="listaAdmin.css">
  <!-- DataTables CSS -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- DataTables JS -->
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
  <script>
    $(document).ready(function() {
        $('#tabelSpecializari').DataTable({
            "language": {
                "search": "Căutare:",
                "lengthMenu": "Afișează _MENU_ înregistrări",
                "zeroRecords": "Nicio specializare găsită",
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
      <button class="butoane" onclick="location.href='clienti.jsp'">Clienți</button>
      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
    </div>
    <div id="notification"></div>
  </header>
  <main class="container">
    <h2>Lista Specializări</h2>
    <button class="btn-green" onclick="location.href='adaugaSpecializare.jsp'">+ Adaugă specializare</button>
    <table id="tabelSpecializari" class="display">
      <thead>
        <tr>
          <th onclick="sortTable(0)">ID</th>
          <th onclick="sortTable(1)">Denumire</th>
        </tr>
      </thead>
      <tbody>
        <% for (String[] s : specializari) { %>
        <tr>
          <td><%= s[0] %></td>
          <td><%= s[1] %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </main>
  <script>
      <% if (succes != null) { %>
      window.addEventListener('DOMContentLoaded', function() {
        showNotification('Specializarea a fost adaugata cu succes!', 'success');
      });
    <% } else if (eroare != null) { %>
      window.addEventListener('DOMContentLoaded', function() {
        showNotification('Specializarea exista deja!', 'error');
      });
    <% } %>
    function showNotification(message, type) {
      const notif = document.getElementById('notification');
      notif.textContent = message;
      notif.className = '';
      notif.style.display = 'block';
      notif.classList.add(type === 'success' ? 'success' : 'error');
      if (window.notificationTimeout) clearTimeout(window.notificationTimeout);
      window.notificationTimeout = setTimeout(() => {
        notif.style.display = 'none';
      }, 3000);
    }
  </script>
</body>
</html>