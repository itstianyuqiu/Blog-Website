package Servlet;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String createAccount = req.getParameter("newAccount");
        if ("Log in".equals(login)) {
         //check if the login is correct, if correct then redirect to Article Servlet
            req.getSession().setAttribute("userID", "1");
            req.getSession().setAttribute("userLogged", true);
            req.getSession().setAttribute("buttonClicked", false);
            resp.sendRedirect("/ArticleServlet");
            //if not correct then promt user to enter again
        }
        else if ("newAccount".equals(createAccount)){
            //form a jsp page with a new user details form
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
