<%@page import="ClassSystem.*"%>
<%@page import="Systems.DateFunc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%
    int id = 100;
    
    String check_in = request.getParameter("check_in");
    String check_out = request.getParameter("check_out");
    String[] select_extra_bed = request.getParameterValues("select_extra_bed");
    String[] select_room = request.getParameterValues("select_room");;
    
    DateFunc date = new DateFunc();
    float price_reservation = 0.0f;
    float extra_bed = 0.0f;
    session = request.getSession();
    long night = date.calDateDiff(date.DateToMysql(check_out), date.DateToMysql(check_in));
    Reservation reservation = new Reservation();
    Condb db0 = new Condb();
    ResultSet rs = null;
    
    ArrayList<Room> room_list;
    
    if (session.getAttribute("room_list") != null) {
        room_list = (ArrayList<Room>) session.getAttribute("room_list");
    } else {
        room_list = new ArrayList<Room>();//ถ้ามีข้อมูลรายการห้องอยู่แล้วจะสร้างใหม่
    }
    
    int reservertion_id = reservation.CountReservation();
    
    if (reservertion_id == 0) {
        reservertion_id = 1;
    } else {
        reservertion_id++;
    }
    
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
                    <h1 class="page-header">แสดงรายการห้องพักที่ลูกค้าเลือกและแบบฟอร์มค้นหาลูกค้า<small> รหัสใบสำรองห้องพัก:<code><%=reservertion_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center" id="form_room">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>รายการห้องพัก วันลงทะเบียนเข้าพัก(Check in):<code><%=check_in%></code> 
                                            วันส่งคืนห้องพัก (Check out): <code><%=check_out%></code>  
                                            จำนวน:<code><%=night%></code> คืน
                                        </b>
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
                                                                }%>
                                                            </td>
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
                                                        <td><b><%=price_reservation * night + extra_bed%> บาท</b></td>
                                                        <td></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <!-- /.col-lg-6 (nested) -->
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4><i class="glyphicon glyphicon-user"></i> ค้นหาข้อมูลลูกค้า</h4>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <div class="col-lg-12">
                                                <form role="form" onsubmit="return false;">
                                                    <div class="col-sm-12">
                                                        <div class="col-sm-10">
                                                            <div class="form-group input-group">
                                                                <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i> </span>
                                                                <input type="number" class="form-control" id="idno" value="1103100356079" placeholder="กรุณาระบบหมายเลขประจำตัวประชาชน" required="true">
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <a  class="btn btn-info" onclick="search_guest()" id="bt"><i class="glyphicon glyphicon-search"></i> ค้นหาข้อลูกค้า</a>                                                            
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.table-responsive -->
                                </div>
                                <!-- /.panel-body -->
                            </div>
                            <div class="col-lg-12  text-center" id="form_guest" style=" display: none">
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <b>ข้อมูลลูกค้า</b>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <form onsubmit="return false;"name="form1" id="form1"><!--ใช้ ajax ในการบันทึกข้อมูลลูกค้า-->
                                            <input type="hidden" name="guest_id" id="guest_id" />
                                            <div class="form-group">
                                                <label>ชื่อ-นามสกุล*:</label>
                                                <input class="form-control" name="guest_name_input" id="guest_name_input">
                                            </div>
                                            <div class="form-group">
                                                <label>รหัสบัตรประชาชน:</label>
                                                <input type="number" class="form-control" name="guest_idno_input" id="guest_idno_input">
                                            </div>
                                            <div class="form-group">
                                                <label>อีเมล์*:</label>
                                                <input type="email" class="form-control" name="guest_email_input" id="guest_email_input">
                                            </div>
                                            <div class="form-group">
                                                <label>เบอร์โทรศัพท์*:</label>
                                                <input type="number" class="form-control" name="guest_phone_input" id="guest_phone_input">
                                            </div>
                                            <div class="form-group">
                                                <label>ที่อยู่:</label>
                                                <textarea class="form-control" rows="3" name="guest_address_input" id="guest_address_input"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <div class="col-lg-12 text-center" id="wait_email">
                                <!-- <a class="btn btn-info" onclick="SendEmail()"><i class="glyphicon glyphicon-send"></i> ส่ง E-mail</a>-->
                                <span class="btn btn-info"><input type="checkbox" name="sendemail" id="sendemail" checked=""/>ส่ง E-mail</span>  
                                <button href="#" class="btn btn-success" onclick="saveReservation()"><i class="glyphicon glyphicon-floppy-save"></i> บันทึกข้อมูลใบสำรองห้องพัก</button>                                
                                <a href="room_list.jsp?check_in=<%=request.getParameter("check_in")%>&check_out=<%=request.getParameter("check_out")%>" class="btn btn-warning"><i class="glyphicon glyphicon-new-window"></i> เลือกห้องใหม่</a>                                       
                                <button type="button" class="btn btn-danger" onclick="del_reservation()" > <i class="glyphicon glyphicon-remove"></i> ยกเลิกการทำรายการ</button>
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
        var guest_data = true;// ตรวจสอบว่ามีข้อมลูกหรือไม
        var guest_id = null;
        var input = get('idno');
        input.addEventListener("keyup", function (event) {
            //event.preventDefault();
            if (event.keyCode === 13) {
                search_guest();
            }
        });
        function search_guest() {
            console.log("ทำการค้นหาข้อมูลลุกค้า");
            var idno = get('idno').value;
            if (idno === "") {
                alert('กรุณาระบุรหัสบัตรประชาชนเพื่อใช้ในการค้นหาข้อูลลูกค้า');
                get('idno').focus();
                return false;
            }
            get('guest_idno_input').disabled = true;
            get('guest_name_input').value = "";
            get('guest_idno_input').value = "";
            get('guest_email_input').value = "";
            get('guest_phone_input').value = "";
            get('guest_address_input').value = "";
            $.ajax({
                type: "GET",
                url: "../ajax/customer_info.jsp?idno=" + idno,
                dataType: "json",
                success: function (data) {
                    var flag = parseInt(data);
                    if (flag !== -1) {
                        var text = JSON.stringify(data);
                        var obj = null;
                        obj = JSON.parse(text);
                        get('guest_name_input').value = obj.guest_name;
                        get('guest_idno_input').value = obj.guest_idno;
                        get('guest_email_input').value = obj.guest_email;
                        get('guest_phone_input').value = obj.guest_phone;
                        get('guest_address_input').value = obj.guest_address;
                        get('guest_id').value = obj.guest_id;
                        get('form_guest').style.display = "block";
                    } else {
                        get('form_guest').style.display = "block";
                        get('guest_idno_input').value = idno;
                        guest_data = false;
                    }
                }
            });
        }
        
        function del_reservation() {
            var r = confirm("ต้องการที่จะยกเลิกใบสำรองห้องพักหรือไม่");
            if (r === true) {
                location.href = "del_reservation.jsp";
            }
        }

        function SendEmail() {

            if (get('guest_email_input').value === "") {
                alert('กรุณากรอกอีเมล์ลูกค้า');
                get('guest_email_input').focus();
                return false;
            } else {
                var email = get('guest_email_input').value;
            }
            //var r = confirm("ต้องการที่จะส่งใบสำรองห้องพักหรือไม่!!!!!");
            //if (r === false) {
            //    return false;
            //}
            // ValidateEmail(document.form1.guest_email_input);
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (!document.form1.guest_email_input.value.match(mailformat))
            {
                alert("อีเมล์ไม่ถูกต้อง!");
                get('guest_email_input').focus();
                return false;
            }
            if (get('guest_phone_input').value === "") {
                alert('กรุณากรอกเบอร์โทรลูกค้า');
                get('guest_phone_input').focus();
                return false;
            }
            //$('#wait_email').hide();
            get('wait_email').innerHTML = '<span class="alert warning"><h3>กำลังส่งอีเมล์ไปหา :' + email + '</h3></span>';
            $.ajax({
                type: "GET",
                url: "../ajax/send_email.jsp?reservertion_id=<%=reservertion_id%>",
                dataType: "html",
                success: function (data) {
                    var temp = parseInt(data);
                    if (temp === 1) {
                        alert("ส่งเรียบร้อยแล้ว");
                        //$('#wait_email').show();
                        get('wait_email').innerHTML = '<span class="alert warning"><h3>ส่งอีเมล์ไปหา :' + email + ' เรียบร้อยแล้ว</h3></span>';
                    } else {
                        alert("ไม่สำเร็จ");
                    }
                }
            });
        }
        
        function saveReservation() {
            if (get("idno").value === '') {
                alert('กรุณาระบุรหัสบัตรประชาชนเพื่อใช้ในการค้นหาข้อูลลูกค้า');
                get('idno').focus();
                return false;
            }
            
            if (get('guest_name_input').value === "") {
                alert('กรุณากรอกชื่อลูกค้า');
                get('guest_name_input').focus();
                return false;
            }
            
            if(Number(get("guest_name_input").value)) {
                //alert(Number(get("staff_name").value));
                alert("ชื่อลูกค้าไม่ถูกต้อง โปรดระบุชื่อลูกค้าอีกครั้ง");
                get("guest_name_input").focus();
                return false;
            }
            
            if (get('guest_email_input').value === "") {
                alert('กรุณากรอกอีเมล์ลูกค้า');
                get('guest_email_input').focus();
                return false;
            }
            
            if(get("guest_phone_input").value === '' ) {
                alert("กรุณากรอกเบอร์โทรศัพท์ลูกค้า");
                get("guest_phone_input").focus();
                return false;
            }
            
            if (get("guest_phone_input").value <= 0 ) {
                    alert("ระบุเบอร์โทรศัพท์อีกครั้ง");
                    get("guest_phone_input").focus();
                    return false;
                }
            
            if(get("guest_address_input").value === '' ) {
                alert("กรุณากรอกที่อยู่ลูกค้า");
                get("guest_address_input").focus();
                return false;
            }
            
            // ValidateEmail(document.form1.guest_email_input);
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if (!document.form1.guest_email_input.value.match(mailformat))
            {
                alert("อีเมล์ไม่ถูกต้อง!");
                get('guest_email_input').focus();
                return false;
            }
            
            var r = confirm("ต้องการที่บันทึกใบสำรองห้องพักหมายเลข:<%=reservertion_id%> หรือไม่");
            if (!r) {
                return;
            }
            
            var guest_id = get('guest_id').value;
            var guest_name = get('guest_name_input').value;
            var guest_idno = get('guest_idno_input').value;
            var guest_email = get('guest_email_input').value;
            var guest_phone = get('guest_phone_input').value;
            var guest_address = get('guest_address_input').value;
            
            if (guest_data) {
                console.log("ทำการอัพเดทข้อมูลลูกค้า");
                var guest_json = {
                    guest_id: guest_id,
                    guest_name: guest_name,
                    guest_idno: guest_idno,
                    guest_email: guest_email,
                    guest_phone: guest_phone,
                    guest_address: guest_address,
                    flag: "update"
                };
                $.ajax({
                    type: "POST",
                    url: "../ajax/save_customer.jsp",
                    dataType: "json",
                    data: guest_json,
                    success: function (data) {
                        var temp = parseInt(data);
                        if (temp === 1) {
                            console.log("อัพเดทข้อมูลลูกค้าสำเร็จ");
                            printReceipt(guest_id);
                        } else {
                            console.log("อัพเดทข้อมูลลูกค้าไม่สำเร็จ");
                            return false;
                        }
                    }
                });
            } else {
                console.log("ทำการบันทึกข้อมูลลูกค้า");
                var guest_json = {
                    guest_name: guest_name,
                    guest_idno: guest_idno,
                    guest_email: guest_email,
                    guest_phone: guest_phone,
                    guest_address: guest_address,
                    flag: "insert"
                };
                $.ajax({
                    type: "POST",
                    data: guest_json,
                    url: "../ajax/save_customer.jsp",
                    dataType: "json",
                    success: function (data) {
                        var temp = parseInt(data);
                        if (temp > 0) {
                            console.log("บันทึกข้อมูลลูกค้าสำเร็จ");
                            guest_id = temp;
                            printReceipt(guest_id);
                        } else {
                            console.log("บันทึกข้อมูลลูกค้าไม่สำเร็จ");
                            return false;
                        }
                    }
                });
            }
        }
        
        function save(guest_id) {
            console.log("ทำการบันทึกใบสำรองห้องพัก");
            $.ajax({
                type: "GET",
                url: "../ajax/save_reservation.jsp?guest_id=" + guest_id,
                dataType: "html",
                success: function (data) {
                    var temp = parseInt(data);
                    if (temp === 1) {
                        console.log("ทำการบันทึกใบสำรองห้องพักเรียบร้อยแล้ว!!!!!!");
                    } else {
                        console.log("ทำการบันทึกใบสำรองห้องพักไม่เรียบร้อยแล้ว!!!!!!");
                        return false;
                    }
                }
            });
        }
        function printReceipt(guest_id) {
            save(guest_id);
            print();
            //setTimeout("", 5000);           
            if (get('sendemail').checked) {
                SendEmail();
            }
            
            //alert("ทำการบันทึกข้อมูลเรียบร้อย"); 
            location.href = "index2.jsp?idno=&display=*";
        }
    </script>
</html>
<%
        //บันทึกลงข้อมูลรายการห้องพัก
        reservation.setReservertion_id(reservertion_id);
        reservation.setCheck_in(check_in);
        reservation.setCheck_out(check_out);
        reservation.setPrice_total(price_reservation * night + extra_bed);
        reservation.setPrice_reservation(price_reservation * night);
        reservation.setStatus_pay("NEW");
        reservation.setStatus_reservation("WAIT_CHECK_IN");
        session.setAttribute("reservation", reservation);
        //session.removeAttribute("guest");
    } else {
        out.print(room_list);
        response.sendRedirect("room_list.jsp?check_in=" + check_in + "&check_out=" + check_out + "&error=no");
    }
%>
