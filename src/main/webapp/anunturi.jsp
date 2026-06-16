<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.AnuntDBHelper" %>
<%@ page import="java.util.*" %>
<%
	String idM = (String) session.getAttribute("id");
	
	if (idM == null) {
	    response.sendRedirect("index.jsp");
	    return;
	}
	String succes = request.getParameter("succes");
	String eroare = request.getParameter("eroare");
    int idMester = Integer.parseInt((String) session.getAttribute("id"));
    List<String[]> anunturi = AnuntDBHelper.getAnunturiMester(idMester);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Anunțurile tale</title>
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
    <a href="indexMester.jsp">
      <img src="imagini/Logo.png" alt="Multiman Logo">
    </a>
  </div>
  <div>
  <button class="butoane" onclick="location.href='lucrari&cereri.jsp'">Lucrări și cereri</button>
     <button class="butoane" onclick="location.href='istoricLucrariMester.jsp'">Istoric lucrări</button>
     <button class="butoane" onclick="location.href='specializari.jsp'">Specializări</button>
    <button class="butoane" onclick="location.href='adaugaAnunt.jsp'">Adaugă anunț</button>
    <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
  </div>
  <div id="notification"></div>
</header>

<h2>Anunțurile tale</h2>

<table id="tabelAnunturi">
  <thead>
    <tr>
      <th>Titlu</th>
      <th>Descriere</th>
      <th>Preț (RON/h)</th>
      <th>Specializare</th>
      <th>Status</th>
      <th>Acțiuni</th>
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
         String statusText = "";
         String statusClass = "";

         if ("y".equalsIgnoreCase(status)) {
             statusText = "Acceptată";
             statusClass = "status-acceptata";
         } else if ("n".equalsIgnoreCase(status)) {
             statusText = "Refuzată/Anulată";
             statusClass = "status-refuzat";
         } else {
             statusText = "În așteptare";
             statusClass = "status-inasteptare";
         }
    %>
    <tr>
      <td><%= titlu %></td>
      <td><%= descriere %></td>
      <td><%= pret %></td>
      <td><%= denumire%></td>
      <td class="<%= statusClass %>"><%= statusText %></td>
      <td>
		 <% if (status == null || status.trim().isEmpty() || "y".equalsIgnoreCase(status)) { %>
			  <form action="anuleazaAnunt.jsp" method="post" style="display:inline;" onsubmit="return confirm('Sigur vrei să anulezi acest anunț?');">
			    <input type="hidden" name="idAnunt" value="<%= id %>">
			    <button type="submit" class="btn-red">Anulează</button>
			  </form>
			<% } %>
			<% if ("y".equalsIgnoreCase(status)) { %>
			  <form action="editareAnunt.jsp" method="get" style="display:inline;">
			    <input type="hidden" name="idAnunt" value="<%= id %>">
			    <button type="submit" class="btn-blue">Editează</button>
			  </form>
			<% } %>
		</td>
    </tr>
    <% } %>
  </tbody>
</table>

	<script>
	<% if (succes != null && succes.equals("1")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Anunțul a fost anulat cu succes!', 'success');
	  });
	<% } else if (eroare != null) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Nu se poate anula anunțul respectiv! Vă rugăm încercați mai târziu!', 'error');
	  });
	<% } else if (succes != null && succes.equals("2")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Anunțul a fost adăugat cu succes!', 'success');
	  });
	<% }else if (succes != null && succes.equals("3")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Anunțul a fost editat cu succes!', 'success');
	  });
	<% }%>%>
	
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
