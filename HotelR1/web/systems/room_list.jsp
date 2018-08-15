<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Systems.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 0;

    session = request.getSession();

    if (request.getParameter("check_in") != null && request.getParameter("check_out") != null) {
        String check_in = request.getParameter("check_in");
        String check_out = request.getParameter("check_out");

        DateFunc date = new DateFunc();
        ConfigSystem con1 = new ConfigSystem();
        Room room = new Room();

        boolean flag = false;
        ResultSet rs = room.searchFreeRooms(check_in, check_out); // ค้นหาห้องที่ว่าง
        ArrayList<Room> room_list = new ArrayList<Room>();

        if (session.getAttribute("room_list") != null) { // ถ้ามีข้อมูลรายการห้องอยู่แล้วจะสร้างใหม่
            room_list = (ArrayList<Room>) session.getAttribute("room_list");
        }

        int index = 0;
        if (rs != null) {
%>
<%if (request.getParameter("error") != null) {%>
<script>
    alert("ไม่มีห้องในรายการ");
</script>
<%}%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="panel panel-default">
                <form action="seva_room.jsp?check_in=<%=request.getParameter("check_in")%>&check_out=<%=request.getParameter("check_out")%>" method="POST">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-3"><h4><i class="glyphicon glyphicon-home"></i> รายการข้อมูลห้องพักที่ว่าง </h4></div>
                            <div class="col-md-4"><h4><%=request.getParameter("check_in")%> - <%=request.getParameter("check_out")%></h4></div>
                            <div class="col-md-5 text-right"><a href="index.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-backward"></i> ระบุวันใหม่</a> 
                                <%if (date.calDateDiff(date.DateToMysql(request.getParameter("check_out")), date.DateToMysql(request.getParameter("check_in"))) <= (Integer.parseInt(con1.GetConfig(12)))) {%>
                                <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-forward"></i> Apply</button></div>
                                <%} else {%>
                            <span class="alert-danger"> จำนวนวันที่สำรองเกินเกินว่าทีโรงแรมกำหนด</span>
                            <%}%>
                        </div>
                    </div>
                    <!-- /.panel-heading -->

                    <div class="panel-body">
                        <div class="table-responsive">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table with-pager" id="example">
                                <thead>
                                    <tr>
                                        <th width="25%">รูปห้องพัก</th>
                                        <th>ประเภทห้องพัก</th>
                                        <th>รายละเอียด</th>
                                        <th colspan="2">ตัวเลือก</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%while (rs.next()) {
                                            flag = true;%>
                                    <tr>
                                        <td><a href="#" class="pop"><img src="image.jsp?table=room&id=<%=rs.getString("room_id")%>" width="100%"/></a></td>
                                        <td><%=rs.getString("room_type_name")%></td>
                                <input type="hidden" name="room_type_<%=rs.getInt("room_id")%>" id="room_type_<%=rs.getInt("room_id")%>" value="<%=rs.getString("room_type_id")%>" />
                                <td>
                                    <b>เลขที่ห้องพัก : <%=rs.getString("room_code")%><br>
                                        ราคาห้องพัก : <%=rs.getString("room_price")%> บาท </b>
                                    <input type="hidden" name="price_<%=rs.getInt("room_id")%>" id="price_<%=rs.getInt("room_id")%>" value="<%=rs.getString("room_price")%>" />
                                </td>
                                <td>
                                    <input type="checkbox" name="extra_bed_<%=rs.getInt("room_id")%>" id="extra_bed_<%=rs.getInt("room_id")%>" <% if (index < room_list.size() && room_list.get(index).getExtra_bed().equals("true")) {
                                            out.print("checked='checked'");
                                        }%>  onchange="bed(<%=rs.getString("room_id")%>)"/><br> เพิ่มเตียงเสริม
                                </td>
                                <td>
                                    <input type="checkbox" name="room_<%=rs.getInt("room_id")%>" id="room_<%=rs.getInt("room_id")%>" onchange="selectRoom(<%=rs.getInt("room_id")%>)" <% if (index < room_list.size() && room_list.get(index).getRoom_id() == rs.getInt("room_id")) {
                                            out.print("checked='checked'");
                                        } %>/><br> เลือกห้องนี้
                                </td>
                                </tr>
                                <%index++;
                                    }%>
                                </tbody>
                                <%if (!flag) {%>
                                <h3 class="alert-danger text-center"><i class="glyphicon glyphicon-warning-sign"></i> ไม่พบห้องว่างที่อยู่ในช่วงวัน <b><%=request.getParameter("check_in")%> - <%=request.getParameter("check_out")%></b></h3>
                                <%}%>
                            </table>

                            <nav>
                                <ul class="pager">
                                    <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> ก่อนหน้า</a></li>
                                    <li class="next"><a href="#">ถัดไป <span aria-hidden="true">&rarr;</span></a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>

<script>
    size = 0;
    function selectRoom(room_id) { //เลือกห้อง
        if (get('room_' + room_id).checked) {
            //add(room_id);
            size++;
            if (size ><%=con.GetConfig(3)%>) {//อย่าลืมใส่config
                alert("เกินจำนวนที่กำหนดไว้ <%=con.GetConfig(3)%> ห้อง");
                get('room_' + room_id).checked = false;                
                size--;
            }
        } else {
            //del(room_id);
            size--;
        }
    }

    function bed(room_id) {
        if (get('extra_bed_' + room_id).checked) {
            //add_bed(room_id);
        } else {
            //del_bed(room_id);
        }
    }

    function add(room_id) {
        console.log("ทำการเพิ่มห้องพัก");
        var extra_bed = get('extra_bed_' + room_id).checked;
        var price = get('price_' + room_id).value;
        var room_type = get('room_type_' + room_id).value;
        var action = "add";
        var room_json = {
            room_id: room_id,
            extra_bed: extra_bed,
            price: price,
            room_type: room_type,
            action: action
        };
        $.ajax({
            type: "POST",
            url: "../ajax/room_list.jsp?room_id=" + room_id + "&extra_bed=" + extra_bed + "&room_type=" + room_type + "&price=" + price + "&action=" + action,
            dataType: "html",
            success: function (data) {
                var total = parseInt(data);
                if (total ><%=con.GetConfig(3)%>) {//อย่าลืมใส่config
                    alert("เกินจำนวนที่กำหนดไว้ <%=con.GetConfig(3)%> ห้อง");
                    get('room_' + room_id).checked = false;
                }
            }
        });
    }

    function del(room_id) {
        console.log("ทำการลบห้องพัก");
        //?room_id=" + room_id + "&action=del
        var room_json = {
            room_id: room_id,
            action: "del"
        };
        $.ajax({
            type: "POST",
            url: "../ajax/room_list.jsp",
            dataType: "json",
            data: room_json,
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
</script>
</html>
<%}//rs

session.removeAttribute("room_list");
    }//checkin checkout%>