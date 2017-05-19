/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class editRegistryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/tablas.jsp");
            HttpSession s = request.getSession();
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            Statement query = con.createStatement();
            String primaryKey = "";
            try{
                    int pk = Integer.parseInt(request.getParameter("primaryKeyValue")); 
                    primaryKey = pk+"";
            }
            catch(Exception e){
                try{
                    double pk = Double.parseDouble(request.getParameter("primaryKeyValue"));    
                    primaryKey = pk+"";
                }
                catch(Exception el){
                    String pk = request.getParameter("primaryKeyValue");
                    primaryKey = "'" + pk + "'";
                }
            }
            String QueryString = "SELECT * FROM "+s.getAttribute("tabla");
            ResultSet rs = query.executeQuery(QueryString);
            String temp = "";
            for(int i=1; i<=Integer.parseInt(request.getParameter("numCol"));i++){
                String columna = rs.getMetaData().getColumnLabel(i);
                System.out.println("columna: " + columna);
                if (i>1){
                    temp += ",";
                }                       
                temp += columna + "=";
                try{
                    int campo = Integer.parseInt(request.getParameter("campo"+i));
                    temp += campo;
                }
                catch(Exception e){
                    try{
                        double campo = Double.parseDouble(request.getParameter("campo"+i));       
                        temp += campo;
                    }
                    catch(Exception el){
                        temp += "'" + request.getParameter("campo"+i) + "'";
                    }
                }
                 
            }  
            rs.close();
            con.close();
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/"+(String)s.getAttribute("baseDatos"), (String)s.getAttribute("usuario"), (String)s.getAttribute("contrasegna"));
            query = con.createStatement();
            QueryString = "UPDATE "+s.getAttribute("tabla") + " SET " + temp + " WHERE " + request.getParameter("primaryKey") + "=" + primaryKey;
            System.out.println(QueryString);
            query.executeUpdate(QueryString);
            con.close();
                dispatcher.forward(request, response);
        }
        }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(editRegistryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(editRegistryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(editRegistryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(editRegistryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
