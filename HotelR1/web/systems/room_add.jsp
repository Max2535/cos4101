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
<%int id = 1;//เปลื่ยนตรงนี้ด้วย%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%
            if (staff.getStaff_type_id ()!= 1) {
                 response.sendRedirect("dashboard.jsp");
            }
        %>
        <script>
            function saveRoom(form) {
                
                if (get("room_code").value.length>10) {
                    alert("ความยาวเกินกำหนด");
                    get("room_code").focus();
                    return false;
                }
                
                
                var test=/^[A-Za-z0-9]*$/.test(get("room_code").value);               
                if (!test) {
                    alert("หมายเลขห้องไม่ถูกต้อง ต้องเป็นตัวอังกฦษหรือตัวเลขเท่านั้น::::::::"+test);
                    get("room_code").focus();
                    return false;
                }
                
                if (get("room_code").value === '' ) {
                    alert("ไม่ได้ระบุหมายเลขห้องพัก");
                    get("room_code").focus();
                    return false;
                }
               /* if (get("room_id").value <= 0 ) {
                    alert("ห้ามหมายเลขห้องพักติดลบ");
                    get("room_id").focus();
                    return false;
                }*/
                if (get("room_price").value === '' ) {
                    alert("ไม่ได้ระบุราคาค่าห้องพัก");
                    get("room_price").focus();
                    return false;
                }
                if (get("room_price").value <= 0 ) {
                    alert("ห้ามราคาค่าห้องต้องติดลบหรือเป็น 0");
                    get("room_price").focus();
                    return false;
                }
                if (get("room_image").value === '' ) {
                    alert("ไม่ได้อัพโหลดรูป");
                    get("room_image").focus();
                    return false;
                }
                //get("room_id").value = (parseInt(get("room_id").value)).toString() ;
                get("room_price").value = (parseInt(get("room_price").value)).toString();
                
                console.log("กำลังเพิ่มห้องพัก");
                var r = confirm("ต้องการบันทึกการเพิ่มห้องพักหรือไม่?");
                if (!r) {
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="glyphicon glyphicon-plus-sign"></i> เพิ่มข้อมูลห้องพัก</h1>
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
                                <!-- -->
                                <form role="form" action="../room_add" onsubmit="return saveRoom()" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label>หมายเลขที่ห้องพัก *</label>
                                        <input type="text" name="room_code" id="room_code" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>ราคาห้องพัก (บาท) *</label>
                                        <input type="number" name="room_price" id="room_price" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>รูปภาพห้องพัก *</label>
                                        <input type="file" class="form-control" id="room_image" name="room_image">
                                    </div>
                                    <div class="form-group">
                                        <label>ประเภทห้องพัก</label>
                                        <select class="form-control" name="room_type_id" id="room_type_id">
                                            <option value="1">เตียงเดียว</option>
                                            <option value="2">เตียวคู่</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-save-file"></i> บันทึกข้อมูลห้องพัก</button>
                                    <a href="#" class="btn btn-danger" onclick="window.history.back()" ><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิก</a>
                                </form>
                            </div>
                        </div>
                        <!-- /.row (nested) -->
                    </div>
                </div>
            </div>
        </div>
    </body>
    <%@include file="../include/footer.jsp"%>
</html>