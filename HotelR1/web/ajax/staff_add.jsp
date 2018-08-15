<%@page import="ClassSystem.*"%>
<%@page import="Systems.Condb"%>
<%@page import="java.util.Random " %>%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<% 
    request.setCharacterEncoding("UTF-8");
    
    //Random random = new Random();
    Staff staff1 = new Staff();
    Staff staff2 = new Staff();
    
    //int randomNumber = random.nextInt(10000);
    //staff1.setStaff_code(String.valueOf(randomNumber) );
    staff1.setStaff_code(request.getParameter("staff_code"));
    staff1.setStaff_name(request.getParameter("staff_name"));
    staff1.setStaff_idno(request.getParameter("staff_idno"));
    staff1.setStaff_email(request.getParameter("staff_email"));
    staff1.setStaff_tel(request.getParameter("staff_tel"));
    staff1.setStaff_address(request.getParameter("staff_address"));
    staff1.setStaff_status(request.getParameter("staff_status"));
    staff1.setStaff_type_id(Integer.parseInt(request.getParameter("staff_type_id")));
    
    if ((staff1.checkStaffPassword(Integer.parseInt(request.getParameter("staff_code")))) && (staff1.checkStaffIdNoStaff(request.getParameter("staff_idno")))) {
        int status = staff2.registerStaff(staff1, staff.getStaff_id());
        response.sendRedirect("../systems/index3.jsp?msg=yes");
    } else {
        Log.SeveLog(staff.getStaff_id(), "ลงทะเบียนผู้ใช้ล้มเหลว เนื่องจากรหัสผ่านซ้ำหรือรหัสบัตรประชาชนซ้ำ", "ลงทะเบียนผู้ใช้");
        response.sendRedirect("../systems/staff_add.jsp?msg=no");
    }
%>
