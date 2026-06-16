<%@page import="Default.Anunt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, DatabaseHelper.AnuntDBHelper, DatabaseHelper.MesterSpecializareDBHelper" %>
<%
    String idMester = (String) session.getAttribute("id");
    if (idMester == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String idAnunt = request.getParameter("idAnunt");
    if (idAnunt == null) {
        response.sendRedirect("anunturi.jsp");
        return;
    }

    Anunt anunt = AnuntDBHelper.getAnuntById(idAnunt);
    if (anunt == null) {
        response.sendRedirect("anunturi.jsp");
        return;
    }
    
    List<String[]> specializari = MesterSpecializareDBHelper.getSpecializariMester(idMester, "y");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editează Anunț</title>
    <link rel="stylesheet" href="styleAnunturi.css">
</head>
<body>
    <h2>Editează Anunț</h2>

    <form action="verificareEditareAnunt.jsp" method="post">
        <input type="hidden" name="idAnunt" value="<%= idAnunt %>">

        <label for="titlu">Titlu:</label><br>
        <input type="text" id="titlu" name="titlu" value="<%= anunt.getTitlu() %>" required><br><br>

        <label for="descriere">Descriere:</label><br>
        <textarea id="descriere" name="descriere" rows="5" cols="50" required><%= anunt.getDescriere() %></textarea><br><br>

        <label for="pretOra">Preț pe oră (RON):</label><br>
        <input type="number" id="pretOra" name="pretOra" min="1" value="<%= anunt.getPretOra() %>" required><br><br>
        
        <label for="idSpecializare">Specializare:</label><br>
        <select id="idSpecializare" name="idSpecializare" required>
            <% for (String[] spec : specializari) { 
                   String selected = spec[0].equals(anunt.getIdSpecializare()) ? "selected" : "";
            %>
                <option value="<%= spec[0] %>" <%= selected %>><%= spec[1] %></option>
            <% } %>
        </select><br><br>

        <button type="submit">Salvează Modificările</button>
        <a class="back-button" href='anunturi.jsp'>Renunță</a>
    </form>
</body>
</html>
