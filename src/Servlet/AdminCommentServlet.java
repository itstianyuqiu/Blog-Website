package Servlet;

import DAO.ArticleDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminCommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String str = req.getParameter("Mangerart");
        try(ArticleDAO articleDAO=new ArticleDAO()){
        if (str == null || str.equals("")) {

        } else {
            if (str.equals("quaryall")) {

            } else if (str.equals("quaryhidden")) {

            } else if (str.equals("quaryshow")) {

            } else if (str.equals("sethidden")) {

            } else if (str.equals("setshow")) {

            }
        }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private List quaryall(ArticleDAO articleDAO) throws SQLException {

        return articleDAO.loadAllArticles();
    }
//    private List quaryhidden(ArticleDAO articleDAO){
//           return articleDAO.
//    }
//    private List quaryshow(ArticleDAO articleDAO){
//
//    }
//    private List sethidden(ArticleDAO articleDAO){
//
//    }
//    private List setshow(ArticleDAO articleDAO){
//
//    }
}
