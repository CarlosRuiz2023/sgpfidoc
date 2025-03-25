<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_tasignacion.aspx.vb" Inherits="Admin_procesos_consultar_tasignacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">




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



        function MostrarTipoAsignacion(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceTipoAsignacion.asmx/GetTipoAsignacion_Grid", //PageMethod
                           data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                           "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                           "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                           "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                           "','filtro':'" + filtro + "'}", //PageMethod Parametros de entrada           
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
                     id: "idasignacion"
                 },
                 colModel: [
                                 {
                                     index: 'idasignacion', width: 50, align: 'Center', name: 'idTipoAsignacion'
                                 },
                                 {
                                     index: 'etiqueta', width: 100, align: 'Center', name: 'Tipo_Asignacion'
                                 },
                                 {
                                     index: 'descrip_tipo_asig', width: 300, align: 'Center', name: 'Descripcion'
                                 },
                                 {
                                     index: 'cactivo', width: 50, align: 'Center', name: 'Estatus'
                                 },
                                 {
                                     index: 'fec_cre', width: 50, align: 'Center', name: 'FecCre'
                                 },
                                 {
                                     index: 'idusu', width: 50, align: 'Center', name: 'UsuCre'
                                 }],
                 pager: "#pager", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input contAccion text format.
                 rowNum: "20", // PageSize.
                 rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "idasignacion", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1800",
                 height: "800",
                 caption: "CATALOGO DE TIPO DE ASIGNACION"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaTipoAsignacion",
                            id: "alta_tasignacion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAsignacion = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionTipoAsignacion(objTipoAsignacion, 0);

                            },
                            position: "last",
                            title: "AltaTipoAsig",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditTipoAsignacion",
                            id: "edit_tasignacion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAsignacion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAsignacion.idTipoAsignacion) {
                                    GestionTipoAsignacion(objTipoAsignacion, 1);
                                }
                                else {
                                    alert("Selecciona un Tipo de Asignación...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "DesactivarTipoAsignacion",
                            id: "desactivar_tipo_asignacion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAsignacion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAsignacion.idTipoAsignacion) {
                                    if (objTipoAsignacion.Estatus == 1) {
                                        GestionTipoAsignacion(objTipoAsignacion, 2);
                                    }
                                    else {
                                        alert('El Tipo de Asignación está desactivado');
                                    }
                                }
                                else {
                                    alert("Selecciona un Tipo de Asignación...");
                                }
                            },
                            position: "last",
                            title: "DesTipAsig",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "ActivarTipoAsignacion",
                            id: "activar_tipo_asignacion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAsignacion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAsignacion.idTipoAsignacion) {
                                    if (objTipoAsignacion.Estatus == 0) {
                                        GestionTipoAsignacion(objTipoAsignacion, 3);
                                    }
                                    else {
                                        alert('El Tipo de Asignacion esta activado');
                                    }
                                }
                                else {
                                    alert("Selecciona un Tipo de Asignacion...");
                                }

                            },
                            position: "last",
                            title: "ActTipAsig",
                            cursor: "pointer"
                        });

        }



        function ObtenerFiltro() {


            var nom_tipo_asig = $('#txttipo_asignacion_q').val();
            if (nom_tipo_asig.length <= 0 || nom_tipo_asig.length > 30) {
                nom_tipo_asig = "NULL";
            }

            var filtro = nom_tipo_asig.toString();
            return filtro;
        }


        function Buscar_TipoAsignacion(idusu) {
            MostrarTipoAsignacion(idusu, ObtenerFiltro());
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




            $(".buscar_tipo_asignacion").click(function () {
                Buscar_TipoAsignacion(idusu);
            });

            $(".alta_tipo_asignacion").click(function () {
                GestionTipoAsignacion(0, 0);
            });

            $("#bodegadatos").data("idusu", idusu);

            $(".posicion_boton_cancelar_tipo_asignacion").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_tipo_asignacion").click(function (e) {
                EjecutarAccionTipoAsignacion();
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function RegistrarTipoAsignacionBD(objTipoAsignacion) {

            var stringData = JSON.stringify(objTipoAsignacion);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceTipoAsignacion.asmx/GuardarTipoAsignacion",
                data: "{objTipoAsig:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function EjecutarAccionTipoAsignacion() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



            var usu_cre_tipo_asignacion = idusu;

            var accion = parseInt($("#lblaccion_tasignacion").html());
            var objTipoAsignacion = {
                "idasignacion": 0,
                "etiqueta": '',
                "descrip_tipo_asig": '',
                "usu_cre": idusu,
                "fec_cre": hoy,
                "cactivo": 0,
                "accion": accion
            }


            if (accion == 0) { /*Registrar Accion*/
                objTipoAsignacion.cactivo = 1;
                objTipoAsignacion.idasignacion = 1;
                objTipoAsignacion.etiqueta = $("#txtetiqueta_tasignacion").val();
                objTipoAsignacion.descrip_tipo_asig = $("#txtdescripcion_tasignacion").val();

                RegistrarTipoAsignacionBD(objTipoAsignacion)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de asignacion ' + arr[1] + ' ha sido creado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);

                     alert("No fue posible guardar el tipo de asignacion creada");
                 })
            }
            if (accion == 1) {
                objTipoAsignacion.cactivo = 1;
                objTipoAsignacion.idasignacion = parseInt($("#lbl_idtasignacion").html());
                objTipoAsignacion.etiqueta = $("#txtetiqueta_tasignacion").val();
                objTipoAsignacion.descrip_tipo_asig = $("#txtdescripcion_tasignacion").val();


                RegistrarTipoAsignacionBD(objTipoAsignacion)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de asignacion con IdTipoAsignacion:' + arr[1] + ' ha sido modificado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible editar los cambios el Tipo de Asignación");
                 })

            }

            if (accion == 2) {
                objTipoAsignacion.cactivo = 0;
                objTipoAsignacion.idasignacion = parseInt($("#lbl_idtasignacion").html());
                objTipoAsignacion.etiqueta = $("#txtetiqueta_tasignacion").val();
                var resp = confirm('¿Desea desactivar el Tipo de Asignación: ' + objTipoAsignacion.etiqueta + '?');
                if (resp) {
                    RegistrarTipoAsignacionBD(objTipoAsignacion)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Asignación con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible desactivar el Tipo de Asignación solicitada");
                     })
                }

            }

            if (accion == 3) {
                objTipoAsignacion.cactivo = 1;
                objTipoAsignacion.idasignacion = parseInt($("#lbl_idtasignacion").html());
                objTipoAsignacion.etiqueta = $("#txtetiqueta_tasignacion").val();
                var resp = confirm('¿Desea activar el Tipo de Asignación: ' + objTipoAsignacion.etiqueta + '?');
                if (resp) {
                    RegistrarTipoAsignacionBD(objTipoAsignacion)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Asignacion con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el Tipo de Asignación solicitada");
                     })
                }

            }




        }

        function GestionTipoAsignacion(objTipoAsignacion, accion) {

            if (accion == 0) {  /*Alta de Accion*/
                $("#lbl_idtasignacion").html('0');
                $("#lblaccion_tasignacion").html(accion);
                $("#txtetiqueta_tasignacion").val('');
                $("#txtdescripcion_tasignacion").val('');

            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    $("#lbl_idtasignacion").html(objTipoAsignacion.idTipoAsignacion);
                    $("#lblaccion_tasignacion").html(accion);
                    $("#txtetiqueta_tasignacion").val(objTipoAsignacion.Tipo_Asignacion);
                    $("#txtdescripcion_tasignacion").val(objTipoAsignacion.Descripcion);

                    if (accion == 2 || accion == 3) {
                        $("#txtetiqueta_tasignacion").prop('disabled', true);
                        $("#txtdescripcion_tasignacion").prop('disabled', true);
                    }
                    else {
                        $("#txtetiqueta_tasignacion").prop('disabled', false);
                        $("#txtdescripcion_tasignacion").prop('disabled', false);
                    }

                }
            }
            MostrarModalTipoAsignacion();
        }

        function ConsultaDatosAccion(idAccion) {
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceAccion.asmx/GetAccion",
                data: "{idAccion:" + idAccion + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }


        function MostrarModalTipoAsignacion() {
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
            $("#dialogo_tasig").css('top', winH / 2 - $("#dialogo_tasig").height() / 2);
            $("#dialogo_tasig").css('left', winW / 2 - $("#dialogo_tasig").width() / 2);

            //transition effect
            $("#dialogo_tasig").fadeIn(2000);
        };



