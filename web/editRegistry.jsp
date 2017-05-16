<%-- 
    Document   : editRegistry
    Created on : 15/05/2017, 10:01:51 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit registry</title>
    </head>
    <body>
        <h1>Edit registry</h1>
        <form action="editRegistryServlet">
            <%
                for(int i=1;i<=Integer.parseInt(request.getParameter("numCol"));i++){
                    out.println("<input type = 'text' name = 'campo"+i+"' value = '"+request.getParameter("campo"+i)+"' / >");
                }
                out.println("<input type = 'hidden' name = 'numCol' value = '"+request.getParameter("numCol")+"' / >");
                out.println("<input type = 'hidden' name = 'primaryKey' value = '"+request.getParameter("primaryKey")+"' / >");
                out.println("<input type = 'hidden' name = 'primaryKeyValue' value = '"+request.getParameter("primaryKeyValue")+"' / >");
            %>
            
            <input type="submit" value="Save" />
        </form>
    </body>
</html>
