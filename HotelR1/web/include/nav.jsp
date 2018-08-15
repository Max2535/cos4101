<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="ClassSystem.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom:10px">
    <div class="navbar-header">
        <!--ตรงนี้ต้องมีการตรวจสอบ ว่าทำอะไรค้างไวไม่-->
        <a class="navbar-brand" href="../systems/dashboard.jsp" style="color: #fefefe;"><i class="glyphicon glyphicon-dashboard"></i> Menu</a>
    </div>
    <!-- /.navbar-header -->
    <div class="navbar-right" style="margin-left: 15px;margin-right: 10px;margin-top: 15px">
        <%
            Condb db_money = new Condb();
            ResultSet rs_money = db_money.ConExecuteQuery("SELECT * FROM money  where staff_id=" + staff.getStaff_id());

            float sum_money_staff = 0.0f;
            while (rs_money.next()) {
                sum_money_staff += rs_money.getInt("money_value");
            }
        %>
        <a href="../systems/money_sum.jsp"><b class="alert-warning" style="padding: 5px">ยอดเงินที่ผู้ใช้รับมา <%=sum_money_staff%>.-</b></a>
        <b id="txt" style="color: #fefefe;"></b>
        <a href="#"  style="color: #fefefe"><i class="fa fa-user fa-fw"></i> <%=staff.getStaff_name()%></a>
        <a href="../systems/logout.jsp?id=0">Logout</a>
    </div>
    <!-- /.navbar-top-links -->
</nav> 