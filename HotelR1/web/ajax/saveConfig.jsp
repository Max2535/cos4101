<%@page import="ClassSystem.*"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    int configure_id = Integer.parseInt(request.getParameter("configure_id"));
    String configure_value = request.getParameter("configure_value");
    String configure_unit = request.getParameter("configure_unit");
    
    ConfigSystem configSystem = new ConfigSystem();
    int status = configSystem.saveConfig(staff.getStaff_id() , configure_id, configure_value, configure_unit);
    response.sendRedirect("../systems/dashboard.jsp");
    out.print(status);
%>
