<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.SpecializareDBHelper" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
    String denumire = request.getParameter("denumire");
	List<String[]> specializari = SpecializareDBHelper.getToateSpecializarile();
	for(String[] s : specializari){
		if(s[1].equals(denumire)){
			response.sendRedirect("gestionareSpecializari.jsp?eroare=1");
			return;
		}
	}
    try {
        SpecializareDBHelper.adaugaSpecializare(denumire.trim());
        response.sendRedirect("gestionareSpecializari.jsp?succes=1");
        return;
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>