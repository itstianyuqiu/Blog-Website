package POJO;

public class AdminPOJO {
    private int admin_id;
    private String adminName;
    private String adminUsername;
    private String password;
    private String createdDate;
    //0:high level(add,delete,update users and other admins)
    //1:low level(only can add,delete,update users)
    private int authority;


    public AdminPOJO() {
    }

    @Override
    public String toString() {
        return "AdminPOJO{" +
                "admin_id=" + admin_id +
                ", adminName='" + adminName + '\'' +
                ", adminUsername='" + adminUsername + '\'' +
                ", password='" + password + '\'' +
                ", createdDate='" + createdDate + '\'' +
                ", authority=" + authority +
                '}';
    }

    public AdminPOJO(int admin_id, String adminName, String adminUsername, String password, String createdDate, int authority) {
        this.admin_id = admin_id;
        this.adminName = adminName;
        this.adminUsername = adminUsername;
        this.password = password;
        this.createdDate = createdDate;
        this.authority = authority;
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminUsername() {
        return adminUsername;
    }

    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getAuthority() {
        return authority;
    }

    public void setAuthority(int authority) {
        this.authority = authority;
    }
}
