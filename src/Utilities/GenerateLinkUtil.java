package Utilities;
import POJO.UserPOJO;

/**
 *
 * create new account link
 */
public class GenerateLinkUtil {
    private static final String CHECK_CODE = "securityKey";
    /**
     * create password link
     */
    public static String generateResetPwdLink(UserPOJO user) {
        return "http://localhost:8080/admin/password_reset.jsp?userName="
                + user.getUsername() + "&" + CHECK_CODE + "=" + user.getSecurityKey();
    }



}
