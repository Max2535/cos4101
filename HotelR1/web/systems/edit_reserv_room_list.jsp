<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%
    int id = 0;
    String reservation_id = "";
    Guest guest = new Guest();
    Reservation reservation = new Reservation();
    DateFunc date = new DateFunc();

    if (request.getParameter("reservertion_id") != null) { // รับ Parameter "reservertion_id" จาก index2.jsp
        reservation_id = request.getParameter("reservertion_id"); // ตรวจสอบว่ามีการส่งมาหรือไม่ ?
    }
    
    ResultSet reservationData = reservation.getReservation(reservation_id); // แสดงข้อมูลใบสำรอง ***
    reservationData.first(); // เลือกตัวแรก
    ResultSet reservationDetail = reservation.GetReservationDetail(reservation_id); // แสดงข้อมูลรายละเอียดใบสำรอง (รายการห้อง) ***
    ResultSet guestData = guest.GetGuest(reservationData.getInt("guest_id")); // แสดงข้อมูลลูกค้าที่สัมพันธ์กับใบสำรอง ***
    guestData.first(); // เลิอกตัวแรก
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-md-4"><h4><i class="glyphicon glyphicon-home"></i> รายการห้องของใบสำรองหมายเลขที่ : <%=reservation_id %></h4></div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="example">
                            <thead>
                                <tr>
                                    <th width="25%">รูปห้องพัก</th>
                                    <th>ประเภทห้องพัก</th>
                                    <th>รายละเอียด</th>
                                    <th colspan="2">ตัวเลือก</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%while (reservationDetail.next()) %>
                                <tr>
                                    
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
