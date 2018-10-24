package Servlet;

import DAO.AdminDAO;
import POJO.AdminPOJO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String errMsg = "";
        if (username.equals("") || username == null) {
            errMsg = "please enter your username";
        }
        if (password.equals("") || password == null) {
            errMsg = "please enter your password";
        }
        try (AdminDAO adminDAO = new AdminDAO()) {
            AdminPOJO adminPOJO = adminDAO.queryAdminbyName(username);

            if (adminPOJO == null || adminPOJO.getAdminName().equals("")) {
                errMsg = "wrong username";
            } else if (!adminPOJO.getPassword().equals(password)) {
                errMsg = "wrong password";
            }
            if (!errMsg.equals("")) {
                resp.getWriter().write("error:" + errMsg);
            } else {
                req.getSession().setAttribute("admin", adminPOJO);
                resp.sendRedirect("/admin/index.jsp");
            }
        }  catch (SQLException e) {
            req.setAttribute("error","Your data query is wrong!");
            req.getRequestDispatcher("/promt/Error.jsp").forward(req,resp);
        } catch (Exception e) {
            req.setAttribute("error","Your data query is wrong!");
            req.getRequestDispatcher("/promt/Error.jsp").forward(req,resp);
        }


    }
}
