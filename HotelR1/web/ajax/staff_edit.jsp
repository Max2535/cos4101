<%@page import="ClassSystem.*"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    Staff staff1 = new Staff();
    staff1.setStaff_id(Integer.parseInt(request.getParameter("staff_id")));
    //staff1.setStaff_code(request.getParameter("staff_code"));
    staff1.setStaff_name(request.getParameter("staff_name"));
    staff1.setStaff_idno(request.getParameter("staff_idno"));
    staff1.setStaff_email(request.getParameter("staff_email"));
    staff1.setStaff_tel(request.getParameter("staff_tel"));
    staff1.setStaff_address(request.getParameter("staff_address"));
    staff1.setStaff_status(request.getParameter("staff_status"));
    staff1.setStaff_type_id(Integer.parseInt(request.getParameter("staff_type_id")));
    
    int status = Staff.editStaff(staff1, staff.getStaff_id());
    
    response.sendRedirect("../systems/index3.jsp?msg=success");
%>
