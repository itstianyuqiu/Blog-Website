package UserServlet;

import DAO.UserDAO;
import POJO.UserPOJO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserUpdateAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if ("savechange1".equals(req.getParameter("generalAccount"))) {
            changeGeneralAccountSetting(userDAO, req, resp);
        } else if ("savechange2".equals(req.getParameter("savechange1"))) {
            changePassword(userDAO, req, resp);
        }


    }

    private void changePassword(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) {

    }

    private void changeGeneralAccountSetting(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) {
        String username = req.getParameter("username");
        String emailAddress = req.getParameter("emailaddress");
        String country = req.getParameter("country");
        String description = req.getParameter("description");

        UserPOJO userPOJO = new UserPOJO();
        userPOJO.setUsername(username);
        userPOJO.setEmail(emailAddress);
        userPOJO.setCountry(country);
        userPOJO.setDescription(description);
        System.out.println(userPOJO.getUsername());
        try {
            userDAO.addNewUserAccount(userPOJO);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
