<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 87;
    String sql = "SELECT * FROM configure;";
    Condb db = new Condb();
    ResultSet rs = db.ConExecuteQuery(sql);
    if (rs != null) {
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <%//ตรวจสอบว่าเป็นผู้จัการไหม
        if(staff.getStaff_type_id()!=1){
            response.sendRedirect("dashboard.jsp");//show dashboard
        }
        %>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">   
            <div class="col-lg-12">
                <div class="panel panel">
                    <div class="panel panel-info">
                        <div class="panel-body">
                            <h1 class="page-header"><i class="glyphicon glyphicon-list-alt"></i> รายการ Configuration ของระบบ</h1>
                            <div class="well">
                                <!-- <form class="form-inline mt-1 mt-md-0" id="myForm" style="text-align: center">                                    
                                    <input class="form-control" type="text" name="configure" width="100%">
                                    <button class="btn btn-info" onclick="submit()" ><i class="glyphicon glyphicon-search"></i> ค้นหา</button>
                                </form> -->
                            </div>
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID ที่ใช้อ้างอิงในระบบ</th>
                                        <th>อธิบาย configure</th>
                                        <th>ค่า configure</th>
                                        <th>หน่วย configure</th>
                                        <th><i class="glyphicon glyphicon-cog"></i></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%while (rs.next()) {%>
                                    <tr>
                                        <td><%=rs.getInt("configure_id")%></td>
                                        <td><%=rs.getString("configure_name")%></td>
                                        <td><%=rs.getString("configure_value")%></td>
                                        <td><%=rs.getString("configure_unit")%></td>
                                        <td><a href="configure.jsp?configure_id=<%=rs.getInt("configure_id")%>"> ตั้งค่า</a></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                            <a class="btn btn-danger" href="dashboard.jsp">ย้อนกลับ</a>
                        </div>
                    </div>
                </div>
                <!-- /.panel-body -->
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
<%} else {%>
<script>
    alert("ไม่พบข้อมูล");
</script>
<%}%>