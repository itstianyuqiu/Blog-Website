package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import Utilities.GrecaptchaUtil;
import Utilities.HashedEncode;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserNewAccountServlet extends HttpServlet {
    private File uploadFolder;
    private File tempFolder;

    @Override
    public void init() throws ServletException {
        super.init();
        this.uploadFolder = new File(getServletContext().getRealPath("/Uploaded_Avatar"));
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }
        this.tempFolder = new File(getServletContext().getRealPath("/WEB-INF/tempFolder"));
        if (!tempFolder.exists()) {
            tempFolder.mkdirs();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (UserDAO userDAO = new UserDAO()) {

//            String grecaptcha = req.getParameter("grecaptcha");
////            Boolean boo = GrecaptchaUtil.grecaptcha(grecaptcha);
////            if (!boo) {//输出错误
////                return;
////            }

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(4 * 1024);
            factory.setRepository(tempFolder);
            ServletFileUpload fileUpload = new ServletFileUpload(factory);

            List<FileItem> fileItems = fileUpload.parseRequest(req);

            File imgFile = null;

            Boolean boo = false;

            String firstName = null;
            String lastName = null;
            String username = null;
            String emailAddress = null;
            String password = null;
//            password= HashedEncode.EncryptPassword(password,username);
            String birthDay = null;
            String birthMonth = null;
            String birthYear = null;
            String gender = null;
            String country = null;
            String description = null;
            String avatarPath = null;

            // get all items from the form
            for (FileItem fi : fileItems) {
                if (!fi.isFormField()) {
                    avatarPath = fi.getName();
                    if (!avatarPath.equals("")) {
                        imgFile = new File(uploadFolder, avatarPath);
                        fi.write(imgFile);
                    }

                }

                if (fi.getFieldName().equals("grecaptcha")) {
                    System.out.println("RECAP: " + fi.getString());
                    boo = GrecaptchaUtil.grecaptcha(fi.getString());
                }

                if (fi.getFieldName().equals("firstname")) {
                    firstName = fi.getString();
                }

                if (fi.getFieldName().equals("surname")) {
                    lastName = fi.getString();
                }

                if (fi.getFieldName().equals("username")) {
                    username = fi.getString();
                }

                if (fi.getFieldName().equals("emailaddress")) {
                    emailAddress = fi.getString();
                }

                if (fi.getFieldName().equals("password")) {
                    password = fi.getString();
                    password = HashedEncode.EncryptPassword(password, username);
                }

                if (fi.getFieldName().equals("dob_day")) {
                    birthDay = fi.getString();
                }

                if (fi.getFieldName().equals("dob_month")) {
                    birthMonth = fi.getString();
                }

                if (fi.getFieldName().equals("dob_year")) {
                    birthYear = fi.getString();
                }

                if (fi.getFieldName().equals("gender")) {
                    gender = fi.getString();
                }

                if (fi.getFieldName().equals("country")) {
                    country = fi.getString();
                }

                if (fi.getFieldName().equals("description")) {
                    description = fi.getString();
                }

            }

            // put all user details into POJO
            UserPOJO userPOJO = new UserPOJO();
            userPOJO.setFirstName(firstName);
            userPOJO.setLastName(lastName);
            userPOJO.setUsername(username);
            userPOJO.setEmail(emailAddress);
            userPOJO.setPassword(password);
            userPOJO.setBirth(birthYear + "-" + birthMonth + "-" + birthDay);
            userPOJO.setGender(gender);
            userPOJO.setCountry(country);
            userPOJO.setDescription(description);

            if (gender.equals("male")){
                userPOJO.setAvatar("images/default08.png");
            }else if (gender.equals("female")){
                userPOJO.setAvatar("images/default07.png");
            }


            if (imgFile == null) {
                System.out.println("imgFile is null.");
            } else {
                userPOJO.setAvatar("Uploaded_Avatar/" + avatarPath);
            }

            userDAO.addNewUserAccount(userPOJO);


            List<UserPOJO> usersList = userDAO.queryEntries();
            userPOJO.setUser_id(usersList.get(usersList.size() - 1).getUser_id());


            if (req.getSession().getAttribute("userPOJO") == null) {
                req.getSession().setAttribute("userPOJO", userPOJO);
            }

            //Kien's gr stuffs
            req.getSession().setAttribute("userID", userPOJO.getUser_id());
            req.getSession().setAttribute("firstLogin_AllArticles", true);
            req.getSession().setAttribute("current_article", 0);
            req.getSession().setAttribute("page", "allArticles");

            if (boo) {
                resp.sendRedirect("/homepage.jsp");
            }
            else {
                resp.sendRedirect("/index_signup.jsp");
            }


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
