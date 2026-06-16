<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ro">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>404 - Pagina nu a fost gasită</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: url('https://mad.ac/a') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      color: #fff;
    }

    .overlay {
      background-color: rgba(0, 0, 0, 0.65);
      padding: 50px;
      border-radius: 20px;
      text-align: center;
      animation: fadeIn 2s ease;
    }

    h1 {
      font-size: 6rem;
      margin: 0 0 20px;
      animation: float 3s ease-in-out infinite;
    }

    p {
      font-size: 1.5rem;
      margin-bottom: 30px;
    }

    a {
      padding: 12px 30px;
      background-color: #9b59b6;
      color: white;
      text-decoration: none;
      border-radius: 30px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    a:hover {
      background-color: #8e44ad;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }
  </style>
</head>
<body>
  <div class="overlay">
    <h1>404</h1>
    <p>Ups! Pagina căutată nu există sau a fost mutată.</p>
    <a href="index.jsp">Înapoi la pagina principală</a>
  </div>
</body>
</html>
