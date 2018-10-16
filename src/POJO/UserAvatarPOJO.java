package POJO;

public class UserAvatarPOJO {
    private String avatar;
    //    private UserPOJO userPOJO;
    private int user_id;

    public UserAvatarPOJO() {
        this.avatar = "images/";
    }

    public UserAvatarPOJO(String avatar) {
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

//    public UserPOJO getUserPOJO(UserPOJO userPOJO) {
//        return this.userPOJO = userPOJO;
//    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
}
