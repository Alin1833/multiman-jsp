<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.IndexDBHelper" %>
<%@ page import="Default.AnuntIndex" %>
<%@ page import="java.util.*" %>
<%@ page import="DatabaseHelper.AdresaDBHelper" %>
<%@ page import="DatabaseHelper.MesterSpecializareDBHelper" %>
<%
    String nume = (String) session.getAttribute("nume");
    String prenume = (String) session.getAttribute("prenume");
    String id = (String) session.getAttribute("id");
	String rol = (String) session.getAttribute("rol");
	
	if (id == null || !rol.equals("mester")) {
	    response.sendRedirect("index.jsp");
	    return;
	}

    String showWelcome = (String) session.getAttribute("showWelcome");
    if (showWelcome != null) {
        session.removeAttribute("showWelcome");
    }
    
    String[] judete = request.getParameterValues("judet");
    String[] specializari = request.getParameterValues("specializare");
    String pretMinParam = request.getParameter("pretMin");
    String pretMaxParam = request.getParameter("pretMax");

    Double pretMin = pretMinParam != null && !pretMinParam.isEmpty() ? Double.parseDouble(pretMinParam) : null;
    Double pretMax = pretMaxParam != null && !pretMaxParam.isEmpty() ? Double.parseDouble(pretMaxParam) : null;

    List<String> judetList = judete != null ? Arrays.asList(judete) : new ArrayList<>();
    List<String> specializareList = specializari != null ? Arrays.asList(specializari) : new ArrayList<>();
    
    List<AnuntIndex> listaAnunturi = IndexDBHelper.getFilteredAnunturi(judetList, specializareList, pretMin, pretMax);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
<link rel="stylesheet" href="styleIndex.css">
</head>
<body>
  <header>
    <div class="logo">
    	<a href="indexMester.jsp">
  			<img src="imagini/Logo.png" alt="Multiman Logo">
		</a>
	</div>
    <div>
      <button class="butoane" onclick="location.href='lucrari&cereri.jsp'">Lucrări și cereri</button>
      <button class="butoane" onclick="location.href='specializari.jsp'">Specializări</button>
      <button class="butoane" onclick="location.href='istoricLucrariMester.jsp'">Istoric lucrări</button>
      <button class="butoane" onclick="location.href='anunturi.jsp'">Anunțuri</button>
      <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
    </div>
    
    <div id="notification"></div>
  </header>
  <main>
    <aside class="filters">
      <form method="get" action="indexMester.jsp">
        <div class="filter-box">
          <label>Județ:</label>
          <div class="checkbox-group">
            <% List<String> listaJudete = AdresaDBHelper.getJudete();
			   for(String judet : listaJudete){ 
			     boolean checked = judetList.contains(judet);
			%>
			  <label>
			    <input type="checkbox" name="judet" value="<%= judet %>" <%= checked ? "checked" : "" %>> <%= judet %>
			  </label><br>
			<% } %>
          </div>
        </div>
        <br><br>
        <div class="filter-box">
          <label>Specializări:</label>
          <div class="checkbox-group">
            <% List<String> listaSpecializari = MesterSpecializareDBHelper.getSpecializari();
			   for(String spec : listaSpecializari){ 
			     boolean checked = specializareList.contains(spec);
			%>
			  <label>
			    <input type="checkbox" name="specializare" value="<%= spec %>" <%= checked ? "checked" : "" %>> <%= spec %>
			  </label><br>
			<% } %>
          </div>
        </div>
        <br><br>
        <div class="filter-box">
          <label>Preț minim:</label>
		  <input type="number" name="pretMin" min="0" value="<%= pretMin != null ? pretMin : "" %>" /><br>
		  <label>Preț maxim:</label>
		  <input type="number" name="pretMax" min="0" value="<%= pretMax != null ? pretMax : "" %>" />

        </div>
        <br><br>
        <button type="submit" class="butoane">Filtrează</button>
		<button type="button" class="butoane" onclick="indexMester.jsp">Resetează filtrele</button>
      </form>
    </aside>

    <section class="anunturi-wrapper">
		  <div id="anunturi-container" class="cards-wrapper">
		    <% 
		      int index = 0;
		      for (AnuntIndex anunt : listaAnunturi) {
		    %>
		      <div class="card-paginat" data-index="<%= index %>">
		        <div class="card">
		          <div class="info">
		            <strong><%=anunt.getNume()%> <%=anunt.getPrenume()%> - <%=anunt.getTitlu()%></strong><br>
		            <%=anunt.getDenumire()%><br>
		            📍<%=anunt.getJudet()%><br>
		            💰<%=anunt.getPretOra()%> RON/H<br>
		            <div class="desc"><%=anunt.getDescriere()%></div>
		          </div>
		        </div>
		      </div>
		    <% index++; } %>
		  </div>
		
		  <div class="pagination">
		    <button class="butoane" onclick="prevPage()">◀</button>
		    <span id="page-info"></span>
		    <button class="butoane" onclick="nextPage()">▶</button>
		  </div>
	</section>
  </main>
<script>
<% if (showWelcome != null) { %>
window.addEventListener('DOMContentLoaded', function() {
  showNotification('Bun venit, <%=nume%> <%=prenume%>!', 'success');
});
<% } %>

const pageSize = 6;
let currentPage = 1;
const anunturi = document.querySelectorAll('.card-paginat');

function showPage(page) {
  const totalPages = Math.ceil(anunturi.length / pageSize);
  currentPage = Math.max(1, Math.min(page, totalPages));
  const start = (currentPage - 1) * pageSize;
  const end = start + pageSize;

  anunturi.forEach((el, index) => {
    el.style.display = (index >= start && index < end) ? 'block' : 'none';
  });

  document.getElementById('page-info').textContent = `Pagina ${currentPage} / ${totalPages}`;
}

function prevPage() {
  if (currentPage > 1) showPage(currentPage - 1);
}

function nextPage() {
  if (currentPage < Math.ceil(anunturi.length / pageSize)) showPage(currentPage + 1);
}

document.addEventListener('DOMContentLoaded', () => showPage(currentPage));

function showNotification(message, type) {
	  const notif = document.getElementById('notification');
	  notif.textContent = message;
	  notif.className = '';
	  notif.style.display = 'block';
	  notif.classList.add(type === 'success' ? 'success' : 'error');
	  if (window.notificationTimeout) clearTimeout(window.notificationTimeout);
	  window.notificationTimeout = setTimeout(() => {
	    notif.style.display = 'none';
	  }, 3000);
	}
</script>
</body>
</html>