package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.HashedEncode;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String securityKey = req.getParameter("securityKey");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm");
        String errMsg = "";

        if (password.equals("") || confirm.equals("")) {
            errMsg = "You didn't enter the password!";
        } else if (!password.equals(confirm)) {
            errMsg = "The two passwords do not match!";
        }
        if (!errMsg.equals("")) {
            resp.getWriter().write(errMsg);

            return;
        }
        try (UserDAO userDAO = new UserDAO();) {
            UserPOJO userPOJO = userDAO.queryEntrieBySecurityKey(securityKey);
            password= HashedEncode.EncryptPassword(password,userPOJO.getUsername());
            userPOJO.setPassword(password);
            userPOJO.setSecurityKey("");
            userDAO.updateUserSecurityKey(userPOJO);
            userDAO.updateUserAccount(userPOJO);
            resp.getWriter().write("0");
            return;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
