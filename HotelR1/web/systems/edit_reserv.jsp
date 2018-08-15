<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 0;
    String reservation_id = "";
    Guest guest = new Guest();
    Reservation reservation = new Reservation();
    DateFunc date = new DateFunc();
    ConfigSystem configSystem = new ConfigSystem();
    
    if (request.getParameter("reservertion_id") != null) { // รับ Parameter "reservertion_id" จาก index2.jsp
        reservation_id = request.getParameter("reservertion_id"); // ตรวจสอบว่ามีการส่งมาหรือไม่ ?
    }
    
    ResultSet reservationData = reservation.getReservation(reservation_id); // แสดงข้อมูลใบสำรอง ***
    reservationData.first(); // เลือกตัวแรก
    ResultSet reservationDetail = reservation.GetReservationDetail(reservation_id); // แสดงข้อมูลรายละเอียดใบสำรอง (รายการห้อง) ***
    ResultSet guestData = guest.GetGuest(reservationData.getInt("guest_id")); // แสดงข้อมูลลูกค้าที่สัมพันธ์กับใบสำรอง ***
    guestData.first(); // เลิอกตัวแรก

    long nigth = date.calDateDiff(reservationData.getString("check_out"), reservationData.getString("check_in"));
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <script>
        </script>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">แก้ไขห้องพัก<small> รหัสใบสำรองห้องพัก : <code><%=reservation_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <form action="../ajax/save_edit_reserv.jsp" method="GET" >
                    <div class="panel panel-info">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12  text-center">
                                    <div class="panel panel-default">
                                        <div class="panel-heading text-center">
                                            <b>วันลงทะเบียนเข้าพัก(Check in):<code><%=date.FormatDate(reservationData.getString("check_in"))%></code> 
                                                วันส่งคืนห้องพัก (Check out):<code><%=date.FormatDate(reservationData.getString("check_out"))%></code> 
                                                จำนวน : <code><%=nigth%></code> คืน
                                            </b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive">
                                                <div class="panel-heading text-center"><h2><u>รายการห้องพัก</u></h2>
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>หมายเลขห้องพัก</th>
                                                                <th>ประเภทห้องพัก</th>
                                                                <th>ราคาค่าห้อง</th>
                                                                <th>สถานะเตียงเสริม (1 ห้อง / <%=configSystem.GetConfig(10) %> บาท)</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%while (reservationDetail.next()) {%>
                                                            <tr>
                                                                <td><%=reservationDetail.getString("room_code")%></td>
                                                                <td><%=reservationDetail.getString("room_type_name")%></td>
                                                                <td><%=reservationDetail.getString("room_price")%> บาท</td>
                                                                <td>
                                                                    <input hidden="" type="checkbox" name="clear_extra_bed" value="<%=reservationDetail.getInt("reservation_detail_id")%>" checked=""/>
                                                                    <% if ((reservationDetail.getString("extra_bed").equals("true"))) {%>
                                                                        <input type="checkbox" name="extra_bed" value="<%=reservationDetail.getInt("reservation_detail_id")%>" checked="" />
                                                                    <%} else {%>
                                                                        <input type="checkbox" name="extra_bed" value="<%=reservationDetail.getInt("reservation_detail_id")%>"/>
                                                                    <%}%>
                                                                </td>
                                                            </tr>
                                                            <%}%>
                                                            <tr>
                                                                <td>ค่าห้องห้อง</td>
                                                                <td></td>
                                                                <td align="right"><%=reservationData.getDouble("price_reservation")%> บาท</td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td>ค่าเตรียงเสริม</td>
                                                                <td></td>
                                                                <td align="right"><%=reservationData.getInt("price_total") - reservationData.getInt("price_reservation")%> บาท</td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td><b>เงินรวมสุทธิ</b></td>
                                                                <td></td>
                                                                <td align="right"><b><%=reservationData.getDouble("price_total")%> บาท</b></td>
                                                                <td></td>
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
                                                                <td><%=guestData.getString("guest_name")%></td>
                                                                <td><%=guestData.getString("guest_idno")%></td>
                                                                <td><%=guestData.getString("guest_email")%></td>
                                                                <td><%=guestData.getString("guest_phone")%></td>
                                                                <td><%=guestData.getString("guest_address")%></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>   
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 text-center">
                                    <input type="hidden" name="reservation_id" value="<%=reservation_id %>"/>
                                    <!-- <a href="room_list.jsp?check_in=<%=date.FormatDate(reservationData.getString("check_in"))%>&check_out=<%=date.FormatDate(reservationData.getString("check_out"))%>"class="btn btn-info" ><i class="glyphicon glyphicon-search"></i> ค้นหาห้องว่าง</a> -->
                                    <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-save-file"></i> บันทึกแก้ไขใบสำรอง</button>
                                    <a href="index2.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-backward"></i> ยกเลิกการแก้ไข</a> 
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>   
</div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
