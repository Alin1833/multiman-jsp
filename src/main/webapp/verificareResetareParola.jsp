<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<link rel="stylesheet" href="styleAutentificare.css">
</head>
<body>
<% 	
	String eroare = request.getParameter("eroareParola");
	if ("1".equals(eroare)) {
%>
	<div style="color: red; font-weight: bold;">
   	Creati alta parola! Parola aceasta ati mai avut-o!
	</div>
<%
	} else if ("2".equals(eroare)) {
%>
	<div style="color: red; font-weight: bold;">
    Parolele nu coincid!
	</div>
<%
	}
	String email = request.getParameter("email");
	if (email == null) {
		email = (String) session.getAttribute("email");
	}

	String[] utilizator = ContUtilizatorDatabaseHelper.verificaUtilizatorResetare(email);
	if (utilizator == null) {
		response.sendRedirect("emailResetareParola.jsp?eroare=1");
	} else {
		session.setAttribute("email", email);
		session.setAttribute("parolaVeche", utilizator[2]);
%>
<div align="center">
<h1>Reseteaza-ti parola, <%= utilizator[0] %> <%= utilizator[1] %>!</h1>
  <form action="resetareParola.jsp" method="post">
  <table >
    <tr>
     <td>Parola noua </td>
     <td><input type="password" name="parola1" required/></td>
    </tr>    
    <tr>
     <td>Confirmati parola </td>
     <td><input type="password" name="parola2" required/></td>
    </tr>    
    </table>
    <input type="hidden" name="email" value="<%= session.getAttribute("email") %>" />
	<input type="hidden" name="parola" value="<%= session.getAttribute("parolaVeche") %>" />
    <input type="submit" value="OK" >
    </form>
</div>
<%		
	}
	
%>
</body>
</html>