<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");  %>

<%
int id = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="ReplyOK.jsp" method="post">
	<input type="hidden" name="id" value="<%=id %>">
	<input type="hidden" name="rootid" value="<%=rootid %>">
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
				<input type="submit" value="提交回复">
			</td>
		</tr>
	</table>

</form>
</body>
</html>