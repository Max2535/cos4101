<%-- 
    Document   : testupload
    Created on : Jul 30, 2017, 8:15:31 AM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
</head>
<body>

	<form name="frmUpload" method="post" action="upload.jsp" enctype="multipart/form-data">
		<input type="file" name="filUpload">
		<input name="btnSubmit" type="submit" value="Submit">
	</form>

</body>
</html>
