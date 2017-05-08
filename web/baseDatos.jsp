 <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.sql.Connection"%>
<%-- 
    Document   : baseDatos
    Created on : 5/05/2017, 01:55:35 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Base de datos</title>
    </head>
    <body>
        <h1>Bases de datos</h1>
        <%
            HttpSession s = request.getSession();
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("usuario")+";create=true;", (String)s.getAttribute("usuario"), (String)s.getAttribute("contraseña"));
            DatabaseMetaData meta = con.getMetaData();
            ResultSet res = meta.getTables(null, null, null, new String[] {"TABLE"});
            System.out.println("List of tables: ");

            while (res.next()) {
                out.println(res.getString("TABLE_NAME")+"<br>");
            }
            res.close(); 
        %>
        <form action="newTable.jsp">
            <input type="submit" value="create table" />
        </form>
    </body>
</html>
