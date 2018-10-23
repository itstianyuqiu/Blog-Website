
package Utilities;

import POJO.UserPOJO;
import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.List;
import java.util.Properties;


public class EmailUtil {
    private  static Properties emailProperties;
    private static Session mailSession;
    private  static MimeMessage emailMessage;
    private EmailUtil() {//can't get this object only can use the static method
    }
        public static void sendResetPasswordEmail(List<UserPOJO> userPOJOs,String emailSubject ,String msgBody) throws MessagingException {
            setMailServerProperties();
            createEmailMessage( userPOJOs,emailSubject ,msgBody);
            sendEmail();//here will throw a exception to tll the manager
        }

        private  static void setMailServerProperties() {
            String emailPort = "587";// gmail's smtp port ,smtp is send service ,pop3 is receive service
            emailProperties = System.getProperties();
            emailProperties.put("mail.smtp.port", emailPort);
            emailProperties.put("mail.smtp.auth", "true");
            emailProperties.put("mail.smtp.starttls.enable", "true");
        }

        private  static void createEmailMessage(List<UserPOJO> userPOJOs,String emailSubject ,String msgBody) throws AddressException, MessagingException {

            mailSession = Session.getDefaultInstance(emailProperties, null);
            emailMessage = new MimeMessage(mailSession);
            for (int i = 0; i < userPOJOs.size(); i++) {
                emailMessage.addRecipient(Message.RecipientType.TO,
                        new InternetAddress(userPOJOs.get(i).getEmail()));
            }
            emailMessage.setSubject(emailSubject);
            emailMessage.setContent(msgBody, "text/html");// for a html email
            // emailMessage.setText(emailBody);// for a text email
        }

        private  static void sendEmail() throws AddressException, MessagingException{
        String emailHost = "smtp.gmail.com";
        String fromUser = "cycycyjing";// just the id alone without // @gmail.com
        String fromUserEmailPassword = "JINGcycy.0303"; //your gmail password
        Transport transport = mailSession.getTransport("smtp");
        transport.connect(emailHost, fromUser, fromUserEmailPassword);
        transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
        transport.close();
    }





}
