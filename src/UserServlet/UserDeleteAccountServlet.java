package UserServlet;

import DAO.UserDAO;
import POJO.UserPOJO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserDeleteAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("user user delete delete");
        UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
        try (UserDAO userDAO = new UserDAO()) {
            userDAO.deleteUserAccount(userPOJO.getUser_id());
            req.getSession().removeAttribute("userPOJO");
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
