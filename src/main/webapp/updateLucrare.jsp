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
    String action = request.getParameter("action");
    String idLucrare = request.getParameter("idLucrare");
    if ("accept".equals(action)) {
    	String dataFinalizare = request.getParameter("dataFinalizare");
    	if (dataFinalizare == null || dataFinalizare.trim().isEmpty()) {
    	    response.sendRedirect("lucrari&cereri.jsp?eroare=1");
    	    return;
    	}

        MesterDBHelper.acceptaCerere(Integer.parseInt(idLucrare), dataFinalizare);
        response.sendRedirect("lucrari&cereri.jsp?succes=2");
        return;
    } else if ("reject".equals(action)) {
        MesterDBHelper.refuzaCerere(Integer.parseInt(idLucrare));
        response.sendRedirect("lucrari&cereri.jsp?succes=3");
        return;
    }

%>
</body>
</html>