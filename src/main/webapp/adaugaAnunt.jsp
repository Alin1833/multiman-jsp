<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, DatabaseHelper.MesterSpecializareDBHelper" %>
<%
    String id = (String) session.getAttribute("id");
    if (id == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<String[]> specializari = MesterSpecializareDBHelper.getSpecializariMester(id,"y");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adaugă Anunț</title>
    <link rel="stylesheet" href="styleAnunturi.css">
</head>
<body>
    <h2>Adaugă Anunț Nou</h2>

    <form action="verificareAdaugareAnunt.jsp" method="post">
        <label for="titlu">Titlu:</label><br>
        <input type="text" id="titlu" name="titlu" required><br><br>

        <label for="descriere">Descriere:</label><br>
        <textarea id="descriere" name="descriere" rows="5" cols="50" required></textarea><br><br>

        <label for="pretOra">Preț pe oră (RON):</label><br>
        <input type="number" id="pretOra" name="pretOra" min="1" required><br><br>

        <label for="idSpecializare">Specializare:</label><br>
        <select id="idSpecializare" name="idSpecializare" required>
            <% for (String[] spec : specializari) { %>
                <option value="<%= spec[0] %>"><%= spec[1] %></option>
            <% } %>
        </select><br><br>

        <button type="submit">Adaugă Anunț</button>
        <a class="back-button" href='anunturi.jsp'>Back</a>
    </form>
</body>
</html>
