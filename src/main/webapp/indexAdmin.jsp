<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 String id = (String) session.getAttribute("id");
	String rol = (String) session.getAttribute("rol");
	if (id == null || !rol.equals("admin")) {
	    response.sendRedirect("index.jsp");
	    return;
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Panou de administrare</title>
<link rel="stylesheet" href="styleIndex.css">
</head>
<body>
<header>
    <div class="logo">
  			<img src="imagini/Logo.png" alt="Multiman Logo">
    </div>
    <div>
      <button class="butoane" onclick="location.href='index.jsp?pa=1'">Logout</button>
    </div>
  </header>
   <div class="admin-container">
    <h1>Panou de administrare</h1>
  		<div class="button-grid">
		    <button class="butoane" onclick="location.href='clienti.jsp'">Listă clienți</button>
		    <button class="butoane" onclick="location.href='mesteri.jsp'">Listă meșteri</button>
		    <button class="butoane" onclick="location.href='gestionareAnunturi.jsp'">Anunțuri</button>
		    <button class="butoane" onclick="location.href='mesteriSpecializari.jsp'">Cereri specializări</button>
		    <button class="butoane" onclick="location.href='gestionareSpecializari.jsp'">Specializări</button>
	    </div>
  	</div>
</body>
</html>