</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <label>Tipo de Asignacion:</label><input type="text" name="tipo_asignacion" id="txttipo_asignacion_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_tipo_asignacion"><== Buscar Tipo de Asignacion ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_tipo_asignacion"><== Alta Tipo Asignacion ==></a><br/><br/>        
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
    <div id="dialogo_tasig" class="window"> 
       <div id="tituloTipoAsignacion"> 
         <p style="text-align:center">GESTION DE TIPO DE ASIGNACION DE CONTRATO</p>
         idTipoAsignacion: <label for="id_tipo_asignacion" id="lbl_idtasignacion"></label><br/>         
         accion:<label for="accion_tasignacion" id="lblaccion_tasignacion"></label><br/>
       </div>
       <div class="datos" id="bodyAccion">                  
          <label for="name" id="lbletiqueta_tasignacion">*Nombre de Tipo de Asignación:</label><input type="text" name="Etiqueta Tipo de Asignación" id="txtetiqueta_tasignacion" size="60"/><br/><br/>          
          <label for="name" id="lbldescripcion_tasignacion">*Descripción del Tipo de Asignación:</label><input type="text" name="Descripcion del Tipo de Asignación" id="txtdescripcion_tasignacion" size="120"/><br/><br/>          
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_tipo_asignacion">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_tipo_asignacion">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>



