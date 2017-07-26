<%-- 
    Document   : Insert
    Created on : Jul 16, 2017, 10:30:19 AM
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
        else if(!Type.equals("admin"))
                {
                  response.sendRedirect("/BMPDev/index.jsp");
                }
        %>
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

	<form name="frmAdd" method="post" action="add.jsp">	
	Add Form
	<table width="374" border="1">	
  <tr>
	<th width="140">
    <div align="left">CustomerID </div></th>
		<td width="272"><input type="text" name="txtCustomerID" size="5"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Name </div></th>
		<td><input type="text" name="txtName" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Email </div></th>
		<td><input type="text" name="txtEmail" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">CountryCode </div></th>
		<td><input type="text" name="txtCountryCode" size="2"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Budget </div></th>
		<td><input type="text" name="txtBudget" size="5"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Used </div></th>
		<td><input type="text" name="txtUsed" size="5"></td>
	</tr>
	</table>
	<input type="submit" value="Save">
	</form> 
</body>
</html>