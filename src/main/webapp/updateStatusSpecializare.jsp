<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="DatabaseHelper.MesterSpecializareDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    String idMester = request.getParameter("idMester");
    String idSpecializare = request.getParameter("idSpecializare");
    String action = request.getParameter("action");

    String status = "n";
    if ("accept".equals(action)) {
        status = "y";
    }

    MesterSpecializareDBHelper.updateStatusSpecializare(idMester, idSpecializare, status);
    if(status.equals("y")){
    	response.sendRedirect("mesteriSpecializari.jsp?succes=1");
    	return;}
    
        response.sendRedirect("mesteriSpecializari.jsp?succes=2");
%>

</body>
</html>