<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="DatabaseHelper.MesterDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    String idLucrare = request.getParameter("idLucrare");
    String pretFinal = request.getParameter("pretFinal");
    MesterDBHelper.finalizeazaLucrare(Integer.parseInt(idLucrare), Double.parseDouble(pretFinal));
    response.sendRedirect("lucrari&cereri.jsp?succes=1");
%>
</body>
</html>