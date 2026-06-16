<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, DatabaseHelper.MesterSpecializareDBHelper" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Specializări Meșter</title>
  <link rel="stylesheet" href="styleSpecializari.css">
</head>
<body>
<% 
String id = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id == null || !rol.equals("mester")) {
    response.sendRedirect("index.jsp");
    return;
}
	String succes = request.getParameter("succes");
%>
<header>
  <div class="logo">
    <a href="indexMester.jsp">
      <img src="imagini/Logo.png" alt="Multiman Logo">
    </a>
  </div>
  <div>
    <button class="butoane" onclick="location.href='lucrari&cereri.jsp'">Lucrări și cereri</button>
     <button class="butoane" onclick="location.href='istoricLucrariMester.jsp'">Istoric lucrări</button>
     <button class="butoane" onclick="location.href='anunturi.jsp'">Anunțuri</button>
     <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
    <button class="butoane" onclick="location.href='cerereSpecializare.jsp'">Adaugă o nouă specializare</button>
  </div>
<div id="notification"></div>
</header>


<main class="specializari-container">
<%
    String idMester = (String) session.getAttribute("id");

    if (idMester == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    } else {
        List<String[]> toateSpecializarile = MesterSpecializareDBHelper.getToateSpecializarileMester(idMester); 
%>

  <h2>Specializările tale</h2>
  <table class="status-tabel">
    <thead>
      <tr>
        <th>Specializare</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <% for (String[] spec : toateSpecializarile) { 
           String nume = spec[1];
           String status = spec[2];
           String clasaStatus = "status-asteptare";
           String mesaj = "În așteptare";

           if ("y".equalsIgnoreCase(status)) {
               clasaStatus = "status-acceptat";
               mesaj = "Acceptat";
           } else if ("n".equalsIgnoreCase(status)) {
               clasaStatus = "status-refuzat";
               mesaj = "Refuzat";
           }
      %>
        <tr>
          <td><%= nume %></td>
          <td class="<%= clasaStatus %>"><%= mesaj %></td>
        </tr>
      <% } %>
    </tbody>
  </table>

<% } %>
</main>


<script>
<% if (succes != null) { %>
window.addEventListener('DOMContentLoaded', function() {
  showNotification('Cererea de specializare a fost trimisă cu succes!', 'success');
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

  window.addEventListener('DOMContentLoaded', function() {
    const params = new URLSearchParams(window.location.search);
    if (params.has("succes")) {
      showNotification('Cererea a fost trimisă cu succes!', 'success');
    } else if (params.has("eroare")) {
      showNotification('A apărut o eroare la trimiterea cererii!', 'error');
    }
  });
</script>

</body>
</html>
