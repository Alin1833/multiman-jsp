<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="DatabaseHelper.AnuntDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = (String) session.getAttribute("id");
    String idAnunt = request.getParameter("idAnunt");
    String action = request.getParameter("action");

    if (idAnunt != null && action != null) {
        String status = null;
        if ("accept".equalsIgnoreCase(action)) {
            status = "y";
        } else if ("reject".equalsIgnoreCase(action)) {
            status = "n";
        }

        if (status != null) {
            AnuntDBHelper.updateStatusAnunt(Integer.parseInt(idAnunt), status, Integer.parseInt(id));
        }
    }

    response.sendRedirect("gestionareAnunturi.jsp");
%>

</body>
</html>