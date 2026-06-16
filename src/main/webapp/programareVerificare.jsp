<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, DatabaseHelper.ClientDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	int idAnunt = Integer.parseInt(request.getParameter("idAnunt"));
	int idClient = Integer.parseInt(request.getParameter("idClient"));
	String dataSelectata = request.getParameter("dataSelectata");
	
	Date data = Date.valueOf(dataSelectata);
	
	if (ClientDBHelper.clientAreLucrareInData(idClient, data)) {
	    response.sendRedirect("indexClient.jsp?eroare=0");
	} else {
	    ClientDBHelper.insereazaProgramare(idAnunt, idClient, data);
	    response.sendRedirect("indexClient.jsp?succes=0");
	}
%>

</body>
</html>