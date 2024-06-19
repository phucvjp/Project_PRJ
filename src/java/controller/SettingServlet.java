/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author TUF A15
 */
@WebServlet(name = "SettingServlet", urlPatterns = {"/setting"})
public class SettingServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SettingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SettingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession ss = request.getSession();
        if ( ss.getAttribute("account")!=null && ((Account) ss.getAttribute("account")).getRole() == 1) {
            DAO d = new DAO();
            request.setAttribute("listP", d.getAllP());
            request.setAttribute("listC", d.getAllC());
            request.setAttribute("max", d.maxP());
            request.setAttribute("listA", d.getAllA());
            request.setAttribute("listPu", d.getAllPu());
            if (request.getParameter("name") != null && request.getParameter("name").length() > 0) {
                request.setAttribute("listP", d.search(request.getParameter("name")));
            } else if (request.getParameter("type") != null) {
                request.setAttribute("listP", d.search(Integer.parseInt(request.getParameter("type")), Double.parseDouble(request.getParameter("minP")), Double.parseDouble(request.getParameter("maxP")),
                        request.getParameter("sort"), request.getParameter("ord") == null ? "" : request.getParameter("ord")));

            }
            request.getRequestDispatcher("proTable.jsp").forward(request, response);

        } else {
            response.sendRedirect("home");
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
        DAO d = new DAO();
        request.setAttribute("listP", d.getAllP());
        request.setAttribute("listT", d.getAllC());
        request.setAttribute("max", d.maxP());
        request.getRequestDispatcher("proTable.jsp").forward(request, response);

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
