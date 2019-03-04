<%-- 
    Document   : home
    Created on : 11-feb-2019, 11:23:44
    Author     : carlos
--%>

<%@page import="java.io.Console"%>
<%@page import="model.ChistePuntuado"%>
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
        Categoria categoriaSeleccionada = (Categoria) session.getAttribute("categoria");
        boolean mejores = (boolean) session.getAttribute("mejores");
        List<Chiste> chistes = null;
        if (mejores) {
            chistes = (List<Chiste>) session.getAttribute("chistes");
        } else {
            if (categoriaSeleccionada != null) {
                chistes = categoriaSeleccionada.getChisteList();
            }
        }

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
                            <%if (categoriaSeleccionada == null) {
                            %>
                            <option selected value="-1">Elija Categoria</option>
                            <%} else {%>
                            <option value="-1">Elija Categoria</option>
                            <%}
                                for (Categoria categoria : categorias) {%>            
                            <option <%=(categoriaSeleccionada != null && categoriaSeleccionada.getId() == categoria.getId()) ? "selected" : ""%> value="<%=categoria.getId()%>" class="text-danger"><%=categoria.getNombre()%></option>      
                            <%}%>
                        </select>
                    </div>
                </form>
                <button type="button" class="btn" data-toggle="modal" data-target="#modalNuevaCategoria" style="display: inline-block"><img alt="" src="img/add.png" height="25px" width="25px"/></button>
                    <%if (!mejores) {%>
                <a style="display: inline-block" href="Controller?op=dameMejores">Mejores Chistes</a>
                <%}%>                
            </div>
            <% if (chistes == null) {%>
            <h3 class="sincategoria">Chistes Carlos Navas</h3>
            <%} else {
                if (!mejores) { %>                    
                    <button type="button" class="btn centrado" data-toggle="modal" data-target="#modalNuevoChiste"><img alt="" src="img/add.png" height="35px" width="35px"/></button>
                <%}%>
            <div class="chistes">
                <%for (Chiste chiste : chistes) {%>
                <div class="chiste"> 
                    <h4><%=chiste.getTitulo().toUpperCase()%> (<%=chiste.getIdcategoria().getNombre()%>) - <%=chiste.getAdopo()%> - <%=chiste.getMediaPuntos()%></h4>
                    <p><%=chiste.getDescripcion()%></p>

                    <span class="rating ">
                        <a href="Controller?op=rating&rating=1&chisteid=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=rating&rating=2&chisteid=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=rating&rating=3&chisteid=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=rating&rating=4&chisteid=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=rating&rating=5&chisteid=<%=chiste.getId()%>">&#9733;</a>
                    </span>

                </div>
                <%}%>
                <div class="modal fade" id="modalNuevoChiste" tabindex="-1" role="dialog" aria-labelledby="modalNuevoChiste" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Nuevo chiste para la categoría "<%=categoriaSeleccionada.getNombre()%>"</h5>                     
                            </div>
                            <div class="modal-body">
                                <form action="Controller?op=nuevoChiste" method="post">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="tituloChiste">Título</label>
                                            <input type="text" class="form-control" id="tituloChiste" name="tituloChiste" placeholder="Inserte título" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="apodoChiste">Apodo</label>
                                            <input type="text" class="form-control" id="apodoChiste" name="apodoChiste" placeholder="Inserte su apodo" required/>
                                        </div>
                                    </div>
                                    <label for="contenidoChiste"></label>
                                    <input type="text" class="form-control" id="contenidoChiste" name="contenidoChiste" placeholder="Inserte el chiste" required/>
                                    <button type="submit" class="btn btn-success">Añadir</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                </form>
                            </div>                       
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
        <div class="modal fade" id="modalNuevaCategoria" tabindex="-1" role="dialog" aria-labelledby="modalNuevaCategoria" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Nueva Categoría</h5>                     
                    </div>
                    <div class="modal-body">
                        <form action="Controller?op=nuevaCategoria" method="post">
                            <div class="col-l-2"><input type="text" id="nombreCategoria" name="nombreCategoria" class="form-control" placeholder="Nombre de la categoría" required></div>
                            <button type="submit" class="btn btn-success">Añadir</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                        </form>
                    </div>                       
                </div>
            </div>
        </div>          

        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>