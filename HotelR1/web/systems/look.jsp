<%@page import="ClassSystem.ConfigSystem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>คุณทำการloginบ่อยเกินไป</title>
        <script src="../vendor/jquery/jquery.min.js"></script>
        <script>
            function startTimer(duration, display) {
                var timer = duration, minutes, seconds;
                setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.text(minutes + ":" + seconds);

                    if (--timer < 0) {
                        //timer = duration;
                        unlook();
                    }
                }, 1000);
            }

            jQuery(function ($) {
                <%ConfigSystem con=new ConfigSystem();%>
                var fiveMinutes = 60 * <%=con.GetConfig(9)%>, //กำหนดเวลาตรงนี้ อย่าลืมใส่ config
                        display = $('#time');
                startTimer(fiveMinutes, display);
            });
            function unlook() {
                location.href = "../ajax/unlook.jsp";
            }
        </script>
    </head>
    <body><!--อย่าลืมใส่ config-->
        <div>กรุณา login อีกครั้งต่อไปอีก <span id="time">00:00</span> นาที</div>
    </body>
</html>