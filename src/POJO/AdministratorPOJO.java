package POJO;

public class AdministratorPOJO {
    private int admin_id;
    private String adminName;
    private String password;
    //0:high level(add,delete,update users and other admins)
    //1:low level(only can add,delete,update users)
    private int level;

    public AdministratorPOJO() {
    }

    public AdministratorPOJO(int admin_id, String adminName, String password, int level) {
        this.admin_id = admin_id;
        this.adminName = adminName;
        this.password = password;
        this.level = level;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
