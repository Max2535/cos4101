<%@page import="Systems.DateFunc"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%int id = 0;
    String reservertion_id = "";
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
    }
    String room_id = "";
    if (request.getParameter("room_id") != null) {
        room_id = request.getParameter("room_id");
    }
    String room_id_old = "";
    if (request.getParameter("room_id") != null) {
        room_id_old = request.getParameter("room_id");
    }
    String sql = "SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE t1.reservertion_id=" + reservertion_id + " AND status_pay<>'PAY'";
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    DateFunc date = new DateFunc();
    rs.first();    
    String guest_id=rs.getString("guest_id");    
    String check_out=rs.getString("check_out");
    //ค้นห้องช่วงเวลาcheck in check out ในใบสำรองห้องพัก ว่ามีช่องวันที่ซ้ำกัน และคาบเกี่ยวกันอยู่หรือป่าว
    sql = "SELECT room_id FROM reservation t1,reservation_detail t2"
            + " where t1.reservertion_id=t2.reservertion_id and "
            + " (check_in between '" + rs.getString("check_in") + "' and '" + rs.getString("check_out") + "') or"
            + " (check_out between '" + rs.getString("check_in") + "' and '" + rs.getString("check_out") + "');";
    rs = db.ConExecuteQuery(sql);    
    sql = "";
    while (rs != null && rs.next()) {
        sql += " and t1.room_id<>" + rs.getString("room_id");
    }
    rs = db.ConExecuteQuery("SELECT room_price FROM room WHERE room_id=" + room_id);
    rs.first();
    float price = +rs.getFloat("room_price");
    //ไม่แสดงห้อง ที่check in check out ในใบสำรองห้องพัก ซ้ำกัน และคาบเกี่ยวกันอยู่
    rs = db.ConExecuteQuery("SELECT * FROM room t1 left outer join room_type t2 on t1.room_type_id=t2.room_type_id where 1=1" + sql + " and t1.room_price=" + price + " order by t1.room_id");
    if (rs != null) {
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
                    <h1 class="page-header">ย้ายห้องพัก<small> รหัสใบสำรองห้องพัก:<code><%=reservertion_id%></code></small></h1>
                </div>
            </div>
            <div class="col-lg-12  text-center">
                <div class="panel panel-default">
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th width="25%">รูปห้องพัก</th>
                                        <th>ประเภทห้องพัก</th>
                                        <th>รายละเอียด</th>
                                        <th>ตัวเลือก</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%while (rs.next()) {%>
                                    <tr>
                                        <td><a href="#" class="pop"><img src="image.jsp?table=room&id=<%=rs.getString("room_id")%>" width="100%"/></a></td>
                                        <td><%=rs.getString("room_type_name")%></td>
                                <input type="hidden" name="room_type" id="room_type_<%=rs.getInt("room_id")%>" value="<%=rs.getString("room_type_id")%>" />
                                <td><code>เลขที่ห้องพัก:<%=rs.getString("room_id")%><br>
                                        ราคาห้องพัก:<%=rs.getString("room_price")%>.-</code>
                                </td>
                                <td><input type="checkbox" name="check1" id="room_<%=rs.getInt("room_id")%>" onchange="update(<%=rs.getInt("room_id")%>)" /><br> เลือกห้องนี้</td>
                                </tr>
                                <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <label>เหตุเหตุการแก้ไขข้อมูลห้องพัก</label>
                            <textarea name="remake" rows="5" cols="2">
                            </textarea>
                        </div>
                        <!-- /.table-responsive -->                        
                        <div class="col-lg-12 text-center">
                            <a href="#" class="btn btn-success" onclick="move_room()"><i class="glyphicon glyphicon-ok"></i> อนุมัติการย้ายห้องพัก </a>
                            <a href="#" class="btn btn-danger" onclick="window.history.back()"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิกการทำรายการ</a>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
            </div>
        </div>
    </body>
    <%@include file="../include/footer.jsp"%>
</html>
<%}%>
<script>
    var room_id_new=0;
    function update(room_id) {
        if (get('room_' + room_id).checked) {
            room_id_new=room_id;
        } else {
            room_id_newroom_id;
        }
    }
    function move_room() {
        console.log("ทำการยกเลิกเตียงเสริม");
        var tmp="../ajax/move_room.jsp?room_id_new="+room_id_new+"&room_id_old=<%=room_id_old%>&guest_id=<%=guest_id%>&reservertion_id=<%=reservertion_id%>&check_out=<%=check_out%>";
        $.ajax({
            type: "GET",
            url: tmp,
            dataType: "html",
            success: function (data) {
                //location.href="room_info.jsp?data="+data;
            }
        });
    }
</script>