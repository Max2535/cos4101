<%-- 
    Document   : full
    Created on : Aug 8, 2017, 11:20:03 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <style>
            body {
                background-image: url("image/error.png");
                background-repeat: no-repeat;
                background-position: right top;
                background-attachment: fixed;
            }
            #fof{display:block; width:100%; padding:150px 0; line-height:1.6em; text-align:center;}
            #fof .hgroup{margin-bottom:15px;}
            #fof .hgroup h1, #fof .hgroup h2{margin:0; padding:0; text-transform:uppercase;}
            #fof .hgroup h1{margin-bottom:15px; font-size:40px;}
            #fof .hgroup h2{display:inline-block; padding:0 0 15px 0; font-size:80px; border:solid #CCCCCC; border-width:1px 0; text-transform:lowercase;}
            #fof p{display:block; margin:15px 0 0 0; padding:0; font-size:16px;}
            #fof p:first-child{margin-top:0;}
        </style>
    </head>
    <body>
        <div class="wrapper row2">
            <div id="container" class="clear">
                <!-- ####################################################################################################### -->
                <!-- ####################################################################################################### -->
                <!-- ####################################################################################################### -->
                <!-- ####################################################################################################### -->
                <section id="fof" class="clear">
                    <!-- ####################################################################################################### -->
                    <div class="hgroup">
                        <h1>ขณะนี้มีผู้สมัครเข้าใช้งานเกินที่กำหนดไว้ !</h1>
                        <h2>Error Register</h2>
                    </div>
                    <p>กรุณารอสักครู่...</p>
                    <p>ไปที่<a href="/BMPDev/index.jsp">Home</a></p>
                    <!-- ####################################################################################################### -->
                </section>
            </div>
        </div>

    </body>
</html>
