package POJO;

public class JoinQueryDataModel {
    private UserPOJO up;
    private CommentsPOJO cp;
    private ArticlePOJO ap;


    public UserPOJO getUp() {
        return up;
    }

    public void setUp(UserPOJO up) {
        this.up = up;
    }

    public CommentsPOJO getCp() {
        return cp;
    }

    public void setCp(CommentsPOJO cp) {
        this.cp = cp;
    }

    public ArticlePOJO getAp() {
        return ap;
    }

    public void setAp(ArticlePOJO ap) {
        this.ap = ap;
    }
}
