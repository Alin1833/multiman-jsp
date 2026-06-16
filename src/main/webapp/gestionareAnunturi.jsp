<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DatabaseHelper.AnuntDBHelper" %>
<%@ page import="java.util.List" %>
<%
String id1 = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id1 == null || !rol.equals("admin")) {
    response.sendRedirect("index.jsp");
    return;
}
    List<String[]> anunturi = AnuntDBHelper.getToateAnunturile();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Verificare Anunțuri</title>
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
  <link rel="stylesheet" href="styleListaAnunturi.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
  <script>
    $(document).ready(function() {
      $('#tabelAnunturi').DataTable();
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
      <button class="butoane" onclick="location.href='clienti.jsp'">Clienti</button>
      <button class="butoane" onclick="location.href='mesteri.jsp'">Mesteri</button>
      <button class="butoane" onclick="location.href='mesteriSpecializari.jsp'">Cereri specializari</button>
      <button class="butoane" onclick="location.href='gestionareSpecializari.jsp'">Specializari</button>
      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
    </div>
    
	<div id="notification"></div>
  </header>
  <h2>Verificare Anunțuri</h2>
  <table id="tabelAnunturi">
    <thead>
      <tr>
        <th>Titlu</th>
        <th>Descriere</th>
        <th>Preț (RON)</th>
        <th>Specializare</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <% for (String[] a : anunturi) { 
        String id = a[0];
        String titlu = a[1];
        String descriere = a[2];
        String pret = a[3];
        String status = a[4];
        String denumire = a[5];
      %>
        <tr>
          <td><%= titlu %></td>
          <td><%= descriere %></td>
          <td><%= pret %></td>
          <td><%= denumire %></td>
          <td>
            <% if (status == null || status.trim().isEmpty()) { %>
              <form method="post" action="updateStatusAnunt.jsp" style="display:inline-block;">
                <input type="hidden" name="idAnunt" value="<%= id %>">
                <button name="action" value="accept" class="btn-green">Acceptă</button>
              </form>
              <form method="post" action="updateStatusAnunt.jsp" style="display:inline-block;">
                <input type="hidden" name="idAnunt" value="<%= id %>">
                <button name="action" value="reject" class="btn-red">Refuză</button>
              </form>
            <% } else if ("n".equalsIgnoreCase(status)) { %>
              <span class="status-refuzat">Refuzat</span>
            <% } else if ("y".equalsIgnoreCase(status)) { %>
              <form method="post" action="updateStatusAnunt.jsp">
                <input type="hidden" name="idAnunt" value="<%= id %>">
                <button name="action" value="reject" class="btn-red">Refuză</button>
              </form>
            <% } %>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>
</body>
</html>
