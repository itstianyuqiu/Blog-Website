package Servlet;

import DAO.ArticleDAO;
import POJO.ArticlePOJO;
import POJO.ImagePOJO;
import POJO.UserPOJO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ArticleUpload extends HttpServlet {

    private File uploadsFolder;
    private File tempFolder;

    @Override
    public void init() throws ServletException {

        super.init();

        this.uploadsFolder = new File(getServletContext().getRealPath("/Article_Photos"));

        if (!uploadsFolder.exists()){
            uploadsFolder.mkdir();
        }

        this.tempFolder = new File(getServletContext().getRealPath("/WEB-INF/temp"));

        if (!tempFolder.exists()){
            tempFolder.mkdir();
        }

        //The  mkdirs() method will create necessary directories for a file.
        //The directories may already exist so we only need to create them if they don’t already exist
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {

        //DiskFileItemFactory is a class with APIs to help storing files in the temporary folder and with other aspects of the upload process.
        //ServletFileUpload is a class with APIs that help with aspects of the uploading process.
        //Each of these classes has methods which can be used to do various parts of the file upload process.

        // Setup DiskFileItemFactory and ServletFileUpload objects
        DiskFileItemFactory factory = new DiskFileItemFactory();

        factory.setSizeThreshold(4*1024);
        factory.setRepository(tempFolder);

        ServletFileUpload upload = new ServletFileUpload(factory);



        // get all the requested file, loop through then put a new image file in uploads folder
        try {
            List<FileItem> fileItems = upload.parseRequest(request);

            List <File> uploadedImages = new ArrayList<>();
            String title = null;
            String content = null;
            String article_date = null;

            for (FileItem fi: fileItems){
                if (!fi.isFormField()){
                    String fileName = fi.getName();
                    System.out.println("filename" + fileName);
                    if (!fileName.equals("")){
                        File singleImage = new File(uploadsFolder, fileName);
                        uploadedImages.add(singleImage);
                        fi.write(singleImage);
                    }
                }

                if (fi.getFieldName().equals("article_heading")){
                    title = fi.getString();
                }

                if (fi.getFieldName().equals("article_content")){
                    content = fi.getString();
                }

                if (fi.getFieldName().equals("article_date")){
                    article_date = fi.getString();
                }

            }

            //

            try (ArticleDAO newArticleDAO = new ArticleDAO()){

                //Create ArticlePOJO and post it to database
                ArticlePOJO apj = new ArticlePOJO();
                UserPOJO upj = new UserPOJO();
                apj.setTitle(title);
                apj.setContent(content);
                apj.setArticle_date(article_date);
                upj.setUser_id(Integer.parseInt(request.getSession().getAttribute("userID").toString()));
                newArticleDAO.addNewArticle(apj, upj);

                //Create ImagePOJO and post it to database
                ImagePOJO ipj = new ImagePOJO();
                ipj.setArticle_id(newArticleDAO.getIDOfLastArticle());

                if (uploadedImages != null) {
                    for (File singleImage : uploadedImages){
                        ipj.setSource(singleImage.getName());
                        newArticleDAO.saveImageToDatabase(ipj);
                    }
                }

                //Set redirect div to myArticles and set session for new button
                request.getSession().setAttribute("page", "myArticles");
                request.getSession().setAttribute("button_" + newArticleDAO.getIDOfLastArticle(), false);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
                dispatcher.forward(request, response);

            }

        }
        catch (Exception e){
            throw new ServletException(e);
        }


    }

}
