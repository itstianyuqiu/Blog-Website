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
        String updateArticle = req.getParameter("updateArticle");
        String deleteImage = req.getParameter("delete_image_button");


        try (ArticleDAO newArticleDAO = new ArticleDAO()) {
            ArticlePOJO apj = new ArticlePOJO();

            if ("Delete".equals(deleteArticle)) {
                newArticleDAO.deleteArticle(req.getParameter("articleID"));
                redirect(req,resp);
            } else if ("Edit".equals(editArticle)){
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/JSP_Pages/editUserArticle.jsp");
                req.getSession().setAttribute("articleID", req.getParameter("articleID"));
                apj.setArticle_id(Integer.parseInt(req.getSession().getAttribute("articleID").toString()));
                apj.setTitle(req.getParameter("articleTitle"));
                apj.setContent(req.getParameter("articleContent"));
                req.getSession().setAttribute("editArticle", apj);
                dispatcher.forward(req, resp);
            } else if ("Update".equals(updateArticle)){
               List <ImagePOJO> allImages = (List<ImagePOJO>) req.getSession().getAttribute("allImages");
               for (ImagePOJO i : allImages){
                   if (req.getParameter("checkbox_" + i.getImage_id()) != null){
                       newArticleDAO.deleteSingleImage(req.getParameter("checkbox_" + i.getImage_id()));
                   }
               }
                apj.setArticle_id(Integer.parseInt(req.getSession().getAttribute("articleID").toString()));
                apj.setTitle(req.getParameter("new_article_heading"));
                apj.setContent(req.getParameter("new_article_content"));
                newArticleDAO.updateArticle(apj);
                redirect(req,resp);
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
