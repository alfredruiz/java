<%-- 
    Document   : Resgitrar
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
        
    </head>
    <body>
        
     <div  class="container">
        <%
            //Obtenemos la sesión del usuario
            HttpSession sesion = request.getSession();
            Usuarios usulog = (Usuarios) sesion.getAttribute("idusuarios");
            if (usulog == null || usulog.getPerfil() != "Administrador") {
        %>                  
        <jsp:forward page="index.jsp"></jsp:forward>
        <%
            }
            //Instanciamos la conexión a la base de datos
            Conexion conex=new Conexion();
            //Instanciamos la clase DatosUsuario
            DatosUsuario misDatos = new DatosUsuario();
            //Mensajes del sistema
            String mensaje = "";
            //Instanciamos la clase usuario
            Usuarios usu;

            //Identifica el botón pulsado por el usuario
            boolean consultar = false;
            boolean nuevo = false;
            boolean limpiar = false;
            boolean modificar = false;
            boolean borrar = false;
            boolean listar = false;

            if (request.getParameter("nuevo") != null) {
                nuevo = true;
            }
            if (request.getParameter("modificar") != null) {
                modificar = true;
            }
            if (request.getParameter("borrar") != null) {
                borrar = true;
            }
            if (request.getParameter("consultar") != null) {
                consultar = true;
            }
            if (request.getParameter("listar") != null) {
                listar = true;
            }
            if (request.getParameter("limpiar") != null) {
                limpiar = true;
            }

            //Obtener el valor del method del formulario
            String idusuarios = "";
            String nombre = "";
            String apellidos = "";
            String email = "";
            String password = "";
            String password2 = "";
            String perfil = "";

            if (request.getParameter("idusuarios") != null) {
                idusuarios = request.getParameter("idusuarios");
            }
            if (request.getParameter("nombre") != null) {
                nombre = request.getParameter("nombre");
            }
            if (request.getParameter("apellidos") != null) {
                apellidos = request.getParameter("apellidos");
            }
            if (request.getParameter("email") != null) {
                email = request.getParameter("email");
            }
            if (request.getParameter("password") != null) {
                password = request.getParameter("password");
            }
            if (request.getParameter("password2") != null) {
                password2 = request.getParameter("password2");
            }
            if (request.getParameter("perfil") != null) {
                perfil = request.getParameter("perfil");
            }

            //Validamos si hay usuario a consultar
            if (consultar) {
                misDatos = new DatosUsuario();
                usu = misDatos.getUsuario(idusuarios);
                if (usu == null) { //usuario no esta en la bd
                    mensaje = "Usuario no existe";
                } else {
                    idusuarios = usu.getIdusuarios();
                    nombre = usu.getNombre();
                    apellidos = usu.getApellidos();
                    email = usu.getEmail();
                    password = usu.getPassword();
                    password2 = usu.getPassword();
                    perfil = ("") + usu.getIdPerfil();
                    mensaje = "Usuario consultado";
                }
                conex.CerrarConexion();
            }
            //Limpiamos campos
            if (limpiar) {
                idusuarios = "";
                nombre = "";
                apellidos = "";
                email = "";
                password = "";
                password2 = "";
                perfil = "";
            }

            //Ingresar Usuario 
            if (nuevo) {
                    misDatos = new DatosUsuario();
                    usu = misDatos.getUsuario(idusuarios);
                    if (usu != null) {
                        mensaje = "Usuario ya existe";
                    } else {
                        usu = new Usuarios(
                                idusuarios,
                                nombre,
                                apellidos,
                                email,
                                password,
                                new Integer(perfil));
                        misDatos.nuevoUsuario(usu);
                        mensaje = "Usuario ingresado";
                    }
                    conex.CerrarConexion();
                }
            //Modificar Usuario 
            if (modificar) {
                    misDatos = new DatosUsuario();
                    usu = misDatos.getUsuario(idusuarios);
                    if (usu == null) {
                        mensaje = "Usuario no existe";
                    } else {
                        usu = new Usuarios(
                                idusuarios,
                                nombre,
                                apellidos,
                                email,
                                password,
                                new Integer(perfil));
                        misDatos.modificarUsuario(usu);
                        mensaje = "Usuario modificado";
                    }
                    conex.CerrarConexion();
                }
            //Validamos si hay usuario a consultar
            if (borrar) {
                misDatos = new DatosUsuario();
                usu = misDatos.getUsuario(idusuarios);
                if (usu == null) { //usuario no esta en la bd
                    mensaje = "Usuario no existe";
                } else {
                    misDatos.eliminarUsuario(idusuarios);
                    idusuarios = "";
                    nombre = "";
                    apellidos = "";
                    email = "";
                    password = "";
                    password2 = "";
                    perfil = "";
                    mensaje = "Usuario eliminado";
                }
                conex.CerrarConexion();
            }

        %> 

     <div class="container-fluid">
            <div class="text-center">
                <h1>Bootstrap forms</h1>
                <p class="lead">Example of a form with 3 columns and labels aligned to the left of the 
                    fields at &gt; 1200px (large) screen sizes, 2 columns and labels aligned to the left of the 
                    fields at &gt;992px (medium) screen sizes, 2 columns labels above fields at &gt; 768px (small), and single 
                    column at &lt; 768px (Extra small). 
                </p>
            </div>
            <form class="form-horizontal" role="form">
                <div class="row">
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="inputEmail" class="col-md-4 control-label">Email:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="inputEmail" placeholder="Email" type="email">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="inputPassword" class="col-md-4 control-label">Password:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="inputPassword" placeholder="Password" type="password">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="inputLabel3" class="col-md-4 control-label">Label 3:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="inputLabel3" placeholder="Label 3" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="inputLabel4" class="col-md-4 control-label">Label 4:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="inputLabel4" placeholder="Label 4" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input5" class="col-md-4 control-label">1234567890:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input5" placeholder="input 5" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input6" class="col-md-4 control-label">123456789012:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input6" placeholder="input 6" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input7" class="col-md-4 control-label">12345678901234:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input7" placeholder="input 7" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input8" class="col-md-4 control-label">1234567890123456:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input8" placeholder="input 8" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input9" class="col-md-4 control-label">123456789012345678:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input9" placeholder="input 9" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-4">
                        <div class="form-group">
                            <label for="input10" class="col-md-4 control-label">12345678901234567890:</label>
                            <div class="col-md-8">
                                <input class="form-control" id="input10" placeholder="input 10" type="text">
                            </div>
                        </div>
                    </div>
                </div><!-- /.row this actually does not appear to be needed with the form-horizontal -->
            </form>
            <p>Note: label text will occupy as much space as the text takes regardless of the 
                column size, so be sure to validate your spacing.
            </p>
        </div>
            <!--Tabla de Usuarios-->
            <h1 id="cabeceratabla">Listado Usuarios</h1>
            <div class="table-responsive">
                <table id="tabla" class="table">
                        <thead>
                            <tr>
                                <th>Usuarios</th>
                                <th>Nombre</th>
                                <th>Apellidos</th>
                                <th>Email</th>
                                <th>Password</th>
                                <th>Perfil</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                //Listar Usuarios
                                if (listar) {
                                    ResultSet rs = misDatos.AllUsuarios();
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%=rs.getString("idusuarios")%></td>
                                <td><%=rs.getString("nombre")%></td>
                                <td><%=rs.getString("apellidos")%></td>
                                <td><%=rs.getString("email")%></td>
                                <td><%=rs.getString("password")%></td>
                                <td><%=(rs.getString("idPerfil").equals("1") ? "Administrador" : "Empleado")%></td>                            
                            </tr>
                            <%
                                }
                                    conex.CerrarConexion();
                                }
                            %>
                        </tbody>
                    </table> 
                </div>
         </form> 
    </div>                     
        <jsp:include page="contenido/footer.jsp"></jsp:include>
    </body>
</html>


