<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%!
private void delete (Connection conn, int id) {
	Statement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = " + id);
		while(rs.next()) {
			delete(conn, rs.getInt("id"));
		}
		stmt.executeUpdate("delete from article where id = " + id);
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
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager
		.getConnection("jdbc:mysql://localhost/bbs?user=root&password=2883896960&useSSL=false");
conn.setAutoCommit(false);

delete(conn, id);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);
rs.next();
int count = rs.getInt(1);
if(count <= 0) {
	Statement stmtUpdate = conn.createStatement();
	stmtUpdate.executeUpdate("update article set isleaf=0 where id = " + pid);
	stmtUpdate.close();
}

conn.commit();
conn.setAutoCommit(false);

rs.close();
stmt.close();
conn.close();
response.sendRedirect("ShowArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main page</title>
</head>
<body>
	<table border="1">
	</table>
</body>

</html>