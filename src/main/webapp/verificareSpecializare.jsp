<%@page import="DatabaseHelper.MesterSpecializareDBHelper"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.InputStream" %>
<%
    String idSpecializareRaw = null;
    FileItem fileItem = null;

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
        session.setAttribute("error", "Formular invalid, trebuie multipart/form-data.");
        response.sendRedirect("specializari.jsp");
        return;
    }

    try {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));

        for (FileItem item : items) {
            if (item.isFormField()) {
                if ("idSpecializare".equals(item.getFieldName())) {
                    idSpecializareRaw = item.getString("UTF-8");
                }
            } else {
                if ("document".equals(item.getFieldName())) {
                    fileItem = item;
                }
            }
        }

        int idSpecializare = Integer.parseInt(idSpecializareRaw);


        InputStream inputStream = fileItem.getInputStream();

        String idMester = (String) session.getAttribute("id");

        MesterSpecializareDBHelper.insereazaCerereSpecializare(idMester, (String) idSpecializareRaw, inputStream);
        response.sendRedirect("specializari.jsp?succes=1");
        return;

    } catch (NumberFormatException e) {
        session.setAttribute("error", "Specializarea selectată nu este validă.");
    } catch (Exception e) {
        session.setAttribute("error", "Eroare: " + e.getMessage());
        e.printStackTrace();
    }
    response.sendRedirect("specializari.jsp");
%>
