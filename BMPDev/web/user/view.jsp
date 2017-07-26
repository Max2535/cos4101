<%-- 
    Document   : view
    Created on : Jul 16, 2017, 9:41:52 AM
    Author     : Max
--%>
<%
        Object strUserID = session.getAttribute("sUserID");
        Object Type = session.getAttribute("Type");
	if(strUserID == null&&Type==null) // Check Login
	{
            response.sendRedirect("/BMPDev/index.jsp"); 
            out.print("<script>alert('คุณยังไม่ได้เข้าสู้ระบบ กรุณาเข้าสู่ระบบด้วย');</script>");
                             
	}
        else if(!Type.equals("user"))
                {
                  response.sendRedirect("/BMPDev/index.jsp");
                }
%>
<%@page import="data.configmysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
	<title>ThaiCreate.Com JSP Tutorial</title>
</head>
<body>
	
	<%
	String CusID = "";
	if(request.getParameter("CusID") != null) {
		CusID = request.getParameter("CusID");
	}
	
	Connection connect = null;
	Statement s = null;
	
	try {
		Class.forName(configmysql.mysqljdbc);
		
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
		
		s = connect.createStatement();
		
		String sql = "SELECT * FROM  customer WHERE CustomerID = '" + CusID + "'  ";
		
		ResultSet rec = s.executeQuery(sql);
		if(rec != null) {
			rec.next();
		%>
			<table width="428" border="1">	
			<tr>
				<th width="181">
				<div align="left">CustomerID </div></th>
				<td width="231"><%=rec.getString("CustomerID")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Name </div></th>
				<td><%=rec.getString("Name")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Email </div></th>
				<td><%=rec.getString("Email")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">CountryCode </div></th>
				<td><%=rec.getString("CountryCode")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Budget </div></th>
				<td><%=rec.getFloat("Budget")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Used </div></th>
				<td><%=rec.getFloat("Used")%></td>
			</tr>
			</table> 

		
		<% }
	  		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>
</body>
</html>
