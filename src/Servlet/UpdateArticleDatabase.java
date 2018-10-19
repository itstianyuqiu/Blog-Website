package Servlet;

import DAO.ArticleDAO;
import POJO.ArticlePOJO;
import POJO.ImagePOJO;
import POJO.UserPOJO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UpdateArticleDatabase extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String deleteArticle = req.getParameter("delete_button");
        String editArticle = req.getParameter("edit_button");

        try (ArticleDAO newArticleDAO = new ArticleDAO()) {
            ArticlePOJO apj = new ArticlePOJO();

            //If the delete button is clicked, the whole article will be deleted from the database
            if ("Yes, Delete".equals(deleteArticle)) {
                newArticleDAO.deleteArticle(req.getParameter("articleID"));
                redirect(req,resp);
            //If the edit button is clicked, this will take you through to the the editUserArticle page where you can update the article
            } else if ("Edit".equals(editArticle)){
                req.getSession().setAttribute("articleID", req.getParameter("articleID"));
                apj.setArticle_id(Integer.parseInt(req.getSession().getAttribute("articleID").toString()));
                apj.setTitle(req.getParameter("articleTitle"));
                apj.setContent(req.getParameter("articleContent"));
                apj.setArticle_date(req.getParameter("articleDate"));
                req.getSession().setAttribute("editArticle", apj);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/JSP_Pages/editUserArticle.jsp");
                dispatcher.forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    protected void redirect(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req, resp);
    }
}
