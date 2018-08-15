<%@page import="Systems.DateFunc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 11;
    DateFunc date = new DateFunc();
    session = request.getSession();
    
    ConfigSystem con1 = new ConfigSystem();
    
    session.removeAttribute("room_list");
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <!--ปฏทิน-->
        <script type="text/javascript">
            $(function () {
                var d = new Date();
                var toDay = d.getDate() + '/' + (d.getMonth() + 1) + '/' + (d.getFullYear() + 543);
                $("#date0").datepicker({dateFormat: 'dd/mm/yy', isBuddhist: true, defaultDate: toDay, dayNames: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'],
                    dayNamesMin: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'],
                    monthNames: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
                    monthNamesShort: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.']});
                $("#date1").datepicker({dateFormat: 'dd/mm/yy', isBuddhist: true, defaultDate: toDay, dayNames: ['อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์'],
                    dayNamesMin: ['อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'],
                    monthNames: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
                    monthNamesShort: ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.']});
            });
        </script>
        <style type="text/css">
            .ui-state-default{
                font-size: 18px;
            }
            .demoHeaders { margin-top: 2em; }
            #dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
            #dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
            ul#icons {margin: 0; padding: 0;}
            ul#icons li {margin: 10px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
            ul#icons span.ui-icon {float: left; margin: 0 4px;}
            ul.test {list-style:none; line-height:30px;}
        </style>
        <!--ปฏทิน-->
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="row" style=" margin-top: 5px">
                <div class="col-lg-12  text-center">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4><i class="glyphicon glyphicon-book"></i> สำรองห้องพัก</h4>
                        </div>
                        <div class=" panel-body">
                            <!-- /.col-lg-6 (nested) -->
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4><i class="glyphicon glyphicon-home"></i> ค้นหาข้อมูลห้องพัก</h4>
                                    </div>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <div class="col-lg-12">
                                                <div class="col-sm-5">
                                                    <label><i class="glyphicon glyphicon-log-in"></i> วันลงทะเบียนเข้าพัก</label>
                                                    <div class="form-group input-group">
                                                        <input type="text" name="check_in" class="form-control" value="<%=date.getDate(0)%>" id="date0" placeholder="วันลงทะเบียนเข้าพัก(Check in)" onchange="cal()" required required="true">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar" onclick="get('date0').focus()"></i></span>
                                                    </div>
                                                </div>
                                                <div class="col-sm-5">
                                                    <label><i class="glyphicon glyphicon-log-out"></i> วันส่งคืนห้องพัก</label>
                                                    <div class="form-group input-group">
                                                        <input type="text" name="check_out" class="form-control" value="<%=date.getDate(1)%>" id="date1" placeholder="วันส่งคืนห้องพัก (Check out)" onchange="cal()" required required="true">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar" onclick="get('date1').focus()"></i></span>
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <label> จำนวนคืน</label>
                                                    <select class="form-control" id="night" name="night" onchange="add_date()">
                                                        <%for (int i = 1; i <= Integer.parseInt(con1.GetConfig(12)); i++) {%><!--สามารถ config ได้-->
                                                            <option value="<%=i%>"><%=i%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <p id="error" class="alert-danger"></p>                            
                            <a class="btn btn-danger" href="dashboard.jsp"><i class="glyphicon glyphicon-backward"></i> Back</a>
                            <button  class="btn btn-info" onclick="select()" id="bt"><i class="glyphicon glyphicon-search"></i> ค้นหารายการห้องพักที่ว่าง</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <%@include file="../include/footer.jsp"%>
    <script>
        var flagg = false;
        var flag = true;
        var status = true;
        $(function () {
            cal();
        });
        
        function cal() {
            $.ajax({
                type: "GET",
                url: "../ajax/datecal.jsp?check_in=" + get("date0").value + "&check_out=" + get("date1").value,
                dataType: "html",
                success: function (data) {
                    var total = parseInt(data);
                    /*if (total < 0) {
                        alert('ไม่อนุญาติ!! วันลงทะเบียนเข้าพักต้องน้อยกว่าวันส่งคืนห้องพัก');
                        flag = false;   
                        get("bt").disabled = true;
                        get("night").disabled = true;
                        return false;
                    } else {
                        flag = true;
                        get("bt").disabled = false;
                        get("night").disabled = false;
                    }*/
                    
                    if (total <= <%=con1.GetConfig(12)%>) {
                        get('night').value = total;
                    } else {
                        flag = false;
                        get('night').value = total;
                        //get("bt").disabled = true;
                        //get("night").disabled = true;
                        //alert('จำนวนวันมากกว่าที่โรงแรมกำหนด <%=con1.GetConfig(12)%> วัน');
                        return false;
                    }
                }
            });
        }
        
        function add_date() {
            $.ajax({
                type: "GET",
                url: "../ajax/add_date.jsp?due_date="+get('date0').value+"&date=" + get('night').value,
                dataType: "html",
                success: function (data) {
                    var total = parseInt(data);
                    flag = true;
                    //get('date0').value = date
                    get('date1').value = data;
                    get("bt").disabled = false;
                    get("night").disabled = false;
                }
            });
        }
        
        function select() {
            var status1 = 1;
 
            check_in = get('date0').value;
            check_out = get('date1').value;
            
            if (check_in === "" || check_out === "") {
                alert("กรุณากรอกข้อมูลวันเข้าพักให้ครอบถ้วน!!!!!");
                return false;
            }

            if (check_in === check_out) {
                alert('ไม่อนุญาติให้ระบุเป็นวันเดียวกันได้');
                //get("night").disabled = true;
                return false;
            } 
            
            $.ajax({
                type: "GET",
                url: "../ajax/check_date.jsp?check_in=" + check_in + "&check_out=" + check_out,
                dataType: "html",
                success: function (data) {
                    var total = parseInt(data);
                    if (total < 0) {
                        flagg = true;
                        alert('ไม่สามารถระบุวันลงทะเบียนเข้าพักหรือวันส่งคืนห้องพักก่อนวันปัจจุบัน');
                        get('date0').value = "<%=date.getDate(0)%>";
                        get('date1').value = "<%=date.getDate(1)%>";
                        get('night').value = total;
                        return false;
                    } else {
                        $.ajax({
                        type: "GET",
                        url: "../ajax/datecal.jsp?check_in=" + check_in + "&check_out=" + check_out,
                        dataType: "html",
                        success: function (data) {
                            var total = parseInt(data);
                            
                            //alert(total);
                            if (total > <%=con1.GetConfig(12)%>) {
                                alert('จำนวนวันมากกว่าที่โรงแรมกำหนด <%=con1.GetConfig(12)%> วัน');
                            } else if (total < 0){
                                alert('ไม่อนุญาติ!! วันลงทะเบียนเข้าพักต้องน้อยกว่าวันส่งคืนห้องพัก');
                            }   
                            if( total <= <%=con1.GetConfig(12)%>) {
                                total = total * -1;
                            }
                            if (total > 0 ) {
                                //alert('ไม่อนุญาติ!! วันลงทะเบียนเข้าพักต้องน้อยกว่าวันส่งคืนห้องพัก');
                                get('date0').value = "<%=date.getDate(0)%>";
                                get('date1').value = "<%=date.getDate(1)%>";
                                get('night').value = total;
                                return false;
                            } else {
                                location.href = "room_list.jsp?check_in=" + check_in + "&check_out=" + check_out;
                            }
                        }
                        });
                    }
                }
            });

        }
        
        function selectCheckInAndCheckOut() {
            if (flag) {
                var data = -1;
                
                check_in = get('date0').value;
                check_out = get('date1').value;
                
                if (check_in === "" || check_out === "") {
                    alert("กรุณากรอกข้อมูลวันเข้าพักให้ครอบถ้วน!!!!!");
                    return false;
                }
                
                if (check_in === check_out) {
                    alert('ไม่อนุญาติให้ระบุเป็นวันเดียวกันได้');
                    get("night").disabled = true;
                    return false;
                } 
                
                $.ajax({
                type: "GET",
                url: "../ajax/datecal.jsp?check_in=" + get("date0").value + "&check_out=" + get("date1").value,
                dataType: "html",
                success: function (data) {
                    var total = parseInt(data);
                    if (total < 0)
                    {
                        alert('ไม่อนุญาติ!! วันลงทะเบียนเข้าพักต้องน้อยกว่าวันส่งคืนห้องพัก');
                        flag = false;
                        status = false;
                        //get("bt").disabled = true;
                        //get("night").disabled = true;
                        return false;
                    } else {
                        flag = true;
                        get("bt").disabled = false;
                        get("night").disabled = false;
                    }
                    
                    if (total <= <%=con1.GetConfig(12)%>) {
                        get('night').value = total;
                    } else {
                        flag = false;
                        status = false;
                        //get("bt").disabled = true;
                        //get("night").disabled = true;
                        //get('date0').value = "<%=date.getDate(0)%>";
                        //get('date1').value = "<%=date.getDate(1)%>";
                        alert('จำนวนวันมากกว่าที่โรงแรมกำหนด <%=con1.GetConfig(12)%> วัน');
                        return false;
                    }
                }
                });
                
                if (status !== false) {
                    $.ajax({
                        type: "GET",
                        url: "../ajax/check_date.jsp?check_in=" + get("date0").value + "&check_out=" + get("date1").value,
                        dataType: "html",
                        success: function (data) {
                            var total = parseInt(data);
                            if (total < 0) {
                                if (total < 0) {
                                    //alert(total);
                                    alert('ไม่สามารถระบุวันลงทะเบียนเข้าพักหรือวันส่งคืนก่อนวันปัจจุบัน');
                                }
                                //get("bt").disabled = true;
                                //get("night").disabled = true;
                                flag = false;
                                //get('error').innerHTML = "<i class='glyphicon glyphicon-alert'></i> ข้อมูลผิดพลาด!!!  ไม่สามารถระบุวันย้อนหลังได้";
                                //get('date0').value = "<%=date.getDate(0)%>";
                                //get('date1').value = "<%=date.getDate(1)%>";
                                //alert('ข้อมูลผิดพลาด!!!  ไม่สามารถระบุวันย้อนหลังได้');
                                return false;
                            } else {
                                //get('error').innerHTML = "";
                                //alert('ข้อมูล ' + status + total);
                                location.href = "room_list.jsp?check_in=" + check_in + "&check_out=" + check_out;
                            }
                        }
                    });
                }
            }
        }
        cal();
    </script>
</html>
