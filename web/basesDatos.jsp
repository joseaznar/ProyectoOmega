<%-- 
    Document   : basesDatos
    Created on : 11/05/2017, 08:33:21 PM
    Author     : HP
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DatabaseMetaData"%>
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
        <h1>Bases de datos</h1>
        <%
            HttpSession s = request.getSession();
            s.setAttribute("baseDatos", "");
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("usuario"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            Statement query = con.createStatement();
            String QueryString = "SELECT * FROM BASES"+s.getAttribute("usuario");
            ResultSet rs = query.executeQuery(QueryString);
            
            
            while(rs.next()) {
                out.println("<form action='tablas.jsp'>");
                out.println("<input type = 'hidden' name = 'baseDatos' value = '"+rs.getString("nombre")+"' / >");
                out.println("<BR>"+ rs.getString("nombre") + "<input type = 'submit' value = 'view tables' name = 'editar' / >");
                out.println("</form>");
            }
            
        %>
        
        <form action="newDB.jsp">
            <br><input type="submit" value="create data base" />
        </form>
    </body>
</html>
