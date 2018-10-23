package Servlet;


import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


/**
 * 发送重设密码申请的链接
 * send password
 */
public class UserForgotPasswordServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String emailaddress = request.getParameter("emailaddress");
        try (UserDAO userDao = new UserDAO()) {
            UserPOJO user = userDao.queryEntriesByUsername(username);
            String errMsg="";
            if (user == null) {
                errMsg=username + "，no exist！";
            }else if(!user.getEmail().equals(emailaddress)){
                errMsg=emailaddress+", is a wrong email address!";
            }
            if(!errMsg.equals("")){
                request.setAttribute("errMsg",errMsg);
                request.getRequestDispatcher("/index_forget_pwd.jsp").forward(request,response);
                return;
            }


            user.setSecurityKey(UUID.randomUUID().toString());
            System.out.println(user.getSecurityKey());
            userDao.updateUserSecurityKey(user);//input a security-key in this forget password user ,manager will see this user because this key is not null
            List<UserPOJO> userPOJOList=new ArrayList<>();
            userPOJOList.add(user);
            String emailtitle="hello! from blog!";
            String textemail=" text your email address can work! please don't main";

            EmailUtil.sendResetPasswordEmail(userPOJOList,emailtitle,textemail);//send a email to user ,but this not a link email ,just tall him the email can work as before. and the email is the right email address .
            request.setAttribute("success", "Your request administrator has received please wait for administrator processing,Your " + user.getEmail() + " will receive a email to change your password!");
            request.getRequestDispatcher("/index_forget_pwd.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
