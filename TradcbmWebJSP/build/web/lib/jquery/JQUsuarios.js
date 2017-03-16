  myJson="";

$(document).ready(function() {
    //Al pulsar mostrar oculta el formulario y muestra el listado
    $('#listar').click(function(e) {
        e.preventDefault();
        $('#listado').toggle();
        $('#Registrar').toggle();
    });
    //Muestra el formulario y oculta el listado
    function MostrarOcultar(){   
        $('#listado').toggle();
        $('#Registrar').toggle(); 
    };
    
    //Función de listar para la vista de listado de usuarios
    listar();
    
    //Funcion ingresar    
    $('#ingresar').click(function(e) { 
      e.preventDefault();
      $.post('SvUsuarios', {
            idusuarios: $('#idusuarios').val(),
            password: $('#password').val(),  
            opcion: "ingresar"},
            function(respuesta) {
                    perfil = respuesta;
                    console.log(perfil);
                switch(perfil){
                    case "Administrador": { 
                        logCorrecto();         
                        break;
                    }
                    case "Empleado" : {
                        logCorrecto();
                        break;
                    }
                    case "null": { 
                        logIncorrecto();
                        break;
                    }
                    default:{
                        window.location.href = "index.jsp";
                        break;
                }
                }
            });
    });
    
    function logCorrecto() {
        swal({
            title: "Correcto",
            text: "Bienvenido a Tradcbm",
            type: "success",           
            closeOnConfirm: false,
            showLoaderOnConfirm: true
        },
        function () {                
                if(perfil === "Administrador"){
                    window.location.href = "MenuAdministrador.jsp";}
                else if(perfil === "Empleado"){
                    window.location.href = "MenuEmpleado.jsp"; }
                });                                 
        };        
    function logIncorrecto() {
        swal({
            title: "Error",
            text: "Introduzca usuario o contraseña correctos",
            type: "error",             
            closeOnConfirm: false,
            showLoaderOnConfirm: true
        },
            function () {
                window.location.href = "index.jsp";
        });
    };
    
    //Función de añadir nuevo usuario + validacón
    function nuevo(){
       $.post('SvUsuarios', {
            idusuarios: $('#idusuarios').val(),
            nombre: $('#nombre').val(),
            apellidos: $('#apellidos').val(),
            email: $('#email').val(),
            password: $('#password').val(),
            perfil: $('#perfil').val(),
            opcion: "nuevo"},
            function(respuesta) {  
                if(respuesta === "Existe"){
                     swal({
                      title: "Error",
                      text: "Usuario existe",
                      type: "error",
                      closeOnConfirm: false,
                      showLoaderOnConfirm: true });
             }else{
                 MostrarOcultar();
             }
        }); 
    }   
    $('#nuevo').click(function() {      
        validar_nuevo();   
     });    
     
    //Función de modificar usuario + validacón
    function modificar(){
       $.post('SvUsuarios', {
            idusuarios: $('#idusuarios').val(),
            nombre: $('#nombre').val(),
            apellidos: $('#apellidos').val(),
            email: $('#email').val(),
            password: $('#password').val(),
            perfil: $('#perfil').val(),
            opcion: "modificar"
        });
         MostrarOcultar();
    }
    $('#modificar').click(function() {    
        validar_modificar();  
    });

    function borrar() {
        $.post('SvUsuarios', {
            idusuarios: $('#idusuarios').val(),
            opcion: "eliminar"
        });
    }
    //Función de borrar usuario + validacón
    $('#borrar').click(function() {
        validar_Borrar();
        borrar();
    });

    //Función de consultar usuario + validacón
    $('#consultar').click(function() {
        validar_Consultar();
    });

    //Función para pedir mediante ajax una consulta de usuario
    function consultar() {
        $.post('SvUsuarios', {
            idusuarios: $('#idusuarios').val(),
            perfil: 0,
            opcion: "consultar"},
                function(respuesta) {
                    myJson = $.parseJSON(respuesta);                   
                    if (myJson === null) {
                        //quitamos la clase valid, añadimos la clase error y añadimos detrás un span de error
                        $('#idusuarios').removeClass("valid").addClass("error")
                                .after('<span for="idusuarios" id="spanerror" class="error spanerror">Usuario no existe</span>');
                    } else {
                        $('#idusuarios').val(myJson.idusuarios);
                        $('#nombre').val(myJson.nombre);
                        $('#apellidos').val(myJson.apellidos);
                        $('#email').val(myJson.email);
                        $('#password').val(myJson.password);
                        $('#password2').val(myJson.password);
                        $('#perfil').val(myJson.perfil);
                    }
                });
    }
    ;

    //Función para listar los usuarios en la vista de listadoUsuarios.jsp
    function listar() {
        $.post('SvUsuarios', {
            perfil: 0,
            opcion: "listar",
            method: 'post',
            dataType: 'json'},
                function(data) {
                    myJson = $.parseJSON(data);
                    table = $('#tabla').dataTable({
                        data: myJson,
                        columns: [
                            {"defaultContent":
                                        "<button type='button' class='editar btn btn-primary'>\n\
                                        <i class='fa fa-pencil-square-o'></i></button>"},
                            {"defaultContent":
                                        "<button type='button' class='eliminar btn btn-danger'>\n\
                                         <i class='fa fa-trash-o'></i></button>"},
                            {'data': 'idusuarios'},
                            {'data': 'nombre'},
                            {'data': 'apellidos'},
                            {'data': 'email'},
                            {'data': 'password'},
                            {'data': 'perfil'}  
                        ],
                        "language": Espanol
                    });
                    data_editar();
                    data_borrar();
                    $('#tabla').removeAttr('style');
                });
    } ;
    var Espanol = {
        "sProcessing": "Procesando...",
        "sLengthMenu": "Mostrar _MENU_ registros",
        "sZeroRecords": "No se encontraron resultados",
        "sEmptyTable": "Ningún dato disponible en esta tabla",
        "sInfo": "Registros del _START_ al _END_ de un total de _TOTAL_",
        "sInfoEmpty": "Registros del 0 al 0 de un total de 0",
        "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix": "",
        "sSearch": "Buscar:",
        "sUrl": "",
        "sInfoThousands": ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
            "sFirst": "Primero",
            "sLast": "Último",
            "sNext": "Siguiente",
            "sPrevious": "Anterior"
        },
        "oAria": {
            "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
            "sSortDescending": ": Activar para ordenar la columna de manera descendente"
        }
    };

    function data_editar() {
        $('tbody').on('click', 'button.editar', function() {
            var table = $('#tabla').DataTable();
            var dato = table.row($(this).parents('tr')).data();
            idusuarios = $('#idusuarios').val(dato.idusuarios);
            nombre = $('#nombre').val(dato.nombre);
            apellidos = $('#apellidos').val(dato.apellidos);
            email = $('#email').val(dato.email);
            password = $('#password').val(dato.password);
            password2 = $('#password2').val(dato.password);
            perfil = $('#perfil').val(dato.perfil);
            MostrarOcultar();
        });
    }

    function data_borrar() {
        $('#tabla tbody').on('click', 'button.eliminar', function() {
            var table = $('#tabla').DataTable();
            var dato = table.row($(this).parents('tr')).data();
            idusuarios = $('#idusuarios').val(dato.idusuarios);
            swal({
                title: "Estas seguro de borrar este usuario?",
                text: "No podrás recuperar el usuario eliminado!",
                type: "error",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Borrar"},
                    function() {
                        borrar(idusuarios);                     
                    });
        });
    }

    /************************/
    //  VALIDACIONES //
    /************************/

    //Función para validar las peticiones de nuevo 
    function validar_nuevo(){
        $('#Registrar').validate({
            //Reglas de validación para cada input
            rules: {
                idusuarios: {required: true, maxlength:10},
                nombre: {required: true},
                apellidos: {required: true},
                email: {required: true, email: true},
                password: {required: true, minlength: 5},
                password2: {required: true, equalTo: "#password"},
                perfil: {selectcheck: true}
            },
            //mensajes de error de validación para cada input
            messages: {
                idusuarios: {required: "Debe escribir un nombre de usuario",
                             maxlength:"Máximo diez caracteres"},
                nombre: {required: "Debe escribir un nombre"},
                apellidos: {required: "Debe escribir un apellido"},
                email: {required: "Debe escribir un email",
                    email: 'Formato incorrecto. Ejemplo: u@localhost.com'},
                password: {required: "Debe escribir una contraseña",
                    minlength: "Mínimo cinco caracteres"},
                password2: {required: "Deben coincidir las contraseñas",
                    minlength: "Mínimo cinco caracteres"}
            },
            //Formato del mensaje de error
            errorElement: 'span',
            //Dónde se coloca el mensaje de error
            errorPlacement: function(error, element) {
                error.html(error.text()).addClass('spanerror').insertAfter(element).hide().fadeIn();
            },
             //Funcionalidad para el botón de envío
            submitHandler: function() {                
                nuevo();  
            }
        });
        //Función para la validación del select de perfil
        jQuery.validator.addMethod('selectcheck', function(value) {
        return (value !== "");
        }, "Seleccione un perfil de usuario");
    };
    

    //Función para la validación de modificar 
    function validar_modificar(){
        $('#Registrar').validate({
            //Reglas de validación para cada input
            rules: {
                idusuarios: {required: true, maxlength:10},
                nombre: {required: true},
                apellidos: {required: true},
                email: {required: true, email: true},
                password: {required: true, minlength: 5},
                password2: {required: true, equalTo: "#password"},
                perfil: {selectcheck: true}
            },
            //mensajes de error de validación para cada input
            messages: {
                idusuarios: {required: "Debe escribir un nombre de usuario",
                             maxlength:"Máximo diez caracteres"},
                nombre: {required: "Debe escribir un nombre"},
                apellidos: {required: "Debe escribir un apellido"},
                email: {required: "Debe escribir un email",
                    email: 'Formato incorrecto. Ejemplo: u@localhost.com'},
                password: {required: "Debe escribir una contraseña",
                    minlength: "Mínimo cinco caracteres"},
                password2: {required: "Deben coincidir las contraseñas",
                    minlength: "Mínimo cinco caracteres"}
            },
            //Formato del mensaje de error
            errorElement: 'span',
            //Dónde se coloca el mensaje de error
            errorPlacement: function(error, element) {
                error.html(error.text()).addClass('spanerror').insertAfter(element).hide().fadeIn();
            },
             //Funcionalidad para el botón de envío
            submitHandler: function() {              
                 modificar();
            }
        });
        //Función para la validación del select de perfil
        jQuery.validator.addMethod('selectcheck', function(value) {
        return (value !== "");
        }, "Seleccione un perfil de usuario");
    };
   

    //Función para validar las peticiones de consultar y eliminar
    function validar_Consultar() {
        $('#Registrar').validate({
            //Reglas de validación para cada input
            rules: {
                idusuarios: {required: true}
            },
            //mensajes de error de validación para cada input
            messages: {
                idusuarios: {required: "Debe escribir un nombre de usuario"}
            },
            errorElement: 'span',
            //Dónde se coloca el mensaje de error
            errorPlacement: function(error, element) {
                error.html(error.text()).addClass('spanerror').insertAfter(element).hide().fadeIn();
            },
            //Funcionalidad para el botón de envío
            submitHandler: function() {
                consultar();
            }
        });
    };
    //Función para validar las peticiones de consultar y eliminar
    function validar_Borrar() {
        $('#Registrar').validate({
            //Reglas de validación para cada input
            rules: {
                idusuarios: {required: true}
            },
            //mensajes de error de validación para cada input
            messages: {
                idusuarios: {required: "Debe escribir un nombre de usuario"}
            },
            errorElement: 'span',
            //Dónde se coloca el mensaje de error
            errorPlacement: function(error, element) {
                error.html(error.text()).addClass('spanerror').insertAfter(element).hide().fadeIn();
            },
            //Funcionalidad para el botón de envío
            submitHandler: function(form) {
                form.submit();
            }
        });
    }; 
});
