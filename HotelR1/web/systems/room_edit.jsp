<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
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
<%
    int id = 0;
    String display = "";
    if (request.getParameter("room_id") != null) {
        display += " t1.room_id='" + request.getParameter("room_id") + "'";
    }
    String sql = "SELECT * FROM room t1 left outer join room_type t2 on t1.room_type_id=t2.room_type_id WHERE" + display;
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    boolean flag = true, flag_image = true;
    if (rs.next()) {
        flag = false;
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
                    <h1 class="page-header"><i class="glyphicon glyphicon-edit"></i> แก้ไขข้อมูลห้องพัก</h1>
                </div>
            </div>
            <div class="row show-grid well">
                <div class="col-md-6 col-md-offset-3" style="background-color: #ffffff">
                    <div class="panel-heading">
                        <h3><i class="glyphicon glyphicon-home"></i> ข้อมูลห้องพัก</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" action="../room_edit" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="room_id" id="room_id" value="<%=rs.getInt("room_id")%>" />
                                    <div class="form-group">
                                        <label>เลขที่ห้องพัก</label>
                                        <input type="text" class="form-control" name="room_code" value="<%=rs.getString("room_code")%>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>ราคาห้องพัก</label>
                                        <input type="number" class="form-control" name="room_price" value="<%=rs.getString("room_price")%>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>ประเภทห้องพัก</label>
                                        <%
                                            String msg="";
                                            if((rs.getString("room_type_id") != null && rs.getString("room_type_id").equals("1"))){
                                                msg="เตียงเดียว";
                                            }else{
                                                msg="เตียงคู่";
                                            }
                                        %>
                                        <!--<input type="text" class="form-control" name="#" value="<%=msg%>" readonly>   
                                        <input type="hidden" name="room_type_id" id="room_type_id" value="<%=rs.getInt("room_type_id")%>" />-->
                                        <select class="form-control" name="room_type_id">
                                            <option value="2" <%if (rs.getString("room_type_id") != null && rs.getString("room_type_id").equals("2")) {
                                                    out.print("selected");
                                                }%> >เตียงคู่</option>
                                            <option value="1" <%if (rs.getString("room_type_id") != null && rs.getString("room_type_id").equals("1")) {
                                                    out.print("selected");
                                                }%>>เตียงเดียว</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>รูปภาพห้องพัก</label>
                                        <a href="#" class="pop"><img src="image.jsp?table=room&id=<%=rs.getString("room_id")%>" width="100%"/></a><hr>
                                        <input type="file" class="form-control" name="room_image" onchange="check_upload() ">
                                    </div>
                                    <!-- <div class="form-group">
                                        <label>เหตุเหตุการแก้ไขข้อมูลห้องพัก</label>
                                        <textarea name="remake" rows="32" cols="5">
                                        </textarea>
                                    </div> -->
                                    <%flag_image = (rs.getBlob("room_image") == null) ? true : false;%>
                                    <input type="hidden" name="flag" id="flag" value="<%=flag_image%>" />
                                    <button type="submit" class="btn btn-success">บันทึกแก้ไขข้อมูลห้องพัก</button>
                                    <a class="btn btn-danger" onclick="window.history.back()"> ยกเลิก</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        <%if (flag) {%>
        alert("ไม่พบข้อมูลใบสำรองห้องพัก");
        <%}%>
        function submit()
        {
            get("myForm").submit();
        }
        function check_upload() {//กรณีอัพโหลดรูปใหม่
            if ($('#room_image').val() !== "") {
                get('flag').value = "true";
            } else {
                get('flag').value = "false";
            }
        }
    </script>
    <%@include file="../include/footer.jsp"%>
</html>
<%} else {
        out.print(sql);
    }%>
