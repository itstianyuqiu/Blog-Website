package Servlet;

import DAO.ArticleDAO;
import POJO.CommentsPOJO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class NewCommentSingleArticle extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//        //Gets the userID of the user that is currently logged in
//        String userID = req.getSession().getAttribute("userID").toString();
//
//        CommentsPOJO cpj = new CommentsPOJO();
//        cpj.setUserID(Integer.parseInt(userID));
//        cpj.setArticleID(Integer.parseInt(req.getSession().getAttribute("current_article").toString()));
//        cpj.setComments(req.getParameter("comments_content"));
//        try (ArticleDAO newArticleDAO = new ArticleDAO()) {
//            newArticleDAO.addNewComment(cpj);
//            doPost(req, resp);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }


        //Gets the userID of the user that is currently logged in
        String userID = req.getSession().getAttribute("userID").toString();


        //If the add new comment button is clicked, will show a text input where the new comment can be typed - it is then added to the database
        if ("Add New Comment".equals(req.getParameter("add_comment_button"))) {
            CommentsPOJO cpj = new CommentsPOJO();
            cpj.setUserID(Integer.parseInt(userID));
            cpj.setArticleID(Integer.parseInt(req.getSession().getAttribute("current_article").toString()));
            cpj.setComments(req.getParameter("comments_content"));
            try (ArticleDAO newArticleDAO = new ArticleDAO()){
                newArticleDAO.addNewComment(cpj);

                doPost(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        //If the delete comment button is clicked, the comment will be deleted from the database (for parent comments)
        if ("Delete Comment".equals(req.getParameter("delete_comment_button"))){
            try (ArticleDAO newArticleDAO = new ArticleDAO()) {
                newArticleDAO.deleteComment(req.getParameter("comment_ID"));
                doPost(req,resp);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }


        //If the delete comment button is clicked, the comment will be deleted from the database (for child comments)
        if ("Delete Comment".equals(req.getParameter("delete_child_comment_button"))){
            try (ArticleDAO newArticleDAO = new ArticleDAO()) {
                newArticleDAO.deleteSingleChildComment(req.getParameter("comment_ID"));
                doPost(req,resp);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        //If the reply button is clicked, a child comment can be added to the database (related to the parent comment on which it was clicked)
        if("Reply".equals(req.getParameter("comment_reply"))){
            String parent_id = req.getParameter("parent_ID");
            CommentsPOJO cpj = new CommentsPOJO();
            cpj.setUserID(Integer.parseInt(userID));
            cpj.setArticleID(Integer.parseInt(req.getSession().getAttribute("current_article").toString()));
            cpj.setComments(req.getParameter("comment_reply_content"));
            try (ArticleDAO newArticleDAO = new ArticleDAO()){
                newArticleDAO.addChildComment(parent_id, cpj);
                doPost(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ShowArtDetileServlet");
        dispatcher.forward(req, resp);
    }
}
