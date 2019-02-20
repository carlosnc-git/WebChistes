<%-- 
    Document   : home
    Created on : 11-feb-2019, 11:23:44
    Author     : carlos
--%>

<%@page import="entities.Chiste"%>
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
        List<Chiste> chistes = (List<Chiste>) session.getAttribute("chistes");

    %>
    <body>

        <!-- Contenedor principal-->
        <div class="container shadow" style="background-color: lightblue">
            <div>
                <img class="centrado" src="img/logo.png"/>
            </div>
            <div class="buscador">
                <form class="form-inline" action="Controller?op=dameCategoria" method="post" style="display: inline-block" >
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
                <button type="button" class="btn" data-toggle="modal" data-target="#modalNuevaCategoria" style="display: inline-block"><img alt="" src="img/add.png" height="25px" width="25px"/></button>
            </div>
            <% if (chistes==null){%>
            <h3 class="sincategoria">Chistes Carlos Navas</h3>
            <%}else {%>
                <button type="button" class="btn" data-toggle="modal" data-target="#modalNuevoChiste"><img alt="" src="img/add.png" height="35px" width="35px"/></button>
            <div class="chistes">
                
            </div>  
            <%}%>
                        
        </div>
        

        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>