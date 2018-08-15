<%@page import="Cron.SimpleTrigger"%>
<%@page import="ClassSystem.ConfigSystem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<a href="http://gazpo.com/downloads/tutorials/jquery/scrolltop/#" class="scrollup" style="display: none;">Scroll</a>
<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">              
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <img src="" class="imagepreview" style="width: 100%;" >
            </div>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="container">
        <span class="text-muted"><%=Systems.Data.title%></span>
    </div>
</footer>
<!-- jQuery -->
<%if (id != 11) {%>
<script src="../vendor/jquery/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
<%}%>
<%if (id == -1) {%>
<script>
    alert("กรุณาตรวจสอบ Code ด้วย");
</script>
<%}%>
<audio id="myAudio">
    <!--<source src="../popup/preview.mp3" type="audio/mpeg">-->
    Your browser does not support the <code>audio</code> tag.
</audio>
<%ConfigSystem con = new ConfigSystem();%>
<script>
    $(function () {
        //เวลา
        startTime();
        //up top
        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('.scrollup').fadeIn();
            } else {
                $('.scrollup').fadeOut();
            }
        });
        $('.scrollup').click(function () {
            $("html, body").animate({scrollTop: 0}, 600);
            return false;
        });
        bodyOnload(); //ตรวจสอบระบบ
    <%if (id == 0) {%>
        //popup รูปภาพ
        $('.pop').on('click', function () {
            $('.imagepreview').attr('src', $(this).find('img').attr('src'));
            $('#imagemodal').modal('show');
        });
    <%}%>
    });
    //เสียงแจ้งเตือน
    var x = get('myAudio');
    function playAudio() {
        x.play();
    }
    //เรื่องของวันเวลา
    function startTime() {
        var today = new Date();
        var d = today.getDate();
        var month = new Array();
        month[0] = "มกราคม";
        month[1] = "กุมภาพันธ์";
        month[2] = "มีนาคม";
        month[3] = "เมษายน";
        month[4] = "พฤษภาคม";
        month[5] = "มิถุนายน";
        month[6] = "กรกฎาคม";
        month[7] = "สิงหาคม";
        month[8] = "กันยายน";
        month[9] = "ตุลาคม";
        month[10] = "พฤศจิกายน";
        month[11] = "ธันวาคม";
        var n = month[today.getMonth()];
        var y = today.getFullYear() + 543;
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        var date_time = "เวลา " + h + ":" + m + ":" + s + " น. วันที่ " + d + " " + n + " " + y;
        get('txt').innerHTML = date_time;
        var t = setTimeout(startTime, 500);
    }
    
    function checkTime(i) {
        if (i < 10) {
            i = "0" + i
        }
        ;  // add zero in front of numbers < 10
        return i;
    }

    function GetIEVersion() {
        var sAgent = window.navigator.userAgent;
        var Idx = sAgent.indexOf("MSIE");

        // If IE, return version number.
        if (Idx > 0)
            return parseInt(sAgent.substring(Idx + 5, sAgent.indexOf(".", Idx)));

        // If IE 11 then look for Updated user agent string.
        else if (!!navigator.userAgent.match(/Trident\/7\./))
            return 11;

        else
            return 0; //It is not IE
    }

    function Alertpopup(msg, action) {

        if (GetIEVersion() > 0)
            alert(msg+" "+action);
        else {
            playAudio();
            Push.create('แจ้งเตือนผู้ใช้!', {
                body: msg,
                icon: '../img/email.png',
                link: '#',
                timeout: (<%= con.GetConfig(13)%>*10000),
                onClick: function () {
                    if (action === 'email') {
                        link();
                    } else {
                        link2();
                    }
                    window.focus();
                    this.close();
                },
                vibrate: [200, 100, 200, 100, 200, 100, 200]
            });
        }
    }
    //เปิดหน้ารายการอีเมล์
    function link() {
        window.open('gmail.jsp', '_blank');
    }
    function link2() {
        window.open('index2.jsp', '_blank');
    }

    function bodyOnload()
    {
        var time = (<%=con.GetConfig(4)%> * 1000) * 60;
        setTimeout("showTimmer();", time);
    }

    function showTimmer()
    {
        console.log("ระบบกำลังตรวจสอบ...");
        setTimeout("check_email();", 1);
        //setTimeout("cancel_auto();", 2);
       //setTimeout("check_out_auto();", 3);
        setTimeout("bodyOnload();", 4);
    }

    function cancel_auto() {
        $.ajax({
            type: "GET",
            url: "../ajax/cancel_auto.jsp",
            dataType: "html",
            success: function (data) {
                var n = $.trim(data);
                //n = parseInt(n);
                if (n !== "")
                {
                    Alertpopup("มีการยกเลิกใบสำรองห้องใบเลขที่ : " + data, "ยกเลิกอัตโนมัติ");
                }
            }
        });
    }

    function check_out_auto() {
        $.ajax({
            type: "GET",
            url: "../ajax/check_out_auto.jsp",
            dataType: "html",
            success: function (data) {
                var n = $.trim(data);
                n = parseInt(n);
                if (n > 0)
                {
                    Alertpopup("มีการส่งคืนห้องพักใบสำรองห้องใบเลขที่ : " + data, "ส่งคืนห้องพักอัตโนมัติ");
                }
            }
        });
    }

    //เช็คว่ามีอีเมล์ใหม่เข้ามาไม่
    function check_email() {
        $.ajax({
            type: "GET",
            url: "../ajax/check_email.jsp",
            dataType: "html",
            success: function (data) {
                var n = parseInt(data);
                if (n > 0)
                {
                    Alertpopup("มีการแจ้งชำระเงินเข้ามากรุณาตรวจสอบด่วน!!!", 'email');
                }
            }
        });
    }
    $(function () {
        $('table.with-pager').each(function () {
            var $table = $(this);
            var $nextPage = $('.pager .next');
            var $previousPage = $('.pager .previous');

            var currentPage = 0;
            var numPerPage = <%=con.GetConfig(14)%>;

            var numRows = 0;
            var numPages = 0;

            $table.bind('repaginate', function () {
                numRows = $table.find('tbody tr').length;
                numPages = Math.ceil(numRows / numPerPage);

                $table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();

                if (currentPage == 0) {
                    $previousPage.addClass('disabled');
                } else {
                    $previousPage.removeClass('disabled');
                }

                if (currentPage == numPages - 1) {
                    $nextPage.addClass('disabled');
                } else {
                    $nextPage.removeClass('disabled');
                }
            });

            $table.trigger('repaginate');

            $previousPage.bind('click', function (event) {
                if (currentPage != 0) {
                    currentPage--;
                    $table.trigger('repaginate');
                }
            });

            $nextPage.bind('click', function (event) {
                if (currentPage != numPages - 1) {
                    currentPage++;
                    $table.trigger('repaginate');
                }
            });
        });
    });
</script>
<%
    SimpleTrigger s=new SimpleTrigger();
%>