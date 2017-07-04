<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
String admin = (String)session.getAttribute("admin");
if(admin != null && admin.equals("true")) {
	login = true;
}
%>

<%!
String str = "";
boolean login = false;
private void tree (Connection conn, int id, int level) {
	Statement stmt = null;
	ResultSet rs = null;
	String prestr = "";
	for(int i = 0; i<level; i++) {
		prestr += "----";
	}
	try {
		stmt = conn.createStatement();
		String sql = "select * from article where pid = " + id;
		rs = stmt.executeQuery(sql);
		String loginStr ="";
		while(rs.next()) {
			if(login) {
				loginStr = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid="+rs.getInt("pid")+"'>" + "删除</a></td>";
			}
			str += "<tr><td>" + rs.getInt("id") + "</td><td><a href= 'ShowArticleDetail.jsp?id=" + rs.getInt("id")+ "'>" + prestr + rs.getString("title") + 
					  "</a></td>" +loginStr+ "</tr>";
			tree(conn, rs.getInt("id"), level + 1);
		}
	} catch(SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
			if(stmt != null) {
				stmt.close();
				stmt =null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
%>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager
		.getConnection("jdbc:mysql://localhost/bbs?user=root&password=2883896960&useSSL=false");
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where pid = 0");
String loginStr = "";
while(rs.next()) {
	if(login) {
		loginStr = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid="+rs.getInt("pid")+"'>" + "删除</a></td>";
	}
	str += "<tr><td>" + rs.getInt("id") + "</td><td><a href= 'ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") + 
			  "</a></td>" +loginStr+ "</tr>";
	tree(conn, rs.getInt("id"), 1);
}
login = false;
rs.close();
stmt.close();
conn.close();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main page</title>
</head>
<body>
	<a href="Post.jsp">发表主题</a>
	<table border="1">
	<%=str %> 
	<% str = ""; %>
	</table>
</body>

</html>