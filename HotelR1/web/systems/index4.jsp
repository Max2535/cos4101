<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 0;
    String display = "";
    if (request.getParameter("display") != null && !request.getParameter("display").equals("*")) {
        display += " AND t1.room_type_id='" + request.getParameter("display") + "'";
    }
    if (request.getParameter("room_code") != null && !request.getParameter("room_code").equals("")) {
        display += " AND t1.room_code='" + request.getParameter("room_code") + "'";
    }
    String sql = "SELECT * FROM room t1 left outer join room_type t2 on t1.room_type_id=t2.room_type_id WHERE 1=1" + display;
    //out.print(sql);
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    DateFunc date = new DateFunc();
    boolean flag = true;
    if (rs != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%//ตรวจสอบว่าเป็นผู้จัการไหม
            if (staff.getStaff_type_id() != 1) {
                response.sendRedirect("dashboard.jsp");//show dashboard
            }
        %>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel">
                        <div class="panel panel-info">
                            <div class="panel-body">
                                <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> รายการข้อมูลห้องพัก</h1>
                                <div class="well">
                                    <form class="form-inline mt-1 mt-md-0" id="myForm" style="text-align: center">                                   
                                        <input class="form-control" type="text" placeholder="หมายเลขที่ห้องพัก" value="<%if (request.getParameter("room_code") != null) {out.print(request.getParameter("room_code"));}%>" name="room_code" width="100%">
                                        <button class="btn btn-info" onclick="submit()" ><i class="glyphicon glyphicon-search"></i> ค้นหาข้อมูลห้องพัก</button>
                                        <a class="btn btn-success" href="room_add.jsp"><i class=" glyphicon glyphicon-plus-sign"></i> เพิ่มข้อมูลห้องพัก</a>
                                        <hr>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display" value="*" <%if (request.getParameter("display") == null) {out.print("checked");}%> <%if (request.getParameter("display") != null && request.getParameter("display").equals("*")) {out.print("checked");}%>  onclick="submit()"/> แสดงห้องทั้งหมด /
                                            <input type="radio" name="display" value="2" <%if (request.getParameter("display") != null && request.getParameter("display").equals("2")) {out.print("checked");}%> onclick="submit()"/> เตียวคู่ /
                                            <input type="radio" name="display" value="1" <%if (request.getParameter("display") != null && request.getParameter("display").equals("1")) {out.print("checked");}%> onclick="submit()"/> เตียงเดียว
                                        </div>
                                    </form>
                                </div>
                                <table width="100%" class="table table-striped table-bordered table-hover table with-pager" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>เลขที่ห้องพัก</th>
                                            <th>ประเภทห้องพัก</th>
                                            <th>ราคาห้อง (บาท)</th>
                                            <!-- <th>สถานะห้องพัก</th> -->
                                            <th>รูปภาพ</th>
                                            <th>แก้ไขข้อมูลห้องพัก</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (rs.next()) {
                                                flag = false;
                                        %>
                                        <tr>
                                            <td><%=rs.getString("room_code")%></td>
                                            <td><%=rs.getString("room_type_name")%></td>
                                            <td><%=rs.getString("room_price")%></td>
                                            <!-- <td><%=rs.getString("room_status")%></td> -->
                                            <td  style=" width: 300px"><a href="#" class="pop"><img src="image.jsp?table=room&id=<%=rs.getString("room_id")%>" width="100%"/></a></td>
                                            <td><a class="btn btn-info" href="room_edit.jsp?room_id=<%=rs.getString("room_id")%>">แก้ไขข้อมูลห้องพัก</a></td> 
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
    alert("ไม่พบข้อมูล!!!");
    <%}%>
    function submit()
    {
        get("myForm").submit();
    }
    <%  
        String massage = request.getParameter("msg");
        if (massage != null) {
            if(massage.equals("yes")) {%>
                alert("บันทึกข้อมูลห้องพักสำเร็จ");
        <%} else if (massage.equals("no")){ %>
            alert("ไม่สามารถบันทึกข้อมูลห้องพัก หมายเลขห้องพักซ้ำ");
        <%}%>
    <%}%>
</script>
<%@include file="../include/footer.jsp"%>
</html>
<%} else {
        out.print(sql);
    }%>

