<%-- 
    Document   : newDB
    Created on : 11/05/2017, 08:48:32 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New DB</title>
    </head>
    <body>
        <h1>New DB</h1>
        <form action="createDBServlet">
            Nombre: <input type="text" name="baseDatos" id="baseDatos" value="" />
            <input type="submit" value="send" />
        </form>
        
    </body>
</html>
