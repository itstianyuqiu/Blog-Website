package Filter;


import POJO.UserPOJO;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

public class DefaultIndexFilter implements Filter {

    @Override
    public void destroy() {

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain dofil) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String userIP = request.getRemoteAddr();
        String uri = request.getRequestURI();
        String path = request.getContextPath();
        System.out.println(uri);
        System.out.println(path);
        if (!uri.contains("Servlet") || !uri.contains(".jsp")) {// If the request is not a servlet or JSP, direct release
            dofil.doFilter(request, response);
        } else {
            if (uri.contains("Admin")) {//Filter for request for the login administrator page
                if (userIP.contains("localhost") || userIP.contains("127.0.0.1")) {
                    if(uri.contains("login.jsp")){
                        dofil.doFilter(request, response);
                    }else{
                        if (request.getSession().getAttribute("admin") == null) {
                            request.setAttribute("error","You don't have d login administrator!");
                            request.getRequestDispatcher("/prompt/error").forward(request, response);
                        } else {
                            dofil.doFilter(request, response);
                        }
                    }
                } else {
                    request.setAttribute("error","You don't have the permissions to log in to this page!");
                    request.getRequestDispatcher("/prompt/error").forward(request, response);
                }
            } else if (uri.contains("newArticleSubmitForm.jsp")||uri.contains("homepage.jsp")

//                    uri.contains(".jsp")||uri.contains(".jsp")||
//                    uri.contains(".jsp")||uri.contains(".jsp")||
//                    uri.contains(".jsp")
            ) {//Make a judgment on the place where there is a need for user permission on the front site
                UserPOJO userPOJO = (UserPOJO) request.getSession().getAttribute("userPOJO");
                if (userPOJO == null) {
                    request.getRequestDispatcher("/prompt/error").forward(request, response);
                }
            } else {
                dofil.doFilter(request, response);
            }

        }
//        else {// 用户界面权限验证
//            if (uri.contains("Login.jsp") || uri.contains("checkUser.do") || uri.contains("getcide.do") || uri.contains("Error.jsp") || uri.contains("Success.jsp")) {// 如果包含后缀对权限进行过滤直接放行的
//                dofil.doFilter(request, response);
//            } else {
//                if ("".equals(u.getUser_name()) || null == u) {// 没有登陆的
//                    response.sendRedirect(path + "/prompt/error.jsp");// 跳转到错误界面不放行并提示登陆错误
//                } else {
//                    dofil.doFilter(request, response);// 有用户的直接放行
//                }
//            }
//        }
    }
}
