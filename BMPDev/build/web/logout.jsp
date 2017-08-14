<%-- 
    Document   : logout
    Created on : Aug 3, 2017, 7:09:16 PM
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>logout</title>
    </head>
    <body>
        	<%
		Connection connect = null;
		Statement s = null;
		
		try {
			Class.forName(configmysql.mysqljdbc);
                        connect =  DriverManager.getConnection(configmysql.mysqlserver);
			
			Object strUserID = session.getAttribute("sUserID");
			s = connect.createStatement();
                        String sql = "UPDATE member SET online = '0' WHERE UserID = "+strUserID+";";
                        //out.print(sql);
                        response.sendRedirect("/BMPDev/index.jsp");
                        s.execute(sql);			
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
	session.removeAttribute("sUserID");	
	session.removeAttribute("Type");	
	%>  
    </body>
</html>
