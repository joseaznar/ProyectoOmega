<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>DataWebWizard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body onload="onLoad()">
        
        <%         
            HttpSession s = request.getSession();

            String temp = (String)(s.getAttribute("usuarioPot"));

            if(temp != null && temp.equals("1"))
            {
               out.println("<p color='red'>Error al iniciar sesi�n</p>");
            }
            
            if(s.getAttribute("usuario")!= null && s.getAttribute("usuario")!="")
            {
                response.sendRedirect("baseDatos.jsp");
            }     
        %>
        <p id="errorMessage" color="red"></p>
        <form action="SessionServlet">
            <h2>Iniciar sesi�n</h2>
            <h3>Usuario</h3><input type="text" name="usuario" id="usuario" value="" />
            <h3>Contrase�a</h3><input type="password" name="contrase�a" id="contrase�a" value="" />
            <input type="submit" value="Submit" />
        </form>
    </body>
</html>
