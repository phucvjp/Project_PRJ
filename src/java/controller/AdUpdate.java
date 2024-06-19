/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import model.Product;

/**
 *
 * @author TUF A15
 */
public class AdUpdate extends HttpServlet {

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
            out.println("<title>Servlet AdUpdate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdUpdate at " + request.getContextPath() + "</h1>");
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
        DAO d = new DAO();
        if (request.getParameter("id") != null) {
            request.setAttribute("listA", d.getAllA());
            request.setAttribute("listPu", d.getAllPu());
            request.setAttribute("listC", d.getAllC());
            request.setAttribute("proUpdate", d.getP(Integer.parseInt(request.getParameter("id"))));
            request.getRequestDispatcher("proUpdate.jsp").forward(request, response);
        } else {
            response.sendRedirect("setting");
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
        int PRODUCT_ID = Integer.parseInt(request.getParameter("id"));
        String PRODUCT_NAME = request.getParameter("name");
        double PRICE = Double.parseDouble(request.getParameter("price"));
        int PAGES = Integer.parseInt(request.getParameter("pages"));
        String SIZE = request.getParameter("size");
        double WEIGHT = Double.parseDouble(request.getParameter("weight"));
        String DESCRIPTION = request.getParameter("description"), LANGUAGE = request.getParameter("language"), BOOK_FORMAT = request.getParameter("format");
        int AUTHOR_ID = Integer.parseInt(request.getParameter("author")), PUBLISHER_ID = Integer.parseInt(request.getParameter("publisher")), CATEGORY_ID = Integer.parseInt(request.getParameter("category"));
        Date PUBLIC_DAY = Date.valueOf(request.getParameter("day"));
        int AMOUNT = Integer.parseInt(request.getParameter("amount"));
        String image = request.getParameter("image");
        Product p = new Product(PRODUCT_ID, PRODUCT_NAME, PRICE, PAGES, SIZE, WEIGHT, DESCRIPTION, LANGUAGE, BOOK_FORMAT, AUTHOR_ID, PUBLISHER_ID, CATEGORY_ID, PUBLIC_DAY, AMOUNT, image);
        d.update(p);
        response.sendRedirect("setting");

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
