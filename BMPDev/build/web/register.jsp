<%-- 
    Document   : register
    Created on : Jul 16, 2017, 10:50:10 AM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@page import="data.delcountpage"%>
<%@page import="data.configmysql"%>
<!DOCTYPE html>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    Object Page = session.getAttribute("Page");
    if (Page == null) {

        Connection connect1 = null;
        Statement s1 = null;

        try {
            Class.forName(configmysql.mysqljdbc);
            connect1 = DriverManager.getConnection(configmysql.mysqlserver);
            s1 = connect1.createStatement();
            String sql1 = "SELECT * FROM  pageconut";
            ResultSet rec1 = s1.executeQuery(sql1);
            rec1.first();
            int tmp = rec1.getInt("count");
            if (tmp > 5) {
                response.sendRedirect("/BMPDev/full.jsp");
            }
            tmp++;
            String sql = "UPDATE `pageconut` SET `count` = '" + tmp + "' WHERE `id` = 1";
            s1.execute(sql);
            session.setAttribute("Page", "Y");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();
        }

        try {
            if (s1 != null) {
                s1.close();
                connect1.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();
        }
    }
%>  
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <script type="text/javascript" src="js/jquery.js"></script>
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
        <!-- This is what you need -->
        <script src="http://numnim.96.lt/dist/sweetalert-dev.js"></script>
        <link rel="stylesheet" href="http://numnim.96.lt/dist/sweetalert.css">
        <style>
            footer{
                margin-left: 15%;
            }
            body{
                background-image:url("../BMPDev/image/bg.png");
            }
            .form-signin {
                max-width: 500px;
                padding: 30px;
                margin: 0 auto;
                background-color: #fff;
                border: 1px solid #e5e5e5;
                -webkit-border-radius: 5px;
                -moz-border-radius: 5px;
                border-radius: 5px;
                -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
                font-family:Tahoma, Geneva, sans-serif;
                color:#000000;
                font-weight:lighter;
            }
            .form-signin .form-signin-heading{
                color:#00A2D1;
            }
            .form-signin input[type="text"],
            .form-signin input[type="password"]{
                font-size: 16px;
                height: 45px;
                padding: 10px;
            }
            .signin-form, .body-container
            {
                margin-top:110px;
            }
            #time {
                border: 3px solid #73AD21;
                position: center;
                padding: 5px;
                top: 10px;
                margin-bottom: 20px;
                width: 300px;
                text-align: center;
                color: #000000;
                font-size: 15px;
                font-family: "Calibri", "Trebuchet MS", sans-serif;
            }
        </style>
        <script type='text/javascript'>//<![CDATA[
            jQuery(function ($) {
                var fiveMinutes = 60 * 5,
                        display = $('#time');
                startTimer(fiveMinutes, display);
            });
            function startTimer(duration, display) {
                var timer = duration, minutes, seconds;
                setInterval(function () {
                    minutes = parseInt(timer / 60, 10)
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.text("เวลาคงเหลือ " + minutes + ":" + seconds);

                    if (--timer < 0) {
                        timer = duration;
                    }
                    if (timer == 0)
                    {
                        swal({
                            title: "เวลาหมด",
                            text: "ต้องการสมัครต่อหรือไม่",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "สมัครต่อ",
                            cancelButtonText: "กลับหน้าเว็บไซต์",
                            closeOnConfirm: false,
                            closeOnCancel: false
                        },
                                function (isConfirm) {
                                    if (isConfirm) {
                                        window.location.href = 'register.jsp';
                                    } else {
                                        window.location.href = 'delcount.jsp';
                                    }
                                });
                    }
                }, 1000);
            }
            //]]> 

        </script>

    </head>
    <body>
        <%
            if (request.getParameter("Action") != null) {
                 String savePath =null;
                //start upload
                //to get the content type information from JSP Request Header
                String contentType = request.getContentType();
                //here we are checking the content type is not equal to Null and

                if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                    DataInputStream in = new DataInputStream(
                            request.getInputStream());
                    //we are taking the length of Content type data
                    int formDataLength = request.getContentLength();
                    byte dataBytes[] = new byte[formDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
                    //this loop converting the uploaded file into byte code
                    while (totalBytesRead < formDataLength) {
                        byteRead = in.read(dataBytes, totalBytesRead,
                                formDataLength);
                        totalBytesRead += byteRead;
                    }
                    String file = new String(dataBytes);
                    //for saving the file name
                    String saveFile = file
                            .substring(file.indexOf("filename=\"") + 10);
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,
                            saveFile.indexOf("\""));
                    int lastIndex = contentType.lastIndexOf("=");
                    String boundary = contentType.substring(lastIndex + 1,
                            contentType.length());
                    int pos;
                    //extracting the index of file 
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    int boundaryLocation = file.indexOf(boundary, pos) - 4;
                    int startPos = ((file.substring(0, pos)).getBytes()).length;
                    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                    // creating a new file with the same name and writing the content in new file

                    savePath = application.getRealPath("\\upload\\" + saveFile);
                    //save to sql :savePath

                    FileOutputStream fileOut = new FileOutputStream(savePath);
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();
                }
                //end upload
                Connection connect = null;
                Statement s = null;
                String username = request.getParameter("username");
                String password = request.getParameter("p1");
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                try {
                    Class.forName(configmysql.mysqljdbc);
                    connect = DriverManager.getConnection(configmysql.mysqlserver);                    
                    s = connect.createStatement();
                    //INSERT INTO `member` (`Username`, `Password`, `Email`, `Name`, `type`, `UserID`, `online`, `image`) VALUES ('test', 'test', 'test', 'test', 'user', NULL, '0', 'image/test.jpg');
                    String sql="INSERT INTO `member` (`Username`, `Password`, `Email`, `Name`, `type`, `UserID`, `online`, `image`) VALUES"
                            + " ('"+username+"', '"+password+"', '"+email+"', '"+name+"', 'user', NULL, '0', '"+savePath+"');";
                    //s.execute(sql);
                    out.print(sql);
                    //response.sendRedirect("/BMPDev/login.jsp");

                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace();
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
    }
