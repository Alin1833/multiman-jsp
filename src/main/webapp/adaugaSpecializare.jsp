<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adaugă Specializare</title>
<link rel="stylesheet" href="styleAdaugaSpecializare.css">
</head>
<body>
	
  <div class="form-container">
    <h2>Adaugă Specializare Nouă</h2>
    <form action="verificareAdaugareSpecializare.jsp" method="post">
      <label for="denumire">Denumire specializare:</label>
      <input type="text" id="denumire" name="denumire" required>
      <button type="submit">Adaugă</button>
      <button class="back-button" onclick="location.href='gestionareSpecializari.jsp'">Back</button>
    </form>
  </div>
  
</body>
</html>
