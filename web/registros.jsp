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
            if(s.getAttribute("usuario")==null || s.getAttribute("usuario").equals("")){
                s.setAttribute("usuarioPot", "1");
                response.sendRedirect("index.jsp");
            }
            if(s.getAttribute("inicio")==null || s.getAttribute("inicio").equals(""))
                s.setAttribute("inicio", "1");
            if(s.getAttribute("tabla")==null || s.getAttribute("tabla").equals(""))
                s.setAttribute("tabla", request.getParameter("tabla"));
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            String table = (String)s.getAttribute("tabla");
            ResultSet primaryKey  = con.getMetaData().getPrimaryKeys(null, null, table);
            String pk = "";
            if(primaryKey.next())
                pk = primaryKey.getString("COLUMN_NAME");
            primaryKey.close();
            con.close(); 
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            Statement query = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            String QueryString = "SELECT * FROM "+s.getAttribute("tabla");
            ResultSet rs = query.executeQuery(QueryString);
            
            rs.last();
            int numFilas;
            numFilas = rs.getRow();
            s.setAttribute("numFilas", numFilas);
            if(s.getAttribute("final")==null || s.getAttribute("final").equals(""))
                s.setAttribute("final", numFilas);
            rs.beforeFirst();
            int numCol = rs.getMetaData().getColumnCount();
            
            out.println("<input type = 'hidden' name = 'numCol' value = '"+numCol+"' />"); 
            
            int column = 1;            
            for(int i=1;i<=numCol;i++){
                out.println("<input type = 'text' name = 'campo"+i+"' value = '' / >");
            }
            out.println("</form>");
            out.println("<form action='showNextRegistriesServlet'>");
            out.println("N: <input type='text' name='n' value='"+ numFilas +"' />");
            out.println("<input type = 'submit' name='next' value = 'Next N' / >");
            out.println("</form>");
            out.println("</form>");
            out.println("<form action='showPreviousRegistriesServlet'>");
            out.println("N: <input type='text' name='n' value='"+ numFilas +"' />");
            out.println("<input type = 'submit' name='previous' value = 'Previous N' / >");
            out.println("</form>");
            out.println("<form action='showFirstRegistriesServlet'>");
            out.println("N: <input type='text' name='n' value='"+ numFilas +"' />");
            out.println("<input type = 'submit' name='first' value = 'First N' / >");
            out.println("</form>");
            out.println("<form action='showLastRegistriesServlet'>");
            out.println("N: <input type='text' name='n' value='"+ numFilas +"' />");
            out.println("<input type = 'submit' name='first' value = 'Last N' / >");
            out.println("</form>");
            out.println("<table border='2'> <tbody>");
            out.println("<tr>");
            
            for(int i=1;i<=numCol;i++){
                out.println("<td>"+rs.getMetaData().getColumnLabel(column)+"</td>");
                column++;
            }
            out.println("<td></td><td></td>");
            out.println("</tr>");
            int t = 1;
            while(rs.next()) {                
                String inicio = s.getAttribute("inicio")+"";
                String fina = s.getAttribute("final")+"";
                int ini = Integer.parseInt(inicio);
                int fin = Integer.parseInt(fina);
                //int ini = Integer.parseInt(see);
                //int fin = Integer.parseInt(sei);
                
                if(t>=ini && t<=fin){                    
                    String temp = "";   
                    String tempol = "";
                    column = 1;                
                    String tempi = "";
                    for(int i=1;i<=numCol;i++){
                        temp += "<td>"+rs.getString(rs.getMetaData().getColumnLabel(column))+"</td>"; 
                        tempol += "<input type='hidden' name='campo"+i+"' value='"+rs.getString(rs.getMetaData().getColumnLabel(column))+"' />";  
                        if(rs.getMetaData().getColumnLabel(column).equals(pk))
                            tempi = rs.getString(rs.getMetaData().getColumnLabel(column));
                        column++;
                    }               

                    out.println("<tr>");                
                    out.println(temp);
                    out.println("<form action='deleteRegistryServlet'>"); 
                    out.println("<input type = 'hidden' name = 'numCol' value = '"+numCol+"' />");
                    out.println("<input type = 'hidden' name = 'primaryKey' value = '"+pk+"' / >");
                    out.println("<input type = 'hidden' name = 'primaryKeyValue' value = '"+tempi+"' / >");
                    out.println("<td><input type = 'submit' value = 'delete' name = 'delete' / ></td>");
                    out.println("</form>");
                    out.println("<form action='editRegistry.jsp'>"); 
                    out.println(tempol);
                    out.println("<input type = 'hidden' name = 'numCol' value = '"+numCol+"' />");
                    out.println("<input type = 'hidden' name = 'primaryKey' value = '"+pk+"' / >");
                    out.println("<input type = 'hidden' name = 'primaryKeyValue' value = '"+tempi+"' / >");
                    out.println("<td><input type = 'submit' value = 'edit' name = 'edit' / ></td>");       
                    out.println("</form>");
                    out.println("</tr>");
                    t++;
                }
                else
                    t++;
            }
            rs.close();
            con.close();
            out.println("</tbody>");
            out.println("</table>");
        %>        
    </body>
</html>

