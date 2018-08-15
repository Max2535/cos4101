<%@page import="java.sql.ResultSet"%>
<%@page import="Systems.*"%>
<%@page import="ClassSystem.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    <% if (request.getParameter("msg") != null) {%>
        alert("<%=request.getParameter("msg")%>");
    <%}%>
</script>
<%
    int id = 1;
    String reservation_id = "";
    Guest guest = new Guest();
    Reservation reservation = new Reservation();
    DateFunc date = new DateFunc();
    ConfigSystem configSystem = new ConfigSystem();
    
    if (request.getParameter("reservertion_id") != null) {
        reservation_id = request.getParameter("reservertion_id");
    }
    
    ResultSet reservationData = reservation.getReservation(reservation_id); // แสดงข้อมูลใบสำรอง ***
    reservationData.first(); // เลือกตัวแรก
    ResultSet reservationDetail = reservation.GetReservationDetail(reservation_id); // แสดงข้อมูลรายละเอียดใบสำรอง (รายการห้อง) ***
    ResultSet guestData = guest.GetGuest(reservationData.getInt("guest_id")); // แสดงข้อมูลลูกค้าที่สัมพันธ์กับใบสำรอง ***
    guestData.first(); // เลิอกตัวแรก
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
                <div class="col-lg-12 div_from">
                    <h1 class="page-header">ส่งคืนห้องพัก(Check out)<small> รหัสใบสำรองห้องพัก:<code><%=reservation_id%></code></small></h1>
                </div>
                <div class="col-lg-12 div_from_2">
                    <h1 class="page-header">ใบเสร็จรับเงินค่าห้องพัก</h1>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12  text-center">
                                <div class="panel panel-default">
                                    <!-- panel heading -->
                                    <div class="panel-heading text-center">
                                        <b>วันส่งคืนห้องพัก(Check out) : <code><%=date.FormatDate(reservationData.getString("check_out"))%></code> 
                                           ก่อนเวลา : <code><%=configSystem.GetConfig(6)%></code>
                                           จำนวน : <code><%=date.calDateDiff(reservationData.getString("check_out"), reservationData.getString("check_in"))%></code> คืน
                                        </b>
                                    </div>
                                    <!-- panel body -->
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <!-- panel heading in panel body -->
                                            <div class="panel-heading text-center" style="background-color: #dddddd">รายการห้องพัก</div>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>หมายเลขห้องพัก</th>
                                                        <th>ประเภทห้องพัก</th>
                                                        <th>สถานะเตียงเสริม</th>
                                                        <th>ราคาค่าห้อง</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        float temp_price = 0.0f;
                                                    %>
                                                    <%while (reservationDetail.next()) {%>
                                                    <tr>
                                                        <td><%=reservationDetail.getString("room_code")%></td>
                                                        <td><%=reservationDetail.getString("room_type_name")%></td>
                                                        <td><%if (reservationDetail.getString("extra_bed").equals("true")){ 
                                                                out.print("<b>เพิ่มเตียงเสริม</b>");
                                                            } else {
                                                                out.print("<b>ไม่ได้เพิ่มเตียงเสริม</b>");
                                                            }%>
                                                        </td>
                                                        <td><%=reservationDetail.getInt("room_price")%> บาท </td>
                                                    </tr>
                                                    <%}%>
                                                    <tr>
                                                        <td>ค่าห้องรวม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getDouble("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td>ค่าเตรียงเสริม</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><%=reservationData.getInt("price_total") - reservationData.getInt("price_reservation")%> บาท</td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>เงินรวมสุทธิ</b></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td align="right"><b><%=reservationData.getDouble("price_total")%> บาท</b></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <hr>
                                            <!-- panel heading in panel body -->
                                            <div class="panel-heading text-center" style="background-color: #dddddd">ข้อมูลลูกค้า</div>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ชื่อ-นามสกุล</th>
                                                        <th>รหัสบัตรประชาชน</th>
                                                        <th>อีเมล์</th>
                                                        <th>เบอร์โทรศัพท์</th>
                                                        <th>ที่อยู่</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><%=guestData.getString("guest_name")%></td>
                                                        <td><%=guestData.getString("guest_idno")%></td>
                                                        <td><%=guestData.getString("guest_email")%></td>
                                                        <td><%=guestData.getString("guest_phone")%></td>
                                                        <td><%=guestData.getString("guest_address")%></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <!-- <div class="panel-heading text-center" style="background-color: #dddddd">ค่าปรับ</div>  
                                            <table class="table table-hover order-list"  id="myTable">
                                                <thead>
                                                    <tr>
                                                        <th>รายการ</th>
                                                        <th>เงินค่าปรับ</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <tfoot>
                                                    <tr> 
                                                        <td colspan="2" style="text-align: right;"><b>รวมค่าปรับ: <span id="grandtotal"></span> บาท.</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" style="text-align: center;">
                                                            <div  class="div_from">
                                                                <input type="button" id="addrow" class="btn btn-success" value="เพิ่มค่าปรับ" />
                                                                <a onclick="pay_display()" class="btn btn-info" id="bt_money" ><i class="fa fa-money"></i> ชำระเงิน</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                                </tbody>
                                            </table> -->
                                        </div>    
                                    </div>
                                    <!-- /.panel-body -->
                                </div>
                            </div>
                            <div class="col-lg-12 text-center div_from">
                                <%if (true) {%>
                                    <a href="#" class="btn btn-success" onclick="check_out()" id="check_out_bt"><i class="glyphicon glyphicon-log-in"></i> บันทึกส่งคืนห้องพัก</a>
                                <%} else {%>
                                    <h4><b class="alert-danger">ไม่สามารถส่งคืนห้องพักได้ เนื่องจากยังไม่ถึงเวลาส่งคืนห้องพักของใบสำรอง</b></h4><br>
                                <%}%>
                                <a href="index2.jsp" class="btn btn-danger"><i class="glyphicon glyphicon-remove-circle"></i> ยกเลิกการทำรายการ</a>
                            </div>
                        </div>
                                                    
                        <!-- <div id="id01" class="modal">
                            <div class="container" style="background-color:#f1f1f1">
                                <div class="col-lg-4"></div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label>ชำระเงินปรับ</label>
                                        <input class="form-control" name="money" id="money">
                                    </div>
                                </div>                                
                                <div class="col-lg-4"></div>
                                <div class="col-lg-12">
                                    <div class="text-center" style="margin-bottom: 10px">
                                        <a href="#" class="btn btn-success" onclick="document.getElementById('id01').style.display = 'none';get('check_out_bt').disabled = false;flag_pay = true;"  ><i class="glyphicon glyphicon-ok"></i> อนุมัติการชำระเงินสด</a>
                                        <a onclick="document.getElementById('id01').style.display = 'none'" class="btn btn-danger"> ยกเลิก</a>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="../include/footer.jsp"%>
<script>
    // Get the modal
    calculateGrandTotal();
    pay_addmoney();
    $('#bt_money').hide();
    var modal = get('id01');
    $('.div_from_2').hide();
    var flag_pay = false;
    calculateGrandTotal();
    
    $(document).ready(function () {
        var counter = 0;

        $("#addrow").on("click", function () {

            counter = $('#myTable tr').length - 2;

            var newRow = $("<tr>");
            var cols = "";

            cols += '<td><input type="text" class="form-control" name="name' + counter + '"/></td>';
            cols += '<td><input type="text" class="form-control" name="price' + counter + '"/></td>';

            cols += '<td><input type="button" class="btn btn-danger ibtnDel"  value="ลบค่าปรับ"></td>';
            newRow.append(cols);
            if (counter == (<%=configSystem.GetConfig(7)%> + 1))
                $('#addrow').attr('disabled', true).prop('value', "เกินจำนวนที่ config");
            $("table.order-list").append(newRow);
            counter++;
        });

        $("table.order-list").on("change", 'input[name^="price"]', function (event) {
            calculateRow($(this).closest("tr"));
            calculateGrandTotal();
        });


        $("table.order-list").on("click", ".ibtnDel", function (event) {
            $(this).closest("tr").remove();
            calculateGrandTotal();
            get("check_out_bt").disabled = false;
            counter -= 1
            $('#addrow').attr('disabled', false).prop('value', "เพิ่มค่าปรับ");
        });
    });

    function calculateRow(row) {
        var price = +row.find('input[name^="price"]').val();
    }

    function calculateGrandTotal() {
        var grandTotal = 0;
        $("table.order-list").find('input[name^="price"]').each(function () {
            grandTotal += +$(this).val();
        });
        $("#grandtotal").text(grandTotal.toFixed(2));
        $("#money").val(grandTotal.toFixed(2));
        if (grandTotal > 0) {
            get("check_out_bt").disabled = true;
            $('#bt_money').show();
        }else{
            flag_pay = true;
        }
    }
    
    function check_out() {
        if (flag_pay) {
            console.log("กำลังทำการส่งคืนห้องพักใบสำรองห้องพัก");
            var r = confirm("ต้องการส่งคืนห้องพักใบสำรองห้องพักหมายเลข:<%=reservation_id%> หรือไม่");
            if (!r) {
                return;
            }
            
            console.log("ทำการ check out ใบสำรองห้องพักแล้ว");
            $.ajax({
                type: "GET",
                url: "../ajax/check_out.jsp?reservertion_id=<%=reservation_id%>",
                dataType: "html",
                success: function (data) {
                    location.href = "index2.jsp";
                }
            });
        }
        printReceipt();
    }
    
    function pay_addmoney() {
        var fines = get('grandtotal').innerHTML;
        fines = parseInt(fines);
        if (fines > 0) {
            get("check_out_bt").disabled = true;
        }
        $.ajax({
            type: "GET",
            url: "../ajax/pay_money.jsp?reservertion_id=" + <%=reservation_id%>+"&money_value="+fines,
            dataType: "html",
            success: function (data) {
                //TODO::
            }
        });
    }
    
    function pay_display() {
        modal.style.display = "block";
        pay_addmoney();
    }
    
    function printReceipt() {
        $('.div_from').hide();
        $('.ibtnDel').hide();
        $('.div_from_2').show();
        print();
        $('.ibtnDel').show();
        $('.div_from').show();
        $('.div_from_2').hide();
    }
</script>
</html>
<!--%}%>