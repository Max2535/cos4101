<%@page import="ClassSystem.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession();
    Staff staff = new Staff();
    if (session.getAttribute("staff") != null) {
        staff = (Staff)session.getAttribute("staff");
    }
    if (!request.getParameter("id").equals("1")) {        
        Authentication authentication=new Authentication();
        boolean flag_login=authentication.logout(staff.getStaff_id(),staff.getStaff_name());
        session.setAttribute("flag_login", flag_login);
        session.invalidate();
        response.sendRedirect("login.jsp");
    } else {
%>
<!DOCTYPE html>
<html>
    <head>
        <title>กำลังเปลื่ยนเส้นทาง</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <script>
            var con = confirm("ไม่อนุญาติให้ logout ในหน้านี้");
            if (con) {
                window.history.back();
            } else {
                window.history.back();
            }
        </script>
    </body>
</html>
<%}%>