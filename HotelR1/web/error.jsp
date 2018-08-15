<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>พบข้อผิดพลาด</title>  
        <style>
            body  {
                background-image: url("img/error-code-18.jpeg");
                background-color: #cccccc;
            }
        </style>
    </head>
    <body>
        <h1 style=" color: red; text-align:  center"> Connect Database เยอะเกิน!!!!!!!!!!!!</h1>
        <a href="#" onclick="window.history.back()"> แจ้ง ผู้ดูแลระบบ</a>
    </body>
</html>
<%session.invalidate();%>