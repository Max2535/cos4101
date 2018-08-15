<%@page import="ClassSystem.*"%>
<%@page import="Systems.DateFunc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 100;
    float price_reservation = 0.0f;
    float extra_bed = 0.0f;
    session = request.getSession();
    ArrayList<Room> room_list = new ArrayList<Room>();//ถ้ามีข้อมูลรายการห้องอยู่แล้วจะสร้างใหม่
    if (session.getAttribute("room_list") != null) {
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
    }
    Guest guest = new Guest();
    String check_in = request.getParameter("check_in");
    String check_out = request.getParameter("check_out");
    DateFunc date = new DateFunc();
    long night = date.calDateDiff(date.DateToMysql(check_out), date.DateToMysql(check_in));
    if (night == 0) {
        // night=1;
        response.sendRedirect("room_list_for_move.jsp?reservertion_id=" + request.getParameter("reservertion_id") + "&check_in=" + check_in + "&check_out=" + check_out + "&out=no");
    }
    Reservation reservation = new Reservation();
    Condb db0 = new Condb();
    ResultSet rs = null;
    int reservertion_id = reservation.CountReservation();
    if (reservertion_id == 0) {
        reservertion_id = 1;
    } else {
        reservertion_id++;
    }
    ResultSet rs1 = reservation.SearchGuest(request.getParameter("reservertion_id"));
    rs1.first();
    int guest_id = 0;
    if (rs1 != null) {
        guest_id = rs1.getInt("guest_id");
    }
    guest.setGuest_id(guest_id);
    session.setAttribute("guest", guest);
    ResultSet rs2 = guest.GetGuest(guest_id);
    ResultSet rs3 = reservation.GetReservation(request.getParameter("reservertion_id"));
    rs2.first();
    rs3.first();
    if (room_list.size() > 0) {
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
                    <h1 class="page-header">ข้อมูลสรุปใบสำรองห้องพักที่จะย้ายไป<small> รหัสใบสำรองห้องพัก:<code><%=reservertion_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center" id="form_room">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>รายการห้องพัก วันลงทะเบียนเข้าพัก(Check in):<code><%=check_in%></code> วันส่งคืนห้องพัก (Check out): <code><%=check_out%></code> จำนวนคืน: <code><%=night%></code></b>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>หมายเลขห้องพัก</th>
                                                        <th>ประเภทห้องพัก</th>
                                                        <th>ค่าห้อง</th>
                                                        <th>สถานะเตียงเสริม</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%for (int index = 0; index < room_list.size(); index++) {%>
                                                    <tr>
                                                        <td><%=room_list.get(index).getRoom_code()%></td>
                                                        <%
                                                            //หาประเภทของห้อง
                                                            Room room = new Room();
                                                            rs = room.GetRoomType(room_list.get(index).getRoom_type());
                                                            rs.first();
                                                        %>
                                                        <td><%=rs.getString("room_type_name")%></td>
                                                        <td><%=room_list.get(index).getRoom_price()%> * <%=night%> วัน</td>
                                                        <td><%if (room_list.get(index).getExtra_bed().equals("true")) {
                                                                out.print("เพิ่มเตียงเสริม");
                                                                ConfigSystem con = new ConfigSystem();
                                                                extra_bed += Integer.parseInt(con.GetConfig(10));
                                                            } else {
                                                                out.print("ไม่เพิ่มเตียงเสริม");
                                                            }%></td>
                                                            <%price_reservation += room_list.get(index).getRoom_price();%>
                                                    </tr>
                                                    <%}%>                                                    
                                                    <%if (extra_bed != 0.0f) {%>
                                                    <tr>
                                                        <td>ราคาเตียงเสริมทั้งหมด</td> 
                                                        <td></td>
                                                        <td><%=extra_bed%> บาท</td>
                                                        <td></td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td><b>เงินค่าห้องพักรวม</b></td>
                                                        <td></td>
                                                        <td><b><%=price_reservation * night + extra_bed%></b> บาท</td>
                                                        <td></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        ข้อมูลลูกค้า
                                    </div>
                                    <div class="panel-body">
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
                                        <div class="col-lg-3"> </div>
                                        <div class="col-lg-6">
                                            <label class="alert-warning">เหตุผลในการย้ายห้อง*</label>
                                            <textarea name="note" id='note' rows="2" cols="10"></textarea>
                                        </div>
                                        <div class="col-lg-3"> </div>
                                    </div>                                    
                                </div>
                            </div>
                            <!-- /.col-lg-6 (nested) -->
                            <div class="col-lg-12 text-center" id="wait_email">
                                <button href="#" class="btn btn-success" onclick="saveReservation()"><i class="glyphicon glyphicon-floppy-save"></i> อนุมัติการย้ายห้อง</button>                                
                                <!-- <a href="room_list_for_move.jsp?check_in=<%=request.getParameter("check_in")%>&check_out=<%=request.getParameter("check_out")%>" class="btn btn-warning"><i class="glyphicon glyphicon-new-window"></i> เลือกห้องใหม่</a> -->                       
                                <a href="index2.jsp" class="btn btn-danger"> <i class="glyphicon glyphicon-remove"></i> ยกเลิกการทำรายการ</a>
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
    </body>
    <%@include file="../include/footer.jsp"%>
    <script>
        function del_reservation() {
            var r = confirm("ต้องการที่จะยกเลิกการทำรายการหรือไหม!!!!!");
            if (r === true) {
                location.href = "del_reservation.jsp";
            }
        }

        function saveReservation() {
            var r = confirm("ต้องการที่บันทึกใบสำรองห้องพักหมายเลข:<%=reservertion_id%> หรือไม่");
            if (!r) {
                return;
            }
            if (get('note').value === '') {
                alert('กรุณาระบุเหตุผลการยกเลิกห้องพัก');
                get('note').focus();
                return false;
            }
            var note = get('note').value;
            note += " ,ย้ายใบสำรอห้องพักที่ <%=request.getParameter("reservertion_id")%> ไป <%=reservertion_id%>"
            var cancal_reserv = {
                reservation_id:  <%=request.getParameter("reservertion_id")%> ,
                note: get('note').value,
                type: "ยกเลิกใบสำรอง"
            };
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
            $.ajax({
                type: "GET",
                url: "../ajax/save_reservation_move.jsp",
                dataType: "html",
                success: function (data) {
                    var temp = parseInt(data);
                    if (temp === 1) {
                        console.log("ทำการลงทะเบียนเข้าพักเรียบร้อยแล้ว!!!!!!");
                        location.href = "index2.jsp?reservertion_id=<%=reservertion_id%>";
                    } else {
                        console.log("ทำการลงทะเบียนเข้าพักไม่เรียบร้อย!!!!!!");
                        return false;
                    }
                }
            });
            printReceipt();
        }
        function printReceipt() {

            print();
        }
    </script>
</script>
</html>
<%
        //บันทึกลงข้อมูลรายการห้องพัก
        reservation.setCheck_in(check_in);
        reservation.setCheck_out(check_out);
        reservation.setPrice_total(price_reservation * night + extra_bed);
        reservation.setPrice_reservation(price_reservation * night);
        reservation.setStatus_pay("NEW");
        reservation.setStatus_reservation("WAIT_CHECK_IN");
        session.setAttribute("reservation", reservation);
    } else {
        out.print(room_list);
//room_list_for_move.jsp?reservertion_id=1&check_in=25/04/2561&check_out=26/04/2561
        response.sendRedirect("room_list_for_move.jsp?reservertion_id=" + request.getParameter("reservertion_id") + "&check_in=" + check_in + "&check_out=" + check_out + "&error=no");
    }
%>