<%@page import="ClassSystem.Log"%>
<%@page import="Systems.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%//อนุมัติการชำระเงิน
    request.setCharacterEncoding("UTF-8");
    Condb db = new Condb();
    String reservertion_id = request.getParameter("reservertion_id");
    String note = request.getParameter("note");
    String email = request.getParameter("email");
    GmailClient gmail = new GmailClient();
    if (reservertion_id != null) {
        String sql = "UPDATE `reservation` SET `creation_date`=NOW(),`note`='" + note + "' WHERE `reservertion_id`='" + reservertion_id + "';";
        db.ConExecute(sql);
        out.print(1);
        gmail.setAccountDetails(Systems.Data.Email, Systems.Data.PasswordEmail);
        gmail.sendGmail(Systems.Data.Email, email, "ไม่อนุมัติการชำระเงินด้วยการโอนเงิน ใบสำรองห้องพักเลขที่ " + reservertion_id, note);
        Log.SeveLog(staff.getStaff_id(), note, "ไม่อนุมัติการชำระเงินด้วยการโอนเงิน");
    } else {
        out.print(-1);
    }
%>
