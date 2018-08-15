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
    String sql = "";
    String reservertion_id = "";
    ResultSet rs = null;
    Reservation reservation = new Reservation();
    String email = "";
    Condb db = new Condb();
    DateFunc date = new DateFunc();
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
        rs = reservation.GetReservation(reservertion_id);
    }
    if (rs.first()) {
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
                                        <b>วันลงทะเบียนเข้าพัก(Check in):<code><%=date.FormatDate(rs.getString("check_in"))%></code> วันส่งคืนห้องพัก (Check out):<code><%=date.FormatDate(rs.getString("check_out"))%></code> จำนวนคืน: <code><%=date.calDateDiff(rs.getString("check_out"), rs.getString("check_in"))%></code></b>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <table class="table table-striped table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th colspan="2"><u>ข้อมูลลูกค้า</u><br>ชื่อ-นามสกุล,อีเมล์</th>
                                                    <th>เงินค่าห้องรวม</th>
                                                    <th class="text-center"><i class="fa fa-cogs"></i></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%=rs.getString("guest_name")%></td>
                                                    <td><%=rs.getString("guest_email")%></td> 
                                                    <%email = rs.getString("guest_email");%>
                                                    <td align="right"><%=rs.getString("price_total")%>.-</td>  
                                                    <td>
                                                        <a href="room_info.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>" style="color: #2795e9"><i class="glyphicon glyphicon-info-sign"></i> รายละเอียดห้องพัก</a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- /.panel-body -->
                                </div><h4 style="text-align: center">อีเมล์แจ้งชำระเงิน</h4>
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>วันเวลา</th>
                                                <th>ชื่อลูกค้า</th>
                                                <th>อีเมล์ลูกค้า</th>
                                                <th>หัวเรื่อง</th>
                                                <th>สลิปโอนเงิน</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                //ดึงอีเมล์ออกมาแสดง
                                                sql = "SELECT COUNT(*) as size,datediff(current_timestamp(),email_time) as 'date' FROM email WHERE email_address='" + email + "'  and ('date'=0)";
                                                ResultSet rs1 = db.ConExecuteQuery(sql);
                                                int size = 0;
                                                if (rs1.first()) {
                                                    size = Integer.parseInt(rs1.getString("size"));
                                                }
                                                sql = "SELECT * ,datediff(current_timestamp(),email_time) as 'date' FROM email WHERE email_address='" + rs.getString("guest_email") + "'  and ('date'=0)";
                                                rs1 = db.ConExecuteQuery(sql);
                                                //ต้องไม่เอาอีเมล์เก่ามาแสดง
                                                //ไม่อนุมัตินับใหม่
                                                String email_id_list = "";
                                                boolean flag = false;
                                                if (rs1.first()) {
                                                    flag = true;
                                            %>
                                            <tr>
                                                <td><%=rs1.getString("email_sentdate")%></td>
                                                <td><%=rs1.getString("email_name")%></td>
                                                <td><%=rs1.getString("email_address")%></td>
                                                <td><%=rs1.getString("email_subject")%></td>
                                                <td>
                                                    <%for (int s = 0; s < size; s++) {%>
                                                    <%email_id_list += (rs1.getInt("email_id") + s) + ",";%>
                                                    <a href="#" class="pop"><img src="slip.jsp?table=email&email=<%=rs1.getString("email_address")%>&email_id=<%=rs1.getInt("email_id") + s%>&email_numberfile=<%=s + 1%>" width="25%"></a><hr>
                                                        <%}
                                                            email_id_list += 0;%>
                                                </td>
                                            </tr>
                                            <%} else {%>
                                        <h3 class="alert-danger">ไม่พบข้อมูลอีเมล์</h3>
                                        <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-lg-12 text-center" id="divbt">
                                <%if (flag) {%><a href="#" class="btn btn-success" onclick="approve()" id="bt_approve"><i class="glyphicon glyphicon-ok"></i> ยืนยันการการชำระเงินด้วยการโอนเงิน</a><%}%>
                                <a href="#" class="btn btn-warning" onclick="noapprove()"><i class="glyphicon glyphicon-remove-circle"></i> ไม่อนุมัติการชำระเงินด้วยการโอนเงิน</a>
                                <a href="index2.jsp" class="btn btn-danger"> ยกเลิกทำรายการ</a>
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
    </div>
</div>
</body>
<%@include file="../include/footer.jsp"%>
<script>
    <%if (!flag) {%>alert('ไม่พบข้อมูลอีเมล์');<%} else if (flag) {%>
        function approve() {
            $('#divbt').hide();
            console.log("กำลังทำการอนุมัติการชำระเงินให้กับลูกค้า");
            var r = confirm("ต้องการที่อนุมัติการชำระเงินใบสำรองห้องพักหมายเลข:<%=rs.getString("reservertion_id")%> หรือไม่");
            if (!r) {
                return;
            }
            var money_json = {
                reservertion_id: <%=rs.getString("reservertion_id")%>,
                type: "bank",
                money_value: <%=rs.getString("price_total")%>,
                money_type: "สลิปค่าห้อง",
                email_id:"<%=email_id_list%>",
                email:"<%=rs1.getString("email_address")%>"
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
        }
    <%}%>
        function noapprove() {
            console.log("ยกเลิกการอนุมัติการชำระเงินให้กับลูกค้า");
            var note = prompt("ไม่อนุมัติการชำระเงินใบสำรองห้องพักหมายเลข:<%=rs.getString("reservertion_id")%> ");
            if (note === null) {
                return;
            }
            $('#divbt').hide();
            console.log("ไม่อนุมัติการชำระเงินให้กับลูกค้า");
            $.ajax({
                type: "GET",
                url: "../ajax/noapprove.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>&note=" + note + "&email=<%=email%>",
                dataType: "html",
                success: function (data) {
                    location.href = "index2.jsp";
                }
            });
        }
</script>
</html>
<%
    if (flag) {
        sql = "UPDATE `email` SET `is_read`='Y' WHERE `email_address`='" + email + "';";
        db.ConExecute(sql);
    }
%>
<%}%>
