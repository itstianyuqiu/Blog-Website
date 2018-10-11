package POJO;

public class UserAvatarPOJO {
    private String avatar;
    private UserPOJO userPOJO;

    public UserAvatarPOJO(String avatar) {
        this.avatar = avatar;
    }


    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public UserPOJO getUserPOJO(UserPOJO userPOJO) {
        return this.userPOJO = userPOJO;
    }
}
