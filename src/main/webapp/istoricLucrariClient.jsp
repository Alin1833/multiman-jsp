<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DatabaseHelper.ContUtilizatorDatabaseHelper" %>
<%@ page import="DatabaseHelper.RecenzieDBHelper" %>
<%@ page import="java.util.*" %>

<%
	String id = (String) session.getAttribute("id");
	String rol = (String) session.getAttribute("rol");
	if (id == null || !rol.equals("client")) {
	    response.sendRedirect("index.jsp");
	    return;
	}
    String succes = request.getParameter("succes");
    List<String[]> listaLucrari = ContUtilizatorDatabaseHelper.getIstoricLucrariClient(id);
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Istoric Lucrări</title>
    <link rel="stylesheet" href="listaAdmin.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#tabelLucrari').DataTable({
                "language": {
                    "search": "Căutare:",
                    "lengthMenu": "Afișează _MENU_ înregistrări",
                    "zeroRecords": "Nicio lucrare găsită",
                    "info": "Pagina _PAGE_ din _PAGES_",
                    "infoEmpty": "Fără date disponibile",
                    "infoFiltered": "(filtrate din _MAX_ înregistrări)"
                },
                "paging": true,
                "ordering": true
            });
        });
    </script>
</head>
<body>
<header>
    <div class="logo">
        <img src="imagini/Logo.png" alt="Multiman Logo">
    </div>
    <div>
        <button class="butoane" onclick="location.href='indexClient.jsp'">Anunțuri</button>
        <button class="butoane" onclick="location.href='cont.jsp'">Contul meu</button>
    </div>
    <div id="notification"></div>
</header>

<main class="container">
    <h2>Lucrările Mele</h2>
    <table id="tabelLucrari" class="display">
        <thead>
        <tr>
            <th>Nume Meșter</th>
            <th>Specializare</th>
            <th>Adresă</th>
            <th>Data</th>
            <th>Descriere</th>
            <th>Preț Final</th>
            <th>Recenzie</th>
        </tr>
        </thead>
        <tbody>
        <% for (String[] lucrare : listaLucrari) {
        %>
            <tr>
			    <td><%= lucrare[0] %> <%= lucrare[1] %></td>     
			    <td><%= lucrare[2] %></td>                    
			    <td><%= lucrare[3] %></td>                    
			    <td><%= lucrare[4] %></td>           
			    <td><%= lucrare[5] %></td>          
			    <td><%= lucrare[6] %> RON</td>                
			    <td>
			      <%
			        String recenzieHTML = "";
			        if(lucrare[8] == null){
			            recenzieHTML = "<button class='btn-recenzie' onclick=\"location.href='recenzie.jsp?idLucrare=" + lucrare[7] + "'\">Lasă recenzie!</button>";
			        } else {
			            String[] recenzie = RecenzieDBHelper.getRecenzie(lucrare[8]);
			            recenzieHTML = "Recenzie: " + recenzie[0] + "<br>Rating: " + recenzie[2];
			        }
			      %>
			      <%= recenzieHTML %>
			    </td>
			</tr>

        <% } %>
        </tbody>
    </table>
</main>

<script>
    <% if (succes != null) { %>
    window.addEventListener('DOMContentLoaded', function() {
        showNotification('Recenzia a fost trimisă cu succes!', 'success');
    });
    <% } %>

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
