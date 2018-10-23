<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
		<head>
				<base href="<%=basePath%>">
				<title>My JSP 'Error.jsp' starting page</title>
				<meta http-equiv="pragma" content="no-cache">
				<meta http-equiv="cache-control" content="no-cache">
				<meta http-equiv="expires" content="0">
				<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
				<meta http-equiv="description" content="This is my page">
			<style>
				div{
					width: 300px;
					height: 300px;
					margin: 200px auto;
					border-radius: 20px;
					background-color: #eeeeee;
				}
				h3{
					color: #e53359;
					margin: 50px auto;
				}
				button{
					width: 80px;
					height: 40px;
					background-color: #3dbaf4;
					border-radius: 6px;
					margin: 60px auto;
				}
			</style>
		</head>
		<body>

 <div>
	 <h3>  ERROR！connect 404 you connect a wrong page ! you can't find this page in our blog!<br/> </h3>
	 <a href="javascript:history.go(-1)"><button>GO BACK</button></a>
 </div>
		</body>
</html>
