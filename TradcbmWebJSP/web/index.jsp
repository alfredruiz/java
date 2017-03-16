<%--
    Document   : Login
    Created on : 26-ene-2017, 18:09:06
    Author     : Ana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <jsp:include page="contenido/librerias.jsp"></jsp:include>
            <script src="lib/jquery/JQUsuarios.js" type="text/javascript"></script>
        </head>
        <body> 
        <%  //Mata la sesión
            session.invalidate();%>
        <div class="container">
            <form id="ValidaUsuario" name="ValidaUsuario" method="post">
                <h2>Ingresar</h2>
                <input type="text" id="idusuarios" name="idusuarios" class="form-control" placeholder="Usuario">
                <input type="password" id="password" name="password" class="form-control" placeholder="Password">

                <button class="btn btn-lg btn-danger btn-block" name="ingresar" id="ingresar">Entrar</button>
            </form>
        </div>
    </body>
</html>


