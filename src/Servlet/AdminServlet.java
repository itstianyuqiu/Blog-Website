package Servlet;

import DAO.ArticleDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try (ArticleDAO newArticleDAO = new ArticleDAO()) {

            //Changes the visibility of the article that is clicked to either TRUE of FALSE on the admin interface

            if ("Show/Hide Article".equals(req.getParameter("article_visibility_button"))) {
                String articleID = req.getParameter("articleID");
                newArticleDAO.changeArticleVisibility(articleID);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin/articles.jsp");
                dispatcher.forward(req, resp);
            }

            //Changes the visibility of the comment that is clicked to either TRUE of FALSE on the admin interface

            else  if ("Show/Hide Comment".equals(req.getParameter("comment_visibility_button"))) {
                String commentID = req.getParameter("commentID");
                newArticleDAO.changeCommentVisibility(commentID);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin/comments.jsp");
                dispatcher.forward(req, resp);
            }


        } catch (Exception e) {
            e.getMessage();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
