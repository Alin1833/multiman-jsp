<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
<%@ page import="DatabaseHelper.AdresaDBHelper" %>
<%@ page import="DatabaseHelper.ContDBHelper" %>
<%@ page import="DatabaseHelper.ClientDBHelper" %>
<%@ page import="DatabaseHelper.MesterDBHelper" %>
<%@ page import="java.time.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String email = request.getParameter("email");
	int verificare = ContUtilizatorDatabaseHelper.verificareEmailCont(email);
	if(verificare == 1){
		response.sendRedirect("inregistrare.jsp?eroare=1");
	}else{
		String telefon = request.getParameter("telefon");
		String nume = request.getParameter("nume");
		String prenume = request.getParameter("prenume");
		String judet = request.getParameter("judet");
		String localitate = request.getParameter("localitate");
		String strada = request.getParameter("strada");
		String parola = request.getParameter("parola");
		String tip = request.getParameter("rol");
		
		AdresaDBHelper.insertAdresa(judet, localitate, strada);
		Date dataInregistrare = Date.valueOf(LocalDate.now());
		int idAdresa = AdresaDBHelper.getIdMaxAdresa();
		ContDBHelper.insertCont(email, parola, telefon, dataInregistrare, idAdresa);
		int idCont = ContDBHelper.getIdContMax();
		if(tip.equals("mester")){
			MesterDBHelper.insertMester(nume, prenume, idCont);
			response.sendRedirect("login.jsp?cont=1");
		}else{
			ClientDBHelper.insertClient(nume, prenume, idCont);
			response.sendRedirect("login.jsp?cont=1");
		}
	}
%>
</body>
</html>