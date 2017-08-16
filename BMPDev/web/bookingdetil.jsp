<%-- 
    Document   : bookingdetil
    Created on : Aug 12, 2017, 4:59:09 PM
    Author     : Max
--%>
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
        connect = DriverManager.getConnection(configmysql.mysqlserver);

        s = connect.createStatement();

        String sql = "SELECT * FROM motorcycle where motorcycle.MotorCycleID=" + id + ";";

        ResultSet rec = s.executeQuery(sql);
        rec.first();
        rec.getString("image1");
%>                   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Modern Business - Start Bootstrap Template</title>

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
                    <a class="navbar-brand" href="index.html">Start Bootstrap</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="about.html">About</a>
                        </li>
                        <li>
                            <a href="services.html">Services</a>
                        </li>
                        <li>
                            <a href="contact.html">Contact</a>
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
                    <br>
                    <ol class="breadcrumb">
                        <li><a href="index.html">Home</a>
                        </li>
                        <li class="active">จองรถมอเตอร์ไซค์:<%=rec.getString("BrandMotorCycle")%></li>
                    </ol>
                </div>
            </div>
            <!-- /.row -->

            <!-- Portfolio Item Row -->
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3>รายละเอียดการจอง</h3>
                    </div>
                    <div class="panel-body">
                        <h4>
                            <center>
                                <table border="0" style="width: 50%">
                                    <tbody>
                                        <tr>
                                            <td>ยี่ห้อ,ยี่ห้อ</td>
                                            <td><%=rec.getString("BrandMotorCycle")%></td>
                                        </tr>
                                        <tr>
                                            <td>ราคา</td>
                                            <td><%=rec.getInt("Price")%>.- บาท</td>
                                        </tr>
                                        <tr>
                                            <td>วันที่รับรถ</td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>วันที่ส่งคืนรถ</td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </center>
                        </h4>
                    </div>
                    <div class="panel-footer">
                        ชื่อสมาชิก
                    </div>
                </div>




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
        //response.sendRedirect("/BMPDev/admin/index.jsp");
    }

    try {
        if (s != null) {
            s.close();
            connect.close();
        }
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println(e.getMessage());
        e.printStackTrace();
    }
%>