<%-- 
    Document   : newUser
    Created on : 11/05/2017, 08:57:23 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
    </head>
    <body>
        <h1>Register</h1>
        <%
            HttpSession s = request.getSession();
            if(s.getAttribute("usuario")==null || s.getAttribute("usuario").equals("")){
                s.setAttribute("usuarioPot", "1");
                response.sendRedirect("index.jsp");
            }
        %>
        <form action="createUserServlet">
            Name: <input type="text" name="nombre" value="" /><br>
            Password: <input type="password" name="contrasegna" value="" /><br>
            <input type="submit" value="create" />
        </form>
    </body>
</html>
