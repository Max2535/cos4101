<%@page import="ClassSystem.Reservation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Systems.GmailClient"%>
<%@page import="Systems.DateFunc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //ดึงข้อมูลใบสำรองห้องพักมาแสดง
    int id = 0;
    String sql = "";
    String reservertion_id = "";
    ResultSet rs = null;
    Reservation reservation = new Reservation();
    Condb db = new Condb();
    DateFunc date = new DateFunc();
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
        rs = reservation.GetReservation(reservertion_id);
    }
    if (rs.first()) {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">ข้อมูลการอนุมัติการชำระเงิน<small> รหัสใบสำรองห้องพัก:<code><%=rs.getString("reservertion_id")%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>วันลงทะเบียนเข้าพัก(Check in):<code><%=date.FormatDate(rs.getString("check_in"))%></code> วันส่งคืนห้องพัก (Check out):<code><%=date.FormatDate(rs.getString("check_out"))%></code> จำนวนคืน: <code><%=date.calDateDiff(rs.getString("check_out"), rs.getString("check_in"))%></code></b>
                                    </div>
                                </div>
                                        <%if (rs.getString("email_id") != null&&!rs.getString("email_id").equals("null")) {%>
                                <h4 style="text-align: center">อีเมล์แจ้งชำระเงิน</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>วันเวลา</th>
                                                <th>ชื่อลูกค้า</th>
                                                <th>อีเมล์ลูกค้า</th>
                                                <th>หัวเรื่อง</th>
                                                <th>สลิปโอนเงิน</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                sql = "SELECT * FROM email WHERE email_address='" + rs.getString("guest_email") + "' and email_id IN (" + rs.getString("email_id") + ")";
                                                ResultSet rs1 = db.ConExecuteQuery(sql);
                                                String temp_list[] = rs.getString("email_id").split(",");
                                                boolean flag = false;
                                                if (rs1.first()) {
                                                    flag = true;
                                            %>
                                            <tr>
                                                <td><%=rs1.getString("email_sentdate")%></td>
                                                <td><%=rs1.getString("email_name")%></td>
                                                <td><%=rs1.getString("email_address")%></td>
                                                <td><%=rs1.getString("email_subject")%></td>
                                                <td>
                                                    <%for (int s = 0; s < temp_list.length - 1; s++) {%>
                                                    <a href="#" class="pop"><img src="slip.jsp?table=email&email=<%=rs1.getString("email_address")%>&email_id=<%=rs1.getInt("email_id") + s%>&email_numberfile=<%=temp_list[s]%>" width="25%"></a><hr>
                                                        <%}%>
                                                </td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                                <%} else {%>
                                <h3 class=" alert-success text-center">ชำระด้วยเงินสด</h3>
                                <%}%>
                            </div>
                            <div class="col-lg-12 text-center" id="divbt">
                                <a href="#" class="btn btn-danger" onclick="window.history.back()"><i class="glyphicon glyphicon-backward"></i> กลับ</a>
                            </div>
                        </div>
                        <!-- /.col-lg-6 (nested) -->
                    </div>
                    <!-- /.row (nested) -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
    </div>
</div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
<%}%>
