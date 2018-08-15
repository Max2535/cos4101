<%@page import="ClassSystem.Log"%>
<%@page import="Systems.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%//อนุมัติการชำระเงิน
    request.setCharacterEncoding("UTF-8");
    response.setContentType("application/json");
    Condb db = new Condb();
    String reservertion_id = request.getParameter("reservertion_id");
    String money_value = request.getParameter("money_value");
    String type = request.getParameter("note");
    String money_type = request.getParameter("money_type");
    String email_id = null;
    String email = request.getParameter("email");
    GmailClient gmail = new GmailClient();
    if (request.getParameter("email_id") != null) {
        email_id = request.getParameter("email_id");
    }
    if (reservertion_id != null) {
        String sql = "UPDATE `reservation` SET `time_pay`=NOW(),`status_pay`='PAY',`payment_type`='" + type + "',`email_id`='" + email_id + "' WHERE `reservertion_id`='" + reservertion_id + "';";
        db.ConExecute(sql);
        sql = "INSERT INTO `money` (`money_value`, `staff_id`, `reservertion_id`, `money_type`) VALUES ('" + money_value + "', '" + staff.getStaff_id() + "', '" + reservertion_id + "', '" + money_type + "');";
        db.ConExecute(sql);
        out.print(1);
        if(type == null) {
            type = "อนุมัติการชำระเงินด้วยการโอนเงิน ";
        }
        Log.SeveLog(staff.getStaff_id(), type + "ใบสำรองหมายเลขที่ " +reservertion_id, "อนุมันการชำระเงิน");
    } else {
        out.print(-1);
    }
    if (type.equals("bank")) {

        gmail.setAccountDetails(Systems.Data.Email, Systems.Data.PasswordEmail);
        gmail.sendGmail(Systems.Data.Email, email, "อนุมันการชำระเงิน ใบสำรองห้องพักเลขที่" + reservertion_id, "ทางโรงแรมได้อนุมัติการชำระเงิน ใบสำรองห้องพักเลขที่ " + reservertion_id + " แล้ว");
    }
%>
