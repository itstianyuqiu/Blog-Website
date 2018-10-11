package UserServlet;

import DAO.ArticleDAO;
import POJO.ArticlePOJO;
import POJO.UserPOJO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UpdateArticleDatabase extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String addArticle = req.getParameter("addArticle");
        String deleteArticle = req.getParameter("delete_button");
        String editArticle = req.getParameter("edit_button");
        String updateArticle = req.getParameter("updateArticle");


        try (ArticleDAO newArticleDAO = new ArticleDAO()){

            ArticlePOJO apj = new ArticlePOJO();
            UserPOJO upj = new UserPOJO();

            if ("Add Now".equals(addArticle)) {
                apj.setTitle(req.getParameter("article_heading"));
                apj.setContent(req.getParameter("article_content"));
                upj.setUser_id(Integer.parseInt(req.getSession().getAttribute("userID").toString()));
                newArticleDAO.addNewArticle(apj,upj);
                doPost(req, resp);
            } else if ("Delete".equals(deleteArticle)) {
                newArticleDAO.deleteArticle(req.getParameter("articleID"));
                doPost(req,resp);
            } else if ("Edit".equals(editArticle)){
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/JSP_Pages/editUserArticle.jsp");
                req.getSession().setAttribute("articleID", req.getParameter("articleID"));
                dispatcher.forward(req, resp);
            } else if ("Update".equals(updateArticle)){
                apj.setArticle_id(Integer.parseInt(req.getSession().getAttribute("articleID").toString()));
                apj.setTitle(req.getParameter("new_article_heading"));
                apj.setContent(req.getParameter("new_article_content"));
                newArticleDAO.updateArticle(apj);
                doPost(req,resp);
            }
        }
        catch(SQLException e){
            System.out.println(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req, resp);
    }
}
