<%-- 
    Document   : home
    Created on : 11-feb-2019, 11:23:44
    Author     : carlos
--%>

<%@page import="entities.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" dir="ltr">

    <head>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="css/mycss.css">
        <title>Chistes</title>
    </head>
    <%
        List<Categoria> categorias = (List<Categoria>) session.getAttribute("categorias");
        short idCategoria = (short) session.getAttribute("idCategoria");

    %>
    <body>

        <!-- Contenedor principal-->
        <div class="container shadow">
            <div>
                <img class="imagen" src="img/logo.png"/>
            </div>
            <div class="buscador">
                <form class="form-inline" action="Controller?op=dameCategoria" method="post" style="display: inline;" >
                    <div class="form-group">
                        <select class="custom-select" id="comboCategoria" name="comboCategoria" onchange="this.form.submit()" style="width: 300px">
                            <%if (idCategoria == -1) {
                            %>
                            <option selected>Elija Categoria</option>
                            <%} else {%>
                            <option >Elija Categoria</option>
                            <%}
                            for (Categoria categoria : categorias) {%>            
                                <option <%=(idCategoria == categoria.getId()) ? "selected" : ""%> value="<%=categoria.getId()%>" class="text-danger"><%=categoria.getNombre()%></option>      
                            <%}%>
                        </select>
                    </div>
                </form>   
            </div>
        </div>

        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>