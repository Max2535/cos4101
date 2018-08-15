<%@page import="ClassSystem.*"%>
<%@page import="Systems.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 0;
    DateFunc date = new DateFunc();
    Reservation reservation = new Reservation();
    Guest guest = new Guest();
    
    String reservation_id = "";
    if (request.getParameter("reservertion_id") != null) { // รับ Parameter "reservertion_id" จาก index2.jsp
        reservation_id = request.getParameter("reservertion_id"); // ตรวจสอบว่ามีการส่งมาหรือไม่ ?
    }
    
    ResultSet reservationData = reservation.getReservation(reservation_id); // แสดงข้อมูลใบสำรอง ***
    reservationData.first(); // เลือกตัวแรก
    ResultSet reservationDetail = reservation.GetReservationDetail(reservation_id); // แสดงข้อมูลรายละเอียดใบสำรอง (รายการห้อง) ***
    ResultSet guestData = guest.GetGuest(reservationData.getInt("guest_id")); // แสดงข้อมูลลูกค้าที่สัมพันธ์กับใบสำรอง ***
    guestData.first(); // เลิอกตัวแรก
    ResultSet staffCreate = Staff.getStaffData(reservationData.getInt("staff_id"));
    staffCreate.first();
    
    ResultSet staffEdit = null;
    if (reservationData.getInt("staff_edit_id") > 0) {
        staffEdit = Staff.getStaffData(reservationData.getInt("staff_edit_id"));
        staffEdit.first();
    }
    
    ResultSet staffCancel = null;
    if (reservationData.getInt("staff_cancel_id") > 0) {
        staffCancel = Staff.getStaffData(reservationData.getInt("staff_cancel_id"));
        staffCancel.first();
    }
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
                    <h1 class="page-header">รายละเอียดใบสำรองห้องพักหมายเลข <%=reservation_id%></h1>
                </div>
            </div>
            <div class="panel panel-info">
                <div class="panel-body">
                    <h4>
                        <div><b>ใบสำรองห้องพักหมายเลข :</b> <b class="alert-info"><%=reservation_id%></b></div>
                        <div><b>วันลงทะเบียนเข้าพัก (Check in) :</b> <b class="alert-info"><%=date.FormatDate(reservationData.getString("check_in"))%></b></div>
                        <div><b>วันส่งคืนห้องพัก (Check out) :</b> <b class="alert-info"><%=date.FormatDate(reservationData.getString("check_out"))%></b></div>
                        <div><b>จำนวน</b> <b class="alert-info"><%=date.calDateDiff(reservationData.getString("check_out"), reservationData.getString("check_in"))%></b> <b>คืน</b></div>
                        <div><b>ลูกค้า : </b><b class="alert-info"><a href="guest_info.jsp?reservertion_id=<%=reservationData.getString("reservertion_id")%>"><%=guestData.getString("guest_name")%></a></b></div>
                        <div><b>เงินค่าห้องรวม :</b> <b class="alert-info"><%=reservationData.getDouble("price_total")%></b> <b>บาท</b></div>
                        <div><b>สถานะการชำระเงิน :</b> <%if (reservationData.getString("status_pay").equals("NEW")) {%>
                                                        <b class="alert-warning">ยังไม่ชำระเงิน</b>
                                                    <%} else {%>
                                                        <b class="alert-success">ชำระเงินแล้ว</b>
                                                    <%}%>
                        </div>
                        <div><b>ประเภทการชำระเงิน :</b> <%if (reservationData.getString("payment_type") != null) {%>
                                                        <b class="alert-info"><%=reservationData.getString("payment_type")%></b>
                                                     <%}%>
                        </div>
                        <div><b>สถานะใบสำรองห้องพัก :</b><%if (reservationData.getString("status_reservation").equals("WAIT_CHECK_IN")) {%>             
                                                            <b class="alert-warning">รอลงทะเบียนเข้าพัก(wait for check in)</b>
                                                        <%} else if (reservationData.getString("status_reservation").equals("CHECK_IN") && reservationData.getString("status_pay").equals("PAY")) {%>                                                
                                                            <b class="alert-info">ลงทะเบียนเข้าพัก(check in)</b>
                                                        <%} else if (reservationData.getString("status_reservation").equals("CHECK_OUT") && reservationData.getString("status_pay").equals("PAY")) {%>                                                
                                                            <b class="alert-success">ส่งคืนห้องพัก(check out)</b>
                                                        <%} else if (reservationData.getString("status_reservation").equals("CANCEL")) {%>                                                
                                                            <b class="alert-danger">ยกเลิกใบสำรอง</b>
                                                        <%} else if (reservationData.getString("status_reservation").equals("CHECK_OUT") && reservationData.getString("status_pay").equals("NEW")) {%>                                                
                                                            <b class="alert-danger">ยกเลิกใบสำรอง(cancel)</b>
                                                        <%}%>
                        </div>
                        <div><b>วันเวลาที่อนุมัติการชำระเงิน :</b> <b class="alert-info"><%=date.FormatDateTime(reservationData.getString("time_pay"))%></b></div>
                        <div><b>วันเวลาที่สร้างใบสำรอง :</b> <b class="alert-info"><%=date.FormatDateTime(reservationData.getString("creation_date"))%></b> <b> น. / สร้างโดย :</b> <b class="alert-info"><%=staffCreate.getString("staff_name") %></b></div>
                        <div><b>วันเวลาที่แก้ไขใบสำรอง :</b> <b class="alert-info"><%=date.FormatDateTime(reservationData.getString("edit_time"))%></b> <b> น. / แก้ไขโดย :</b> <%if (staffEdit != null) {%><b class="alert-info"><%=staffEdit.getString("staff_name") %></b><%}%></div>
                        <%if(reservationData.getString("move_room")!=null){%>
                        <div><b>วันเวลาที่ย้ายห้องพัก :</b> <b class="alert-info"><%=date.FormatDateTime(reservationData.getString("cancel_time"))%></b> <b> น. / ย้ายโดย :</b> <%if (staffCancel != null) {%> <b class="alert-info"><%=staffCancel.getString("staff_name") %></b><%}%></div>
                        <%}%>
                        <div><b>วันเวลาที่ยกเลิกใบสำรอง :</b> <b class="alert-info"><%=date.FormatDateTime(reservationData.getString("cancel_time"))%></b> <b> น. / ยกเลิกโดย :</b> <%if (staffCancel != null) {%> <b class="alert-info"><%=staffCancel.getString("staff_name") %></b><%}%></div>
                        <%if(reservationData.getString("note")!=null){%>
                        <div><b>หมายเหตุ :</b> <b class="alert-warning"><%=reservationData.getString("note")%></b></div>
                        <%}%>
                        
                    </h4>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <h3 class="center-text"><b>รายการห้องพัก</b></h3>
                            <thead>
                                <tr>
                                    <th>หมายเลขห้อง</th>
                                    <th>ประเภทห้อง</th>
                                    <th>ราคาห้อง</th>
                                    <th>สถานะเตียงเสริม</th>
                                    <th style="width:200px">รูปห้องพัก</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%while (reservationDetail.next()) {%>
                                <tr>
                                    <td><%=reservationDetail.getString("room_id")%></td>
                                    <td><%=reservationDetail.getString("room_type_name")%></td>
                                    <td><%=reservationDetail.getString("room_price")%> บาท</td>
                                    <td><%if (reservationDetail.getString("extra_bed").equals("true")){ 
                                            out.print("<b>เพิ่มเตียงเสริม</b>");
                                        } else {
                                            out.print("<b>ไม่ได้เพิ่มเตียงเสริม</b>");
                                        }%>
                                    </td>
                                    <td><a href="#" class="pop"><img src="image.jsp?table=room&id=<%=reservationDetail.getString("room_id")%>" style="width: 100%"/></a></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
                    <a href="#" onclick="window.history.back()" class="btn btn-danger">ย้อนกลับ</a>
                </div>
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
</html>