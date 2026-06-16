<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="styleAutentificare.css">
</head>
<body>
<%
    String eroare = request.getParameter("eroare");
    if ("1".equals(eroare)) {
%>
    <div style="color: red; font-weight: bold;">
        Email sau parola incorecta!
    </div>
<%
    }
    String parolaResetata=request.getParameter("parolaResetata");
    if("1".equals(parolaResetata)){
%>
	<div style="color: green; font-weight: bold;">
        Parola resetata!
    </div>
<%
    }
    String cont = request.getParameter("cont");
    if("1".equals(cont)){
%>    	
  	<div style="color: green; font-weight: bold;">
       Cont inregistrat!
    </div>
<%	
    }
%>

<div align="center">
  <h1>Login</h1>
  <form action="verificareLogin.jsp" method="post">
   <table>
    <tr>
     <td>Email</td>
     <td><input type="text" name="email" required/></td>
    </tr>
    <tr>
     <td>Parola</td>
     <td><input type="password" name="parola" required/></td>
    </tr>
   </table>
   <input type="submit" value="Login" />
   <p>Nu ai cont?<a href="inregistrare.jsp">Înregistrează-te!</a></p>
   <p>Ai uitat parola?<a href="emailResetareParola.jsp">Resetează parola!</a>
   <button class="back-button" onclick="location.href='index.jsp'">Înapoi</button>
  </form>
 </div>
</body>
</html>