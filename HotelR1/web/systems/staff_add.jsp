<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page import="ClassSystem.*"%>
<script>
    <%  
        String massage = request.getParameter("msg");
        if (massage != null) {
            if(massage.equals("yes")) {%>
                alert("ลงทะเบียนผู้ใช้ระบบสำเร็จ");
        <%} else if (massage.equals("no")){ %>
                alert("ไม่สามารถลงทะเบียนผู้ใช้ได้ ข้อมูลบางอย่างไม่ถูกต้อง");
        <%}%>
    <%}%>
</script>
<%int id = 1;%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%
            if (staff.getStaff_type_id() != 1) {
                response.sendRedirect("dashboard.jsp");//show dashboard
            }
        %>
        <script>
            function registerStaff(form) {
                var status = false;
                var number = 0;
                
                while (status === false) {
                    number = (Math.floor(Math.random()* 10000));
                    if (number >= 1000) {
                        status = true;
                    }
                }
                //alert(number);
                get("staff_code").value = number;
                
                /*
                if (get("staff_code").value === '' ) {
                    alert("ไม่ได้ระบุรหัสผ่าน");
                    get("staff_code").focus();
                    return false;
                }
                if (isNaN(get("staff_code").value)) {
                    alert("รหัสผ่านต้องเป็นตัวเลข");
                    get("staff_code").focus();
                    return false;
                }
                if (get("staff_code").value.length !== 4) {
                    alert("รหัสผ่านต้องเป็นตัวอักษร 4 ตัว");
                    get("staff_code").focus();
                    return false;
                }
                */
                if(get("staff_name").value === '') {
                    alert("ไม่ได้ระบุชื่อผู้ใช้");
                    get("staff_name").focus();
                    return false;
                }       
                if(Number(get("staff_name").value)) {
                    //alert(Number(get("staff_name").value));
                    alert("ชื่อผู้ใช้ไม่ถูกต้อง โปรดระบุชื่อผู้ใช้ใหม่");
                    get("staff_name").focus();
                    return false;
                }
                if(get("staff_idno").value === '') {
                    alert("ไม่ได้ระบุรหัสบัตรประชาชน");
                    get("staff_idno").focus();
                    return false;
                }
                get("staff_idno").value = (parseInt(get("staff_idno").value)).toString();
                if(get("staff_idno").value.length !== 13 ) {
                    alert("ตัวเลขบัตรประชาชนรหัสไม่เท่ากับ 13 หลัก");
                    get("staff_idno").focus();
                    return false;
                }
                if(get("staff_email").value === '') {
                    alert("ไม่ได้ระบุอีเมล์ผู้ใช้");
                    get("staff_email").focus();
                    return false;
                }
                if(get("staff_tel").value === '') {
                    alert("ไม่ได้ระบุเบอร์โทรศัพท์");
                    get("staff_tel").focus();
                    return false;
                }
                if (get("staff_tel").value <= 0 ) {
                    alert("เบอร์โทรศัพท์ห้ามติดลบ");
                    get("staff_tel").focus();
                    return false;
                }
                if(get("staff_address").value === '') {
                    alert("ไม่ได้ระบุที่อยู่ผู้ใช้");
                    get("staff_address").focus();
                    return false;
                }
                
                console.log("กำลังลงทะเบียนผู้ใช้");
                var r = confirm("ต้องการบันทึกการลงทะเบียนผู้ใช้หรือไม่?");
                if (!r) {
                    return false;
                }
            }
        </script> 
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">ลงทะเบียนผู้ใช้ระบบ </h1>
                </div>
            </div>
            <div class="row show-grid well">
                <div class="col-md-6 col-md-offset-3" style="background-color: #ffffff">
                    <div class="panel-heading">
                        <h3><i class="glyphicon glyphicon-user"></i> ข้อมูลผู้ใช้ระบบ</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <!-- แบบฟอร์มลงทะเบียนผู้ใช้ -->
                                <form role="form" onsubmit="return registerStaff(this)" action="../ajax/staff_add.jsp" method="post">
                                    <!--<div class="form-group">-->
                                        <!--<label>รหัสผู้ใช้ระบบ</label> -->
                                        <input type="hidden" class="form-control" name="staff_code" id="staff_code">
                                    <!--<</div>  -->
                                    <div class="form-group">
                                        <label>ชื่อผู้ใช้ *</label>
                                        <input type="text" class="form-control" name="staff_name" id="staff_name">
                                    </div>
                                    <div class="form-group">
                                        <label>รหัสบัตรประชาชน 13 หลัก *</label>
                                        <input type="number" class="form-control" name="staff_idno" id="staff_idno" maxlength="13">
                                    </div>
                                    <div class="form-group">
                                        <label>อีเมล์ *</label>
                                        <input type="email" class="form-control" name="staff_email" id="staff_email" value="ghostpha27742@gmail.com">
                                    </div>
                                    <div class="form-group">
                                        <label>เบอร์โทรศัพท์ *</label>
                                        <input type="number" class="form-control" name="staff_tel" id="staff_tel" value="0826717665">
                                    </div>
                                    <div class="form-group">
                                        <label>ที่อยู่ *</label>
                                        <textarea class="form-control" rows="3" name="staff_address" id="staff_address">กรุงเทพ</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>ตำแหน่ง</label>
                                        <select class="form-control" name="staff_type_id" id="staff_type_id">
                                            <option value="1">ผู้จัดการ</option>
                                            <option value="2">พนักงาน</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-success"> บันทึกข้อมูลผู้ใช้ระบบ</button>
                                    <a href="#" class="btn btn-danger" onclick="window.history.back()" > ยกเลิกทำรายการ</a>
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
