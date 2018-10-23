package Utilities;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;



public class ConnectUtil {
        private static final String USER_AGENT = "Mozilla/5.0";//设置用户系统 确定回传的参数格式
    /**
     *  HTTP GET请求
     * @param url  传入一个连接
     * @param map  传入一个连接参数
     * @return  返回一个字符集
     * @throws Exception  所有异常自己处理
     */
        public static String sendGet(String url, Map<String,String> map) throws Exception {
                    //创建连接
            url=url+changeMapToParameters(map);
            URL obj = new URL(url);
            //建立连接通达
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            //设置连接模式  默认为GET
            con.setRequestMethod("GET");
            //添加请求头
            con.setRequestProperty("User-Agent", USER_AGENT);
            //获取响应
            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'GET' request to URL : " + url);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            //打印结果
            System.out.println(response.toString());
                return  response.toString();
        }
        // HTTP POST请求
        public static String sendPost(String url, Map<String,String> map) throws Exception {
            URL obj = new URL(url);
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
            //添加请求头
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", USER_AGENT);
            con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
                //请求参数
            String urlParameters = changeMapToParameters(map).substring(1);

            //发送Post请求
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + url);
            System.out.println("Post parameters : " + urlParameters);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            //打印结果
            System.out.println(response.toString());
            return response.toString();
        }
        public static String changeMapToParameters(Map<String,String> map){
            String str="";
            for (Map.Entry<String, String> entry : map.entrySet()) {
              str +="&"+entry.getKey() +"="+ entry.getValue();
            }
            if (!str.equals("")){
               str="?"+ str.substring(1);
            }
            return str;
        }

    public static void main(String[] args) {
        ConnectUtil con=new ConnectUtil();
        Map<String ,String>  map=new HashMap<>();
        map.put("secret","6Lfkp3UUAAAAALjvR0nxlCj1frd1n7qv6Legj2ju");
        map.put("response","03AMGVjXix27kmn580lWoJAC35Tds0LqfRf5i37Jk3czTlQuIf6dmt0YoEge0m4a3ucV-yZz7nsqj3qnOVMZTgq9VKxNuBCmdQkrnwKavPsthg5dHWJPqFOD08MXCl9MTVcMGT2su3nx84xudiprNUB9upFaJcxkp0mSFm3riO3K2oKTMZXCv0cMoJaWWu2BWljhf6soANmVdpkm_9V9w12AtIb36WL5_Af_5hlPadCeTmQIArImAKTAB1DSB4MoLuir6NyBIW0lsHS0EWacwXUP5_PlXuH69ZYw");
        String sTR= null;
        try {
            sTR = con.sendPost("https://recaptcha.net/recaptcha/api/siteverify",map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(sTR+"这个是验证中的");
    }
    }