%>
    <center>
        <span id="time"></span>
        <br>
        <br>
        <form class="form-signin" name="singinform" method="post" action="register.jsp?Action=Register" onsubmit="return validateForm()" enctype="multipart/form-data">
            <table border="0" style="width: 100%">
                <tbody>
                    <tr>
                        <td>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" name="username" id="username" class="form-control" placeholder="Username" autofocus>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" name="name" class="form-control" placeholder="Name" autofocus>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-inbox"></i></span>
                                <input type="text" name="email" class="form-control" placeholder="E-mail">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
                                <input type="password" name="p1" class="form-control" placeholder="Password">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
                                <input type="password" name="p2" class="form-control" placeholder="Confirm Password">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="form-group">
                                <input type="file" name="fileUpload" class="form-control">
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br>
            <br>
            <button type="submit" name="Submit" value="Singup" class="pull-right btn btn-success"><i class="glyphicon glyphicon-log-in"></i> สมัครใช้งาน</button>
            <br>
        </form>
    </center>
    <script>
        function validateForm() {
            var x = document.forms["singinform"]["p1"].value;
            var y = document.forms["singinform"]["p2"].value;
            var z = document.forms["singinform"]["username"].value;
            var w = document.forms["singinform"]["email"].value;
            if (x === "" || y === "" || z === "" || w === "")
            {
                sweetAlert("Oops...", "กรุณาป้อนข้อมูลให้ครบด้วย", "error");
                return false;
            }
            var atpos = w.indexOf("@");
            var dotpos = w.lastIndexOf(".");
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= w.length)
            {
                sweetAlert("Oops...", "E-Mail ไม่ถูกต้อง", "error");
                return false;
            }
            if (x !== y)
            {
                sweetAlert("Oops...", "รหัสผ่านไม่ตรงกัน", "error");
                return false;
            }
        }
    </script>
    <!-- Footer -->
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p>Copyright &copy; <%out.print(configmysql.website);%></p>
            </div>
        </div>
    </footer>
</body>
</html>
