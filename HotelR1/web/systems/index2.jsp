<%@page import="ClassSystem.*"%>
<%@page import="Systems.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    session.removeAttribute("guest");
    int id = 2;
    String display = "";
    Reservation reservation = new Reservation();
    Condb db = new Condb();
    ResultSet rs = null;
    DateFunc date = new DateFunc();
    boolean flag = true;
    //ค้นหาใบสำรองห้องพัก
    if (request.getParameter("display") != null && !request.getParameter("display").equals("*")) {
        if (request.getParameter("display").equals("CHECK_OUT")) {//ด้วยเงื่อนไข ใบสำรองห้องพักเท่ากับ  CHECK_OUT
            display += " AND status_reservation='" + request.getParameter("display") + "'";
        }
        if (request.getParameter("display").equals("CHECK_IN")) {//ด้วยเงื่อนไข ใบสำรองห้องพักเท่ากับ  CHECK_IN
            display += " AND status_reservation='" + request.getParameter("display") + "'";
        }
        if (request.getParameter("display").equals("CANCEL")) {//ด้วยเงื่อนไข ใบสำรองห้องพักเท่ากับ  CANCEL
            display += " AND status_reservation='" + request.getParameter("display") + "'";
        }
        if (request.getParameter("display").equals("WAIT_CHECK_IN")) { //ด้วยเงื่อนไข ใบสำรองห้องพักเท่ากับ WAIT_CHECK_IN
            display += " AND status_reservation='" + request.getParameter("display") + "'";
            display += " AND check_in=current_date";
        }
        if (request.getParameter("display").equals("NEW")) {//ด้วยเงื่อนไข สถานะการชำระเงิน เท่ากับ ยังไม่ชำระเงิน
            display += " AND status_pay='" + request.getParameter("display") + "'" + "AND status_reservation != 'CANCEL'";
        }
        if (request.getParameter("display").equals("PAY")) {//ด้วยเงื่อนไข สถานะการชำระเงิน เท่ากับ ชำระเงินแล้ว
            display += " AND status_pay='" + request.getParameter("display") + "'";
        }
    } else if (request.getParameter("display") == null || request.getParameter("display").equals("*")){
        display += " AND status_reservation != 'CANCEL' AND status_reservation != 'CHECK_OUT'";
    }
    //ค้นหาข้อมูลลูกค้า
    if (request.getParameter("idno") != null && !request.getParameter("idno").equals("")) {//ค้นหาข้อมูลลูกค้า ด้วยเลขบัตรประจำตัวประชาชน
        display += " AND guest_idno='" + request.getParameter("idno") + "'";
    }
    rs = reservation.listReservation(display);
    if (rs != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="">
            <div class="">
                <div class="">
                    <div class="panel panel">
                        <div class="panel panel-info">
                            <div class="panel-body">
                                <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> รายการใบสำรองห้องพัก</h1>
                                <div class="well">
                                    <form class="form-inline mt-1 mt-md-0" id="myForm" style="text-align: center">                                    
                                        <input class="form-control" type="number" placeholder="หมายเลขประจำตัวประชาชน" value="<%if (request.getParameter("idno") != null) {out.print(request.getParameter("idno"));}%>" name="idno" width="100%">
                                        <button class="btn btn-info" onclick="submit()" ><i class="glyphicon glyphicon-search"></i> ค้นหาข้อมูลใบสำรองห้องพัก</button>
                                        <hr>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display" value="*" <%if (request.getParameter("display") == null) {out.print("checked");}%> <%if (request.getParameter("display") != null && request.getParameter("display").equals("*")) {out.print("checked");}%>  onclick="submit()"/> แสดงทั้งหมด /
                                            <input type="radio" name="display" value="NEW" <%if (request.getParameter("display") != null && request.getParameter("display").equals("NEW")) {out.print("checked");}%> onclick="submit()"/> ยังไม่ชำระเงิน /
                                            <input type="radio" name="display" value="PAY" <%if (request.getParameter("display") != null && request.getParameter("display").equals("PAY")) {out.print("checked");}%> onclick="submit()"/> ชำระเงินแล้ว /
                                            <input type="radio" name="display" value="WAIT_CHECK_IN" <%if (request.getParameter("display") != null && request.getParameter("display").equals("WAIT_CHECK_IN")) {out.print("checked");}%> onclick="submit()"/>  รอลงทะเบียนเข้าพัก /
                                            <input type="radio" name="display" value="CHECK_IN" <%if (request.getParameter("display") != null && request.getParameter("display").equals("CHECK_IN")) {out.print("checked");}%> onclick="submit()"/>  กำลังลงทะเบียนเข้าพัก /                                   
                                            <input type="radio" name="display" value="CHECK_OUT" <%if (request.getParameter("display") != null && request.getParameter("display").equals("CHECK_OUT")) {out.print("checked");}%> onclick="submit()"/> ส่งคืนห้องพักแล้ว /
                                            <input type="radio" name="display" value="CANCEL" <%if (request.getParameter("display") != null && request.getParameter("display").equals("CANCEL")) {out.print("checked");}%> onclick="submit()"/> ใบสำรองที่ถูกยกเลิก
                                        </div>
                                    </form>
                                </div>
                                <table width="100%" class="table table-striped table-bordered table-hover table with-pager" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>หมายเลขใบสำรอง</th>
                                            <th>วันลงทะเบียนเข้าพัก-วันส่งคืนห้องพัก</th>
                                            <th>จำนวนคืน</th>
                                            <th>เงินค่าห้อง(บาท)</th>
                                            <th>ลูกค้า</th>
                                            <th>สถานะชำระเงิน</th>
                                            <th>สถานะใบสำรอง</th>
                                            <th class="text-warning">แก้ไขเตียงเสริม</th>
                                            <th class="text-info">ย้ายห้อง</th>
                                            <th class="text-success">อนุมัติชำระเงิน</th>
                                            <th class="text-primary">ลงทะเบียนเข้าพัก / ส่งคืนห้องพัก</th>
                                            <th class="text-danger">ยกเลิกใบสำรอง</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (rs.next()) {//ลูปแสดงห้องพัก
                                                flag = false; //ถ้าเจอจะไม่เจอเตื่อน
                                        %>
                                        <tr>
                                            <td><a href="room_info.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><b>ใบที่ <%=rs.getString("reservertion_id")%></b></a></td>
                                            <td><%=date.FormatDate(rs.getString("check_in"))%> - <%=date.FormatDate(rs.getString("check_out"))%></td>
                                            <td><%=date.calDateDiff(rs.getString("check_out"), rs.getString("check_in"))%></td>                                            
                                            <td><%=rs.getDouble("price_total")%></td> 
                                            <td><a href="guest_info.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><%=rs.getString("guest_name")%></a></td>
                                            <td>
                                                <%if (rs.getString("status_pay").equals("NEW")) {%>             
                                                    <b class="alert-warning">ยังไม่ชำระเงิน</b>
                                                <%} else if (rs.getString("status_pay").equals("PAY")) {%>  
                                                    <a href="approve_info.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><b class="alert-success">ชำระเงินแล้ว</b></a>
                                                <%}%>
                                            </td>
                                            <td>
                                                <%if (rs.getString("status_reservation").equals("WAIT_CHECK_IN")) {%>             
                                                    <b class="alert-warning">รอลงทะเบียนเข้าพัก(wait for check in)</b>
                                                <%} else if (rs.getString("status_reservation").equals("CHECK_IN") && rs.getString("status_pay").equals("PAY")) {%>                                                
                                                    <b class="alert-info">ลงทะเบียนเข้าพัก(check in)</b>
                                                <%} else if (rs.getString("status_reservation").equals("CHECK_OUT") && rs.getString("status_pay").equals("PAY")) {%>                                                
                                                    <b class="alert-success">ส่งคืนห้องพัก(check out)</b>
                                                <%} else if (rs.getString("status_reservation").equals("CANCEL")) {%>                                                
                                                    <b class="alert-danger">ยกเลิกใบสำรอง</b>
                                                <%} else if (rs.getString("status_reservation").equals("CHECK_OUT") && rs.getString("status_pay").equals("NEW")) {%>                                                
                                                    <b class="alert-success">ส่งคืนห้องพัก(check out)</b>
                                                <%}%>
                                            </td>
                                            <!--<td>
                                                <%if (rs.getString("status_reservation").equals("CHECK_IN")) {%>             
                                                <a href="edit.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"  class="alert-warning"><i class="glyphicon glyphicon-edit"></i> ย้ายห้องพัก</a>
                                                <%}%>
                                                <%if (rs.getString("status_reservation").equals("WAIT_CHECK_IN")) {%>
                                                <br><a href="edit_reserv.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"  class="alert-info"><i class="glyphicon glyphicon-edit"></i> แก้ไขใบสำรอง</a>
                                                <%}%>
                                                <%if (rs.getString("note") != null && !rs.getString("note").equals("null")) {%>             
                                                <i class="glyphicon glyphicon-info-sign"></i> <span class="alert-danger"><%=rs.getString("note")%></span>
                                                <%}%>
                                            </td>-->
                                            <!--<td><%
                                                if (rs.getString("creation_date") != null) {
                                                    out.print(reservation.staffName(rs.getString("reservertion_id")));
                                                    out.print("<br>");
                                                    out.print(date.FormatDateTime(rs.getString("creation_date")));
                                                }
                                                %>
                                            </td>
                                            <td><%
                                                if (rs.getString("edit_time") != null) {
                                                    out.print(reservation.getStaffEditName(rs.getString("reservertion_id")));
                                                    out.print("<br>");
                                                    out.print(date.FormatDateTime(rs.getString("edit_time")));
                                                }
                                                %></td>
                                            <td><%
                                                if (rs.getString("cancel_time") != null) {
                                                    out.print(reservation.getStaffCancelName(rs.getString("reservertion_id")));
                                                    out.print("<br>");
                                                    out.print(date.FormatDateTime(rs.getString("cancel_time")));
                                                }%>
                                            </td> -->
                                            <td>
                                                <%if (rs.getString("status_reservation").equals("WAIT_CHECK_IN") && !rs.getString("status_pay").equals("PAY")) {%>
                                                    <a class="btn btn-warning btn-sm" href="edit_reserv.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>แก้ไขใบสำรอง</u></a>
                                                <%} else {%>
                                                    <a class="btn btn-warning btn-sm disabled">แก้ไขใบสำรอง</a>
                                                <%}%>
                                            </td>
                                            <td>
                                                <%if (rs.getString("status_pay").equals("NEW")) {%>             
                                                    <a class="btn btn-info btn-sm" href="edit.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>ย้ายห้องพัก</u></a>
                                                <%} else {%>
                                                    <a class="btn btn-info btn-sm disabled">ย้ายห้องพัก</a>
                                                <%}%>
                                            </td>
                                            <td>
                                                <%if (!rs.getString("status_reservation").equals("CANCEL") && !rs.getString("status_reservation").equals("CHECK_OUT") && !rs.getString("status_pay").equals("PAY")) {%>  
                                                <a class="btn btn-success btn-sm" href="pay_type.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>อนุมัติการชำระเงิน</u></a>
                                                <%} else {%>
                                                    <a class="btn btn-success btn-sm disabled">อนุมัติการชำระเงิน</a>
                                                <%}%>
                                            </td>
                                            <td>
                                                <%if (rs.getString("status_pay").equals("PAY") && rs.getString("status_reservation").equals("WAIT_CHECK_IN")) {%>
                                                    <a class="btn btn-primary btn-sm" href="check_in.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>ลงทะเบียนเข้าพัก(check in)</u></a>
                                                <%} else if ((!rs.getString("status_pay").equals("PAY") && rs.getString("status_reservation").equals("WAIT_CHECK_IN")) || rs.getString("status_reservation").equals("CANCEL")) {%>
                                                    <a class="btn btn-primary btn-sm disabled">ลงทะเบียนเข้าพัก(check in)</a>
                                                <%} else if (rs.getString("status_reservation").equals("CHECK_IN") && rs.getString("status_pay").equals("PAY")) {%>
                                                    <a class="btn btn-primary btn-sm" href="check_out.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>ส่งคืนห้องพัก(check out)</u></a>
                                                <%} else if (rs.getString("status_reservation").equals("CHECK_OUT")) {%>
                                                    <a class="btn btn-primary btn-sm disabled">ส่งคืนห้องพัก(check out)</a>
                                                <%}%>
                                            </td>
                                            <td>
                                                <%if (rs.getString("status_reservation").equals("WAIT_CHECK_IN")) {%>             
                                                    <a class="btn btn-danger btn-sm" href="cancel.jsp?reservertion_id=<%=rs.getString("reservertion_id")%>"><u>ยกเลิกใบสำรองห้องพัก</u></a>
                                                <%} else {%>
                                                    <a class="btn btn-danger btn-sm disabled">ยกเลิกใบสำรองห้องพัก</a>
                                                <%}%>
                                            </td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                                <nav>
                                    <ul class="pager">
                                        <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> ก่อนหน้า</a></li>
                                        <li class="next"><a href="#">ถัดไป <span aria-hidden="true">&rarr;</span></a></li>
                                    </ul>
                                </nav>
                                <a class="btn btn-danger" href="dashboard.jsp">ย้อนกลับไปหน้า Menu</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    <%if (flag) {%>
    alert("ไม่พบข้อมูลใบสำรองห้องพัก");//ถ้าไม่เจอจะแจ้งเตือน
    <%}%>
    function submit()
    {
        get("myForm").submit();
    }
</script>
<%@include file="../include/footer.jsp"%>
</html>
<%}%>