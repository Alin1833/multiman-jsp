
<%@ page import="java.util.*, Default.MesteriSpecializari, DatabaseHelper.MesterSpecializareDBHelper" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String rol = (String) session.getAttribute("rol");
	String id = (String) session.getAttribute("id");
	
	if (id == null || !rol.equals("admin")) {
	    response.sendRedirect("index.jsp");
	    return;
	}
	
	String succes = request.getParameter("succes");
    List<MesteriSpecializari> cereri = MesterSpecializareDBHelper.getCereriSpecializari();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Cereri Specializări</title>
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
  <link rel="stylesheet" href="styleListaAnunturi.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
  <script>
    $(document).ready(function() {
      $('#tabelCereri').DataTable();
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
    <button class="butoane" onclick="location.href='clienti.jsp'">Clienți</button>
    <button class="butoane" onclick="location.href='gestionareSpecializari.jsp'">Specializări</button>
    <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
  </div>
  <div id="notification"></div>
</header>

<h2>Cereri de specializări ale meșterilor</h2>

<table id="tabelCereri">
  <thead>
    <tr>
      <th>Nume</th>
      <th>Prenume</th>
      <th>Specializare</th>
      <th>Document</th>
      <th>Status</th>
      <th>Acțiune</th>
    </tr>
  </thead>
  <tbody>
  
    <% System.out.print(cereri.size()); 
    for (MesteriSpecializari c : cereri) {
         String nume = c.getNume();
         String prenume = c.getPrenume();
         String denumire = c.getDenumire();
         String status = (c.getStatus() != null) ? String.valueOf(c.getStatus()) : null;
         int idMester = c.getIdMester();
         int idSpecializare = c.getIdSpecializare();
    %>
    <tr>
      <td><%= nume %></td>
      <td><%= prenume %></td>
      <td><%= denumire %></td>
      <td>
        <a href="descarcaDocument.jsp?idMester=<%= idMester %>&idSpecializare=<%= idSpecializare %>" target="_blank">Deschide PDF</a>
      </td>
		<%
		    String statusText;
		    String statusClass;
		
		    if ("y".equalsIgnoreCase(status)) {
		        statusText = "Acceptată";
		        statusClass = "status-acceptata";
		    } else if ("n".equalsIgnoreCase(status)) {
		        statusText = "Refuzată";
		        statusClass = "status-refuzat";
		    } else {
		        statusText = "În așteptare";
		        statusClass = "status-inasteptare";
		    }
		%>
		<td class="<%= statusClass %>"><%= statusText %></td>
      <td>
        <% if (status == null || status.isEmpty()) { %>
          <form method="post" action="updateStatusSpecializare.jsp" style="display:inline-block;">
            <input type="hidden" name="idMester" value="<%= idMester %>">
            <input type="hidden" name="idSpecializare" value="<%= idSpecializare %>">
            <button name="action" value="accept" class="btn-green">Acceptă</button>
          </form>
          <form method="post" action="updateStatusSpecializare.jsp" style="display:inline-block;">
            <input type="hidden" name="idMester" value="<%= idMester %>">
            <input type="hidden" name="idSpecializare" value="<%= idSpecializare %>">
            <button name="action" value="reject" class="btn-red">Refuză</button>
          </form>
        <% } else { %>
          <span>-</span>
        <% } %>
      </td>
    </tr>
    <% } %>
  </tbody>
</table>



  <script>
	  <% if (succes != null && succes.equals("1")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Cererea a fost acceptată cu succes!', 'success');
	  });
	<% } else if (succes != null && succes.equals("2")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
		    showNotification('Cererea a fost refuzată cu succes!', 'success');
		  });
		<% }  %> 
    
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
