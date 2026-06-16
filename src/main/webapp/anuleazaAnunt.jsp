<%@page import="DatabaseHelper.AnuntDBHelper"%>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String mesaj = "";
    String idParam = request.getParameter("idAnunt");
    String idAdmin = (String) session.getAttribute("id");

    if (idParam != null) {
        try {
            int idAnunt = Integer.parseInt(idParam);
            int id = Integer.parseInt(idAdmin);
            AnuntDBHelper.rejectAnunt(idAnunt, id);
            response.sendRedirect("anunturi.jsp?succes=1");
        } catch (Exception e) {
            mesaj = "Eroare la anularea anunțului: " + e.getMessage();
        }
    } else {
    	response.sendRedirect("anunturi.jsp?succes=1");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
</body>
</html>
