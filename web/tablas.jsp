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
        <h1>Tablas</h1>
        <%
            HttpSession s = request.getSession();
            if(s.getAttribute("usuario")==null || s.getAttribute("usuario").equals("")){
                s.setAttribute("usuarioPot", "1");
                response.sendRedirect("index.jsp");
            }
            s.setAttribute("tabla", "");
            if(s.getAttribute("baseDatos")==null || s.getAttribute("baseDatos")=="")
                s.setAttribute("baseDatos", request.getParameter("baseDatos"));
            
            if(s.getAttribute("baseDatos")!=null){
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos")+";create=true;", (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
                DatabaseMetaData meta = con.getMetaData();
                ResultSet res = meta.getTables(null, null, null, new String[] {"TABLE"});
                //System.out.println("req");

                while (res.next()) {
                    out.println("<form action='registros.jsp'>");
                    out.println("<input type = 'hidden' name = 'tabla' value = '"+res.getString("TABLE_NAME")+"' / >");
                    out.println(res.getString("TABLE_NAME")+"<input type='submit' value='see registries' name='registros' />");
                    out.println("</form>");
                }
                res.close(); 
                con.close();
            }
        %>
        <form action="newTable.jsp">
            <br><input type="submit" value="create table" />
        </form>
        <form action="basesDatos.jsp">
            <br><input type="submit" value="return to data bases" />
        </form>
    </body>
</html>
