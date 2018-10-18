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

    private File imageFolder;
    private File audioFolder;
    private File videoFolder;

    private File tempFolder;


    @Override
    public void init() throws ServletException {

        super.init();

        this.imageFolder = new File(getServletContext().getRealPath("/Uploaded_Images"));

        if (!imageFolder.exists()) {
            imageFolder.mkdir();
        }

        this.audioFolder = new File(getServletContext().getRealPath("/Uploaded_Audio"));

        if (!audioFolder.exists()) {
            audioFolder.mkdir();
        }


        this.videoFolder = new File(getServletContext().getRealPath("/Uploaded_Video"));

        if (!videoFolder.exists()) {
            videoFolder.mkdir();
        }


        this.tempFolder = new File(getServletContext().getRealPath("/WEB-INF/temp"));

        if (!tempFolder.exists()) {
            tempFolder.mkdir();
        }

        //The  mkdirs() method will create necessary directories for a file.
        //The directories may already exist so we only need to create them if they don’t already exist
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //DiskFileItemFactory is a class with APIs to help storing files in the temporary folder and with other aspects of the upload process.
        //ServletFileUpload is a class with APIs that help with aspects of the uploading process.
        //Each of these classes has methods which can be used to do various parts of the file upload process.

        // Setup DiskFileItemFactory and ServletFileUpload objects
        DiskFileItemFactory factory = new DiskFileItemFactory();

        factory.setSizeThreshold(4 * 1024);
        factory.setRepository(tempFolder);

        ServletFileUpload upload = new ServletFileUpload(factory);


        //Setup PrintWriter
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // get all the requested file, loop through then put a new image file in uploads folder
        try {
            List<FileItem> fileItems = upload.parseRequest(request);

            List<File> allImages = new ArrayList<>();
            File audioFile = null;
            File videoFile = null;

            String title = null;
            String content = null;
            String date = null;
            String youtubeLink = null;

            String form = null;

            for (FileItem fi : fileItems) {

                //get uploaded image/audio/video details
                if (!fi.isFormField()) {

                    if (fi.getFieldName().equals("picture")){
                        String fileName = fi.getName();
                        if (!fileName.equals("")) {
                            File singleImage = new File(imageFolder, fileName);
                            allImages.add(singleImage);
                            fi.write(singleImage);
                        }
                    }

                    if (fi.getFieldName().equals("audioUpload")){
                        String audioName = fi.getName();
                        if (!audioName.equals("")) {
                            audioFile = new File(audioFolder, audioName);
                            fi.write(audioFile);
                        }
                    }

                    if (fi.getFieldName().equals("videoUpload")){
                        String videoName = fi.getName();
                        if (!videoName.equals("")) {
                            videoFile = new File(videoFolder, videoName);
                            fi.write(videoFile);
                        }
                    }

                }

                // get article details
                if (fi.getFieldName().equals("article_heading")) {
                    title = fi.getString();
                }

                if (fi.getFieldName().equals("article_content")) {
                    content = fi.getString();
                }

                if (fi.getFieldName().equals("article_date")) {
                    date = fi.getString();
                }

                if (fi.getFieldName().equals("youtubeLink")) {
                    String[] parts = fi.getString().split("=");
                    youtubeLink = parts[parts.length-1];
                }

                // which form is the code coming from
                if (fi.getFieldName().equals("addArticle")) {
                    form = fi.getString();
                }

                if (fi.getFieldName().equals("updateArticle")){
                    form = fi.getString();
                }

            }


            try (ArticleDAO newArticleDAO = new ArticleDAO()) {
                ArticlePOJO apj = new ArticlePOJO();

                if ("Add Now".equals(form)) {
                    //set article details tile, content, date, author

                    apj.setAuthor_id(Integer.parseInt(request.getSession().getAttribute("userID").toString()));
                    apj.setTitle(title);
                    apj.setContent(content);
                    apj.setArticle_date(date);
                    apj.setArticle_Youtube(youtubeLink);

                    //add audio file to Article POJO if it's available
                    if (audioFile != null){
                        apj.setArticle_audio(audioFile.getName());
                    }

                    //add video file to Article POJO if it's available
                    if (videoFile != null){
                        apj.setArticle_video(videoFile.getName());
                    }

                    //add the info to database (project_article table)
                    newArticleDAO.addNewArticle(apj);

                    // if images are available, add them to the database (project_aticle_image table)
                    if (!allImages.isEmpty()) {
                        for (File singleImage : allImages) {
                            ImagePOJO ipj = new ImagePOJO();
                            ipj.setArticle_id(newArticleDAO.getIDOfLastArticle());
                            ipj.setSource(singleImage.getName());
                            newArticleDAO.saveImageToDatabase(ipj);
                        }
                    }

                    // set the page session to myArticles, and the visibility for comment div to be false
                    request.getSession().setAttribute("page", "myArticles");
                    request.getSession().setAttribute("button_" + newArticleDAO.getIDOfLastArticle(), false);

                } else if ("Update".equals(form)) {

                    List <ImagePOJO> allImagesEdit = (List<ImagePOJO>) request.getSession().getAttribute("allImages");

                    for (ImagePOJO i : allImagesEdit){
                        for (FileItem fi : fileItems){
                            if (fi.getFieldName().equals("checkbox_" + i.getImage_id())){
                                if (fi.getString() != null){
                                    newArticleDAO.deleteSingleImage(fi.getString());
                                }
                            }
                        }
                    }

                    apj.setArticle_id(Integer.parseInt(request.getSession().getAttribute("articleID").toString()));
                    apj.setTitle(title);
                    apj.setContent(content);
                    apj.setArticle_date(date);
                    newArticleDAO.updateArticle(apj);

                    if (!allImages.isEmpty()) {

                        for (File singleImage : allImages) {
                            ImagePOJO ipj = new ImagePOJO();
                            ipj.setArticle_id(Integer.parseInt(request.getSession().getAttribute("articleID").toString()));
                            ipj.setSource(singleImage.getName());
                            newArticleDAO.saveImageToDatabase(ipj);
                        }
                    }

                }


                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
                dispatcher.forward(request, response);
            }


        } catch (Exception e) {
            throw new ServletException(e);
        }


    }

}
