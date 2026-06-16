<%@ page import="DatabaseHelper.ContDBHelper" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<%
	String parolaNoua1=request.getParameter("parola1");
	String parolaNoua2=request.getParameter("parola2");
	String email = (String) session.getAttribute("email");
	String parolaVeche = (String) session.getAttribute("parolaVeche");

	
	if(parolaNoua1.equals(parolaNoua2)){
		if(parolaNoua1.equalsIgnoreCase(parolaVeche)){
			response.sendRedirect("verificareResetareParola.jsp?eroareParola=1");
		}
		else{
			ContDBHelper.resetareParola(email, parolaNoua1);
			session.invalidate();
			response.sendRedirect("login.jsp?parolaResetata=1");
		}
	}else{
		response.sendRedirect("verificareResetareParola.jsp?eroareParola=2");
	}
		
%>
</body>
</html>