<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    <% if (request.getParameter("msg") != null) {%>
    alert("<%=request.getParameter("msg")%>");
    <%}%>
</script>
<%
    //ดึงข้อมูลใบสำรองห้องพักมาแสดง
    int id = 0;
    String reservertion_id = "";
    //ดึงข้อมูลลูกค้าออกมาแสดง   
    Guest guest = new Guest();
    String sql = "";
    Condb db = new Condb();
    Reservation reservation = new Reservation();
    DateFunc date = new DateFunc();
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
    }
    //ดึงข้อมูลใบสำรองห้องพักออกมา
    ResultSet rs = reservation.GetReservationDetail(reservertion_id);
    //หาว่าใบสำรองห้องพักเป็นของใคร
    ResultSet rs1 = reservation.SearchGuest(reservertion_id);
    rs1.first();
    int guest_id = 0;
    if (rs1 != null) {
        guest_id = rs1.getInt("guest_id");
    }
    ResultSet rs2 = guest.GetGuest(guest_id);
    rs2.first();
    if (rs != null && rs1 != null && rs2 != null) {
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
                <div class="col-lg-12 div_from_2">
                    <h1 class="page-header">ข้อลูกค้า</h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <!-- /.panel-heading -->
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <div class="panel-heading text-center" style="background-color: #dddddd">ข้อมูลลูกค้า</div>
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ชื่อ-นามสกุล</th>
                                                    <th>รหัสบัตรประชาชน</th>
                                                    <th>อีเมล์</th>
                                                    <th>เบอร์โทรศัพท์</th>
                                                    <th>ที่อยู่</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%=rs2.getString("guest_name")%></td>
                                                    <td><%=rs2.getString("guest_idno")%></td>
                                                    <td><%=rs2.getString("guest_email")%></td>
                                                    <td><%=rs2.getString("guest_phone")%></td>
                                                    <td><%=rs2.getString("guest_address")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <hr>
                                        <a href="#" class="pop"><img src="image.jsp?table=guest&id=<%=rs2.getString("guest_id")%>" width="25%" alt="ไม่มีรูปหลักฐาน"/></a>
                                    </div>  
                                    <hr>
                                    <%rs=db.ConExecuteQuery("SELECT * FROM reservation WHERE status_reservation='CANCEL' and reservertion_id='"+reservertion_id+"'");%>
                                    <%if(rs.first()){%>
                                    <div class="table-responsive">
                                        <div class="panel-heading text-center" style="background-color: #dddddd">ข้อมูลการยกเลิกใบสำรองห้องพัก</div>
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>วันสำรองห้องพัก</th>
                                                    <th>วันยกเลิกใบสำรองห้องพัก</th>
                                                </tr>
                                                <tr>
                                                    <td><%=date.FormatDateTime(rs.getString("creation_date")) %></td>
                                                    <td><%=date.FormatDateTime(rs.getString("cancel_time")) %></td>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <%}%>
                                </div>
                                <!-- /.panel-body -->
                            </div>
                            <div class="col-lg-12 text-center div_from">
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