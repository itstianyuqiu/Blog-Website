package UserServlet;

import POJO.CommentsPOJO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userID = req.getSession().getAttribute("userID").toString();
        String articleID = req.getParameter("articleID_comment");
        req.getSession().setAttribute("articleID_comment", articleID);

            if (req.getSession().getAttribute("buttonClicked").toString().equals("false")) {
                req.getSession().setAttribute("buttonClicked", true);
            }
            else {
                req.getSession().setAttribute("buttonClicked", false);
            }

        if ("Add New Comment".equals(req.getParameter("add_comment_button"))) {
                CommentsPOJO cpj = new CommentsPOJO();
                cpj.setUserID(Integer.parseInt(userID));
                cpj.setArticleID(Integer.parseInt(articleID));
                cpj.setComments(req.getParameter("comments_content"));
        }



        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(req, resp);
    }
}
