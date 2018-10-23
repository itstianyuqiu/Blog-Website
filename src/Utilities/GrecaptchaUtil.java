package Utilities;

import java.util.HashMap;
import java.util.Map;

public class GrecaptchaUtil {
    public static Boolean grecaptcha(String grecaptcha){

        Map<String ,String> map=new HashMap<>();
        map.put("secret","6Lfkp3UUAAAAALjvR0nxlCj1frd1n7qv6Legj2ju");
        map.put("response",grecaptcha);
        String str= "";
        try {
            str = ConnectUtil.sendPost("https://recaptcha.net/recaptcha/api/siteverify",map);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        System.out.println(sTR);
        str= str.substring(1,str.length()-1);
        str=str.replaceAll("\"", "");
        String strs[]=str.split(",");
        String successStrs[]=strs[0].trim().split(":");
        System.out.println(successStrs[0]+"11111111111"+successStrs[1]);
        if(successStrs[0].trim().equals("success")&&successStrs[1].trim().trim().equals("true")){
            return true;
        }else {
            return false;
        }

    }
}
