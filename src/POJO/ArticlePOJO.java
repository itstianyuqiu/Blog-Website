package POJO;

public class ArticlePOJO {
    private int article_id;
    private String title;
    private String content;

    public ArticlePOJO(){

    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) { this.title = title; }
}
