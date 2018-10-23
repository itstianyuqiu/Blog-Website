package Exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyExceptionHander extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Throwable throwable = (Throwable) req.getAttribute("javax.servlet.error.exception");//when the exception  get it
        Integer status = (Integer) req.getAttribute("javax.servlet.error.status_code");//get the exception status number
        String servletName = (String) req.getAttribute("javax.servlet.error.servlet_name") != null ?
                (String) req.getAttribute("javax.servlet.error.servlet_name"):"Unknown";
        resp.setContentType("text/html");
        String title="Error / Exception Detail";
        if(status==404||status==403){
            System.out.println("roororororororororo");
            req.setAttribute("error","you can't find this page in our station!");
        }else {
            req.setAttribute("error",throwable.getMessage()+"! error found in servce ! call 111!");
        }




    }
}
