<%-- 
    Document   : edit
    Created on : Jul 16, 2017, 10:35:47 AM
    Author     : Max
--%>

<%@page import="data.configmysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	Connection connect = null;
	Statement s = null;
	
	try {
		
		Class.forName(configmysql.mysqljdbc);
		
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
		
		s = connect.createStatement();
		String CusID = request.getParameter("CusID");
		String sql = "SELECT * FROM  customer WHERE CustomerID = '" + CusID + "'  ";
		
		ResultSet rec = s.executeQuery(sql);
		if(rec != null) {
			rec.next();
		%>
	<form name="frmUpdate" method="post" action="save.jsp?CusID=<%=rec.getString("CustomerID")%>">	
		Update Form
			<table width="428" border="1">	
			<tr>
				<th width="181">
				<div align="left">CustomerID </div></th>
				<td width="231"><%=rec.getString("CustomerID")%></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Name </div></th>
				<td><input type="text" name="txtName" size="20" value="<%=rec.getString("Name")%>"></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Email </div></th>
				<td><input type="text" name="txtEmail" size="20" value="<%=rec.getString("Email")%>"></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">CountryCode </div></th>
				<td><input type="text" name="txtCountryCode" size="2" value="<%=rec.getString("CountryCode")%>"></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Budget </div></th>
				<td><input type="text" name="txtBudget" size="5" value="<%=rec.getFloat("Budget")%>"></td>
			</tr>
			<tr>
				<th width="181">
				<div align="left">Used </div></th>
				<td><input type="text" name="txtUsed" size="5" value="<%=rec.getFloat("Used")%>"></td>
			</tr>
			</table> 
		<input type="submit" value="Save">
		</form> 
		
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
