<%@page import="ClassSystem.Log"%>
<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    int id = 11;
    String sql = "";
    Condb db = new Condb();
    ResultSet rs = null;
    float temp = 0.0f;
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>   
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <%            if (request.getParameter("flag") != null && request.getParameter("flag").equals("true")) {
                db.ConExecute("DELETE FROM `money` WHERE `staff_id`='" + staff.getStaff_id() + "';");
                Log.SeveLog(staff.getStaff_id(), "ได้ทำการเคลียร์เงินออกจากระบบแล้ว จำนวน:" + request.getParameter("price"), "ใบนำส่งเงิน");
            }
            sql = "SELECT * FROM staff t1 left outer join money t2 on t1.staff_id=t2.staff_id WHERE t1.staff_id=" + staff.getStaff_id();
            rs = db.ConExecuteQuery(sql);
            DateFunc date = new DateFunc();
            boolean flag = true;
            if (rs != null) {
        %>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <%if (flag) {%>
                    <div class="alert-danger">ไม่พบข้อมูล!!!</div>
                    <%}%>
                    <div class="panel panel">
                        <div class="panel panel-info">
                            <div class="panel-body">
                                <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> ใบนำส่งเงิน</h1>                                
                                <div class="col-12" id="d1">
                                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                        <thead>
                                            <tr>
                                                <th>วันเวลา</th>
                                                <th>รหัสผู้ใช้</th>
                                                <th>ชื่อพนักงาน</th>
                                                <th>รหัสใบสำรองห้องพัก</th>
                                                <th>เงินค่า</th>
                                                <th>จำนวนเงิน</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                while (rs.next() && rs.getString("money_pay_datetime") != null) {
                                                    flag = false;
                                                    if (rs.getFloat("money_value") > 0.0) {
                                            %>
                                            <tr>
                                                <td><%=date.FormatDateTime(rs.getString("money_pay_datetime"))%></td>
                                                <td><%=rs.getString("staff_id")%></td>
                                                <td><%=rs.getString("staff_name")%></td>
                                                <td><%=rs.getString("reservertion_id")%></td>                                                
                                                <td><%=rs.getString("money_type")%></td>
                                                <td><%=rs.getFloat("money_value")%>.-</td>
                                                <%temp += rs.getFloat("money_value");%>
                                            </tr>
                                            <%}//_IF
                                                }//WHILE%>
                                            <tr>
                                                <td>รวมเงิน</td>
                                                <td colspan="4"></td>
                                                <td><%=temp%>.-</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="well text-right" id="w1">
                                    <%if (!flag) {%>
                                    <a href="#"  class="btn btn-default" onclick="printReceipt()"><i class="glyphicon glyphicon-print"></i> พิมพ์</a>                                        
                                    <%}%>
                                    <a href="#" class="btn btn-danger" onclick="window.history.back()"><i class="glyphicon glyphicon-backward"></i> กลับ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
        </div>
    </div>
</body>
<script>

    function submit()
    {
        get("myForm").submit();
    }
    <%if (request.getParameter("msg") != null) {%>
    alert("<%=request.getParameter("msg")%>");
    <%}%>
</script>
<%@include file="../include/footer.jsp"%>
</html>
<%} else {
        out.print(sql);
    }%>
<script>
    function printReceipt()
    {
        var n = confirm("คุณต้องการที่จะจำหน่อยเงินออกหรือไม่");
        if (!n) {
            return;
        }
        var mywindow = window.open('', 'PRINT', '');
        var title = "ใบนำส่งเงิน";
        mywindow.document.write('<html><head><title>' + document.title + '</title>');
        mywindow.document.write('</head><body >');
        mywindow.document.write('<h1><center>' + title + '<center></h1>');
        mywindow.document.write(get('d1').innerHTML);
        mywindow.document.write('</body></html>');

        mywindow.document.close(); // necessary for IE >= 10
        mywindow.focus(); // necessary for IE >= 10*/

        mywindow.print();
        mywindow.close();
        location.href = "money_sum.jsp?flag=true&price=<%=temp%>";
        return true;
    }
</script>

