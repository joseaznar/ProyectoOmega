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
    <body>
        
        <%         
            HttpSession s = request.getSession();

            String temp = (String)(s.getAttribute("usuarioPot"));

            if(temp != null && temp.equals("1"))
            {
               out.println("<p color='red'>Error al iniciar sesión</p>");
            }
            
            if(s.getAttribute("usuario")!= null && s.getAttribute("usuario")!="")
            {
                response.sendRedirect("basesDatos.jsp");
            }     
        %>
        <p id="errorMessage" color="red"></p>
        <form action="SessionServlet">
            <h2>Iniciar sesión</h2>
            <h3>Usuario</h3><input type="text" name="usuario" id="usuario" value="" />
            <h3>Contraseña</h3><input type="password" name="contrasegna" id="contrasegna" value="" />
            <input type="submit" value="Submit" />
        </form>
        <form action="newUser.jsp">
            <input type="submit" value="Register" />
        </form>
    </body>
</html>
