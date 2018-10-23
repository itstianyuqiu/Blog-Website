package Servlet;

import DAO.ArticleDAO;
import DAO.UserDAO;
import POJO.ImagePOJO;
import POJO.JoinQueryDataModel;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class QuaryUserArtServlet extends HttpServlet {
    private List<JoinQueryDataModel> jqmList;
    private static List<JoinQueryDataModel> quaryList;

    private static List<JoinQueryDataModel> quaryMathLis(List<JoinQueryDataModel> quaryList) {

        Collections.sort(quaryList, new Comparator<JoinQueryDataModel>() {
            public int compare(JoinQueryDataModel arg0, JoinQueryDataModel arg1) {
                // order by date
                if (Date.valueOf(arg1.getAp().getArticle_date()).getTime() > Date.valueOf(arg0.getAp().getArticle_date()).getTime()) {
                    return 1;
                } else if (Date.valueOf(arg1.getAp().getArticle_date()).getTime() < Date.valueOf(arg0.getAp().getArticle_date()).getTime()) {
                    return -1;
                } else {
                    System.out.println("sort by article title");
                    if (arg1.getAp().getTitle().toCharArray()[0] > arg0.getAp().getTitle().toCharArray()[0]) {
                        return -1;
                    } else if (arg1.getAp().getTitle().toCharArray()[0] < arg0.getAp().getTitle().toCharArray()[0]) {
                        return 1;
                    } else {
                        System.out.println("sort by username");
                        if (arg0.getUp().getUsername().toCharArray()[0] > arg1.getUp().getUsername().toCharArray()[0]) {
                            return -1;
                        } else if (arg0.getUp().getUsername().toCharArray()[0] > arg1.getUp().getUsername().toCharArray()[0]) {
                            return 1;
                        }else {return 0;}
                    }
                }
            }
        });

        return quaryList;


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    public void init() throws ServletException {

        try (UserDAO ud = new UserDAO();
             ArticleDAO articleDAO = new ArticleDAO()) {
            String frontstr[] = {"", ""};
            Date datebegin = Date.valueOf("1970-1-1");
            Date dateend = new Date(new java.util.Date().getTime());
            this.jqmList = ud.quaryArtAnduser(frontstr, new Date[]{datebegin, dateend});
            for (int i = 0; i < jqmList.size(); i++) {
                JoinQueryDataModel joinQueryDataModel = jqmList.get(i);
                List<ImagePOJO> imagePOJOS = articleDAO.quaryImgByartID(joinQueryDataModel.getAp().getArticle_id());
                joinQueryDataModel.getAp().setImagePOJOS(imagePOJOS);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fronttext = req.getParameter("text");
        if (fronttext.equals("$_init_load")) {
            JSONArray ja = JSONArray.fromObject(this.jqmList);
            System.out.println(ja);
            resp.setCharacterEncoding("utf-8");
            resp.getWriter().write(ja.toString());
            return;
        }
        fronttext = fronttext.equals("$_all") ? "" : fronttext;
        Date datebegin = Date.valueOf(req.getParameter("datebegin"));
        Date dateend = Date.valueOf(req.getParameter("dateend"));
        System.out.println(dateend);
        String frontstr[] = fronttext.split("/+");

        System.out.println("fronttext==" + fronttext + "==" + frontstr.length + "datebegin" + datebegin + "dateend" + dateend);
        try (UserDAO ud = new UserDAO();
             ArticleDAO articleDAO = new ArticleDAO()) {
            this.quaryList = ud.quaryArtAnduser(frontstr, new Date[]{datebegin, dateend});
            this.quaryList = this.quaryMathLis(this.quaryList);
            for (int i = 0; i < quaryList.size(); i++) {
                JoinQueryDataModel joinQueryDataModel = quaryList.get(i);
                List<ImagePOJO> imagePOJOS = articleDAO.quaryImgByartID(joinQueryDataModel.getAp().getArticle_id());
                joinQueryDataModel.getAp().setImagePOJOS(imagePOJOS);

            }
            System.out.println(quaryList);
            JSONArray ja = JSONArray.fromObject(quaryList);
            System.out.println(ja);
            resp.setCharacterEncoding("utf-8");
            resp.getWriter().write(ja.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        quaryList = QuaryUserArtServlet.quaryMathLis(quaryList);
        System.out.println(quaryList.toString());
    }

}
