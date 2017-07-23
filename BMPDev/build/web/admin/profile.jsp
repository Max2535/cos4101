<%-- 
    Document   : profile
    Created on : Jul 16, 2017, 10:51:07 AM
    Author     : Max
--%>

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
	Object strUserID = session.getAttribute("sUserID");
	if(strUserID == null) // Check Login
	{
		response.sendRedirect("index.jsp");
	}
	
	Connection connect = null;
	Statement s = null;
	
	try {
		Class.forName(configmysql.mysqljdbc);
		
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
                
		s = connect.createStatement();
		
		
		String sql = "SELECT * FROM  member WHERE UserID = '" + strUserID.toString() + "' ";
		
		ResultSet rec = s.executeQuery(sql);
		if(rec.next())
		{
		%>
		
			 Profile<br>
			  <table border="1" style="width: 300px">
			    <tbody>
			      <tr>
			        <td> &nbsp;UserID</td>
			        <td>
			          <%=rec.getString("UserID") %>
			        </td>
			      </tr>
			      <tr>
			        <td> &nbsp;Username</td>
			        <td>
			          <%=rec.getString("Username") %>
			        </td>
			      </tr>
			      <tr>
			        <td> &nbsp;Password</td>
			        <td>
			          <%=rec.getString("Password") %>
			        </td>
			      </tr>
			      <tr>
			        <td> &nbsp;Email</td>
			        <td>
			          <%=rec.getString("Email") %>
			        </td>
			      </tr>		
			      <tr>
			        <td> &nbsp;Name</td>
			        <td>
			          <%=rec.getString("Name") %>
			        </td>
			      </tr>	   
			    </tbody>
			  </table>
			  <br>	
	     <%} %>
	    <%	
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

