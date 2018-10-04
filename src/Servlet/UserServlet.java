package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("we got here UserServlet");
        String login = req.getParameter("login");
        String createAccount = req.getParameter("newAccount");
        if ("Log in".equals(login)) {
         //check if the login is correct, if correct then redirect to Article Servlet
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
