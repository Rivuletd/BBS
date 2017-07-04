<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String action = request.getParameter("login");
if(action!=null && action.equals("login")){
	String username = request.getParameter("u");
	String password = request.getParameter("p");
	if(username==null || !username.equals("admin") || password==null || !password.equals("admin")){
		//out.println("Username or passwor not correct!");
		%>
		<font color="white">Username or passwor not correct!</font>
		<%
	} else {
		//out.println("Welcome admin!");
		session.setAttribute("admin", "true");
		response.sendRedirect("ShowArticleTree.jsp");
	}
}
%>
<html>  
<head>  
    <title>Login</title>  
    <link rel="stylesheet" type="text/css" href="CSS/Login.css"/>  
</head>  
<body>  
    <div id="login">  
        <h1>Login</h1>  
        <form method="post" action="Login.jsp">
        	<input type="hidden" name="login" value="login">  
            <input type="text" required="required" placeholder="用户名" name="u"></input>  
            <input type="password" required="required" placeholder="密码" name="p"></input>  
            <button class="but" type="submit">登录</button>  
        </form>  
    </div>  
</body>  
</html>  