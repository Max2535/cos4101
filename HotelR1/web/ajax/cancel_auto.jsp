<%@page import="ClassSystem.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    Reservation reservation = new Reservation();
    out.print(reservation.cancelReservationAutomation(staff.getStaff_id()));

    /*
    Condb db = new Condb();
    DateFunc date = new DateFunc();
    String sql = "SELECT * FROM reservation WHERE status_pay='NEW' and status_reservation<>'CANCEL'";
    ResultSet rs = db.ConExecuteQuery(sql);
    
    String list = "";
    
    while (rs.next()) {
        if (date.calDateDiff(rs.getString("creation_date"), date.getTimeNow()) != 0) { //ต้องเป็นวันเดียวกันก่อน
            list += rs.getString("reservertion_id") + ",";
            Log.SeveLog(staff.getStaff_id(), "ยกเลิกใบสำรองห้องพักอัติโนมัติ : " + list, "ยกเลิกใบสำรองห้องพักอัติโนมัติ");
        }
    }
    
    if (!list.equals("")) {
        sql = "UPDATE `reservation` SET `status_reservation`='CANCEL',`note`='ไม่ได้ชำระเงินภายใน 24 ชม.' WHERE `reservertion_id` IN (" + list + "0)";
        db.ConExecute(sql);
    }
*/
%>