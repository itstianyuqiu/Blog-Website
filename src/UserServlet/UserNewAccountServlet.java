package UserServlet;

import DAO.UserDAO;
import POJO.UserPOJO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserNewAccountServlet extends HttpServlet {
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
        String firstName = req.getParameter("firstname");
        String lastName = req.getParameter("surname");
        String username = req.getParameter("username");
        String emailAddress = req.getParameter("emailaddress");
        String password = req.getParameter("password");
        String birthDay = req.getParameter("dob_day");
        String birthMonth = req.getParameter("dob_month");
        String birthYear = req.getParameter("dob_year");
        String gender = req.getParameter("gender");

        System.out.println(gender);
        System.out.println(birthYear);

        UserPOJO userPOJO = new UserPOJO();
        userPOJO.setFirstName(firstName);
        userPOJO.setLastName(lastName);
        userPOJO.setUsername(username);
        userPOJO.setEmail(emailAddress);
        userPOJO.setPassword(password);
        userPOJO.setBirth(birthYear + "-" + birthMonth + "-" + birthDay);
        userPOJO.setGender(gender);

        try {
            userDAO.addNewUserAccount(userPOJO);
            resp.sendRedirect("/homepage.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }
}
