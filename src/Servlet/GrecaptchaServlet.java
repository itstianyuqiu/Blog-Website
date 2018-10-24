package Servlet;

import Utilities.ConnectUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class GrecaptchaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String grecaptcha=req.getParameter("grecaptcha");
        Map<String ,String> map=new HashMap<>();
        map.put("secret","6Lfkp3UUAAAAALjvR0nxlCj1frd1n7qv6Legj2ju");
        map.put("response",grecaptcha);
        String str= "";
        try {
            str = ConnectUtil.sendPost("https://recaptcha.net/recaptcha/api/siteverify",map);
        } catch (Exception e) {
            e.printStackTrace();
        }

       str= str.substring(1,str.length()-1);
        str=str.replaceAll("\"", "");
        String strs[]=str.split(",");
        String successStrs[]=strs[0].trim().split(":");

        if(successStrs[0].trim().equals("success")&&successStrs[1].trim().trim().equals("true")){
            resp.getWriter().write("success");
        }else {
            resp.getWriter().write("error");
        }



    }
}
