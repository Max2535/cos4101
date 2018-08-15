<%@page import="ClassSystem.Reservation"%>
<%@page import="Systems.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //แสดงรายการอีเมล์ ที่ยังไม่ได้อ่าน 
    int id = 112;
    String sql = "SELECT distinct email_address,email_sentdate,email_name FROM email WHERE 1=1 order by email_id desc";
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">            
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">รายการอีเมล์แจ้งชำระเงินใบสำรองห้องพัก</h1>
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>วันเวลา</th>
                        <th>ชื่อลูกค้า</th>
                        <th>อีเมล์</th>
                        <th><i class="glyphicon glyphicon-cog"></i></th>
                    </tr>
                </thead>
                <tbody>
                    <%while (rs!=null&&rs.next()) {%>
                    <tr>
                        <td><%=rs.getString("email_sentdate")%></td>
                        <td><%=rs.getString("email_name")%></td>
                        <td><%=rs.getString("email_address")%></td>
                        <%
                        Reservation reservation=new Reservation();
                        ResultSet rs1=db.ConExecuteQuery("SELECT * FROM reservation t1 left outer join guest t2 on t1.guest_id=t2.guest_id WHERE t2.guest_email='" + rs.getString("email_address") + "' and t1.status_reservation='WAIT_CHECK_IN' and status_pay='NEW'");
                        %>
                        <td>
                            <%while(rs1.next()){%>
                            <a href="approve.jsp?reservertion_id=<%=rs1.getString("reservertion_id")%>"> อนุมัติการชำระเงินใบสำรองห้องพักหมายเลขที่: <%=rs1.getString("reservertion_id")%></a><br>
                            <%}%>
                        </td>                
                    </tr>
                    <%
                        }//WHILE
                    %>
                </tbody>
            </table>
            <a class="btn btn-danger" href="index2.jsp">ย้อนกลับไปหน้ารายการใบสำรอง</a>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
