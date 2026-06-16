<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="DatabaseHelper.MesterSpecializareDBHelper" %>
<% 
	String id = (String) session.getAttribute("id");
	
	if (id == null) {
	    response.sendRedirect("index.jsp");
	    return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cerere Specializare</title>
<link rel="stylesheet" href="styleCerere.css">
</head>
<body>
	<form action="verificareSpecializare.jsp" method="post" enctype="multipart/form-data">
	    <label>Alege specializarea:</label><br>
	    <select name="idSpecializare" required>
	        <% 
	        	String idMester = (String) session.getAttribute("id");
	            List<String[]> toate = MesterSpecializareDBHelper.getSpecializariDisponibile(idMester);
	            for (String[] spec : toate) { 
	        %>
	            <option value="<%= spec[0] %>"><%= spec[1] %></option>
	        <% } %>
	    </select><br><br>

	    <label>Document justificativ (PDF):</label><br>
	    <input type="file" name="document" accept="application/pdf" required><br><br>

	    <button type="submit">Trimite cerere</button>
	    <button class="back-button" onclick="location.href='specializari.jsp'">Back</button>
	</form>
</body>
</html>
