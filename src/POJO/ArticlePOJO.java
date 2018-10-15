package POJO;

public class ArticlePOJO {
    private int article_id;
    private String title;
    private String content;
    private int author_id;
    private boolean article_visibility;

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

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public void setArticle_visibility(boolean article_visibility) {
        this.article_visibility = article_visibility;
    }

    public boolean isArticle_visibility() {
        return article_visibility;
    }
}
