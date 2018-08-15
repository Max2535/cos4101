<%@page import="Systems.Condb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import='java.io.InputStream' %> 
<%@ page import='java.io.OutputStream' %> 
<html>
    <body>
        <%
            ResultSet rs = null;
            int nBytes = 0;
            String table="";
            int id=0;
            if(request.getParameter("table")!=null){
                table=request.getParameter("table");
            }
            if(request.getParameter("id")!=null){
                id=Integer.parseInt(request.getParameter("id"));
            }
            String sql="SELECT "+table+"_image FROM "+table+" where "+table+"_id=" + id;
            Condb db=new Condb();
            rs = db.ConExecuteQuery(sql);
            try {
                if (rs.next()) {
                    response.setContentType("image");
                    InputStream is = rs.getBinaryStream(1);
                    OutputStream aux = response.getOutputStream();

                    byte[] buffer = new byte[4096];
                    for (;;) {
                        nBytes = is.read(buffer);
                        if (nBytes == -1) {
                            break;
                        }
                        aux.write(buffer, 0, nBytes);
                    }
                    is.close();
                    aux.flush();
                    aux.close();
                } else {
                    throw new SQLException("image not found");
                }
                rs.close();
            } catch (SQLException e) {
                out.println("Imagen no encontrada");
            }
            out.println("no se muestra");
        %>     
        <div>
            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgWETRHHFIDIDIDCNCNNRRLKJPPDJDdjfSSS==" alt="My Image from DB" />
        </div>
        <input type="submit" value="Back" name="back" onclick="window.back();"/>
    </body>
</html>