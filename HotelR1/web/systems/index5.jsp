<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    int id = 11;
    String display = "";
    if (request.getParameter("display") != null && !request.getParameter("display").equals("*")) {
        display += " AND t1.log_type='" + request.getParameter("display") + "'";
    }
    String sql = "SELECT * FROM log t1 left outer join staff t2 on t1.staff_id=t2.staff_id left outer join staff_type t3 on t2.staff_type_id=t3.staff_type_id WHERE 1=1" + display + " order by log_id desc";
    //out.print(sql);
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    DateFunc date = new DateFunc();
    boolean flag = true;
    if (rs != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%//ตรวจสอบว่าเป็นผู้จัการไหม
            if (staff.getStaff_type_id() != 1) {
                response.sendRedirect("dashboard.jsp");//show dashboard
            }
        %>
        <script type="text/javascript">
            $(function () {
                var d = new Date();
                var toDay = d.getDate() + '/' + (d.getMonth() + 1) + '/' + (d.getFullYear() + 543);
                $("#start_date").datepicker({dateFormat: 'dd/mm/yy', isBuddhist: true, defaultDate: toDay, dayNames: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'],
                    dayNamesMin: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'],
                    monthNames: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
                    monthNamesShort: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.']});
                $("#end_date").datepicker({dateFormat: 'dd/mm/yy', isBuddhist: true, defaultDate: toDay, dayNames: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'],
                    dayNamesMin: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'],
                    monthNames: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
                    monthNamesShort: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.']});
            });
        </script>
        <style type="text/css">
            .demoHeaders { margin-top: 2em; }
            #dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
            #dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
            ul#icons {margin: 0; padding: 0;}
            ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
            ul#icons span.ui-icon {float: left; margin: 0 4px;}
            ul.test {list-style:none; line-height:30px;}
        </style>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel">
                        <div class="panel panel-info">
                            <div class="panel-body">
                                <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> รายการ Log System</h1>
                               <!-- <div class="well" id="w1">
                                    <form class="form-inline mt-1 mt-md-0" id="myForm" style="text-align: center">
                                        <input type="hidden" name="report" id="report" value="<%if (request.getParameter("display") == null) {
                                                out.print("ระบบ");
                                            } else {
                                                out.print(request.getParameter("display"));
                                            }%>" />
                                        <a class="btn btn-danger" onclick="window.history.back()"><i class="glyphicon glyphicon-backward"></i> Back</a>                                       
                                        <div class="form-group col-3">
                                            User:
                                            <div class="form-group input-group col-3">
                                                <input type="text" class="form-control" name="staff" id="staff" placeholder="ชื่อพนักงาน" required>
                                            </div>
                                            Start Date:
                                            <div class="form-group input-group col-3">
                                                <input type="text" name="start_date" class="form-control" id="start_date" placeholder="Start Date" required>
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                            End Date:
                                            <div class="form-group input-group col-3">
                                                <input type="text" name="end_date" class="form-control" id="end_date" placeholder="End Date" required>
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </div>
                                        <div class="form-group input-group col-3" style="margin-top: 5px;">
                                            <button class="btn btn-info" onclick="submit()" ><i class="glyphicon glyphicon-search"></i> ค้นหา</button>
                                            <a href="#"  class="btn btn-default" style="margin-left: 10px" onclick="printReceipt()"><i class="glyphicon glyphicon-print"></i> พิมพ์</a>                                        
                                        </div>
                                </div>

                                </form>
                            </div>-->
                            <div class="col-12" id="d1">
                                <table width="100%" class="table table-striped table-bordered table-hover table with-pager" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th width="180">วันเวลา</th>
                                            <th width="90">รหัสผู้ใช้</th>
                                            <th width="150">ชื่อผู้ใช้</th>
                                            <th width="120">ตำแหน่งผู้ใช้</th>
                                            <th width="180">กิจกรรม</th>
                                            <th>เหตุการณ์ Log</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (rs.next()) {
                                                flag = false;
                                        %>
                                        <tr>
                                            <td><%=date.FormatDateTime(rs.getString("log_time"))%></td>
                                            <td><%=rs.getString("staff_id")%></td>
                                            <td><%=rs.getString("staff_name")%></td>
                                            <td><%=rs.getString("staff_type_name")%></td>
                                            <td><b><%=rs.getString("log_type")%></b></td>
                                            <td><%=rs.getString("action")%></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                                <nav>
                                    <ul class="pager">
                                        <li class="previous"><a href="#"><span aria-hidden="true">&larr;</span> ก่อนหน้า</a></li>
                                        <li class="next"><a href="#">ถัดไป <span aria-hidden="true">&rarr;</span></a></li>
                                    </ul>
                                </nav>
                                <a class="btn btn-danger" href="dashboard.jsp">ย้อนกลับไปหน้า Menu</a>
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
    <%if (flag) {%>
    alert("ไม่พบข้อมูล!!!");
    <%}%>
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
        var mywindow = window.open('', 'PRINT', '');
        $('.w1').hide();
        var title = get('report').value;
        mywindow.document.write('<html><head><title>' + document.title + '</title>');
        mywindow.document.write('</head><body >');
        mywindow.document.write('<h1><center> รายงาน ' + title + '<center></h1>');
        mywindow.document.write(get('d1').innerHTML);
        mywindow.document.write('</body></html>');

        mywindow.document.close(); // necessary for IE >= 10
        mywindow.focus(); // necessary for IE >= 10*/

        mywindow.print();
        mywindow.close();
        $('.w1').show();
        return true;
    }
</script>

