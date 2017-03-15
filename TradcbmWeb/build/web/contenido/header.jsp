
<%@page import="clases.Usuarios"%>
<header>   
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#mibarra">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp" id="brandlink">Tradcbm</a>
            </div>
            <!-- link principales-->
            <div class="collapse navbar-collapse" id="mibarra">
                <ul class="nav navbar-nav" id="link">
                    <li id="active"><a href="Clientes.jsp">Clientes</a></li>
                    <li><a href="Proyectos.jsp">Proyectos</a></li>               
                    <li><a href="Facturas.jsp">Facturas</a></li>    
                    <li><a href="Proveedores.jsp">Proveedores</a></li>  
                    <li><a href="Compras.jsp">Compras</a></li> 
                 </ul>
                <ul class="nav navbar-nav navbar-left">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"  role="button" aria-haspopup="true" 
                           id="laterallink"><strong>Impuestos </strong><span class="caret"></span></a>
                        <ul class="dropdown-menu text-center" id="lateralli">
                            <li><a href="Irpf.jsp">IRPF</a></li>
                            <li><a href="Iva.jsp">IVA</a></li>            	
                        </ul>
                    </li>
                </ul>
                  <%
                     //Obtenemos la sesión del usuario
                     HttpSession sesion = request.getSession();
                     Usuarios usulog = (Usuarios) sesion.getAttribute("idusuarios");                                
                  %> 
                <!-- link lateral de login-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
                           role="button" aria-haspopup="true" id="laterallink">
                        <strong>Bienvenido :<%=usulog.getNombre()%></strong> 
                        <strong>Login </strong><span class="caret"></span></a>
                        <ul class="dropdown-menu text-center" id="lateralli"> 
                           <li><a href="Registrar.jsp">Registrarse</a></li>
                            <li><a href="index.jsp">Ingresar</a></li>            	
                            <li role="separator" class="divider"></li>
                            <li><a href="index.jsp">Salir</a></li> 
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header> 