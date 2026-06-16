<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DatabaseHelper.MesterDBHelper" %>
    <%@ page import="java.sql.*, DatabaseHelper.DatabaseHelper, DatabaseHelper.MesterDBHelper, Default.Anunt
    ,DatabaseHelper.AnuntDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String titlu = request.getParameter("titlu");
	String descriere = request.getParameter("descriere");
	double pretOra = Double.parseDouble(request.getParameter("pretOra"));
	int idSpecializare = Integer.parseInt(request.getParameter("idSpecializare"));
	
	int id = Integer.parseInt((String)session.getAttribute("id"));
	int idAdresa = MesterDBHelper.getIdAdresaFromMester(id);
	
	Anunt anunt = new Anunt();
	anunt.setDescriere(descriere);
	anunt.setIdMester(id);
	anunt.setPretOra(pretOra);
	anunt.setIdAdresa(idAdresa);
	anunt.setTitlu(titlu);
	anunt.setIdSpecializare(idSpecializare);
	
	AnuntDBHelper.insertAnunt(anunt);
	response.sendRedirect("anunturi.jsp?succes=2");
%>
</body>
</html>