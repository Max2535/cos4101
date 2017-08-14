<%-- 
    Document   : index
    Created on : Jul 25, 2017, 3:59:22 PM
    Author     : Max
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Object Page = session.getAttribute("Page");
    if(Page!=null)
    {
        session.setAttribute("Page",null);
        response.sendRedirect("/BMPDev/delcount.jsp");
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="data.configmysql"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	Connection connect = null;
	Statement s = null;
	String id = request.getParameter("id");
	try {
		Class.forName(configmysql.mysqljdbc);
		connect =  DriverManager.getConnection(configmysql.mysqlserver);
		
		s = connect.createStatement();
		
		String sql = "SELECT * FROM motorcycle;";
		
		ResultSet rec = s.executeQuery(sql);
		%>  
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><%
        out.print(configmysql.title);
        %></title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp"><%
        out.print(configmysql.title);
        %></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="login.jsp">login</a>
                    </li>
                    <li>
                        <a href="register.jsp">register</a>
                    </li>
                    <li>
                        <a href="logout.jsp">logout</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">

        <!-- Page Heading/Breadcrumbs -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">ร้าน BMP
                    <small>บริการจองรถมอเตอร์ไซค์ออนไลน์</small>
                </h1>
            </div>
        </div>
        <!-- /.row -->
<!-- Portfolio Section -->
        <div class="row">
            <%while((rec!=null) && (rec.next())) { %>
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">                     
                    <a href="info.jsp?id=<%=rec.getString("MotorCycleID")%>"><img src="<%=rec.getString("thumbnail")%>" width="1000" height="492" alt="<%=rec.getString("BrandMotorCycle")%>" data-holder-rendered="true" style="height: 200px; width: 70%; display: block;"/></a>
                    <div class="caption" style=" text-align: center"> <h3>ราคา:<%=rec.getInt("Price")%>.-บาท</h3><p>
                                                <a href="info.jsp?id=<%=rec.getString("MotorCycleID")%>" class="btn btn-primary" role="button">จอง</a>
                                                <a href="info.jsp?id=<%=rec.getString("MotorCycleID")%>" class="btn btn-default" role="button">รายละเอียด</a></p> 
                                        </div> 
                </div> </div> 
            <%}%>
                                </div>
        <!-- /.row -->

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
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>

       <%	
		} catch (Exception e) {
			// TODO Auto-generated catch block
                        out.print("<script>alert('ไม่พบข้อมูล')</script>");
			out.println(e.getMessage());
			e.printStackTrace();
                        response.sendRedirect("/BMPDev/admin/index.jsp");
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