<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession();
    session.removeAttribute("room_list");
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
                <div class="col-lg-12">
                    <h1 class="page-header">ย้ายห้องพัก<small> รหัสใบสำรองห้องพัก:<code><%=reservertion_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>วันลงทะเบียนเข้าพัก(Check in) :<code><%=date.FormatDate(rs1.getString("check_in"))%></code> 
                                            วันส่งคืนห้องพัก (Check out) :<code><%=date.FormatDate(rs1.getString("check_out"))%></code> 
                                            จำนวน : <code><%=date.calDateDiff(rs1.getString("check_out"), rs1.getString("check_in"))%></code> คืน
                                        </b>
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
                                                    <%while (rs.next()) {%>
                                                    <tr>
                                                        <td><%=rs.getString("room_code")%></td>
                                                        <td><%=rs.getString("room_type_name")%></td>
                                                        <td><%if (rs.getString("extra_bed").equals("true")){ 
                                                                out.print("<b>เพิ่มเตียงเสริม</b>");
                                                            } else {
                                                                out.print("<b>ไม่ได้เพิ่มเตียงเสริม</b>");
                                                            }%>
                                                        </td>
                                                        <td><%=rs.getString("room_price")%> บาท</td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td>ค่าห้องรวม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=rs1.getDouble("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td>ค่าเตรียงเสริม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=rs1.getInt("price_total") - rs1.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>เงินรวมสุทธิ</b></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><b><%=rs1.getDouble("price_total")%> บาท</b></td>
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
                                                        <td><%=rs2.getString("guest_name")%></td>
                                                        <td><%=rs2.getString("guest_idno")%></td>
                                                        <td><%=rs2.getString("guest_email")%></td>
                                                        <td><%=rs2.getString("guest_phone")%></td>
                                                        <td><%=rs2.getString("guest_address")%></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <div class="col-lg-12 text-center">
                                <a href="#" class="btn btn-warning" onclick="move_room()">ทำการย้ายห้องพัก</a>
                                <a href="index2.jsp" class="btn btn-danger"> ยกเลิกการทำรายการ</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="../include/footer.jsp"%>
<script>
    function move_room() {
        location.href = "room_list_for_move.jsp?reservertion_id=<%=reservertion_id%>&check_in=<%=date.getDate(0)%>&check_out=<%=date.FormatDate(rs1.getString("check_out"))%>";
    }
</script>
</html>
<%}%>