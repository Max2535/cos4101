<%@page import="java.sql.ResultSet"%>
<%@page import="ClassSystem.*"%>
<%@page import="Systems.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%//ส่งอีเมล์หาลูกค้า
    request.setCharacterEncoding("UTF-8");
    DateFunc date = new DateFunc();
    Reservation reservation = new Reservation();
    Guest guest = new Guest();
    ResultSet rs=null;
    Condb db=new Condb();
    String reservation_id = "";
    if (request.getParameter("reservertion_id") != null) { // รับ Parameter "reservertion_id" จาก index2.jsp
        reservation_id = request.getParameter("reservertion_id"); // ตรวจสอบว่ามีการส่งมาหรือไม่ ?
    }
    ResultSet reservationData = reservation.getReservation(reservation_id); // แสดงข้อมูลใบสำรอง ***
    reservationData.first(); // เลือกตัวแรก
    ResultSet reservationDetail = reservation.GetReservationDetail(reservation_id); // แสดงข้อมูลรายละเอียดใบสำรอง (รายการห้อง) ***
    ResultSet guestData = guest.GetGuest(reservationData.getInt("guest_id")); // แสดงข้อมูลลูกค้าที่สัมพันธ์กับใบสำรอง ***
    guestData.first(); // เลิอกตัวแรก
    rs=db.ConExecuteQuery("SELECT * FROM `condition` WHERE condition_id=1");
    rs.first();
    String msg = "<div>"+rs.getString("condition_value")+"<b>ใบสำรองห้องพักหมายเลข :</b> <b class=\"alert-info\">"
            + reservationData.getString("reservertion_id") + "</b></div>"
            + "<div><b>วันลงทะเบียนเข้าพัก (Check in) :</b> <b class=\"alert-info\">"
            + date.FormatDate(reservationData.getString("check_in")) + "</b></div>"
            + "<div><b>วันส่งคืนห้องพัก (Check out) :</b> <b class=\"alert-info\">"
            + date.FormatDate(reservationData.getString("check_out")) + "</b></div>"
            + "<div><b>จำนวน</b> <b class=\"alert-info\">"
            + date.calDateDiff(reservationData.getString("check_out"), reservationData.getString("check_in")) + ""
            + "</b> <b>คืน</b></div>"
            + "<div><b>ลูกค้า : " + guestData.getString("guest_name") + "</a></b></div>"
            + "<div><b>เงินค่าห้องรวม :</b> <b class=\"alert-info\">" + reservationData.getDouble("price_total") + "</b> <b>บาท</b></div>"
            + "<div class=\"table-responsive\">\n"
            + "                        <table class=\"table table-hover\">\n"
            + "                            <h3 class=\"center-text\"><b>รายการห้องพัก</b></h3>\n"
            
            + "                            <tbody>";
    while (reservationDetail.next()) {
        msg+= "<tr>"
                + "<td>" + reservationDetail.getString("room_id") + " </td>"
                + "<td>" + reservationDetail.getString("room_type_name") + "</td>"
                + "<td>" + reservationDetail.getString("room_price") + ".บาท</td>"
                + "<td>" + reservationDetail.getString("extra_bed") + "</td>"
                + "</tr>";
    }
    msg += "</tbody>\n"
            + "                        </table>\n"
            + "                    </div>";
    msg += "\nลูกค้าที่โอนเงิน ต้องส่งสลิปโอนเงินมาทางอีเมล์ที " + Systems.Data.Email + " ภายใน 24 ชม";
    Email email_send = new Email();
    int flag = 0;
    if (!guestData.getString("guest_email").equals("")) {//ตรวจสอบก่อนส่ง  email
        flag = email_send.sendEmail(guestData.getString("guest_email"), "ข้อมูลใบสำรองห้องพัก เลขที่:" + reservation_id, msg);
    }
    out.print(flag);
%>