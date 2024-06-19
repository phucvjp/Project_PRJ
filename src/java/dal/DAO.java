/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Author;
import model.Category;
import model.EvaMin;
import model.Evaluation;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Publisher;
import model.TopBuyer;

/**
 *
 * @author TUF A15
 */
public class DAO extends DBContext {

    public Account check(String user, String pass) {
        String sql = "select * from Customer where EMAIL like ? and [Password] like ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("CUSTOMER_ID"), rs.getString("CUSTOMER_NAME"), rs.getString("PHONE"), rs.getString("ADDRESS"), rs.getDate("BIRTHDAY"), rs.getString("EMAIL"), rs.getString("SEX"), rs.getString("Password"), rs.getInt("Role"), rs.getString("cart"), rs.getString("fav"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Product> getAllP() {
        ArrayList<Product> list = new ArrayList();

        String sql = "select * from PRODUCT";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product c = new Product(rs.getInt("PRODUCT_ID"), rs.getNString("PRODUCT_NAME"), rs.getDouble("PRICE"), rs.getInt("PAGES"), rs.getString("SIZE"), rs.getDouble("WEIGHT"), rs.getString("DESCRIPTION"), rs.getString("LANGUAGE"), rs.getString("BOOK_FORMAT"), rs.getInt("AUTHOR_ID"), rs.getInt("PUBLISHER_ID"), rs.getInt("CATEGORY_ID"), rs.getDate("PUBLIC_DAY"), rs.getInt("AMOUNT"), rs.getString("Image"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<TopBuyer> topBuyer() {
        ArrayList<TopBuyer> list = new ArrayList();

        String sql = "EXECUTE TopBuyer";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TopBuyer c = new TopBuyer(rs.getInt("CUSTOMER_ID"),rs.getString("CUSTOMER_NAME"),rs.getDouble("TOTAL"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public HashMap<Product, Integer> bestSeller() {
        HashMap<Product, Integer> map = new HashMap();

        String sql = "select * from DBO.BestSeller()";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product c = getP(rs.getInt("PRODUCT_ID"));
                map.put(c, rs.getInt("SELLING_AMOUNT"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return map;
    }

    public ArrayList<Author> getAllA() {
        ArrayList<Author> list = new ArrayList();

        String sql = "select * from Author";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Author c = new Author(rs.getInt("Author_ID"), rs.getNString("Author_NAME"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Publisher> getAllPu() {
        ArrayList<Publisher> list = new ArrayList();

        String sql = "select * from Publisher";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Publisher c = new Publisher(rs.getInt("Publisher_ID"), rs.getNString("Publisher_NAME"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Product getP(int id) {

        String sql = "select * from PRODUCT where PRODUCT_ID=" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Product c = new Product(rs.getInt("PRODUCT_ID"), rs.getNString("PRODUCT_NAME"), rs.getDouble("PRICE"), rs.getInt("PAGES"), rs.getString("SIZE"), rs.getDouble("WEIGHT"), rs.getString("DESCRIPTION"), rs.getString("LANGUAGE"), rs.getString("BOOK_FORMAT"), rs.getInt("AUTHOR_ID"), rs.getInt("PUBLISHER_ID"), rs.getInt("CATEGORY_ID"), rs.getDate("PUBLIC_DAY"), rs.getInt("AMOUNT"), rs.getString("Image"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public double getAvgE(int id) {

        String sql = "select DBO.AVG_EVALUATION(?) [AVG]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return Double.parseDouble(String.format("%.1f", rs.getDouble("AVG")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int numOfEva(int id) {

        String sql = "select count(*) [all] from dbo.LIST_EVALUATION(?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("all");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public ArrayList<EvaMin> allEva(int id) {
        ArrayList<EvaMin> li = new ArrayList<>();
        String sql = "select * from dbo.LIST_EVALUATION(?) Order by EVA_TIME desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                li.add(new EvaMin(rs.getNString("CUSTOMER_NAME"), rs.getNString("EVA_CONTENT"),
                        rs.getInt("EVA_SCORE"), rs.getDate("EVA_TIME")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return li;
    }

    public int numEvaByScore(int id, int score) {

        String sql = "select count(*) [all] from dbo.LIST_EVALUATION(?) where EVA_SCORE=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, score);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("all");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public ArrayList<EvaMin> evaByScore(int id, int score) {
        ArrayList<EvaMin> li = new ArrayList<>();
        String sql = "select *  from dbo.LIST_EVALUATION(?) where EVA_SCORE=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, score);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                li.add(new EvaMin(rs.getInt("CUSTOMER_ID"), rs.getNString("CUSTOMER_NAME"), rs.getNString("EVA_CONTENT"),
                        rs.getInt("EVA_SCORE"), rs.getDate("EVA_TIME")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return li;
    }

    public Account checkA(int id) {
        String sql = "select * from Customer where Customer_ID=" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("CUSTOMER_ID"), rs.getString("CUSTOMER_NAME"), rs.getString("PHONE"), rs.getString("ADDRESS"), rs.getDate("BIRTHDAY"), rs.getString("EMAIL"), rs.getString("SEX"), rs.getString("Password"), rs.getInt("Role"), rs.getString("cart"), rs.getString("fav"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public double maxP() {

        String sql = "select * from PRODUCT where PRICE >= all(select PRICE from PRODUCT)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble("PRICE");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public ArrayList<Product> getAllP(int type) {
        ArrayList<Product> list = new ArrayList();

        String sql = "select * from Product where CATEGORY_ID =? order by PRODUCT_ID asc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, type);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product c = new Product(rs.getInt("PRODUCT_ID"), rs.getNString("PRODUCT_NAME"), rs.getDouble("PRICE"), rs.getInt("PAGES"), rs.getString("SIZE"), rs.getDouble("WEIGHT"), rs.getString("DESCRIPTION"),
                        rs.getString("LANGUAGE"), rs.getString("BOOK_FORMAT"), rs.getInt("AUTHOR_ID"), rs.getInt("PUBLISHER_ID"), rs.getInt("CATEGORY_ID"), rs.getDate("PUBLIC_DAY"), rs.getInt("AMOUNT"), rs.getString("Image"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ArrayList<Product> search(String input) {
        ArrayList<Product> list = new ArrayList();
        String sql = "select p.*\n"
                + "            from PRODUCT p join AUTHOR a on p.AUTHOR_ID=a.AUTHOR_ID\n"
                + "            join CATEGORY c on p.CATEGORY_ID=c.CATEGORY_ID"
                + " where p.PRODUCT_NAME like N'%" + input + "%' or a.AUTHOR_NAME like N'%" + input + "%' or c.CATEGORY_NAME like N'%" + input + "%'";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("PRODUCT_ID"), rs.getNString("PRODUCT_NAME"), rs.getDouble("PRICE"), rs.getInt("PAGES"), rs.getString("SIZE"), rs.getDouble("WEIGHT"), rs.getString("DESCRIPTION"),
                        rs.getString("LANGUAGE"), rs.getString("BOOK_FORMAT"), rs.getInt("AUTHOR_ID"), rs.getInt("PUBLISHER_ID"), rs.getInt("CATEGORY_ID"), rs.getDate("PUBLIC_DAY"), rs.getInt("AMOUNT"), rs.getString("Image")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public ArrayList<Product> search(int type, double minP, double maxP, String sort, String ord) {
        ArrayList<Product> list = new ArrayList();
        String sql = "select * from Product where 1=1 ";
        PreparedStatement st;
        try {
            sql += "and PRICE between " + minP + " and " + maxP + " ";
            if (type != 0) {
                sql += "and CATEGORY_ID =" + type + "  ";
            }
            if (!sort.equals("0")) {
                sql += "Order by " + sort + " " + ord;
            }
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt("PRODUCT_ID"), rs.getNString("PRODUCT_NAME"), rs.getDouble("PRICE"), rs.getInt("PAGES"), rs.getString("SIZE"), rs.getDouble("WEIGHT"), rs.getString("DESCRIPTION"),
                        rs.getString("LANGUAGE"), rs.getString("BOOK_FORMAT"), rs.getInt("AUTHOR_ID"), rs.getInt("PUBLISHER_ID"), rs.getInt("CATEGORY_ID"), rs.getDate("PUBLIC_DAY"), rs.getInt("AMOUNT"), rs.getString("Image")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public void updateCart(int aid, String cart) {
        String sql = "update Customer set cart=? where CUSTOMER_ID=?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, cart);
            st.setInt(2, aid);
            st.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateFav(int aid, String fav) {
        String sql = "update Customer set fav=? where CUSTOMER_ID=?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, fav);
            st.setInt(2, aid);
            st.executeUpdate();

        } catch (SQLException e) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public ArrayList<Category> getAllC() {
        ArrayList<Category> list = new ArrayList();

        String sql = "select * from CATEGORY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt("CATEGORY_ID"), rs.getNString("CATEGORY_NAME"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void delete(int id) {
        String sql = "delete from Product where PRODUCT_ID=" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, "fail delete", "");
        }
    }

    public void update(Product pro) {
        String sql = "UPDATE [dbo].[PRODUCT]\n"
                + "   SET [PRODUCT_ID] = ?\n"
                + "      ,[PRODUCT_NAME] = ?\n"
                + "      ,[PRICE] = ?\n"
                + "      ,[PAGES] =?\n"
                + "      ,[SIZE] = ?\n"
                + "      ,[WEIGHT] =?\n"
                + "      ,[DESCRIPTION] = ?\n"
                + "      ,[LANGUAGE] = ?\n"
                + "      ,[BOOK_FORMAT] = ?\n"
                + "      ,[AUTHOR_ID] =?\n"
                + "      ,[PUBLISHER_ID] =?\n"
                + "      ,[CATEGORY_ID] = ?\n"
                + "      ,[PUBLIC_DAY] = ?\n"
                + "      ,[AMOUNT] = ?\n"
                + "      ,[Image] = ?\n"
                + " WHERE [PRODUCT_ID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pro.getPRODUCT_ID());
            st.setString(2, pro.getPRODUCT_NAME());
            st.setDouble(3, pro.getPRICE());
            st.setInt(4, pro.getPAGES());
            st.setString(5, pro.getSIZE());
            st.setDouble(6, pro.getWEIGHT());
            st.setString(7, pro.getDESCRIPTION());
            st.setString(8, pro.getLANGUAGE());
            st.setString(9, pro.getBOOK_FORMAT());
            st.setInt(10, pro.getAUTHOR_ID());
            st.setInt(11, pro.getPUBLISHER_ID());
            st.setInt(12, pro.getCATEGORY_ID());
            st.setDate(13, pro.getPUBLIC_DAY());
            st.setInt(14, pro.getAMOUNT());
            st.setString(15, pro.getImage());
            st.setInt(16, pro.getPRODUCT_ID());
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public void insert(Product pro) {
        String sql = "insert into Product values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pro.getPRODUCT_ID());
            st.setString(2, pro.getPRODUCT_NAME());
            st.setDouble(3, pro.getPRICE());
            st.setInt(4, pro.getPAGES());
            st.setString(5, pro.getSIZE());
            st.setDouble(6, pro.getWEIGHT());
            st.setString(7, pro.getDESCRIPTION());
            st.setString(8, pro.getLANGUAGE());
            st.setString(9, pro.getBOOK_FORMAT());
            st.setInt(10, pro.getAUTHOR_ID());
            st.setInt(11, pro.getPUBLISHER_ID());
            st.setInt(12, pro.getCATEGORY_ID());
            st.setDate(13, pro.getPUBLIC_DAY());
            st.setInt(14, pro.getAMOUNT());
            st.setString(15, pro.getImage());
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public void insertOrd(Account a, HashMap<Product, Integer> mp) {
        String sql1 = "INSERT INTO [dbo].[ORDERS]\n"
                + "           ([CUSTOMER_ID]\n"
                + "           ,[ORDER_DATE]\n"
                + "           ,[TOTAL_PRICE])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?) ",
                sql2 = "INSERT INTO [dbo].[ORDER_DETAIL]\n"
                + "           ([ORDER_ID]\n"
                + "           ,[PRODUCT_ID]\n"
                + "           ,[PRICE]\n"
                + "           ,[AMOUNT])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql1);
            st.setInt(1, a.getCUSTOMER_ID());
            st.setString(2, new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
            double total = 0;
            for (Product product : mp.keySet()) {
                total += product.getPRICE() * mp.get(product);
            }
            st.setDouble(3, total);
            st.executeUpdate();

            st = connection.prepareCall(sql2);
            st.setInt(1, maxOr());
            for (Product p : mp.keySet()) {
                st.setInt(2, p.getPRODUCT_ID());
                st.setDouble(3, p.getPRICE());
                st.setInt(4, mp.get(p));
                st.executeUpdate();
            }

        } catch (SQLException e) {

        }
    }

    public void insert1Ord(Account a, Product p, int amount) {
        String sql1 = "INSERT INTO [dbo].[ORDERS]\n"
                + "           ([CUSTOMER_ID]\n"
                + "           ,[ORDER_DATE]\n"
                + "           ,[TOTAL_PRICE])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?) ",
                sql2 = "INSERT INTO [dbo].[ORDER_DETAIL]\n"
                + "           ([ORDER_ID]\n"
                + "           ,[PRODUCT_ID]\n"
                + "           ,[PRICE]\n"
                + "           ,[AMOUNT])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql1);
            st.setInt(1, a.getCUSTOMER_ID());
            st.setString(2, new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()));
            double total = 0;
            total += p.getPRICE() * amount;
            st.setDouble(3, total);
            st.executeUpdate();

            st = connection.prepareCall(sql2);
            st.setInt(1, maxOr());
            st.setInt(2, p.getPRODUCT_ID());
            st.setDouble(3, p.getPRICE());
            st.setInt(4, amount);
            st.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public void insertEva(Account a, int pid, int oid, String content, double score) {
        String sql1 = "INSERT INTO [dbo].[EVALUATION]\n"
                + "           ([CUSTOMER_ID]\n"
                + "           ,[PRODUCT_ID]\n"
                + "           ,[EVA_CONTENT]\n"
                + "           ,[EVA_SCORE]\n"
                + "           ,[EVA_TIME])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?) ",
                sql2 = " UPDATE ORDER_DETAIL SET EVALUATED=1 WHERE PRODUCT_ID=? and ORDER_ID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql1);
            st.setInt(1, a.getCUSTOMER_ID());
            st.setInt(2, pid);
            st.setString(3, content);
            st.setDouble(4, score);
            st.setString(5, new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(Calendar.getInstance().getTime()));
            st.executeUpdate();

            st = connection.prepareCall(sql2);
            st.setInt(1, pid);
            st.setInt(2, oid);
            st.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public boolean signUp(String name, String phone, String addr, String birth, String email, String sex, String pass) {
        String sql = "INSERT INTO [dbo].[CUSTOMER]\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,2\n"
                + "           ,'','')";
        if (name.length() == 0 || phone.length() == 0 || addr.length() == 0 || birth.length() == 0 || email.length() == 0 || sex.length() == 0 || pass.length() == 0) {
            return false;
        }
        int id = 0;
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = connection.prepareCall("select MAX(CUSTOMER_ID) [MAX] from CUSTOMER").executeQuery();
            if (rs.next()) {
                id = rs.getInt("MAX") + 1;
            }
            st.setInt(1, id);
            st.setString(2, name);
            st.setString(3, phone);
            st.setString(4, addr);
            st.setString(5, birth);
            st.setString(6, email);
            st.setString(7, sex);
            st.setString(8, pass);
            if (checkEmail(email)) {
                st.executeUpdate();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return false;
    }

    public boolean checkEmail(String email) {
        String sql = "select * from Customer where EMAIL like '" + email + "'";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

    public boolean updateAcc(String name, String phone, String addr, String birth, String sex, int id) {
        String sql = "UPDATE [dbo].[CUSTOMER]\n"
                + "   SET \n"
                + "      [CUSTOMER_NAME] = ?\n"
                + "      ,[PHONE] = ?\n"
                + "      ,[ADDRESS] = ?\n"
                + "      ,[BIRTHDAY] = ?\n"
                + "      ,[SEX] = ?\n"
                + " WHERE CUSTOMER_ID=?";
        if (name.length() == 0 || phone.length() == 0 || addr.length() == 0 || birth.length() == 0 || sex.length() == 0) {
            return false;
        }
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, name);
            st.setString(2, phone);
            st.setString(3, addr);
            st.setString(4, birth);
            st.setString(5, sex);
            st.setInt(6, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return true;
    }

    public boolean changePass(String pass, int id) {
        String sql = "UPDATE [dbo].[CUSTOMER]\n"
                + "   SET \n"
                + "      [PASSWORD] = ?\n"
                + " WHERE CUSTOMER_ID=?";
        if (pass.length() == 0) {
            return false;
        }
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setString(1, pass);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return true;
    }

    public int maxOr() {

        String sql = "select * from Orders where ORDER_ID >= all(select ORDER_ID from ORDERs)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("ORDER_ID");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public ArrayList<Order> getAllOr(Account a) {
        ArrayList<Order> li = new ArrayList<Order>();
        String sql = "select * from Orders where CUSTOMER_ID=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, a.getCUSTOMER_ID());
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("ORDER_ID"), a.getCUSTOMER_ID(), rs.getDate("ORDER_DATE"), rs.getDouble("TOTAL_PRICE"), rs.getBoolean("PAYING"));
                li.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return li;
    }

    public LinkedHashMap<String, Double> rev() {
        LinkedHashMap<String, Double> map = new LinkedHashMap<>();
        String sql = "select * from DBO.RevenueInQuarter()";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("Quarter"), rs.getDouble("Total") / 1000.0);
            }
            return map;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Order getOr(int id) {
        String sql = "select * from Orders where order_ID=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Order(rs.getInt("ORDER_ID"), rs.getInt("Customer_ID"), rs.getDate("ORDER_DATE"), rs.getDouble("TOTAL_PRICE"), rs.getBoolean("PAYING"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<OrderDetail> getOrDetail(int id) {
        ArrayList<OrderDetail> li = new ArrayList<OrderDetail>();
        String sql = "select * from Order_DETAIL where order_ID=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                li.add(new OrderDetail(rs.getInt("Order_ID"), rs.getInt("PRODUCT_ID"), rs.getDouble("PRICE"), rs.getInt("AMOUNT"), rs.getBoolean("EVALUATED")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return li;
    }
}
