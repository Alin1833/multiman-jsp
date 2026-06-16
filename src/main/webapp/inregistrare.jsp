<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="styleAutentificare.css">
</head>
<body>
<%
    String eroare = request.getParameter("eroare");
    if ("1".equals(eroare)) {
%>
    <div style="color: red; font-weight: bold;">
        Cont existent cu email-ul scris!
    </div>
<%
    }
%>
<div align="center">
  <h1>Înregistrare</h1>
  <form action="verificareInregistrare.jsp" method="post">
   <table style="width: 30%">
    <tr>
     <td>Email</td>
     <td><input type="text" name="email" required/></td>
    </tr>
    <tr>
     <td>Telefon</td>
     <td><input type="text" name="telefon" required/></td>
    </tr>
    <tr>
     <td>Nume</td>
     <td><input type="text" name="nume" required/></td>
    </tr>
    <tr>
     <td>Prenume</td>
     <td><input type="text" name="prenume" required/></td>
    </tr>
    <tr>
     <td>Județ</td>
     <td><input type="text" name="judet" required/></td>
    </tr>
    <tr>
     <td>Localitate</td>
     <td><input type="text" name="localitate" required/></td>
    </tr>
    <tr>
     <td>Stradă</td>
     <td><input type="text" name="strada" required/></td>
    </tr>
    <tr>
     <td>Parolă</td>
     <td><input type="password" name="parola" required/></td>
    </tr>
    <tr>
    <td>Tip utilizator</td>
    <td>
    	<input type="radio" name="rol" value="client" checked> Client
    	<input type="radio" name="rol" value="mester"> Meșter
    </td>
    </tr>
   </table>
   <input type="submit" value="Inregistreaza-te" />
   <p>Dacă ai cont...<a href="login.jsp">Login!</a></p>
   <button class="back-button" onclick="location.href='index.jsp'">Înapoi</button>
  </form>
 </div>
</body>
</html>