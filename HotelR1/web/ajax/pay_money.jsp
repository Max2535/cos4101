<%@page import="ClassSystem.Log"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<%//อนุมัติการชำระเงิน
    request.setCharacterEncoding("UTF-8");
    Condb db = new Condb();
    String reservertion_id = request.getParameter("reservertion_id");
    String money_value = request.getParameter("money_value");
    String sql="";
    
    if (reservertion_id != null) {
        sql="INSERT INTO `money` (`money_value`, `staff_id`, `reservertion_id`, `money_type`) VALUES ('"+money_value+"', '"+staff.getStaff_id()+"', '"+reservertion_id+"', 'ชำระเงิน');";
        db.ConExecute(sql);
        sql="UPDATE `hotel`.`reservation` SET `payment_type`='money' WHERE `reservertion_id`='"+reservertion_id+"'";
        db.ConExecute(sql);
        out.print(1);
        Log.SeveLog(staff.getStaff_id(), "อนุมัติการชำระเงินด้วยเงินสดสำเร็จ หมายเลขใบสำรองห้องพักที่ : " + reservertion_id, "อนุมันการชำระเงิน");
    } else {
        out.print(-1);
    }
%>
