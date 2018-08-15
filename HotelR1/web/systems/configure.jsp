<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 1;
    String sql = "";
    Condb db = new Condb();
    String configure_id = request.getParameter("configure_id");
    ResultSet rs = null;
    /*if (request.getParameter("submit") != null) {
        sql = "UPDATE `configure` SET `configure_value`='" + request.getParameter("configure_value") + "' WHERE `configure_id`='" + configure_id + "';";
        db.ConExecute(sql);
        response.sendRedirect("configure_list.jsp");
    }*/
    sql = "SELECT * FROM configure WHERE configure_id=" + configure_id;
    rs = db.ConExecuteQuery(sql);
    rs.first();
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
                    <h1 class="page-header">Configure Systems</h1>
                </div>
            </div>
            <div class="row show-grid">
                <div class="col-md-6 col-md-offset-3" style="background-color: #ffffff">
                    <div class="panel-heading">
                        <h3><i class="glyphicon glyphicon-cog"></i> กำหนดค่า Configuration : <b><%=rs.getString("configure_name")%></b></h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form role="form" id="submit" onsubmit="return save(this)" name="config" action="../ajax/saveConfig.jsp" method="post">
                                    <div class="form-group">
                                        <input type="hidden" name="configure_id" value="<%=configure_id%>" />
                                        <input type="text" id="configId" class="form-control" name="configure_value" value="<%=rs.getString("configure_value")%>">
                                        <input type="hidden" name="configure_unit" value="<%=rs.getString("configure_unit")%>">
                                        <label><h4>หน่วย configure : <b><%=rs.getString("configure_unit")%></b></h4></label>
                                    </div>                                      
                                    <button type="submit" name="submit" class="btn btn-success"><i class="glyphicon glyphicon-save"></i> บันทึก</button>
                                    <a class="btn btn-danger" href="index2.jsp"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิก</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
<script> 
    function save() {
        if(get('configId').value === '') {
            alert("กรุณาระบุค่า Configutation อีกครั้ง");
            return false;
        }
        console.log("กำลังแก้ไขค่า Configuration");
            var r = confirm("ต้องการแก้ไขค่า Configuration หรือไม่");
            if (!r) {
                return false;
            }
    }
</script>
</html>
