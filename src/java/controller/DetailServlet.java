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
import model.Account;
import model.Author;
import model.Product;
import model.Publisher;

/**
 *
 * @author TUF A15
 */
public class DetailServlet extends HttpServlet {

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
            out.println("<title>Servlet DetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetailServlet at " + request.getContextPath() + "</h1>");
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
        Product pro = new Product();
        if (request.getParameter("id") != null) {
            pro = d.getP(Integer.parseInt(request.getParameter("id")));
        }
        //truc tiep mua hang
        for (Product p : d.getAllP()) {
            if (request.getParameter("" + p.getPRODUCT_ID()) != null && session.getAttribute("account") != null) {
                d.insert1Ord((Account) session.getAttribute("account"), p, Integer.parseInt(request.getParameter("" + p.getPRODUCT_ID())));
                request.setAttribute("success", "success buying!");
                response.sendRedirect("order");
                return;
            } else if (request.getParameter("" + p.getPRODUCT_ID()) != null && session.getAttribute("account") == null) {
                request.setAttribute("errorBuy", "you must login to buy");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        }
        request.setAttribute("product", d.getP(Integer.parseInt(request.getParameter("id"))));

        request.setAttribute("numEva", d.numOfEva(Integer.parseInt(request.getParameter("id"))));
        request.setAttribute("star1", d.numEvaByScore(Integer.parseInt(request.getParameter("id")), 1));
        request.setAttribute("star2", d.numEvaByScore(Integer.parseInt(request.getParameter("id")), 2));
        request.setAttribute("star3", d.numEvaByScore(Integer.parseInt(request.getParameter("id")), 3));
        request.setAttribute("star4", d.numEvaByScore(Integer.parseInt(request.getParameter("id")), 4));
        request.setAttribute("star5", d.numEvaByScore(Integer.parseInt(request.getParameter("id")), 5));

        request.setAttribute("eva", d.allEva(Integer.parseInt(request.getParameter("id"))));
        if (request.getParameter("star") != null && Integer.parseInt(request.getParameter("star")) != 0) {
            request.setAttribute("star", Integer.parseInt(request.getParameter("star")));
            request.setAttribute("eva", d.evaByScore(Integer.parseInt(request.getParameter("id")), Integer.parseInt(request.getParameter("star"))));
        }
        request.setAttribute("d", d);
        request.setAttribute("avg", d.getAvgE(Integer.parseInt(request.getParameter("id"))));
        for (Author author : d.getAllA()) {
            if (pro.getAUTHOR_ID() == author.getAUTHOR_ID()) {
                request.setAttribute("author", author.getAUTHOR_NAME());
            }
        }
        for (Publisher publisher : d.getAllPu()) {
            if (pro.getPUBLISHER_ID() == publisher.getPUBLISHER_ID()) {
                request.setAttribute("pub", publisher.getPUBLISHER_NAME());
            }
        }
        request.getRequestDispatcher("product.jsp").forward(request, response);
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
        HttpSession ss = request.getSession();
        Cookie[] lc = request.getCookies();
        Cookie c = null;
        for (Cookie cookie : lc) {
            if (cookie.getName().equals("cart")) {
                c = cookie;
            }
        }
        if (c == null) {
            response.addCookie(c = new Cookie("cart", ""));
        }
        if (ss.getAttribute("account") == null) {
            request.setAttribute("errorBuy", "you must login first!!!");
            request.getRequestDispatcher("login").forward(request, response);
            return;
        }
        //add to cart
        for (Product product : d.getAllP()) {
            if (request.getParameter("" + product.getPRODUCT_ID()) != null) {
                String[] tokens = c.getValue().split("%");
                boolean check = false;
                for (int i = 0; i < tokens.length; i++) {
                    String token = tokens[i];
                    if (token.split(":")[0].equals("" + product.getPRODUCT_ID())) {
                        tokens[i] = product.getPRODUCT_ID() + ":" + request.getParameter("" + product.getPRODUCT_ID());
                        check = true;
                        break;
                    }
                }
                c.setValue(String.join("%", tokens));
                if (!check && c.getValue().length() > 0) {
                    c.setValue(c.getValue() + "%" + product.getPRODUCT_ID() + ":" + request.getParameter("" + product.getPRODUCT_ID()));
                }
                if (!check && c.getValue().length() == 0) {
                    c.setValue(product.getPRODUCT_ID() + ":" + request.getParameter("" + product.getPRODUCT_ID()));
                }
                d.updateCart(((Account) ss.getAttribute("account")).getCUSTOMER_ID(), c.getValue());
                ss.setAttribute("account", d.checkA(((Account) ss.getAttribute("account")).getCUSTOMER_ID()));
                break;
            }
        }
        c.setMaxAge(60 * 60 * 24);
        response.addCookie(c);
        response.sendRedirect("home");
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
