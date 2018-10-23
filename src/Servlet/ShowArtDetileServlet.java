package Servlet;

import DAO.ArticleDAO;
import DAO.UserDAO;
import POJO.ArticlePOJO;
import POJO.ImagePOJO;
import POJO.JoinQueryDataModel;
import POJO.UserPOJO;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShowArtDetileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String articleID= req.getParameter("articleid");
      try( ArticleDAO articleDAO=new ArticleDAO();
           UserDAO userDAO=new UserDAO()){
          ArticlePOJO articlePOJO=articleDAO.quaryArtAndimgs(Integer.valueOf(articleID));
           List<ImagePOJO> imgs=articleDAO.quaryImgByartID(Integer.valueOf(articleID));
          articlePOJO.setImagePOJOS(imgs);

         UserPOJO userPOJO= userDAO.getUserName(String.valueOf(articlePOJO.getAuthor_id()));

          JoinQueryDataModel joinQueryDataModel=new JoinQueryDataModel();
          joinQueryDataModel.setUp(userPOJO);
          joinQueryDataModel.setAp(articlePOJO);
          req.setAttribute("article",joinQueryDataModel);
          req.getRequestDispatcher("/article.jsp").forward(req,resp);
//         JSONObject jsonObject= JSONObject.fromObject(joinQueryDataModel);
//         resp.getWriter().write(jsonObject.toString());
      }
      catch (SQLException e) {
          e.printStackTrace();
      } catch (Exception e) {
          e.printStackTrace();
      }
    }

}
