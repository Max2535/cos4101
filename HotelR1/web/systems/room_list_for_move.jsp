<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 0;
    session = request.getSession();
    session.removeAttribute("room_list");
    String reservertion_id = request.getParameter("reservertion_id");
    if (request.getParameter("check_in") != null && request.getParameter("check_out") != null) {
        String check_in = request.getParameter("check_in");
        String check_out = request.getParameter("check_out");
        Room room = new Room();
        ResultSet rs = room.searchRoomsForMove(check_in, check_out, reservertion_id);
        Reservation reservation = new Reservation();
        ResultSet rs1 = reservation.GetReservationDetail(reservertion_id);
        int size = 0;
        while (rs1.next()) {
            size++;
        }
        if (rs != null) {
%>
<%if (request.getParameter("size") != null) {%>
<script>
    alert("จำนวนห้องเกินขนาดที่ทำการสำรองไว้");
</script>
<%}%>
<%if (request.getParameter("error") != null) {%>
<script>
    alert("ไม่ได้เลือกห้องที่จะย้ายไป");
</script>
<%}%>
<%if (request.getParameter("out") != null) {%>
<script>
    alert("ไมสามารถย้ายห้องพักได้เพราะถึงวัน Check out แล้ว");
    location.href="check_out.jsp?reservertion_id=<%=reservertion_id%>";
</script>
<%}%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <script>
            var flag = false;
            function initRoom(room_id) {//เลือกห้องที่อยู่ในใบสำรองมาแสดง
                get('room_' + room_id).checked = true;
            }
            function initbed(room_id) {//ดึงค่าเตรียงเสริฒออกมา
                get('extra_bed_' + room_id).checked = true;
            }
            function selectRoom(room_id) {//เลือกห้อง
                flag = true;
            }
            function checkflag() {
                if (!flag) {
                    alert('คุณยังไม่ได้เลือกห้องที่จะย้ายไป หรือไม่มีห้องว่าง');
                }
                return flag;
            }
            function bed(room_id) {
                if (get('extra_bed_' + room_id).checked) {
                    add_bed(room_id);
                } else {
                    del_bed(room_id);
                }
            }

            function add(room_id) {
                console.log("ทำการเพิ่มห้องพัก");
                var extra_bed = get('extra_bed_' + room_id).checked;
                var price = get('price_' + room_id).value;
                var room_type = get('room_type_' + room_id).value;
                var room_json = {
                    room_id: room_id,
                    extra_bed: extra_bed,
                    price: price,
                    room_type: room_type,
                    action: "add",
                    size:<%=size%>
                };
                $.ajax({
                    type: "POST",
                    url: "../ajax/room_list_move.jsp?room_id=" + room_id + "&extra_bed=" + extra_bed + "&room_type=" + room_type + "&price=" + price + "&action=" + action + "&size=<%=size%>",
                    dataType: "html",
                    success: function (data) {
                        var total = parseInt(data);
                        if (total ><%=size%>) {//ตามจำนวนห้องเติม
                            alert("เกินจำนวนที่ได้สำรองไว้ <%=size%> ห้อง");
                            get('room_' + room_id).checked = false;
                        }
                    }
                });
            }

            function del(room_id) {
                console.log("ทำการลบห้องพัก");
                $.ajax({
                    type: "GET",
                    url: "../ajax/room_list.jsp?room_id=" + room_id + "&action=del",
                    dataType: "html",
                    success: function (data) {
                        var total = parseInt(data);
                        if (total < 0) {//ตรวจสอบก่อนลบ
                            alert("ไม่มีห้องในรายการ");
                        }
                    }
                });
            }

            function add_bed(room_id) {
                console.log("ทำการเพิ่มเตียงเสริม");
                $.ajax({
                    type: "GET",
                    url: "../ajax/add_extra_bed.jsp?room_id=" + room_id,
                    dataType: "html",
                    success: function (data) {
                        alert("ทำการเพิ่มเตียงเสริม");
                    }
                });
            }
            function del_bed(room_id) {
                console.log("ทำการยกเลิกเตียงเสริม");
                $.ajax({
                    type: "GET",
                    url: "../ajax/del_extra_bed.jsp?room_id=" + room_id,
                    dataType: "html",
                    success: function (data) {
                        alert("ทำการยกเลิกเตียงเสริม");
                    }
                });
            }
            function next_step() {
                if (!flag) {
                    alert('คุณยังไม่ได้เลือกห้องที่จะย้ายไป หรือไม่มีห้องว่าง');
                    return;
                }
                $.ajax({
                    type: "GET",
                    url: "../ajax/check_room.jsp",
                    dataType: "html",
                    success: function (data) {
                        var total = parseInt(data);
                        if (total > 0) {
                            location.href = "form_move.jsp?check_in=<%=request.getParameter("check_in")%>&check_out=<%=request.getParameter("check_out")%>" + "&reservertion_id=" +<%=reservertion_id%>;
                        } else {
                            alert("ไม่มีห้องในรายการ");
                            return false;
                        }
                    }
                });
            }
        </script>
        <div class="container">  
            <form onsubmit="return checkflag();" action="seva_room_move.jsp?check_in=<%=request.getParameter("check_in")%>&check_out=<%=request.getParameter("check_out")%>&reservertion_id=<%=reservertion_id%>" method="POST">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-4"><h4><i class="glyphicon glyphicon-home"></i> รายการข้อมูลห้องพักที่ว่างในช่วง </h4></div>
                            <div class="col-md-4"><h4><%=request.getParameter("check_in")%> - <%=request.getParameter("check_out")%></h4></div>
                            <div class="col-md-4 text-right"><a href="edit.jsp?reservertion_id=<%=reservertion_id%>" class="btn btn-danger"><i class="glyphicon glyphicon-backward"></i> กลับ</a> 
                                <button type="submit" class="btn btn-success" id="next_bt"><i class="glyphicon glyphicon-forward"></i> Apply</button></div>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
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
                                    <%while (rs.next()) {%>
                                    <tr>
                                        <td><a href="#" class="pop"><img src="image.jsp?table=room&id=<%=rs.getString("room_id")%>" width="100%"/></a></td>
                                        <td><%=rs.getString("room_type_name")%></td>
                                <input type="hidden" name="room_type_<%=rs.getInt("room_id")%>" id="room_type_<%=rs.getInt("room_id")%>" value="<%=rs.getString("room_type_id")%>" />
                                <td><b>เลขที่ห้องพัก:<%=rs.getString("room_id")%><br>
                                        ราคาห้องพัก:<%=rs.getString("room_price")%> บาท</b>
                                    <input type="hidden" name="price_<%=rs.getInt("room_id")%>"id="price_<%=rs.getInt("room_id")%>" value="<%=rs.getString("room_price")%>" />
                                </td>
                                <td>
                                    <input type="checkbox" name="extra_bed_<%=rs.getInt("room_id")%>"  id="extra_bed_<%=rs.getInt("room_id")%>" 
                                           <%
                                               rs1 = reservation.GetReservationDetail(reservertion_id);
                                               while (rs1.next()) {
                                                   if (rs.getInt("room_id") == rs1.getInt("room_id")) {
                                                       if (rs1.getString("extra_bed").equals("true")) {
                                                           out.print("checked");
                                                       }
                                                   }
                                               }%>  onchange="bed(<%=rs.getString("room_id")%>)"/><br> เพิ่มเตียงเสริม
                                </td>
                                <td onclick="flag = true;">
                                    <input type="checkbox" name="room_<%=rs.getInt("room_id")%>" id="room_<%=rs.getInt("room_id")%>" onchange="selectRoom(<%=rs.getInt("room_id")%>)" 
                                           <%
                                               rs1 = reservation.GetReservationDetail(reservertion_id);
                                               while (rs1.next()) {

                                                   if (rs.getInt("room_id") == rs1.getInt("room_id")) {
                                                       out.print("checked");
                                                   }
                                               }%>/><br> เลือกห้องนี้
                                </td>
                                </tr>
                                <%}%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>

</html>
<%}//rs
    }//checkin checkout%>