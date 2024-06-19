/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import model.Account;
import model.Product;

/**
 *
 * @author TUF A15
 */
public class FavServlet extends HttpServlet {

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
            out.println("<title>Servlet FavServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FavServlet at " + request.getContextPath() + "</h1>");
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
            throws ServletException, IOException, NullPointerException {
        DAO d = new DAO();
        HttpSession session = request.getSession();
        ArrayList<Product> m = new ArrayList();
        Account a = (Account) session.getAttribute("account");
        Cookie[] lc = request.getCookies();
        Cookie c = null;
        for (Cookie cookie : lc) {
            if (cookie.getName().equals("fav")) {
                c = cookie;
            }
        }
        if (a == null) {
            request.setAttribute("errorBuy", "you must login first!!!");
            request.getRequestDispatcher("login").forward(request, response);
            
            return;
        }
        if (request.getParameter("add") != null) {

            for (Product product : d.getAllP()) {
                if (request.getParameter("add").equals("" + product.getPRODUCT_ID())) {
                    String[] tokens = c.getValue().split("%");
                    boolean check = false;
                    for (int i = 0; i < tokens.length; i++) {
                        String token = tokens[i];
                        if (token.equals("" + product.getPRODUCT_ID())) {
                            tokens[i] = "" + product.getPRODUCT_ID();
                            check = true;
                            break;
                        }
                    }
                    c.setValue(String.join("%", tokens));
                    if (!check && c.getValue().length() > 0) {
                        c.setValue(c.getValue() + "%" + product.getPRODUCT_ID());
                    }
                    if (!check && c.getValue().length() == 0) {
                        c.setValue("" + product.getPRODUCT_ID());
                    }
                    for (String s : c.getValue().split("%")) {
                        if (!c.getValue().contains(":null") && c.getValue().length() > 0) {
                            m.add(d.getP(Integer.parseInt(s)));
                        }
                    }
                    session.setAttribute("fav", c);
                    session.setAttribute("favList", m);
                    d.updateFav(((Account) session.getAttribute("account")).getCUSTOMER_ID(), c.getValue());
                    c.setMaxAge(60 * 60 * 24);
                    response.addCookie(c);
                    break;
                }
            }
        }

        if (request.getParameter("remove") != null) {
            if (!c.getValue().contains(":null")) {
                String[] tokens = c.getValue().split("%");
                for (int i = 0; i < tokens.length; i++) {
                    String token = tokens[i];
                    if (token.equals(request.getParameter("remove"))) {
                        tokens[i] = "";
                        break;
                    }
                }
                c.setValue("");
                for (String token : tokens) {

                    if (token.length() >= 1 && c.getValue().length() == 0) {
                        log(token);
                        c.setValue(token);
                    } else if (token.length() >= 1) {
                        log(token);
                        c.setValue(c.getValue() + "%" + token);
                    }
                }
                log(c.getValue());
                for (String s : c.getValue().split("%")) {
                    if (!c.getValue().contains(":null") && c.getValue().length() > 0) {
                        m.add(d.getP(Integer.parseInt(s)));
                    }
                }
                session.setAttribute("fav", c);
                session.setAttribute("favList", m);

            }
            c.setMaxAge(60 * 60 * 24);
            response.addCookie(c);
            d.updateFav(((Account) session.getAttribute("account")).getCUSTOMER_ID(), c.getValue());
            response.sendRedirect("fav");
            return;
        }

        log(c.getValue());
        request.getRequestDispatcher("fav.jsp").forward(request, response);
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
        processRequest(request, response);
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
