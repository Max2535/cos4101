<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 99;
    session = request.getSession();
    boolean flag_login = true;
    if (session.getAttribute("flag_login") != null) {
        flag_login = (Boolean) session.getAttribute("flag_login");
        if (flag_login == false) {
            response.sendRedirect("look.jsp");
        }
    }
    if (session.getAttribute("staff") != null) {
        response.sendRedirect("dashboard.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%=Systems.Data.title%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="../img/favicon.ico">
        <meta name="author" content="Suppchai kalmro">
        <!-- Bootstrap Core CSS -->
        <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom Fonts -->
        <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script>
            function get(id) {
                var x = document.getElementById(id);
                return x;
            }
        </script>
    </head>
    <body>
        <div class="container">            
            <div class="row">
                <div class="col-md-4 col-md-offset-4"  style="margin-top: 50px">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading text-center">
                            <h4 class="panel-heading"><i class="fa fa-user"></i> Authentication:<small><%=Systems.Data.title%></small></h4>
                            <b id="txt"></b>
                        </div>
                            <div class="panel-body">
                            <form role="form" action="../authentication_login" method="post">
                                <div class="form-group input-group">
                                    <span class="input-group-addon"><i class="fa fa-key"></i>
                                    </span>
                                    <input type="password" name="staff_code" class="form-control" placeholder="กรุณาระบุรหัสพนักงาน" required="true" autofocus="true">
                                </div>
                                <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-log-in"></i> เข้าสู่ระบบ</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
