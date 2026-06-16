<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verificare</title>
</head>
<body>
<%
	String email = request.getParameter("email");
    String parola = request.getParameter("parola");

    try {
        String[] utilizator = ContUtilizatorDatabaseHelper.verificaUtilizator(email, parola);

        if (utilizator != null) {
            session.setAttribute("nume", utilizator[0]);
            session.setAttribute("prenume", utilizator[1]);
            session.setAttribute("rol", utilizator[2]);
            session.setAttribute("id",utilizator[3]);
            session.setAttribute("email", email);
			
            if(utilizator[2].equals("admin")){
            	response.sendRedirect("indexAdmin.jsp");
            }else if(utilizator[2].equals("mester")){
            	session.setAttribute("showWelcome", "yes");
            	response.sendRedirect("indexMester.jsp");
            }else{
            	session.setAttribute("showWelcome", "yes");
            	response.sendRedirect("indexClient.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?eroare=1");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("A aparut o eroare: " + e.getMessage());
    }
%>
</body>
</html>