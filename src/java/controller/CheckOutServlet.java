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
import java.util.HashMap;
import model.Account;
import model.Product;

/**
 *
 * @author TUF A15
 */
public class CheckOutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckOutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckOutServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        HashMap<Product, Integer> m = new HashMap();
        Cookie[] lc = request.getCookies();
        Cookie c = null;

        if (session.getAttribute("account") != null) {

            for (Cookie cookie : lc) {
                if (cookie.getName().equals("cart")) {
                    c = cookie;
                    break;
                }
            }
            String[] tokens = c.getValue().split("%");
            for (int i = 0; i < tokens.length; i++) {
                String token = tokens[i];
                tokens[i] = token.split(":")[0] + ":" + request.getParameter(token.split(":")[0]);
            }
            c.setValue(String.join("%", tokens));
            if (!c.getValue().contains(":null")) {
                for (String s : c.getValue().split("%")) {
                    m.put(d.getP(Integer.parseInt(s.split(":")[0])), Integer.parseInt(s.split(":")[1]));
                }
                if (session.getAttribute("account") != null) {
                    d.updateCart(((Account) session.getAttribute("account")).getCUSTOMER_ID(), "");
                }
                response.addCookie(new Cookie("cart", ""));
                session.removeAttribute("cart");
                session.removeAttribute("cartM");
                d.insertOrd((Account) session.getAttribute("account"), m);
                request.getRequestDispatcher("order").forward(request, response);
            } else if (!c.getValue().equals(":null") && c.getValue().contains(":null")) {
                request.setAttribute("error", "Remove missing product first !");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "There are no products in the cart");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("errorBuy", "you must login to buy");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
