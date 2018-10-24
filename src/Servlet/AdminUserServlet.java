package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.EmailUtil;
import Utilities.QuaryModal;
import net.sf.json.JSONArray;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("admin servlet");
        String str = req.getParameter("adminuser");
        try (UserDAO userDAO = new UserDAO()) {
            if (str == null || str.equals("")) {

            } else {
                if (str.equals("getalluser")) {

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
                    System.out.println("admin add============");
                    UserPOJO userPOJO = new UserPOJO();
                    addUser(req, userDAO, userPOJO);
                    req.getRequestDispatcher("/admin/add_user.jsp").forward(req, resp);
                } else if (str.equals("sendemail")) {
                    sendEmail(req,resp,userDAO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void deleteuser(int id, UserDAO userDAO) throws SQLException {
        userDAO.deleteUserAccount(id);
    }

    public void addUser(HttpServletRequest req, UserDAO userDAO, UserPOJO userPOJO) throws SQLException {
        userPOJO.setUsername(req.getParameter("username"));
        userPOJO.setPassword(req.getParameter("password"));
        userPOJO.setFirstName(req.getParameter("firstname"));
        userPOJO.setLastName(req.getParameter("lastname"));
        userPOJO.setBirth(req.getParameter("dob"));
        userPOJO.setEmail(req.getParameter("email"));
        userPOJO.setDescription(req.getParameter("description"));
        userPOJO.setCountry(req.getParameter("country"));
        userDAO.addNewUserAccount(userPOJO);
    }

    private void sendEmail(HttpServletRequest req, HttpServletResponse resp, UserDAO userDAO) throws SQLException, MessagingException, IOException {
        String emailTitle = req.getParameter("email-title");
        String emailContent = req.getParameter("email-content");
        String securityKey = req.getParameter("security-Key");
        if (securityKey == null) {
                resp.getWriter().write("1");
                return;
        }
        UserPOJO userPOJO = userDAO.queryEntrieBySecurityKey(securityKey);
        List<UserPOJO> userPOJOList = new ArrayList<>();
        userPOJOList.add(userPOJO);
        EmailUtil.sendResetPasswordEmail(userPOJOList, emailTitle, emailContent);
        resp.getWriter().write("0");
    }

}
