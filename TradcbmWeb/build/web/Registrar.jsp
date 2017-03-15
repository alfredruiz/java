<%--
    Document   : Usuarios
    Created on : 31-ene-2017, 12:45:41
    Author     : Ana
--%>

<%@page import="datos.DatosUsuario"%>
<%@page import="datos.Conexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="clases.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <jsp:include page="contenido/librerias.jsp"></jsp:include>
         <script src="lib/jquery/JQUsuarios.js"></script>            
        </head>
        <body>
     <div  class="container">
            <jsp:include page="contenido/header.jsp"></jsp:include> 

            <form id="Registrar" style="display:inline" name="Registrar" method="post" class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1">
                <h1>Usuarios</h1>
                <div class="row">
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="text" id="idusuarios" name="idusuarios" class="cuadrotexto form-control" placeholder="Usuario" autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="text" id="nombre" name="nombre" class=" cuadrotexto form-control" placeholder="Nombre"  autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="text" id="apellidos" name="apellidos" class=" cuadrotexto form-control" placeholder="Apellido"  autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="text" id="email" name="email" class="cuadrotexto form-control" placeholder="Email" autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="password" id="password" name="password" class="cuadrotexto form-control" placeholder="Password"  autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <input type="password" id="password2" name="password2" class="cuadrotexto form-control" placeholder="Confirmar password" autofocus/>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <select name="perfil" id="perfil"  class="cuadrotexto form-control">
                            <option value="">Seleccione perfil..</option>
                            <option value="Administrador">Administrador</option>
                            <option value="Empleado">Empleado</option>
                        </select>
                    </div>
                    <div class="form-group col-md-12 col-sm-12 col-xs-12">
                        <button type="submit" id="nuevo" value="nuevo" name="nuevo" class="btn btn-primary col-md-2 col-sm-2 col-xs-2"><i class="fa fa-floppy-o fa-2x"></i></button>
                        <button type="submit" id="modificar" value="modificar" name="modificar" class="btn btn-success col-md-2 col-sm-2 col-xs-2"><i class="fa fa-edit fa-2x"></i></button>
                        <button type="submit" id="borrar" value="borrar" name="borrar" class="btn btn-default btn-danger col-md-2 col-sm-2 col-xs-2"><i class="fa fa-trash fa-2x"></i></button>
                        <button type="submit" id="consultar" value="consultar" name="consultar"  class="btn btn-primary col-md-2 col-sm-2 col-xs-2"><i class="fa fa-search fa-2x"></i></button>
                        <button type="reset" id="limpiar" value="limpiar" name="limpiar" class="btn btn-warning col-md-2 col-sm-2 col-xs-2"><i class="fa fa-eraser fa-2x"></i></button>
                        <button id="listar" value="listar" name="listar" class="btn btn-info col-md-2 col-sm-2 col-xs-2"><i class="fa fa-list fa-2x"></i></button>
                    </div>
                </div>
            </form>
            <div style="clear: both"></div>
            <!--Tabla de Usuarios--> 
             <div class="table-responsive" id="listado" style="display:none">            
                 <h1 id="cabeceratabla" class="text-center">Listado Usuarios</h1>
                <table id="tabla" class="display">
                    <thead>
                        <tr>
                            <th></th>
                            <th></th>
                            <th>Usuarios</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Perfil</th>
                        </tr>
                        </thead>
                </table>
            </div>
</div>
    <jsp:include page="contenido/footer.jsp"></jsp:include>
</body>
</html>


