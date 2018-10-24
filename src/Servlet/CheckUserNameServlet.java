package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;


@WebServlet("/checkUserNameServlet")


public class CheckUserNameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(" got here! Checkusername");
        String form = request.getParameter("form");

        PrintWriter pw = response.getWriter();

        if (form == null) {
            form = "";
        }
        try {
            switch (form) {
                case "username":
                    String username = request.getParameter("username");

                    checkUserNameChange(username, request, pw);
                    break;


            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void checkUserNameChange(String username, HttpServletRequest request, PrintWriter pw) throws SQLException, IOException {
        String  errMsg ="";
        UserDAO userDAO=new UserDAO();
        username=username.trim();
        UserPOJO userPOJO=userDAO.queryEntriesByUsername(username);
        if(username.equals("")){
            errMsg = "1";//No  user name input!
        }
        else if (userPOJO==null||userPOJO.getUsername().equals("")) {
            errMsg = "2";//Vailed username
        } else {
            errMsg = "3";//username already exist
        }
        pw.write(errMsg);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
