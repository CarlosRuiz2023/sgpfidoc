<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="consultar_usuarios.aspx.vb" Inherits="Admin_procesos_consulta_usuarios" Culture="Auto" UICulture="Auto"%>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">



        function ConsultaEdoCtaCoop(idusu, coo_clv2) {
            //alert(img);
            var url1 = "../../Procesos/EdoCtaFteGral_S.html?ResponseType=Edit&idusu=" + idusu + "&coo_clv2=" + coo_clv2;
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1600,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }

        //Funcion para redimensionar los input de la ventana modal
        function resizeInput() {

            var valueLength = $(this).prop('value').length;

            // Para que no arroje error si el input se vacía
            if (valueLength > 0) {

                $(this).prop('size', valueLength);
            }
        }

       



        function ConvertirCadenaToFecha(cadenafec) {
            if (cadenafec != "") {
                var from = cadenafec.split("/");
                var fecha = new Date(from[2], from[1] - 1, from[0]);
            }
            else {
                /*var fecha = new Date('2200', '01', '01');*/
                var fecha = '01/01/1900';
            }

            return fecha;
        }


        function recuperarParametro(campo) {
            var RE = new RegExp("[&?]" + campo + "=([^&]*)&");
            var href = location.href + "&";
            if (RE.test(href)) {
                RE.exec(href);
                return unescape(RegExp.$1);
            }
        }

        function IsNumeric(valor) {

            var log = valor.length;
            var sw = "S";
            for (x = 0; x < log; x++) {
                v1 = valor.substr(x, 1);
                v2 = parseInt(v1);
                //Compruebo si es un valor numérico 
                if (isNaN(v2)) {
                    if (v1 != ".") {
                        sw = "N";
                        x = log;
                    }
                }
            }
            if (sw == "S") { return true; } else { return false; }
        }

        var primerslap = false;
        var segundoslap = false;

        function formateafecha(fecha) {
            var long = fecha.length;
            var dia;
            var mes;
            var ano;
            if ((long >= 2) && (primerslap == false)) {
                dia = fecha.substr(0, 2);
                if ((IsNumeric(dia) == true) && (dia <= 31) && (dia != "00")) { fecha = fecha.substr(0, 2) + "/" + fecha.substr(3, 7); primerslap = true; }
                else { fecha = ""; primerslap = false; }
            }
            else {
                dia = fecha.substr(0, 1);
                if (IsNumeric(dia) == false)
                { fecha = ""; }
                if ((long <= 2) && (primerslap = true)) { fecha = fecha.substr(0, 1); primerslap = false; }
            }
            if ((long >= 5) && (segundoslap == false)) {
                mes = fecha.substr(3, 2);
                if ((IsNumeric(mes) == true) && (mes <= 12) && (mes != "00")) { fecha = fecha.substr(0, 5) + "/" + fecha.substr(6, 4); segundoslap = true; }
                else { fecha = fecha.substr(0, 3);; segundoslap = false; }
            }
            else { if ((long <= 5) && (segundoslap = true)) { fecha = fecha.substr(0, 4); segundoslap = false; } }
            if (long >= 7) {
                ano = fecha.substr(6, 4);
                if (IsNumeric(ano) == false) { fecha = fecha.substr(0, 6); }
                else { if (long == 10) { if ((ano == 0) || (ano < 1900) || (ano > 2100)) { fecha = fecha.substr(0, 6); } } }
            }
            if (long >= 10) {
                fecha = fecha.substr(0, 10);
                dia = fecha.substr(0, 2);
                mes = fecha.substr(3, 2);
                ano = fecha.substr(6, 4);
                // Año no viciesto y es febrero y el dia es mayor a 28 
                if ((ano % 4 != 0) && (mes == 02) && (dia > 28)) { fecha = fecha.substr(0, 2) + "/"; }
            }
            return (fecha);
        }




        function checkVacio(conten, regexp, msj) {
            if (conten == "" || conten.trim() == "") {
                return true;
            }
            else {
                return checkRegexp(conten, regexp, msj);
            }
        }

        function checkLength(largo, n, min, max) {
            if (largo > max || largo < min) {
                updateTips("La longitud de:  " + n + " debe ser entre  " + min + " y " + max + ".");
                return false;
            } else {
                return true;
            }
        }

        function CompletaCerosIzq(cadena, longitud) {

            cadena.length > longitud
            if (largo > max || largo < min) {
                updateTips("La longitud de:  " + n + " debe ser entre  " + min + " y " + max + ".");
                return false;
            } else {
                return true;
            }
        }

        function checkRegexp(o, regexp, n) {
            if (regexp.test(o)) {
                return true;
            } else {
                updateTips(n);
                return false;
            }
        }

        function updateTips(t) {
            alert(t);
        }



        function RedibujarGrid() {
            //    jQuery("#grid").jqGrid('setGridParam',
            //        {
            //          datatype: function () { ObtenerDatos(ObtenerFiltro()) }                
            //        })
            //.trigger("reloadGrid");
            $("#grid").trigger("reloadGrid");
        }



        function MostrarUsuarios(idusu) {


            var date = new Date();
            var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
            var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();


            if ($("#grid")[0].grid) {
                $.jgrid.gridUnload("#grid");
                //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
            }

            $("#grid").jqGrid(
             {
                 datatype: function () {
                     $.ajax(
                       {
                           url: "../../WebServices/WebServiceUsuario.asmx/GetUsuariosGral", //PageMethod
                           data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                           "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                           "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                           "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                           "','idusu':'" + idusu + "'}", //PageMethod Parametros de entrada           
                           dataType: "json",
                           type: "post",
                           contentType: "application/json; charset=utf-8",
                           complete: function (jsondata, stat) {
                               if (stat == "success") {
                                   jQuery("#grid")[0].addJSONData(JSON.parse(jsondata.responseText).d);
                                   var objeto = JSON.parse(jsondata.responseText).d;
                                   var regs = objeto.RecordCount;
                                   if (regs == 0) {
                                       alert('No se encontraron registros...');
                                   }
                               }
                               else
                                   alert(JSON.parse(jsondata.responseText).Message);
                           }
                       });
                 },
                 jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                 {
                     root: "Items",
                     page: "CurrentPage",
                     total: "PageCount",
                     records: "RecordCount",
                     repeatitems: true,
                     cell: "row",
                     id: "IdUsuario"
                 },
                 colModel: [
                                 {
                                     index: 'IdUsuario', width: 80, align: 'Center', name: 'idusu'
                                 },
                                 {
                                     index: 'Nombre', width: 300, align: 'Center', name: 'Nombre_Usuario'
                                 },
                                 {
                                     index: 'idarea', width: 50, align: 'Center', name: 'idarea', hidden: true
                                 },
                                 {
                                     index: 'Area', width: 200, align: 'Center', name: 'Area'
                                 },
                                 {
                                     index: 'Correo', width: 200, align: 'Center', name: 'Correo_Electronico'
                                 },
                                 {
                                     index: 'Usuario', width: 200, align: 'Center', name: 'Cuenta_Usuario'
                                 },
                                 {
                                     index: 'Pass', width: 100, align: 'Center', name: 'Contraseña', hidden: true
                                 },
                                 {
                                     index: 'IdRol', width: 100, align: 'Center', name: 'CveRol', hidden: true
                                 },
                                 {
                                     index: 'RolTxt', width: 200, align: 'Center', name: 'NombreRol'
                                 },
                                 {
                                     index: 'Rfc', width: 100, align: 'Center', name: 'RFC'
                                 },
                                 {
                                     index: 'Curp', width: 200, align: 'Center', name: 'CURP'
                                 },
                                 {
                                     index: 'Ss', width: 100, align: 'Center', name: 'SS', hidden: true
                                 },
                                 {
                                     index: 'Empleado', width: 100, align: 'Center', name: 'No_Empleado'
                                 },
                                 {
                                     index: 'UsuCre', width: 200, align: 'Center', name: 'Usuario_crea'
                                 },
                                 {
                                     index: 'UsuMod', width: 200, align: 'Center', name: 'Usuario_modifica'
                                 },
                                 {
                                     index: 'UsuEstatus', width: 100, align: 'Center', name: 'Estatus_Usuario', hidden: true
                                 },
                                 {
                                     index: 'Activo', width: 100, align: 'Center', name: 'ACTIVO', hidden: true
                                 },
                                 {
                                     index: 'FecUltCon', width: 150, align: 'Center', name: 'FecUltCon'
                                 },
                                 {
                                     index: 'FecCre', width: 100, align: 'Center', name: 'FecCre'
                                 },
                                 {
                                     index: 'FecMod', width: 100, align: 'Center', name: 'FecMod'
                                 }],
                 pager: "#pager", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                 rowNum: "20", // PageSize.
                 rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "musuid", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "2500",
                 height: "800",
                 caption: "Usuarios"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaUsu",
                            id: "alta_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objUsuario = myGrid.jqGrid('getRowData', selectedRowId);
                                
                                PantallaUsuario(objUsuario,0);
                               
                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditUsu",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objUsuario = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objUsuario.idusu) {                                    
                                    if (objUsuario.ACTIVO == '1') {
                                        PantallaUsuario(objUsuario, 1);
                                    }
                                    else {
                                        alert('El usuario se encuentra eliminado.');
                                    }
                                }
                                else {
                                    alert("Selecciona un usuario...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "ElimUsu",
                            id: "eliminar_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objUsuario = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objUsuario.idusu) {
                                    if (objUsuario.ACTIVO == '1') {
                                        PantallaUsuario(objUsuario, 2);
                                    }
                                    else {
                                        alert('El usuario se encuentra eliminado.');
                                    }
                                }
                                else {
                                    alert("Selecciona un usuario...");
                                }


                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "CambiaContraseña",
                            id: "cambia_contraseña",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objUsuario = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objUsuario.idusu) {
                                    if (objUsuario.ACTIVO == '1') {
                                        PantallaUsuario(objUsuario, 3);
                                    }
                                    else {
                                        alert('El usuario se encuentra eliminado.');
                                    }
                                }
                                else {
                                    alert("Selecciona un usuario...");
                                }


                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        });

            var myGrid = $('#grid');
            /*Prepara vista segun la opcion del menu*/
            if (idusu != 46) {
                var $viewBtn1 = $('#edit_usuario');
                $viewBtn1.addClass("ui-state-disabled");
                var $viewBtn2 = $('#alta_usuario');
                $viewBtn2.addClass("ui-state-disabled");
                var $viewBtn2 = $('#eliminar_usuario');
                $viewBtn2.addClass("ui-state-disabled");
            }
        }

        



        //// FUNCION PRINCIPAL

        $(document).ready(function () {

            var opcmenu = recuperarParametro("opcmenu");
            var idusu_aux = recuperarParametro("idusu");

            posicion = idusu_aux.indexOf('#');
            if (posicion !== -1)
                idusu = idusu_aux.substr(0, idusu_aux.length - 1);
            else
                idusu = idusu_aux;
            


            $("#bodegadatos").data("idusu",idusu);
            MostrarUsuarios(idusu);
            
            
            $(".posicion_boton_cancelar_usuario").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_usuario").click(function (e) {
                var accion_gestion = $("#lblaccionusu").html();
                GestionUsuario(accion_gestion);
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function PantallaUsuario(objUsuario,accion) {

            if (accion == 0) {

                $("#txtusunombre").val('');
                $("#txtemail").val('');
                $("#txtcuenta").val('');
                $("#txtcontra").val('');
                $("#txtnumempleado").val('');
                $("#txtrfc").val('');
                $("#txtcurp").val('');
                $("#lblidusu").html($("#bodegadatos").data("idusu"));
                $("#lblaccionusu").html('0');
                $("#lblidusu_gestion").html('0');

                llenarRolesUsuario(accion, 0);
                llenarAreasTrabajo(accion, 0);
            }
            else {
                if (accion == 1 || accion == 2) {

                    $("#txtusunombre").prop('disabled', false);
                    $("#txtemail").prop('disabled', false);
                    $("#txtcuenta").prop('disabled', false);
                    $("#txtcontra").prop('disabled', false);
                    $("#txtnumempleado").prop('disabled', false);
                    $("#txtrfc").prop('disabled', false);
                    $("#txtcurp").prop('disabled', false);
                    $("#lstareatrabajo").prop('disabled', false);
                    $("#lstrol").prop('disabled', false);

                    $("#txtusunombre").val(objUsuario.Nombre_Usuario);
                    $("#txtemail").val(objUsuario.Correo_Electronico);
                    $("#txtcuenta").val(objUsuario.Cuenta_Usuario);
                    $("#txtcontra").val(objUsuario.Contraseña);
                    $("#txtnumempleado").val(objUsuario.No_Empleado);
                    $("#txtrfc").val(objUsuario.RFC);
                    $("#txtcurp").val(objUsuario.CURP);
                    $("#lblidusu").html($("#bodegadatos").data("idusu"));
                    $("#lblaccionusu").html('1');
                    $("#lblidusu_gestion").html(objUsuario.idusu);
                   

                    if (accion == 2) {
                        $("#txtusunombre").prop('disabled', true);
                        $("#txtemail").prop('disabled', true);
                        $("#txtcuenta").prop('disabled', true);
                        $("#txtcontra").prop('disabled', true);
                        $("#txtnumempleado").prop('disabled', true);
                        $("#txtrfc").prop('disabled', true);
                        $("#txtcurp").prop('disabled', true);
                        $("#lstareatrabajo").prop('disabled', true);                        
                        $("#lstrol").prop('disabled', true);

                        $("#lblidusu").html($("#bodegadatos").data("idusu"));
                        $("#lblaccionusu").html('2');
                        $("#lblidusu_gestion").html(objUsuario.idusu);
                    }                 

                }
                else {                
                       if (accion == 3) {
                           $("#txtusunombre").prop('disabled', true);
                           $("#txtemail").prop('disabled', true);
                           $("#txtcuenta").prop('disabled', true);
                           $("#txtcontra").prop('disabled', false);
                           $("#txtnumempleado").prop('disabled', true);
                           $("#txtrfc").prop('disabled', true);
                           $("#txtcurp").prop('disabled', true);
                           $("#lstareatrabajo").prop('disabled', true);
                           $("#lstrol").prop('disabled', true);

                           $("#lblidusu").html($("#bodegadatos").data("idusu"));
                           $("#lblaccionusu").html('3');
                           $("#lblidusu_gestion").html(objUsuario.idusu);

                           $("#txtusunombre").val(objUsuario.Nombre_Usuario);
                           $("#txtemail").val(objUsuario.Correo_Electronico);
                           $("#txtcuenta").val(objUsuario.Cuenta_Usuario);
                           $("#txtcontra").val(objUsuario.Contraseña);
                           $("#txtnumempleado").val(objUsuario.No_Empleado);
                           $("#txtrfc").val(objUsuario.RFC);
                           $("#txtcurp").val(objUsuario.CURP);
                           $("#lblidusu").html($("#bodegadatos").data("idusu"));
                           $("#lblaccionusu").html('3');
                           $("#lblidusu_gestion").html(objUsuario.idusu);
                        }
                    
                }

                llenarRolesUsuario(accion, objUsuario.CveRol);
                llenarAreasTrabajo(accion, objUsuario.idarea);
            }

            MostrarModalUsuario();

        }


        function GestionUsuario(accion) {                     
                        
            $("#lblidusu").html($("#bodegadatos").data("idusu"));            
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var usurec = arrusuario[2];
            var opcion = true;

            var usuid = $("#lblidusu_gestion").html();
            var usunombre = $("#txtusunombre").val();
            var usucorreo = $("#txtemail").val();            
            var usucuenta = $("#txtcuenta").val();
            var usupass = $("#txtcontra").val();
            var usuidrol = $("#lstrol").val();
            var usuidarea = $("#lstareatrabajo").val();
            var usurfc = $("#txtrfc").val();
            var usucurp = $("#txtcurp").val();
            var ususs = '';
            var usuempleado = $("#txtnumempleado").val();

            var usuestatus;
            var usuactivo;
            var usuusucre;
            var usuusumod;
          
            
            
            
            var date = new Date();
            var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();

            var usulastlogin = ConvertirCadenaToFecha('01/01/1900');
            var usufeccre = ConvertirCadenaToFecha(hoy);
            var usufecmod = ConvertirCadenaToFecha(hoy);
          
            
            


            if (accion == 0 || accion == 1) {  /*Alta de usuario*/

                usuestatus = 1;
                usuactivo = 1;
                usuusucre = usuario;
                usuusumod = usuario;                
            }
            else {
                if (accion == 2) {
                    opcion = confirm('Desea eliminar el usuario: ' + usunombre + ' con cuenta: ' + usucuenta);
                    if (opcion) {
                        usuestatus = 0
                        usuactivo = 0
                        usuusumod = usuario;
                    }



                }
                else {
                    if (accion == 3) {
                        usuestatus = 1
                        usuactivo = 1                        
                        usuusumod = usuario;
                    }

                }
            }
            
            if (opcion) {

                var objUsuario = {
                    "IdUsuario": usuid,
                    "Nombre": usunombre,
                    "Correo": usucorreo,
                    "Usuario": usucuenta,
                    "Pass": usupass,
                    "IdRol": usuidrol,
                    "Rfc": usurfc,
                    "Curp": usucurp,
                    "Ss": ususs,
                    "Empleado": usuempleado,
                    "UsuCre": usuusucre,
                    "UsuMod": usuusumod,
                    "UsuEstatus": usuestatus,
                    "Activo": usuactivo,
                    "FecUltCon": usulastlogin,
                    "FecCre": usufeccre,
                    "FecMod": usufecmod,
                    "idarea": usuidarea,
                    "accion": accion
                }
              RegistrarUsuarioBD(objUsuario);
            }
        }



        function RegistrarUsuarioBD(objUsuario) {

            var stringData = JSON.stringify(objUsuario);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceUsuario.asmx/GuardarUsuario",
                data: "{objUsuario:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        alert(data.d);
                        $('#mask, .window').hide();
                        RedibujarGrid();
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };


        function MostrarModalUsuario() {
            var maskHeight = $(document).height();
            var maskWidth = $(window).width();


            //Set height and width to mask to fill up the whole screen
            $('#mask').css({ 'width': maskWidth, 'height': maskHeight });

            //transition effect             
            $('#mask').fadeIn(1000);
            $('#mask').fadeTo("slow", 0.8);

            //Get the window height and width
            var winH = $(window).height();
            var winW = $(window).width();

            //Set the popup window to center
            $("#dialogousuario").css('top', winH / 2 - $("#dialogousuario").height() / 2);
            $("#dialogousuario").css('left', winW / 2 - $("#dialogousuario").width() / 2);

            //transition effect
            $("#dialogousuario").fadeIn(2000);
        };

       


        function llenarRolesUsuario(accion, idrol) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceRolesUsuario.asmx/GetRolesUsuario",
                data: "{'accion':'" + accion  + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lstrol").html('');
                    $(data.d).find("rolusu").each(function () {
                        var option = $(document.createElement('option'));
                        var cverol = $(this).find("crolidr").text();
                        var rolnombre = $(this).find("crolnombrer");
                        option.html(rolnombre);
                        option.val(cverol);
                        //Nombre de combo a poblar
                        $("#lstrol").append(option);
                        elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                    });
                    if (accion == 1) {
                        $("#lstrol").val(idrol);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }


        function llenarAreasTrabajo(accion, idarea) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceAreasTrabajo.asmx/GetAreasTrabajo",
                data: "{'accion':'" + accion + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lstareatrabajo").html('');
                    $(data.d).find("areatrabajo").each(function () {
                        var option = $(document.createElement('option'));
                        var cve_area = $(this).find("idareatrabajor").text();
                        var nom_area = $(this).find("nom_arear");
                        option.html(nom_area);
                        option.val(cve_area);
                        //Nombre de combo a poblar
                        $("#lstareatrabajo").append(option);
                        elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                    });
                    if (accion == 1) {
                        $("#lstareatrabajo").val(idarea);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }





</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
     
    
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>
 
<div id="boxes">        
    <div id="dialogousuario" class="window"> 
       <div id="titulousu"> 
         <p style="text-align:center">GESTION DE USUARIOS</p>
         Usuario: <label for="cve_usuario" id="lblidusu"></label><br/>
         Usuario en Gestión: <label for="cve_usu_" id="lblidusu_gestion"></label><br/>
         Acción:<label for="accion" id="lblaccionusu"></label><br/>
       </div>
       <div class="datos" id="bodyusuario">                  
          <label for="name" id="lblusunombre">*Nombre de usuario:</label><input type="text" name="usunombre" id="txtusunombre" size="80"/><br/><br/>
          <label for="name" id="lblarea">*Área de trabajo:</label><select name="areatrabajo" id="lstareatrabajo"></select><br/><br/>  
          <label for="name" id="lblusucorreo">*Correo electrónico:</label><input type="text" name="email" id="txtemail" size="100"/><br/><br/>
          <label for="name" id="lblusucuenta">*Cuenta:</label><input type="text" name="cuenta" id="txtcuenta" size="50"/><br/><br/>
          <label for="name" id="lblusupass">*Contraseña:</label><input type="text" name="contraseña" id="txtcontra" size="50"/><br/><br/>        
          <label for="name" id="lblusurol">*Rol de Usuario:</label><select name="rol" id="lstrol"></select><br/><br/>
          <label for="name" id="lblnumempleado">*Numero empleado: </label><input type="text" name="numempleado" id="txtnumempleado" size="10" maxlength="10"/><br/><br/>            
          <label for="name" id="lblusurfc">Rfc:</label><input type="text" name="rfc" id="txtrfc" size="15"/><br/><br/>
          <label for="name" id="lblusucurp">CURP:</label><input type="text" name="curp" id="txtcurp" size="30"/><br/><br/>
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_usuario">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_usuario">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>


