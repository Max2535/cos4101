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
    int id = 0;
    String reservation_id = "";
    Guest guest = new Guest();
    Reservation reservation = new Reservation();
    DateFunc date = new DateFunc();
    ConfigSystem configSystem = new ConfigSystem();
    
    if (request.getParameter("reservertion_id") != null) {
        reservation_id = request.getParameter("reservertion_id");
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
                    <h1 class="page-header">ลงทะเบียนเข้าพัก(Check in)<small> รหัสใบสำรองห้องพัก:<code><%=reservation_id%></code></small></h1>
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
                                        <b>วันลงทะเบียนเข้าพัก(Check in) : <code><%=date.FormatDate(reservationData.getString("check_in"))%></code> 
                                            เวลา : <code><%=configSystem.GetConfig(5)%></code>
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
                                                        <th>สถานะเตียงเสริม</th>
                                                        <th>ราคาค่าห้อง</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%while (reservationDetail.next()) {%>
                                                    <tr>
                                                        <td><%=reservationDetail.getString("room_code")%></td>
                                                        <td><%=reservationDetail.getString("room_type_name")%></td>
                                                        <td><%if (reservationDetail.getString("extra_bed").equals("true")){ 
                                                                out.print("<b>เพิ่มเตียงเสริม</b>");
                                                            } else {
                                                                out.print("<b>ไม่ได้เพิ่มเตียงเสริม</b>");
                                                            }%>
                                                        </td>
                                                        <td><%=reservationDetail.getInt("room_price") %> บาท </td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td>ค่าห้องรวม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td>ค่าเตรียงเสริม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getInt("price_total") - reservationData.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>เงินรวมสุทธิ</b></td>
                                                        <td></td>
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
                                                    
                                        <!-- ตรวจสอบรูปภาพว่ามีหรือไม่? -->
                                        <%if (guestData.getString("guest_image") != null) {%>
                                            <a href="#" class="pop">
                                                <img src="image.jsp?table=guest&id=<%=guestData.getString("guest_id")%>" width="25%" alt="ไม่มีรูปหลักฐาน"/>
                                            </a>
                                        <%} else {%>
                                            <h3><span class="alert-danger">ไม่มีรูปหลักฐาน</span></h3>
                                        <%}%>
                                        
                                        <!-- ฟอร์มของเรื่องไฟล์รูป -->
                                        <form id="myForm" role="form" action="../guest_upload" method="post" enctype="multipart/form-data">
                                            <input type="hidden" name="flag" id="flag" />
                                            <input type="hidden" name="isupload" id="isupload" />
                                            <div class="form-group text-left">
                                                <label><i class="glyphicon glyphicon-upload"></i> อัพโหลดบัตรประชาชนหรือบัตรที่ทางราชการ</label>
                                                <input type="file" name="guest_image" id="guest_image" onchange="check_upload()">
                                                <input type="hidden" name="guest_id" value="<%=guestData.getString("guest_id")%>" />
                                                <input type="hidden" name="reservertion_id" value="<%=reservation_id%>" />
                                            </div>
                                        </form>
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <div class="col-lg-12 text-center">
                                <%if (date.TimeCheckIn() == 1 && date.checkDateCheckIn(reservation_id) == 1) {%>
                                    <a href="#" class="btn btn-success" onclick="check_in()"><i class="glyphicon glyphicon-log-in"></i> บันทึกลงทะเบียนเข้าพัก</a>
                                <%} else {%>
                                    <h4><b class="alert-danger">ไม่สามารถลงทะเบียนเข้าพักได้ เนื่องจากยังไม่ถึงวันหรือ วันลงทะเบียนเข้าพักของใบสำรอง</b></h4><br>
                                <%}%>
                                <a href="index2.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิกการทำรายการ</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <%@include file="../include/footer.jsp"%>
    <script>
        <%if (date.TimeCheckIn() == 1) {%> //แสดงว่าวันปัจจบัน มากกว่าวันของที่ Config
            function check_in() {
                console.log("กำลังทำการลงทะเบียนเข้าพักใบสำรองห้องพัก");
                var r = confirm("ต้องการลงทะเบียนเข้าพักใบสำรองห้องพักหมายเลข:<%=reservation_id%> หรือไม่");
                if (!r) {
                    return ;
                } else {
                    if (get("flag").value === "true" || get('isupload').value === "true") {
                        get('flag').value = "true";
                        get("myForm").submit();
                    } else {
                        alert("ไม่ได้อัพโหลดรูปภาพ");
                        alert(get("isupload").value);
                        alert(get('flag').value);
                    }
                }
            }
        <%}%>
        
        <%if (guestData.getString("guest_image") != null) {%> //มีรูปแล้วลงทะเบียนเข้าพักได้
            get('flag').value = "true";
        <%} else {%>
            get('flag').value = "false";
        <%}%>
        
        function check_upload() { //กรณีอัพโหลดรูปใหม่
            if (get('guest_image').value !== "") {
                get('isupload').value = "true";
            } else {
                get('isupload').value = "false";
            }
        }
    </script>
</html>