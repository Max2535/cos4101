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
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">ยกเลิกใบสำรองห้องพัก <small>รหัสใบสำรองห้องพัก:<code><%=reservation_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <!-- panel heading -->
                                    <div class="panel-heading text-center">
                                        <b>วันลงทะเบียนเข้าพัก(Check in): <code><%=date.FormatDate(reservationData.getString("check_in"))%></code>
                                           วันส่งคืนห้องพัก(Check out): <code><%=date.FormatDate(reservationData.getString("check_out"))%></code>
                                           จำนวน : <code><%=date.calDateDiff(reservationData.getString("check_out"), reservationData.getString("check_in"))%></code> คืน
                                        </b>
                                    </div>
                                    <!-- panel body -->
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <!-- panel heading in panel body -->
                                            <div class="panel-heading text-center" style="background-color: #dddddd">รายการห้องพัก</div>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>หมายเลขห้องพัก</th>
                                                        <th>ประเภทห้องพัก</th>
                                                        <th>ราคาค่าห้อง</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%while (reservationDetail.next()) {%>
                                                    <tr>
                                                        <td><%=reservationDetail.getString("room_code")%></td>
                                                        <td><%=reservationDetail.getString("room_type_name")%></td>
                                                        <td><%=reservationDetail.getString("room_price")%> บาท</td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td>ค่าห้องรวม</td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getDouble("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td>ค่าเตรียงเสริม</td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getInt("price_total") - reservationData.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>เงินรวมสุทธิ</b></td>
                                                        <td></td>
                                                        <td align="right"><b><%=reservationData.getDouble("price_total")%> บาท</b></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <hr>
                                            <!-- panel heading in panel body -->
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
                                        <div class="col-lg-3"></div>
                                        <div class="col-lg-6">
                                            <label class="alert-warning">เหตุผลในการยกเลิก*</label>
                                            <textarea name="note" id='note' rows="2" cols="10"></textarea>
                                        </div>
                                        <div class="col-lg-3"></div>
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <div class="col-lg-12 text-center">
                                <a href="#" class="btn btn-warning" onclick="cancel()"><i class="glyphicon glyphicon-remove-sign"></i> บันทึกยกเลิกใบสำรองห้องพัก</a>
                                <a href="#" class="btn btn-danger" onclick="window.history.back()"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิกทำรายการ</a>
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
    function cancel() {
        console.log("กำลังทำการยกเลิกใบสำรองห้องพัก");
        var r = confirm("ต้องการที่ยกเลิกใบสำรองห้องพักหมายเลข:<%=reservation_id%> หรือไม่");
        if (!r) {
            return;
        }
        var cancal_reserv = {
            reservation_id : <%=reservation_id%>,
            note : get('note').value,
            type : "ยกเลิกใบสำรอง"
        };
        if(get('note').value !=='' && !Number(get('note').value)){
            alert('ทำการยกเลิกใบสำรองห้องพักสำเร็จ');
            console.log("ทำการยกเลิกใบสำรองห้องพักแล้ว");
            $.ajax({
                type : "GET",
                url : "../ajax/cancel.jsp",
                dataType : "json",
                data : cancal_reserv,
                success: function (data) {
                    var status = parseInt(data);
                    //alert(status);
                    if(status > 0){
                        location.href = "index2.jsp";
                    }
                }
            });
        } else {
            alert('กรุณาระบุเหตุผลห้องพัก อีกครั้ง');
            get('note').focus();
            return false;
        }
    }
</script>
</html>