<%@page import="Systems.DateFunc"%>
<%@page import="Systems.Condb"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 2;
    String display = "";
    if (request.getParameter("display") != null && !request.getParameter("display").equals("*")) {
        display += " AND t1.staff_type_id='" + request.getParameter("display") + "'";
    }
    if (request.getParameter("idno") != null && !request.getParameter("idno").equals("")) {
        display += " AND t1.staff_idno='" + request.getParameter("idno") + "'";
    }
    String sql = "SELECT * FROM staff t1 left outer join staff_type t2 on t1.staff_type_id=t2.staff_type_id WHERE 1=1" + display;
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    boolean flag = true;
    DateFunc data = new DateFunc();
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
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel">
                        <div class="panel panel-info">
                            <div class="panel-body">
                                <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> รายการข้อมูลผู้ใช้ระบบ</h1>
                                <div class="well">
                                    <form class="form-inline mt-1 mt-md-0" id="myForm" style="text-align: center">                               
                                        <input class="form-control" type="text" placeholder="หมายเลขประจำตัวประชาชน" name="idno" width="100%" value="<%if (request.getParameter("idno") != null) {
                                                out.print(request.getParameter("idno"));
                                            } %>"/>
                                        <button class="btn btn-info" onclick="submit()"><i class="glyphicon glyphicon-search"></i> ค้นหาข้อมูลผู้ใช้ระบบ</button>
                                        <a class="btn btn-success " href="staff_add.jsp"><i class=" glyphicon glyphicon-plus-sign"></i> ลงทะเบียนผู้ใช้ระบบ</a>
                                        <hr>
                                        <div class="custom-control custom-radio">
                                            <input type="radio" name="display" value="*" <%if (request.getParameter("display") == null) {
                                                    out.print("checked");
                                                }%> <%if (request.getParameter("display") != null && request.getParameter("display").equals("*")) {
                                                    out.print("checked");
                                                }%>  onclick="submit()"/> แสดงรายชื่อทั้งหมด
                                            <input type="radio" name="display" value="2" <%if (request.getParameter("display") != null && request.getParameter("display").equals("2")) {
                                                    out.print("checked");
                                                }%> onclick="submit()"/> พนักงาน
                                            <input type="radio" name="display" value="1" <%if (request.getParameter("display") != null && request.getParameter("display").equals("1")) {
                                                    out.print("checked");
                                                }%> onclick="submit()"/> ผู้จัดการ
                                        </div>
                                    </form>
                                </div>
                                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>รหัสผู้ใช้ระบบ</th>
                                            <th>ชื่อนามสกุล</th>
                                            <th>รหัสบัตรประชาชน</th>
                                            <th>อีเมล์</th>
                                            <th>เบอร์โทรศัพท์</th>
                                            <th>ที่อยู่</th>
                                            <th>ตำแหน่ง</th>
                                            <th colspan="3" style=" width: 200px" class="text-center">แก้ไข</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (rs.next()) {
                                                flag = false;
                                        %>
                                        <tr>
                                            <td><%=rs.getString("staff_code")%></td>
                                            <td><%=rs.getString("staff_name")%></td>
                                            <td><%=rs.getString("staff_idno")%></td>
                                            <td><%=rs.getString("staff_email")%></td>
                                            <td><%=rs.getString("staff_tel")%></td>
                                            <td><%=rs.getString("staff_address")%></td>
                                            <td><%=rs.getString("staff_type_name")%></td>
                                            <td>
                                                <a href="staff_edit.jsp?staff_id=<%=rs.getString("staff_id")%>"><i class="glyphicon glyphicon-edit"></i> แก้ไขข้อมูลผู้ใช้ระบบ</a><br>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">Login:<%=data.FormatDateTime(rs.getString("login"))%></td>
                                            <%if (rs.getString("logout") != null) {%>
                                            <td colspan="4">Logout:<%=data.FormatDateTime(rs.getString("logout"))%></td>
                                            <%} else {%>
                                            <%
                                                sql = "SELECT log.* FROM log where staff_id=" + rs.getString("staff_id")+" order by log_id desc";
                                                ResultSet rs1 = db.ConExecuteQuery(sql);
                                            %>                     
                                            <%if (rs1.first()) {%>
                                            <td colspan="4">Last Transitions:<%=data.FormatDateTime(rs1.getString("log_time"))%>,<%=rs1.getString("log_type")%></td>
                                            <%}%>
                                            <%}%>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
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