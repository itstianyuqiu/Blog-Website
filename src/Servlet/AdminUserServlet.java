package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.QuaryModal;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String str = req.getParameter("adminuser");
        System.out.println(str);
        try (UserDAO userDAO = new UserDAO()) {
            if (str == null || str.equals("")) {

            } else {
                if (str.equals("getalluser")) {
                    System.out.println(str);
                    int pageno = Integer.valueOf(req.getParameter("currentpage"));
                    int count = userDAO.queryCount();
                    QuaryModal<UserPOJO> userPOJOQuaryModal = new QuaryModal<>();
                    userPOJOQuaryModal.setPageSize(8);
                    userPOJOQuaryModal.setNum(count);
                    userPOJOQuaryModal.setPageNO(pageno);
                    userPOJOQuaryModal = userDAO.queryAllUserByPage(userPOJOQuaryModal);

                    req.setAttribute("quarymodel", userPOJOQuaryModal);
//                    resp.sendRedirect("/admin/users.jsp");
                    req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);


                } else if (str.equals("deleteuser")) {
                    String user_id = req.getParameter("user_id");
                    JSONArray jsonArray = JSONArray.fromObject(user_id);
                    Integer[] userArr = (Integer[]) JSONArray.toArray(jsonArray, Integer.class);
                    if (userArr.length > 0) {
                        for (int i = 0; i < userArr.length; i++) {
                            deleteuser((int) userArr[i], userDAO);
                        }
                        resp.getWriter().write("success");
                    }


                } else if (str.equals("adduser")) {
                    UserPOJO userPOJO = new UserPOJO();
                    adduser(req, userDAO, userPOJO);
                    req.getRequestDispatcher("/admin/add_user.jsp").forward(req, resp);
                } else if (str.equals("sendemail")) {
                    String username = req.getParameter("username");
                    sendemail(userDAO, username);
                    req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void deleteuser(int id, UserDAO userDAO) throws SQLException {
        System.out.println("delete=" + id);
        userDAO.deleteUserAccount(id);
    }

    public void adduser(HttpServletRequest req, UserDAO userDAO, UserPOJO userPOJO) throws SQLException {
        userPOJO.setUsername(req.getParameter("username"));
        userPOJO.setPassword(req.getParameter("password"));
        userPOJO.setBirth(req.getParameter("nickname"));
        userPOJO.setGender(req.getParameter("gender"));
        userPOJO.setEmail(req.getParameter("email"));
        userPOJO.setDescription(req.getParameter("disciption"));
        userPOJO.setCountry(req.getParameter("country"));
        userDAO.addNewUserAccount(userPOJO);
    }

    public void sendemail(UserDAO userDAO, String name) throws SQLException {
        UserPOJO userPOJO = userDAO.queryEntriesByUsername(name);
//        Properties props=new Properties();
//        Session session=Session.getInstance(props,null);
//        MIMEMessage message=new MIMEMessage(session);
//        message.setContent("Hello","text/plain");//设置 内容和 格式
//        message.setSubject("")//设置邮件主题
//        Address address=new InternetAddress("邮件地址","名字")//传入一个地址的字符串 建立一个地址类
//        message.setFrom(address)//设置发信人
//        message.setReplayTo(address)//设置发信人
//        Address address1[]={}//设置多个发信人
//        message.addFrom(address1);
//        message.addRecipient(type,address)//s设置收信人 增加一个


    }

}
