<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DatabaseHelper.AnuntDBHelper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
    int idAnunt = Integer.parseInt(request.getParameter("idAnunt"));
	int idAdmin = Integer.parseInt((String) session.getAttribute("id"));
	
    try {
        AnuntDBHelper.rejectAnunt(idAnunt, idAdmin);
        session.setAttribute("succes", "Anunțul a fost refuzat cu succes.");
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("eroare", "Eroare la ștergerea anunțului.");
    }

    response.sendRedirect("cont.jsp");
	%>
</body>
</html>