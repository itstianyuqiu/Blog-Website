package ictgradschool.web.lab.uploads;

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
import java.util.List;

public class FileUploads extends HttpServlet {

    private File uploadsFolder;
    private File tempFolder;

    //TODO - make this a proper HttpServlet that uses init() and doPost() methods

    @Override
    public void init() throws ServletException {

        super.init();

        this.uploadsFolder = new File(getServletContext().getRealPath("/Uploaded_Photos"));

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

        System.out.println(upload);

        //Setup PrintWriter
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // get all the requested file, loop through then put a new image file in uploads folder
        try {
            List<FileItem> fileItems = upload.parseRequest(request);

            System.out.println(fileItems);

            File fullSizeImage = null;

            for (FileItem fi: fileItems){

                if (!fi.isFormField()){
                    String fileName = fi.getName();
                    fullSizeImage = new File(uploadsFolder, fileName);
                    fi.write(fullSizeImage);
                }
            }

            out.println("<img src=\"../Uploaded_Photos/" + fullSizeImage.getName() + "\"" + "width=\"1000\">");

        }
        catch (Exception e){
            throw new ServletException(e);
        }


    }

}
