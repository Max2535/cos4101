 <%-- 
     Document   : edit
     Created on : Jul 16, 2017, 10:35:47 AM
     Author     : Max
 --%>
<jsp:include page="admin.jsp"/>
 <%@page import="data.configmysql"%>
 <%@page contentType="text/html" pageEncoding="UTF-8"%>
 <!DOCTYPE html>
 <%@ page import="java.sql.ResultSet" %>
 <%@ page import="java.sql.SQLException" %>
 <%@ page import="java.sql.Statement" %>
 <%@ page import="java.sql.Connection" %>
 <%@ page import="java.sql.DriverManager" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 
 <html lang="en">
 
 <head>
 
     <meta charset="utf-8">
     <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <meta name="description" content="">
     <meta name="author" content="">
 
     <title>Modern Business - Start Bootstrap Template</title>
 
     <!-- Bootstrap Core CSS -->
     <link href="/BMPDev/css/bootstrap.min.css" rel="stylesheet">
     <!-- Custom max -->
     <link href="/BMPDev/css/crud.css" rel="stylesheet">
 
     <!-- Custom CSS -->
     <link href="/BMPDev/css/modern-business.css" rel="stylesheet">
 
     <!-- Custom Fonts -->
     <link href="/BMPDev/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
 
     <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
     <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
     <!--[if lt IE 9]>
         <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
         <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
     <![endif]-->
 
     <!-- MetisMenu CSS -->
     <link href="/BMPDev/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
 
     <!-- Social Buttons CSS -->
     <link href="/BMPDev/vendor/bootstrap-social/bootstrap-social.css" rel="stylesheet">
 
     <!-- Custom CSS -->
     <link href="/BMPDev/dist/css/sb-admin-2.css" rel="stylesheet">
 
     <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
     <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
     <!--[if lt IE 9]>
         <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
         <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
     <![endif]-->
 
 </head>
 <body>
 	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
         <div class="container">
             <!-- Brand and toggle get grouped for better mobile display -->
             <div class="navbar-header">
                 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"style="padding-left:  20px;">
                     <span class="sr-only">Toggle navigation</span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                 </button>
                 <a class="navbar-brand" href="index.jsp">แก้ไข้ข้อมูลการคืนมอเตอร์ไซค์</a>
                 
             </div>
             
             <!-- Collect the nav links, forms, and other content for toggling -->
             <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                 
                 <ul class="nav navbar-nav navbar-right">
                    
                     <li>
                         <a href="#">เพิ่มเมนู</a>
                     </li>
                     
                 </ul>
             </div>
             <!-- /.navbar-collapse -->
         </div>
         <!-- /.container -->
     </nav>
 	<%
 	String StandID = "";
 	if(request.getParameter("StandID") != null) {
 		StandID = request.getParameter("StandID");
 	}
 	
 	Connection connect = null;
 	Statement s = null;
 	
 	try {
 		Class.forName(configmysql.mysqljdbc);
 		
 		connect =  DriverManager.getConnection(configmysql.mysqlserver);
 		
 		s = connect.createStatement();
 		
 		String sql = "SELECT * FROM  stand WHERE StandID = '"+StandID+"'";
 		
 		ResultSet rec = s.executeQuery(sql);
 		if(rec != null) {
 			rec.next();
 		%>
                 <div class="container">
                 <div class="row">
                         <div class="panel-body">
 	<form name="frmUpdate" method="post" action="/BMPDev/admin/stand/save.jsp?StandID=<%=rec.getString("StandID")%>">	
 		<table class="table table-striped table-bordered table-hover">
                                     <tbody>                                  
                                         <tr>
                                             <td align="center">StandID:<input type="text" name="StandID" value="<%=rec.getString("StandID")%>" disabled></td>
                                             <td align="center">UserID:<input type="text" name="UserID" value="<%=rec.getString("UserID")%>" disabled></td>
                                             <td align="center">MotorCycleID:<input type="text" name="MotorCycleID"  value="<%=rec.getString("MotorCycleID")%>" disabled></td>
                                             <td align="center">Data:<input type="text" name="Data"  value="<%=rec.getString("Data")%>"></td>
                                             <td align="center">ExpiredDate:<input type="text" name="ExpiredDate" value="<%=rec.getString("ExpiredDate")%>" disabled></td>
                                         </tr>
                                     </tbody>
                                 </table>
 		<input type="submit" value="Save">
 		</form> 
                         </div>
                 </div>
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
                 <hr>
         <!-- Footer -->
         <footer>
             <div class="row">
                 <div class="col-lg-12">
                     <p>Copyright &copy; <%out.print(configmysql.website);%></p>
                 </div>
             </div>
         </footer>
 
     </div>
     <!-- /.container -->
 
     <!-- jQuery -->
     <script src="/BMPDev/js/jquery.js"></script>
 
     <!-- Bootstrap Core JavaScript -->
     <script src="/BMPDev/js/bootstrap.min.js"></script>
 
     <!-- Script to Activate the Carousel -->
     <script>
     $('.carousel').carousel({
         interval: 5000 //changes the speed
     })
     </script>
 </body>
 </html>