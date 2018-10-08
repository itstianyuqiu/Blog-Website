package Servlet;

import DAO.ArticleDAO;
import POJO.CommentsPOJO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            String articleID = req.getParameter("articleID_comment");
            req.getSession().setAttribute("articleID_comment", articleID);

            if (req.getSession().getAttribute("buttonClicked").toString().equals("false")) {
                req.getSession().setAttribute("buttonClicked", true);
            }
            else {
                req.getSession().setAttribute("buttonClicked", false);
            }

        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/JSP_Pages/userLoggedMainPage.jsp");
        dispatcher.forward(req, resp);
    }
}
