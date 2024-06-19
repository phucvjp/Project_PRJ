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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author TUF A15
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet login at " + request.getContextPath() + "</h1>");
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
        Cookie[] lc = request.getCookies();
        for (Cookie cookie : lc) {
            if (cookie.getName().equals("cuser")) {
                request.setAttribute("user", cookie.getValue());
                log(cookie.getValue());
                continue;
            }
            if (cookie.getName().equals("cpass")) {
                request.setAttribute("pass", cookie.getValue());
                log(cookie.getValue());

                continue;
            }
            if (cookie.getName().equals("crem")) {
                request.setAttribute("rem", cookie.getValue());
                log(cookie.getValue());

                continue;
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
        Cookie[] lc = request.getCookies();
        for (Cookie cookie : lc) {
            if (cookie.getName().equals("cuser")) {
                request.setAttribute("user", cookie.getValue());
                log(cookie.getValue());
                continue;
            }
            if (cookie.getName().equals("cpass")) {
                request.setAttribute("pass", cookie.getValue());
                log(cookie.getValue());
                continue;
            }
            if (cookie.getName().equals("crem")) {
                request.setAttribute("rem", cookie.getValue());
                log(cookie.getValue());
                continue;
            }
        }
        if (request.getAttribute("errorBuy") != null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        Account a = d.check(request.getParameter("username"), request.getParameter("password"));
        if (a != null) {
            Cookie user = new Cookie("cuser", request.getParameter("username"));
            Cookie pass = new Cookie("cpass", request.getParameter("password"));
            Cookie rem = new Cookie("crem", request.getParameter("remember"));
            if (request.getParameter("remember") != null) {
                user.setMaxAge(60 * 60 * 24 * 7);
                pass.setMaxAge(60 * 60 * 24 * 7);
                rem.setMaxAge(60 * 60 * 24 * 7);
            } else {
                user.setMaxAge(0);
                pass.setMaxAge(0);
                rem.setMaxAge(0);
            }
            response.addCookie(rem);
            response.addCookie(pass);
            response.addCookie(user);

            Cookie c = new Cookie("cart", a.getCart());
            session.setAttribute("account", a);
            c.setMaxAge(60 * 60 * 24);
            response.addCookie(c);
            c = new Cookie("fav", a.getFav());
            c.setMaxAge(60 * 60 * 24);
            response.addCookie(c);
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "invalid username or password!!!");
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
