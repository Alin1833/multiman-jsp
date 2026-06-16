<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resetare parola</title>
<link rel="stylesheet" href="styleAutentificare.css">
</head>
<body>
<%
    String eroare = request.getParameter("eroare");
    if ("1".equals(eroare)) {
%>
    <div style="color: red; font-weight: bold;">
        Email incorect sau inexistent!
    </div>
<%
    }
%>
<div align="center">
  <h1>Resetare parolă</h1>
  <form action="verificareResetareParola.jsp" method="post">
  <table >
    <tr>
     <td>Email</td>
     <td><input type="text" name="email" required/></td>
    </tr>    
    </table>
    <input type="submit" value="OK" >
   <p>Ți ai amintit parola?<a href="login.jsp">Înapoi la login!</a>
  </form>
 </div>
</body>
</html>