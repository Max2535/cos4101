<%@page import="ClassSystem.Chart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%int id = 0;//เปลื่ยนตรงนี้ด้วย%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../include/head.jsp"%>
        <script src="../js/Chart.bundle.js" type="text/javascript"></script>
        <script src="../js/utils.js" type="text/javascript"></script>        
        <style>
            canvas {
                -moz-user-select: none;
                -webkit-user-select: none;
                -ms-user-select: none;
            }
        </style>
    </head>
    <body>
        <%@include file="../include/nav.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-dashboard fa-1x"></i> Menu</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="panel panel-info">
                <div class="panel-body">
                    <a href="index.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-book fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>สำรองห้องพัก</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="index2.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-file-o fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>สืบค้นรายการใบสำรองห้องพัก</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <% if(staff.getStaff_type_id ()== 1) { %>      
                    <a href="index5.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-history fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>Log</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="staff_add.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-user-plus fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>ลงทะเบียนให้กับผู้ใช้ระบบ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="index3.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-users fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>สืบค้นข้อมูลผู้ใช้ระบบ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="index4.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-home fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>สืบค้นข้อมูลห้องพัก</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="room_add.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-plus-circle fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>เพิ่มห้องพัก</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                    <a href="configure_list.jsp" class="col-lg-3 col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-cog fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div> Configure</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <% } %>
                    <a id="exit" href="logout.jsp?id=0" class="col-lg-3 col-md-6">
                        <div class="panel panel-danger">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-sign-out fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>Logout</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>                    
                </div>
                <div class="well">
                    <canvas id="canvas"></canvas>
                </div>
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
<script>
    var lineChartData = {
    labels: ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'],
            datasets: [{
            label: 'ยกเลิกใบสำรองห้องพัก',
                    borderColor: window.chartColors.red,
                    backgroundColor: window.chartColors.red,
                    fill: false,
                    data: [
    <% Chart chart = new Chart();%>
    <% for(int z = 1;
        z
        <=12;z

        
            ++){%>
    <%=chart.chartCancel(z) + ","%>
    <%}%>
                    ],
//                yAxisID: 'y-axis-1',
                    yAxisID: 'y-axis-2',
            }, {
            label: 'อนุมันการชำระเงิน',
                    borderColor: window.chartColors.green,
                    backgroundColor: window.chartColors.green,
                    fill: false,
                    data: [
    <% for(int z = 1;
        z
        <=12;z

        
            ++){%>
    <%=chart.chartPay(z) + ","%>
    <%}%>
                    ],
//                yAxisID: 'y-axis-1',
                    yAxisID: 'y-axis-2',
            }, {
            label: 'สำรองห้องพัก',
                    borderColor: window.chartColors.blue,
                    backgroundColor: window.chartColors.blue,
                    fill: false,
                    data: [
    <% for(int z = 1;
        z
        <=12;z

        
            ++){%>
    <%=chart.chartReser(z) + ","%>
    <%}%>
                    ],
                    yAxisID: 'y-axis-2'
            }]
    };
    window.onload = function () {
    var ctx = document.getElementById('canvas').getContext('2d');
    window.myLine = Chart.Line(ctx, {
    data: lineChartData,
            options: {
            responsive: true,
                    hoverMode: 'index',
                    stacked: false,
                    title: {
                    display: true,
                            text: 'Line Chart - Multi Axis สำรองห้องพัก'
                    },
                    scales: {
                    yAxes: [{
                    type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            display: false,
                            position: 'left',
                            id: 'y-axis-1',
                    }, {
                    type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                            display: true,
                            position: 'right',
                            id: 'y-axis-2',
                            // grid line settings
                            gridLines: {
                            drawOnChartArea: false, // only want the grid lines for one axis to show up
                            },
                    }],
                    }
            }
    });
    };
</script>
</html>
