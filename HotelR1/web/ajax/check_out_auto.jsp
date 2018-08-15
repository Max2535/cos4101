<%@page import="ClassSystem.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../include/security.jsp"%>
<script src="../vendor/jquery/jquery.min.js"></script>
<script>
    console.log("เข้ามาแล้วจ้าาา CHECK OUT");
</script>
<%  
    request.setCharacterEncoding("UTF-8");

    Reservation reservation = new Reservation();
    out.print(reservation.checkOutReservationAutomation(staff.getStaff_id()));
    
    /*
    DateFunc date = new DateFunc();
    String sql = "SELECT * FROM reservation WHERE status_reservation='CHECK_IN' or status_reservation='WAIT_CHECK_IN'";
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    String list = "";
    ConfigSystem con = new ConfigSystem();
    while (rs.next()) {//ยังผิด ยุ SELECT DATEDIFF('2018-03-12 12:00:00','2018-03-12 12:00:01') as date
        if (date.calDateDiff(rs.getString("check_out"), date.DateToMysql(date.getDate(0))) == 0) { //ต้องเป็นวันเดียวกันก่อน
            if (date.TimeCheckOut() == 0) {//ถ้าหลังจากเวลา check out แล้ว จะทำ
                list += rs.getString("reservertion_id") + ",";
            }
        }
    }//อย่าลืมใส่เหตุผล
    if (!list.equals("")) {
        sql = "UPDATE `reservation` SET `status_reservation`='CHECK_OUT',`note`='ไม่มาลงทะเบียนเข้าพัก หรือ ไม่มาส่งคืนห้องพักที่หน้าเค้าเตอร์' WHERE `reservertion_id` IN (" + list + "0)";
        db.ConExecute(sql);
    }
    Log.SeveLog(staff.getStaff_id(), "ระบบทำการส่งคืนห้องพักอัตโนมัติใบสำรองหมายเลข : " + list + " เพราะไม่ได้ทำการส่งคืนห้องในวันเวลาที่กำหนดในใบสำรอง", "ส่งคืนห้องพักอัตโนมัติ");
    out.print(list);
    */
%>