<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8");  %>

<%
String str = request.getParameter("post");
if(str != null && str.equals("post")) {
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	cont = cont.replaceAll("\n", "<br>");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?user=root&password=2883896960&useSSL=false");
	conn.setAutoCommit(false);
	
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = conn.prepareStatement("insert into article values (null, 0, -1, ?, ?, now(), 0)", Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, title);
	pstmt.setString(2, cont);
	pstmt.executeUpdate();
	ResultSet rsKeys = pstmt.getGeneratedKeys();
	rsKeys.next();
	stmt.executeUpdate("update article set rootid = " + rsKeys.getInt(1) + " where id = " + rsKeys.getInt(1));
	rsKeys.close();
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("ShowArticleTree.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="Post.jsp" method="post">
	<input type="hidden" name="post" value="post">
	<table border=1>
		<tr>
			<td>
				<b>Title: <input type="text" name="title" size=70></b>
			</td>
		</tr>
		<tr>
			<td>
				Content below: 
			</td>
		</tr>
		<tr>
			<td>
				<textarea cols=80 rows=12 name="cont"></textarea>
			</td>
		</tr>
		<tr>
			<td align="center">
				<input type="submit" value="提交">
			</td>
		</tr>
	</table>

</form>
</body>
</html>