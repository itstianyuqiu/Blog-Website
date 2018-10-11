package UserServlet;

import DAO.UserDAO;
import POJO.UserPOJO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserLoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = null;
        try {
            userDAO = new UserDAO();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String login = req.getParameter("login");


        if ("login".equals(login)) {


            try {
                UserPOJO userPOJO = userDAO.postEntriesByUsername(username);
                //check if the login is correct, if correct then redirect to Article Servlet
                if (userPOJO != null) {

                    req.getSession().setAttribute("userPOJO", userPOJO);
                    req.getSession().setAttribute("page","allArticles");
                    req.getRequestDispatcher("/homepage.jsp").forward(req, resp);


                    //Kien's gr stuffs
                    req.getSession().setAttribute("userID", "1");
                    req.getSession().setAttribute("userLogged", true);
                    req.getSession().setAttribute("firstLogin", true);
                    req.getSession().setAttribute("current_article", 0);

                    resp.sendRedirect("/ArticleServlet");
                    //---

                }
                //if not correct then promt user to enter again
                else {
                    resp.sendRedirect("/index_login.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
