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
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        session.setAttribute("list", d.getAllP());
        request.setAttribute("listP", d.getAllP());
        request.setAttribute("bestSeller", d.bestSeller());
        Cookie[] lc = request.getCookies();
        HashMap<Product, Integer> m = new HashMap();
        ArrayList<Product> l = new ArrayList<>();
        int count = 0;
        if (lc != null && session.getAttribute("account") != null) {
            Account a = d.checkA(((Account) session.getAttribute("account")).getCUSTOMER_ID());
            log(a.getCart());
            log(a.getFav());

            for (Cookie cookie : lc) {
                if (count == 2) {
                    break;
                }
                if (cookie.getName().equals("cart")) {
                    cookie.setValue(a.getCart());
                    if (a.getCart() != null) {
                        for (String s : cookie.getValue().split("%")) {
                            if (s.length() > 0) {
                                m.put(d.getP(Integer.parseInt(s.split(":")[0])), Integer.parseInt(s.split(":")[1]));
                            }
                        }
                    }
                    session.setAttribute("cartM", m);
                    count++;
                }
                if (cookie.getName().equals("fav")) {
                    cookie.setValue(a.getFav());
                    if (a.getFav() != null) {
                        for (String s : cookie.getValue().split("%")) {
                            if (s.length() > 0) {
                                l.add(d.getP(Integer.parseInt(s)));
                            }
                        }
                    } else {

                    }
                    session.setAttribute("favList", l);
                    count++;
                }
            }
        }
        if (session.getAttribute("account") == null) {
            if (lc != null) {
                for (Cookie cookie : lc) {
                    if (cookie.getName().equals("cart")) {
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                    if (cookie.getName().equals("fav")) {
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
            }
            session.removeAttribute("account");
            session.removeAttribute("cart");
            session.removeAttribute("cartM");
        }
        if ((request.getParameter("logout") != null)) {
            if (lc != null) {
                for (Cookie cookie : lc) {
                    if (cookie.getName().equals("cart")) {
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    }
                }
            }
            session.removeAttribute("account");
            session.removeAttribute("cart");
            session.removeAttribute("cartM");

        }
        if ((request.getParameter("type") != null) && !request.getParameter("type").equals("0")) {
            request.setAttribute("type", Integer.parseInt(request.getParameter("type")));
            request.setAttribute("listP", d.getAllP(Integer.parseInt(request.getParameter("type"))));
        } else {
            request.setAttribute("type", 0);
        }
        request.setAttribute("listTop", d.topBuyer());
        session.setAttribute("listC", d.getAllC());
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        session.setAttribute("list", d.getAllP());
        request.setAttribute("listP", d.getAllP());
        request.setAttribute("listTop", d.topBuyer());

        if ((request.getParameter("type") != null) && !request.getParameter("type").equals("0")) {
            request.setAttribute("type", Integer.parseInt(request.getParameter("type")));
            request.setAttribute("listP", d.getAllP(Integer.parseInt(request.getParameter("type"))));
        } else {
            request.setAttribute("type", 0);
        }
        session.setAttribute("listC", d.getAllC());
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
