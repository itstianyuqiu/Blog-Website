package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.GrecaptchaUtil;
import Utilities.HashedEncode;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class UserLoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (UserDAO userDAO = new UserDAO()) {

            String errMsg="";

            String username = req.getParameter("username");
            String password = req.getParameter("password");

            System.out.println("username: " + username);
            System.out.println("password: " + password);

            if(username.equals("")||username==null){
                errMsg="you didn't input you username!";

            }else if(password.equals("")||password==null){
                errMsg="you didn't input you password !";
            }
            password=HashedEncode.EncryptPassword(password,username);




            UserPOJO userPOJO = userDAO.queryEntriesByUsername(username);
            //check if the login is correct, if correct then forward to user home page
            if(userPOJO==null||userPOJO.getUsername()==null||userPOJO.getUsername().equals("")){
                errMsg=" have no this username";
            }else if(!userPOJO.getPassword().equals(password)){
                errMsg="wrong password!";
            }
            else {

                req.getSession().setAttribute("userPOJO", userPOJO);
                req.getSession().setAttribute("page", "allArticles");


                //Kien's gr stuffs
                req.getSession().setAttribute("userID", userPOJO.getUser_id());
                req.getSession().setAttribute("firstLogin_AllArticles", true);
                req.getSession().setAttribute("firstLogin_MyArticles", true);
                req.getSession().setAttribute("current_article", 0);
                req.getSession().setAttribute("page", "allArticles");

                resp.sendRedirect("/homepage.jsp");
            }


            //if not correct then back to login page again


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
