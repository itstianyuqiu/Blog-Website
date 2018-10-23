package Servlet;

import DAO.UserDAO;
import POJO.JoinQueryDataModel;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public class IndexServlet extends HttpServlet {
   private  List<JoinQueryDataModel> jqmlist;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setAttribute("allArt",this.jqmlist);
        System.out.println();
        req.getRequestDispatcher("/index.jsp").forward(req,resp);
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        try (UserDAO ud = new UserDAO()) {
            String frontstr[]={"",""};
            Date datebegin=Date.valueOf("1970-1-1");
            Date dateend=new Date(new java.util.Date().getTime());
           this.jqmlist = ud.quaryArtAnduser(frontstr, new Date[]{datebegin, dateend});
            System.out.println(jqmlist);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
