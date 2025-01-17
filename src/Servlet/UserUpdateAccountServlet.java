package Servlet;

import DAO.UserDAO;
import POJO.UserPOJO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

public class UserUpdateAccountServlet extends HttpServlet {
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

    /**
     * predefined avatar icons
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getParameter("imgPath");
        String[] paths = path.split(req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/");

        UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
        userPOJO.setAvatar(paths[1]);
        try (UserDAO userDAO = new UserDAO()) {
            userDAO.updateUserAccount(userPOJO);
            req.getRequestDispatcher("/settingpage.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getParameter("imgPath");
        try (UserDAO userDAO = new UserDAO()) {
            //if click first save change button, change user's username,email,country,description
            if ("savechange1".equals(req.getParameter("savechange1"))) {
                changeGeneralAccountSetting(userDAO, req, resp);
                System.out.println("back to setting page==================");
            }
            //if click second save change button, change user's password
            else if ("savechange2".equals(req.getParameter("savechange2"))) {
                changeToNewPassword(userDAO, req, resp);
                System.out.println("change password");
            }
            //change user avatar by file upload
            else {
                changeAvatarWithFileUpload(userDAO, req, resp);
            }
            req.getRequestDispatcher("/settingpage.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    private void changeAvatarWithFileUpload(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(4 * 1024);
        factory.setRepository(tempFolder);
        ServletFileUpload fileUpload = new ServletFileUpload(factory);

        List<FileItem> fileItems = fileUpload.parseRequest(req);

        File imgFile = null;
        String filename = null;


        for (FileItem fi : fileItems) {
            if (!fi.isFormField()) {

                filename = fi.getName();
                imgFile = new File(uploadFolder, filename);
                fi.write(imgFile);
            }
        }
        if (imgFile == null) {
            System.out.println("imgFile is null.");
        } else {
            UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
            userPOJO.setAvatar("Uploaded_Avatar/" + filename);

            userDAO.updateUserAccount(userPOJO);

        }
    }

    private void changeToNewPassword(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String newPassword = req.getParameter("newpwd");
        String confirmPassword = req.getParameter("confirmpwd");

        if (newPassword.equals(confirmPassword)) {
            UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
            userPOJO.setPassword(newPassword);

            userDAO.updateUserAccount(userPOJO);
            System.out.println("new password");
        } else {
            System.out.println("not correct");////ajax!!!!!
        }
    }

    private void changeGeneralAccountSetting(UserDAO userDAO, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        String email = req.getParameter("emailaddress");
        String country = req.getParameter("country");
        String description = req.getParameter("description");

        UserPOJO userPOJO = (UserPOJO) req.getSession().getAttribute("userPOJO");
        userPOJO.setEmail(email);
        userPOJO.setCountry(country);
        userPOJO.setDescription(description);

        userDAO.updateUserAccount(userPOJO);
        System.out.println("update=============");
    }
}
