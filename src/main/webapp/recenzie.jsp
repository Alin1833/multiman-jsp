<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
<%@ page import="Default.AnuntIndex" %>
<%@ page import="java.util.*" %>
<%@ page import="DatabaseHelper.AdresaDBHelper" %>
<%@ page import="DatabaseHelper.MesterSpecializareDBHelper" %>
<%@ page import="DatabaseHelper.RecenzieDBHelper" %>
<%@ page import="Default.Recenzie" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>Istoric Lucrări</title>
  <link rel="stylesheet" href="styleRecenzie.css">
 
</head>
 
  <%
  String id = (String) session.getAttribute("id");
	String rol = (String) session.getAttribute("rol");
	if (id == null || !rol.equals("client")) {
	    response.sendRedirect("index.jsp");
	    return;
	}
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    int idLucrare = Integer.parseInt(request.getParameter("idLucrare"));
    String com = request.getParameter("comentariu");
    String rat = request.getParameter("rating");

    if(com != null && rat != null){
      int rating = Integer.parseInt(rat);
      Recenzie recenzie = new Recenzie();
      recenzie.setComentariu(com);
      recenzie.setIdLucrare(idLucrare);
      recenzie.setRating(rating);
      RecenzieDBHelper.insertRecenzie(recenzie);
      response.sendRedirect("istoricLucrariClient.jsp?succes=1");
      return;
    }
  }

  String idLucrareParam = request.getParameter("idLucrare");
%>


<body>
  <header>
    <div class="logo">
      <img src="imagini/Logo.png" alt="Muliman Logo">
    </div>
    <div><strong>Istoric lucrari</strong></div>
    <div>
      <button class="butoane" onclick="location.href='indexClient.jsp'">Anunțuri</button>
    </div>
  </header>

  <main>
  <%
    List<String[]> listaLucrari = ContUtilizatorDatabaseHelper.getIstoricLucrariClient(id);
    for(String[] lucrare : listaLucrari){
      if(lucrare[7].equals(idLucrareParam)){
  %>  
  <form action="recenzie.jsp" method="post">
    <strong><%=lucrare[0] %> <%=lucrare[1] %> - <%=lucrare[2] %></strong><br>
    <%=lucrare[4] %><br>
    <%=lucrare[5] %><br>
    Pret final: <%=lucrare[6] %> RON<br>
    <div class="desc"><%=lucrare[3] %></div> 

    <input type="hidden" name="idLucrare" value="<%=lucrare[7] %>">

    <label for="comentariu-<%=lucrare[7]%>">Comentariu (obligatoriu):</label><br>
    <textarea id="comentariu-<%=lucrare[7]%>" name="comentariu" rows="4" cols="50" required placeholder="Scrie un comentariu..."></textarea><br>

    <label>Rating (obligatoriu):</label>
    <div class="stars" id="stars-<%=lucrare[7]%>">
      <% for(int i=5; i>=1; i--) { %>
        <input type="radio" id="star-<%=i%>-<%=lucrare[7]%>" name="rating" value="<%=i%>" required>
        <label for="star-<%=i%>-<%=lucrare[7]%>" title="<%=i%> stele">&#9733;</label>
      <% } %>
    </div>
    <p class="rating-text">Rating: Selectează stelele</p>

    <button type="submit" class="submit-recenzie">Trimite recenzie</button>
    <button class="back-button" onclick="location.href='istoricLucrariClient.jsp'">Back</button>
  </form>
  <hr>
  <% }} %>
</main>

</body>
</html>