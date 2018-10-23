package POJO;

public class JoinQueryDataModel implements Comparable<JoinQueryDataModel>{
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

    @Override
    public int compareTo(JoinQueryDataModel o) {
        if (this.getAp().getTitle().toCharArray()[0]<o.getAp().getTitle().toCharArray()[0]) {
            return -1;
        } else {
            return 1;
        }
    }
}
