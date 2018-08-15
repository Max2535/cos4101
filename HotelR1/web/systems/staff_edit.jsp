<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 2;
    String staff_id = request.getParameter("staff_id");
    Staff staff1 = Staff.getStaffById(Integer.parseInt(staff_id));
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%//ตรวจสอบว่าเป็นผู้จัการไหม
        if(staff.getStaff_type_id()!=1){
            response.sendRedirect("dashboard.jsp");//show dashboard
        }
        %>
        <script>
            function edit()
            {
                /*if (get("staff_code").value === '' ) {
                    alert("ไม่ได้ระบุรหัสผ่าน");
                    get("staff_code").focus();
                    return false;
                }*/
                if(get("staff_name").value === '') {
                    alert("ไม่ได้ระบุชื่อผู้ใช้");
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
                if(get("staff_address").value === '') {
                    alert("ไม่ได้ระบุที่อยู่ผู้ใช้");
                    get("staff_address").focus();
                    return false;
                }
                
                console.log("กำลังแก้ไขการลงทะเบียนผู้ใช้");
                var r = confirm("ต้องการแก้ไขการลงทะเบียนผู้ใช้หรือไม่?");
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
                    <h1 class="page-header"><i class="glyphicon glyphicon-edit"></i> แก้ไขข้อมูลผู้ใช้ระบบ</h1>
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
                                <form role="form" action="../ajax/staff_edit.jsp" onsubmit="return edit(this)" method="post">
                                    <input type="hidden" name="staff_id" value="<%=Integer.parseInt(staff_id) %>" />
                                    <div class="form-group">
                                        <label>ชื่อนามสกุล *</label>
                                        <input type="text" class="form-control" name="staff_name" id="staff_name" value="<%=staff1.getStaff_name() %>">
                                    </div>
                                    <div class="form-group">
                                        <label>รหัสบัตรประชาชน 13 หลัก *</label>
                                        <input type="number" class="form-control" name="staff_idno" id="staff_idno" value="<%=staff1.getStaff_idno() %>" maxlength="13">
                                    </div>
                                    <div class="form-group">
                                        <label>อีเมล์ *</label>
                                        <input type="text" type="email" class="form-control" name="staff_email" id="staff_email" value="<%=staff1.getStaff_email() %>">
                                    </div>
                                    <div class="form-group">
                                        <label>เบอร์โทรศัพท์ *</label>
                                        <input type="number" class="form-control" name="staff_tel" id="staff_tel" value="<%=staff1.getStaff_tel() %>">
                                    </div>
                                    <div class="form-group">
                                        <label>ที่อยู่ *</label>
                                        <textarea class="form-control" rows="3" name="staff_address" id="staff_address" ><%=staff1.getStaff_address() %></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>ตำแหน่ง</label>
                                        <select class="form-control" name="staff_type_id">
                                            <option value="2" <%if (staff1.getStaff_type_id() == 2) {out.print("selected");}%>>พนักงาน</option>
                                            <option value="1" <%if (staff1.getStaff_type_id() == 1) {out.print("selected");}%>>ผู้จัดการ</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-save-file"></i> บันทึกแก้ไขข้อมูลผู้ใช้ระบบ</button>
                                    <a href="index3.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิกแก้ไข</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../include/footer.jsp"%>
</html>
