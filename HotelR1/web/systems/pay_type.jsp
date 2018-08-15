<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = 98;
    String reservertion_id = "";
    if (request.getParameter("reservertion_id") != null) {
        reservertion_id = request.getParameter("reservertion_id");
    }
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
                    <h1 class="page-header">รูปแบบการชำระเงิน</h1>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="col-lg-12">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-money fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>ชำระด้วยเงินสด</div>
                                    </div>
                                </div>
                            </div>
                            <a href="approve_money.jsp?reservertion_id=<%=reservertion_id%>">
                                <div class="panel-footer">
                                    <span class="pull-left"> อนุมัตการชำระด้วยเงินสด</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-bank fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>ชำระด้วยการโอนเงิน</div>
                                    </div>
                                </div>
                            </div>
                            <a href="gmail.jsp?reservertion_id=<%=reservertion_id%>">
                                <div class="panel-footer">
                                    <span class="pull-left"> อนุมัตการชำระด้วยการโอนเงิน</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<%@include file="../include/footer.jsp"%>
</html>
