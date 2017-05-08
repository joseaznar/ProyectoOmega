<%-- 
    Document   : newTable
    Created on : 7/05/2017, 09:34:33 PM
    Author     : HP
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
        %>
        <h1>Nueva Tabla</h1>
        <form action="CreateTableServlet">        
            Nombre de la tabla: <input type="text" name="nombre" value="" />
            <input type="submit" value="Create" />
        </form>
        
    </body>
</html>
