# Multiman

Aplicatie web Java (JSP / Servlet) - o platforma de tip marketplace care pune in legatura clientii cu mesteri pe specializari: anunturi, cereri de specializare, recenzii si conturi de utilizator.

## Functionalitati
- Conturi si autentificare (clienti, mesteri, admin)
- Anunturi: adaugare, editare, anulare, listare
- Specializari ale mesterilor si cereri de specializare
- Recenzii pentru mesteri
- Documente atasate

## Arhitectura
- JSP pentru interfata (`src/main/webapp`)
- Clase `Default/` (entitati: Client, Mester, Anunt, Specializare, Recenzie, Cont ...)
- Clase `DatabaseHelper/` pentru accesul la baza de date
- Bibliotecile JAR sunt in `WEB-INF/lib`

## Tehnologii
- Java (Servlet / JSP)
- Apache Tomcat 10
- Baza de date relationala (JDBC)

## Rulare
1. Importa proiectul in Eclipse (Dynamic Web Project).
2. Configureaza un server Tomcat 10 si conexiunea la baza de date.
3. Deploy si acceseaza din browser.
