<%@ page import="java.io.*, java.sql.*, DatabaseHelper.MesterSpecializareDBHelper" %>
<%

String id = (String) session.getAttribute("id");
String rol = (String) session.getAttribute("rol");
if (id == null || !rol.equals("admin")) {
    response.sendRedirect("index.jsp");
    return;
}
    String idMester = request.getParameter("idMester");
    String idSpecializare = request.getParameter("idSpecializare");

    if (idMester == null || idSpecializare == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametri lipsă.");
        return;
    }

    byte[] pdfBytes = MesterSpecializareDBHelper.getDocumentSpecializare(idMester, idSpecializare);

    if (pdfBytes == null || pdfBytes.length == 0) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Documentul nu a fost găsit.");
        return;
    }

    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "inline; filename=document.pdf");
    response.setContentLength(pdfBytes.length);

    OutputStream os = response.getOutputStream();
    os.write(pdfBytes);
    os.flush();
    os.close();
%>