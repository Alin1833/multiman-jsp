<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.MesterDBHelper" %>
<%@ page import="java.util.*" %>
<% 
String id = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id == null || !rol.equals("mester")) {
    response.sendRedirect("index.jsp");
    return;
}
	String succes = request.getParameter("succes");
	String eroare = request.getParameter("eroare");
%>
<!DOCTYPE html>
<html lang="ro">
<head>
  <meta charset="UTF-8">
  <title>Lucrări și Cereri</title>
  <link rel="stylesheet" href="styleLucrari&Cereri.css">
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
      <button class="butoane" onclick="location.href='istoricLucrariMester.jsp'">Istoric lucrări</button>
      <button class="butoane" onclick="location.href='anunturi.jsp'">Anunțuri</button>
      <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
    </div>
    <div id="notification"></div>
  </header>
  <div class="dashboard">
    <div class="sidebar">
      <h2>Panou Mester</h2>
      <button onclick="toggleView('lucrari')">Lucrări în curs</button>
      <button onclick="toggleView('cereri')">Cereri primite</button>
    </div>

    <div id="view-lucrari" class="view">
  <h3>Lucrări în desfășurare</h3>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>Titlu</th>
        <th>Început</th>
        <th>Finalizare</th>
        <th>Preț Final</th>
        <th>Acțiuni</th>
      </tr>
    </thead>
    <tbody>
      <% List<String[]> lucrariInCurs = MesterDBHelper.getLucrariInCursMester(Integer.parseInt((String)session.getAttribute("id")));
      for (String[] lucrare : lucrariInCurs) { %>
        <tr>
          <form action="finalizeazaLucrare.jsp" method="post">
            <td><%= lucrare[1] %> <%= lucrare[2] %></td>
            <td><%= lucrare[3] %></td>
            <td><%= lucrare[4] %></td>
            <td><%= lucrare[5] != null ? lucrare[5] : "-" %></td>
            <td>
              <input type="number" name="pretFinal" step="0.1" min="0" value="<%= lucrare[6] != null ? lucrare[6] : "" %>" required>
              <input type="hidden" name="idLucrare" value="<%= lucrare[0] %>">
            </td>
            <td>
              <button name="action" value="finalizeaza" class="btn btn-green">Finalizare</button>
            </td>
          </form>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

      <div id="view-cereri" class="view" style="display:none">
  <h3>Cereri în așteptare</h3>
  <table>
    <thead>
      <tr>
        <th>Client</th>
        <th>Titlu</th>
        <th>Data început</th>
        <th>Data finalizare</th>
        <th>Acțiuni</th>
      </tr>
    </thead>
    <tbody>
      <% List<String[]> cereri = MesterDBHelper.getCereriMester(Integer.parseInt((String)session.getAttribute("id")));
      for (String[] cerere : cereri) { %>
        <tr>
          <form action="updateLucrare.jsp" method="post">
            <td><%= cerere[1] %> <%= cerere[2] %></td>
            <td><%= cerere[3] %></td>
            <td><%= cerere[4] %></td>
            <td>
              <input type="date" name="dataFinalizare" >
              <input type="hidden" name="idLucrare" value="<%= cerere[0] %>">
            </td>
            <td>
              <button name="action" value="accept" class="btn btn-green">Acceptă</button>
              <button name="action" value="reject" class="btn btn-red">Refuză</button>
            </td>
          </form>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

  <script>
    function toggleView(viewId) {
      document.getElementById('view-lucrari').style.display = viewId === 'lucrari' ? 'block' : 'none';
      document.getElementById('view-cereri').style.display = viewId === 'cereri' ? 'block' : 'none';
    }
    
    <% if (succes != null && succes.equals("1")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Lucrarea a fost finalizată cu succes!', 'success');
	  });
	<% }else if (succes != null && succes.equals("2")) { %>
	  window.addEventListener('DOMContentLoaded', function() {
		    showNotification('Cererea a fost acceptată cu succes!', 'success');
		  });
		<% }else if (succes != null && succes.equals("3")) { %>
		  window.addEventListener('DOMContentLoaded', function() {
			    showNotification('Cererea a fost respinsă cu succes!', 'success');
			  });
		<% } 
    if (eroare != null) { %>
	  window.addEventListener('DOMContentLoaded', function() {
	    showNotification('Vă rugăm selectați o zi pentru a continua!', 'error');
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
