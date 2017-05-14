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
        <title>Edit table</title>
    </head>
    <body>
        <h1>Registros</h1>
        <form action="addRegistryServlet">
            
            <br><input type="submit" value="add registry" />
        <%
            HttpSession s = request.getSession();
            s.setAttribute("tabla", request.getParameter("tabla"));
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            Statement query = con.createStatement();
            String QueryString = "SELECT * FROM "+s.getAttribute("tabla");
            ResultSet rs = query.executeQuery(QueryString);
            int numCol = rs.getMetaData().getColumnCount();
            
            out.println("<input type = 'hidden' name = 'numCol' value = '"+numCol+"' />"); 
            
            int column = 1;            
            for(int i=1;i<=numCol;i++){
                out.println("<input type = 'text' name = 'campo"+i+"' value = '' / >");
            }
            out.println("</form>");
            out.println("<table border='2'> <tbody>");
            out.println("<tr>");
            
            for(int i=1;i<=numCol;i++){
                out.println("<td>"+rs.getMetaData().getColumnLabel(column)+"</td>");
                column++;
            }
            out.println("<td></td><td></td>");
            out.println("</tr>");
            while(rs.next()) {
                String temp = "";
                column = 1;
                for(int i=1;i<=numCol;i++){
                    temp += "<td>"+rs.getString(rs.getMetaData().getColumnLabel(column))+"</td>";
                    column++;
                }               
                          
                out.println("<tr>");                
                out.println(temp);
                out.println("<form action='deleteRegistryServlet.jsp'>");               
                out.println("<td><input type = 'submit' value = 'delete' name = 'delete' / ></td>");
                out.println("</form>");
                out.println("<form action='editRegistryServlet.jsp'>");               
                out.println("<td><input type = 'submit' value = 'edit' name = 'edit' / ></td>");       
                out.println("</form>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
        %>        
    </body>
</html>

