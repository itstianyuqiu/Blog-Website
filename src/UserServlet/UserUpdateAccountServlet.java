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
        try (UserDAO userDAO = new UserDAO()) {
            //if click first save change button, change user's username,email,country,description
            if ("savechange1".equals(req.getParameter("savechange1"))) {
                changeGeneralAccountSetting(userDAO, req, resp);
                System.out.println("back to setting page==================");
            }
            //if click second save change button, change user's password
            else if ("savechange2".equals(req.getParameter("savechange2"))) {
                changeToNewPassword(userDAO, req, resp);
                System.out.println("修改mim");
            }
            req.getRequestDispatcher("/settingpage.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void changeToNewPassword(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String newPassword = req.getParameter("newpwd");
        String confirmPassword = req.getParameter("confirmpwd");

        if (newPassword.equals(confirmPassword)) {
            UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
            userPOJO.setPassword(newPassword);

            userDAO.updateUserAccount(userPOJO);
        } else {
            System.out.println("not correct");////ajax!!!!!
        }
    }

    private void changeGeneralAccountSetting(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String username = req.getParameter("username");
        String email = req.getParameter("emailaddress");
        String country = req.getParameter("country");
        String description = req.getParameter("description");
        System.out.println(username);

        UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
        userPOJO.setUsername(username);
        userPOJO.setEmail(email);
        userPOJO.setCountry(country);
        userPOJO.setDescription(description);

        userDAO.updateUserAccount(userPOJO);
        System.out.println("update=============");
    }
}
