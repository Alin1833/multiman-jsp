<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
    <%@ page import="java.time.LocalDate" %>
	<%@ page import="java.time.format.DateTimeFormatter" %>
	<%@ page import="java.time.temporal.ChronoUnit" %>
<!DOCTYPE html>
<% 
	String succes = request.getParameter("succes");
	%>
	
<html>
<head>
<meta charset="ISO-8859-1">
<title>Contul meu</title>
<link rel="stylesheet" href="styleCont.css">
<%
	String rol = (String) session.getAttribute("rol");

	if(rol.equals("client")){
		String idC = (String) session.getAttribute("id");
		if (idC == null || !rol.equals("client")) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		String[] date = ContUtilizatorDatabaseHelper.getContClient(idC);
		session.setAttribute("idCont", date[6]); %>
	</head>
	<body>
	  <header>
	    <div class="logo">
	    	<img src="imagini/Logo.png" alt="Muliman Logo">
		</div>
	    <div>
	      <button class="butoane" onclick="location.href='indexClient.jsp'">Acasă</button>
	      <button class="butoane" onclick="location.href='istoricLucrariClient.jsp'">Istoric lucrări</button>
	      <button class="butoane" onclick="location.href='indexClient.jsp'">Anunțuri</button>
	      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
	    </div>
	    <div id="notification"></div>
	  </header>
	  <main>
    <section class="info-container">
      <div class="personal-info">
        <h2>Datele Personale</h2>
        <form method="post" action="savePersonalInfo.jsp">
          <div class="card">
            <label for="nume"><strong>Nume:</strong></label>
            <input type="text" id="nume" name="nume" value="<%= date[1] %>" required><br><br>
            
            <label for="prenume"><strong>Prenume:</strong></label>
            <input type="text" id="prenume" name="prenume" value="<%= date[2] %>" required><br><br>
            
            <label for="email"><strong>Email:</strong></label>
            <input type="email" id="email" name="email" value="<%= date[3] %>" required><br><br>
            
            <label for="telefon"><strong>Telefon:</strong></label>
            <input type="tel" id="telefon" name="telefon" value="<%= date[4] %>" required><br><br>
          </div>
          <button type="submit" class="butoane submit">Salvează</button>
        </form>
      </div>
      <div class="client-stats">
        <h2>Statistici Client</h2>
        <div class="card">
          <p><strong>Total Cheltuieli:</strong> <%= date[0] %> RON</p>
          <%
          String dataString = date[5];
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

          LocalDate dataInitiala = LocalDate.parse(dataString, formatter);
          LocalDate azi = LocalDate.now();

          long zile = ChronoUnit.DAYS.between(dataInitiala, azi);
          %>
          <p><strong>Durata:</strong> De <%= zile %> zile ești clientul nostru. Mulțumim!</p>
        </div>
      </div>
    </section>
  </main>
<%		
	}else if(rol.equals("mester")){
		
		String id = (String) session.getAttribute("id");
		if (id == null || !rol.equals("mester")) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		
	String[] datePersonale = ContUtilizatorDatabaseHelper.getContMester(id);
		session.setAttribute("idCont", datePersonale[6]); 
		String total = datePersonale[0];
		String dataString = datePersonale[5];
		%>

	</head>
	<body>
	  <header>
	    <div class="logo">
	    
	    	<img src="imagini/Logo.png" alt="Muliman Logo">
		</div>
	    <div>
	      <button class="butoane" onclick="location.href='indexMester.jsp'">Acasă</button>
		<button class="butoane" onclick="location.href='lucrari&cereri.jsp'">Lucrari si cereri</button>
      	<button class="butoane" onclick="location.href='specializari.jsp'">Specializari</button>
      	<button class="butoane" onclick="location.href='istoricLucrariMester.jsp'">Istoric lucrari</button>
   		<button class="butoane" onclick="location.href='anunturi.jsp'">Anunturi</button>
	      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
	    </div>
	     <div id="notification"></div>
	  </header>
	  <main>
    <section class="info-container">
      <div class="personal-info">
        <h2>Datele Personale</h2>
        <form method="post" action="savePersonalInfo.jsp">
          <div class="card">
            <label for="nume"><strong>Nume:</strong></label>
            <input type="text" id="nume" name="nume" value="<%= datePersonale[1] %>" required><br><br>
            
            <label for="prenume"><strong>Prenume:</strong></label>
            <input type="text" id="prenume" name="prenume" value="<%= datePersonale[2] %>" required><br><br>
            
            <label for="email"><strong>Email:</strong></label>
            <input type="email" id="email" name="email" value="<%= datePersonale[3] %>" required><br><br>
            
            <label for="telefon"><strong>Telefon:</strong></label>
            <input type="tel" id="telefon" name="telefon" value="<%= datePersonale[4] %>" required><br><br>
          </div>
          <button type="submit" class="butoane submit">Salvează</button>
        </form>
      </div>
      <div class="client-stats">
        <h2>Statistici Meșter</h2>
        <div class="card">
          <p><strong>Total Câștigat:</strong> <%= total %> RON</p>
          <%
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

          LocalDate dataInitiala = LocalDate.parse(dataString, formatter);
          LocalDate azi = LocalDate.now();

          long zile = ChronoUnit.DAYS.between(dataInitiala, azi);
          %>
          <p><strong>Durata:</strong> De <%= zile %> zile ești meșterul nostru. Mulțumim!</p>
        </div>
      </div>
    </section>
  </main>

<%		
	}
%>
</head>
<body>
<script>
<% if (succes != null) { %>
window.addEventListener('DOMContentLoaded', function() {
  showNotification('Datele au fost salvate cu succes!', 'success');
});
<% }%>

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