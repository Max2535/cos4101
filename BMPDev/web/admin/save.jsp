<%-- 
    Document   : save
    Created on : Jul 16, 2017, 10:41:10 AM
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
		
		String strCustomerID = request.getParameter("CusID");
		String strName = request.getParameter("txtName");
		String strEmail = request.getParameter("txtEmail");
		String strCountryCode = request.getParameter("txtCountryCode");
		float intBudget = Float.valueOf(request.getParameter("txtBudget"));
		float intUsed = Float.valueOf(request.getParameter("txtUsed"));
		
		
		String sql = "UPDATE customer " +
				"SET Name = '"+ strName + "' " +
				", Email = '"+ strEmail + "' " +
				", CountryCode = '"+ strCountryCode + "' " +
				", Budget = '"+ intBudget + "' " +
				", Used = '"+ intUsed + "' " +
				" WHERE CustomerID = '" + strCustomerID + "' ";
         s.execute(sql);
        
         out.println("Record Update Successfully");
	  		
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

