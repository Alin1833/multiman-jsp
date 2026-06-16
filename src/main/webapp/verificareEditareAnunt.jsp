<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="DatabaseHelper.AnuntDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%

    String idAnuntStr = request.getParameter("idAnunt");
    String titlu = request.getParameter("titlu");
    String descriere = request.getParameter("descriere");
    String pretOraStr = request.getParameter("pretOra");
    String idSpec = request.getParameter("idSpecializare");

    int idAnunt = Integer.parseInt(idAnuntStr);
    double pretOra = Double.parseDouble(pretOraStr);

   AnuntDBHelper.updateAnunt(idAnunt, titlu, descriere, pretOra, Integer.parseInt(idSpec));

   response.sendRedirect("anunturi.jsp?succes=3");
%>

</body>
</html>