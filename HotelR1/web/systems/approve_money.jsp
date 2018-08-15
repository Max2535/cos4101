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
    session = request.getSession();
    String sql = "";
    Reservation reservation = new Reservation();
    String reservertion_id = "";
    Condb db = new Condb();
    DateFunc date = new DateFunc();
    ResultSet rs = null;
    boolean flag = false;
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
        rs = reservation.GetReservation(reservertion_id);
    }
    rs.first();
    if (rs != null) {
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
                    <h1 class="page-header">อนุมัติการชำระเงิน<small> รหัสใบสำรองห้องพัก:<code><%=rs.getString("reservertion_id")%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>วันลงทะเบียนเข้าพัก(Check in): <code><%=date.FormatDate(rs.getString("check_in"))%></code> 
                                            วันส่งคืนห้องพัก (Check out): <code><%=date.FormatDate(rs.getString("check_out"))%></code> 
                                            จำนวน : <code><%=date.calDateDiff(rs.getString("check_out"), rs.getString("check_in"))%></code> คืน</b>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">

                                        <div class="table-responsive">
                                            <div class="panel-heading text-center" style="background-color: #dddddd">รายการห้องพัก</div>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>หมายเลขห้องพัก</th>
                                                        <th>ประเภทห้องพัก</th>
                                                        <th>สถานะเตียงเสริม</th>
                                                        <th>ราคาค่าห้อง</th>
                                                    </tr>
                                                </thead>
                                                <tbody>                                                    
                                                    <%
                                                        sql = "SELECT * FROM reservation_detail t1 left outer join room t2 on t1.room_id=t2.room_id  left outer join room_type t3 on t2.room_type_id=t3.room_type_id  WHERE t1.reservertion_id=" + reservertion_id;
                                                        ResultSet rs1 = db.ConExecuteQuery(sql);
                                                        while (rs1.next()) {
                                                    %>
                                                    <tr>
                                                        <td><%=rs1.getString("room_code")%></td>
                                                        <td><%=rs1.getString("room_type_name")%></td>
                                                        <td><%if (rs1.getString("extra_bed").equals("true")){ 
                                                                out.print("<b>เพิ่มเตียงเสริม</b>");
                                                            } else {
                                                                out.print("<b>ไม่ได้เพิ่มเตียงเสริม</b>");
                                                            }%>
                                                        </td>
                                                        <td><%=rs1.getInt("room_price")%> บาท </td>
                                                    </tr>
                                                    <%}%>
                                                    
                                                    <tr>
                                                        <td>ค่าห้องรวม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=rs.getDouble("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td>ค่าเตรียงเสริม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=rs.getInt("price_total") - rs.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>เงินรวมสุทธิ</b></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><b><%=rs.getDouble("price_total")%> บาท</b></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <hr>
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
                                                        <td><%=rs.getString("guest_name")%></td>
                                                        <td><%=rs.getString("guest_idno")%></td>
                                                        <td><%=rs.getString("guest_email")%></td>
                                                        <td><%=rs.getString("guest_phone")%></td>
                                                        <td><%=rs.getString("guest_address")%></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>    
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <%if (!flag) {%>
                            <div class="col-lg-12 text-center">
                                <a href="#" class="btn btn-success" onclick="approve()"><i class="glyphicon glyphicon-ok"></i> ยืนยันการชำระเงิน</a>
                                <a href="index2.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-remove-circle"></i> ไม่อนุมัติการชำระเงินด้วยเงินสด</a>
                            </div>
                            <%}%>
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
<script>
    function approve() {
        console.log("กำลังทำการอนุมัติการชำระเงินให้กับลูกค้า");
        var r = confirm("ต้องการที่อนุมัติการชำระเงินใบสำรองห้องพักหมายเลข:<%=rs.getString("reservertion_id")%> หรือไม่");
        if (!r) {
            return;
        }
//note=เงินสด"
        var money_json = {
            reservertion_id: <%=rs.getString("reservertion_id")%>,
            type: "money",
            money_value: <%=rs.getString("price_total")%>,
            money_type: "ค่าห้อง",
            note: "อนุมัติชำระเงินด้วยเงินสดสำเร็จ"
        };
        console.log("ทำการอนุมัติการชำระเงินให้กับลูกค้าแล้ว");
        $.ajax({
            type: "POST",
            url: "../ajax/approve.jsp",
            dataType: "json",
            data: money_json,
            success: function (data) {
                location.href = "index2.jsp";
            }
        });
        print();
    }
</script>
</html>
<%}%>