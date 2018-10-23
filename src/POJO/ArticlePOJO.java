package POJO;

import java.util.List;

public class ArticlePOJO implements Comparable<ArticlePOJO>{
    private int article_id;
    private String title;
    private String content;
    private int author_id;
    private boolean article_visibility;
    private String article_date;
    private String article_audio;
    private String article_video;
    private String article_Youtube;
    private List<ImagePOJO> imagePOJOS;

    public List<ImagePOJO> getImagePOJOS() {
        return imagePOJOS;
    }

    public void setImagePOJOS(List<ImagePOJO> imagePOJOS) {
        this.imagePOJOS = imagePOJOS;
    }

    public String getArticle_audio() {
        return article_audio;
    }

    public String getArticle_video() {
        return article_video;
    }

    public String getArticle_Youtube() {
        return article_Youtube;
    }

    public void setArticle_audio(String article_audio) {
        this.article_audio = article_audio;
    }

    public void setArticle_video(String article_video) {
        this.article_video = article_video;
    }

    public void setArticle_Youtube(String article_Youtube) {
        this.article_Youtube = article_Youtube;
    }

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

    public void setArticle_date(String article_date) {
        this.article_date = article_date;
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

    public String getArticle_date() {
        return article_date;
    }


    @Override
    public int compareTo(ArticlePOJO o) {
        if (this.getTitle().toCharArray()[0]<o.getTitle().toCharArray()[0]) {
            return 1;
        } else {
            return -1;
        }
    }
}
