<%-- 
    Document   : newTable
    Created on : 7/05/2017, 09:34:33 PM
    Author     : HP
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Table</title>
    </head>
    <body>
        <h1>Nueva Tabla</h1>
        <script>
            function agregar(){               
                var hid = document.getElementById("auxiliar").getAttribute("value");
                hid = Number(hid) + 1; 
                document.getElementById("auxiliar").setAttribute("value", hid);
                
                var txt = document.createTextNode("Field name: ");       // Create a text node
                document.getElementById("forma").appendChild(txt); 
                alert("entró");
                var inp = document.createElement("INPUT");        // Create a <button> element                           // Append the text to <button>
                inp.setAttribute("type", "text");
                inp.setAttribute("name", "campo" + hid);
                document.getElementById("forma").appendChild(inp);
                
                txt = document.createTextNode("Type: ");       // Create a text node
                document.getElementById("forma").appendChild(txt); 
                 
                var sel = document.createElement("SELECT");        // Create a <button> element                         
                sel.setAttribute("name", "tipo" + hid);
                var op1 = document.createElement("OPTION");
                txt = document.createTextNode("Varchar");
                op1.appendChild(txt);
                sel.appendChild(op1);
                var op2 = document.createElement("OPTION");
                txt = document.createTextNode("Integer");
                op2.appendChild(txt);
                sel.appendChild(op2);
                var op3 = document.createElement("OPTION");
                txt = document.createTextNode("Double");
                op3.appendChild(txt);
                sel.appendChild(op3);
                document.getElementById("forma").appendChild(sel); 
                
                var br = document.createElement("BR");
                document.getElementById("forma").appendChild(br); 
                
            }
            function quitar(){
                
                var hid = document.getElementById("auxiliar").getAttribute("value");
                
                if (hid > 1) {
                    hid = Number(hid) - 1; 
                    document.getElementById("auxiliar").setAttribute("value", hid);

                    document.getElementById("forma").removeChild(document.getElementById("forma").lastChild);
                    document.getElementById("forma").removeChild(document.getElementById("forma").lastChild);
                    document.getElementById("forma").removeChild(document.getElementById("forma").lastChild);
                    document.getElementById("forma").removeChild(document.getElementById("forma").lastChild);
                    document.getElementById("forma").removeChild(document.getElementById("forma").lastChild);
                }
            }
        </script>
        
        <form id="forma" action="CreateTableServlet"> 
            
            <input type="submit" value="Guardar" name="guardar" /><br>
            <input type="hidden" name="auxiliar" id="auxiliar" value="1" readonly="readonly" />             
            Nombre de la tabla: <input type="text" name="nombre" value="" />
            <h3>Columnas de la tabla: </h3><br>
            Field name: <input type="text" name="campo1" value="" />
            Type: 
            <select name="tipo1">
                <option>Varchar</option>
                <option>Integer</option>
                <option>Double</option>
            </select><br>
            
            
        </form>
        <input type="submit" value="Agregar" name="agregar" onclick="agregar()"/>        
        <input type="submit" value="Quitar" name="quitar" onclick="quitar()"/>
        
   
    </body>
</html>
