<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
    <%@ page import="DatabaseHelper.ContDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String rol = (String) session.getAttribute("rol");
	String id = (String) session.getAttribute("id");
	String nume = request.getParameter("nume");
	String prenume = request.getParameter("prenume");
	String email = request.getParameter("email");
	String telefon = request.getParameter("telefon");
	String idCont = (String)session.getAttribute("idCont");
	if("client".equals(rol)){
		String[] date = ContUtilizatorDatabaseHelper.getContClient(id);
	}String[] date = ContUtilizatorDatabaseHelper.getContMester(id);
	
	if(nume.equals(date[1]) && prenume.equals(date[2]) && email.equals(date[3]) && telefon.equals(date[4])){
		response.sendRedirect("cont.jsp");
	}else{
		ContDBHelper.updateCont(idCont, nume, prenume, email, telefon, rol);
		session.setAttribute("nume", nume);
		session.setAttribute("prenume", prenume);
		session.setAttribute("email", email);
		session.setAttribute("telefon", telefon);
		response.sendRedirect("cont.jsp?succes=1");
	}
%>
</body>
</html>