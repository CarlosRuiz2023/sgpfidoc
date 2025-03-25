<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_estatus_asamblea.aspx.vb" Inherits="Admin_procesos_consultar_estatus_asamblea" %>


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



        function MostrarEstatusAsamblea(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceEstatusAsamblea.asmx/GetEstatusAsamblea_Grid", //PageMethod
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
                     id: "IdUsuario"
                 },
                 colModel: [
                                 {
                                     index: 'idestatus_asamblea', width: 50, align: 'Center', name: 'idestatus_asamblea'
                                 },
                                 {
                                     index: 'etiqueta_estatus_asamblea', width: 100, align: 'Center', name: 'Etiqueta'
                                 },                                 
                                 {
                                     index: 'cactivo', width: 50, align: 'Center', name: 'Activo'
                                 },
                                 {
                                     index: 'fec_cre', width: 50, align: 'Center', name: 'Fecha_Crea'
                                 },
                                 {
                                     index: 'usu_cre', width: 50, align: 'Center', name: 'Usuario'
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
                 sortname: "idestatus_asamblea", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1000",
                 height: "800",
                 caption: "CATALOGO DE ESTATUS DE ASAMBLEA"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaEstAsamb",
                            id: "alta_estatus_asamblea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objEstatusAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionEstatusAsamblea(objEstatusAsamblea, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditEstAsam",
                            id: "edit_estatus_asamblea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objEstatusAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objEstatusAsamblea.idestatus_asamblea) {
                                    GestionEstatusAsamblea(objEstatusAsamblea, 1);

                                }
                                else {
                                    alert("Selecciona un Estatus de Asamblea...");
                                }
                            },
                            position: "last",
                            title: "EstAsam",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "DesactivarAccion",
                            id: "desactivar_Accion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objEstatusAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objEstatusAsamblea.idestatus_asamblea) {
                                    if (objEstatusAsamblea.Activo == 1) {
                                        GestionEstatusAsamblea(objEstatusAsamblea, 2);
                                    }
                                    else {
                                        alert('El estatus de asamblea esta desactivada');
                                    }

                                }
                                else {
                                    alert("Selecciona un estatus de asamblea...");
                                }


                            },
                            position: "last",
                            title: "ActEstAsam",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "ActivarAccion",
                            id: "activar_Accion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objEstatusAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objEstatusAsamblea.idestatus_asamblea) {
                                    if (objEstatusAsamblea.Activo == 0) {
                                        GestionEstatusAsamblea(objEstatusAsamblea, 3);
                                    }
                                    else {
                                        alert('El estatus de asamblea se encuentra activada.');
                                    }

                                }
                                else {
                                    alert("Selecciona un estatus de asamblea...");
                                }


                            },
                            position: "last",
                            title: "DesactEstAsam",
                            cursor: "pointer"
                        });

        }



        function ObtenerFiltro() {


            var etiqueta_estatus_asamblea = $('#txtnomEstatusAsamblea_q').val();
            if (etiqueta_estatus_asamblea.length <= 0 || etiqueta_estatus_asamblea.length > 30) {
                etiqueta_estatus_asamblea = "NULL";
            }

            var filtro = etiqueta_estatus_asamblea.toString();
            return filtro;
        }


        function Buscar_Estatus_Asamblea(idusu) {
            MostrarEstatusAsamblea(idusu, ObtenerFiltro());
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




            $(".buscar_estatus_asamblea").click(function () {
                Buscar_Estatus_Asamblea(idusu);
            });

            $(".alta_estatus_asamblea").click(function () {
                GestionEstatusAsamblea(0, 0);
            });

            $("#bodegadatos").data("idusu", idusu);

            $(".posicion_boton_cancelar_estatus_asamblea").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_estatus_asamblea_accion").click(function (e) {                
                EjecutarEstatusAsamblea();
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function RegistrarAccionBD(objEstatusAsamblea) {

            var stringData = JSON.stringify(objEstatusAsamblea);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceEstatusAsamblea.asmx/GuardarEstatusAsamblea",
                data: "{objEstatusAsamblea:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function EjecutarEstatusAsamblea() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];
            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
            var accion = parseInt($("#lblaccion_estatus_asamblea").html());

            var objEstatusAsamblea = {
                "idestatus_asamblea": parseInt($("#lblid_estatus_asamblea").html()),
                "etiqueta_estatus_asamblea": '',
                "cactivo": 0,
                "fec_cre": hoy,
                "usu_cre": parseInt(idusu),
                "accion": accion
            }


            if (accion == 0) { /*Registrar Accion*/
                objEstatusAsamblea.cactivo = 1;
                objEstatusAsamblea.etiqueta_estatus_asamblea = $("#txtetiqueta_estatus_asamblea").val();
                RegistrarAccionBD(objEstatusAsamblea)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El estatus de asamblea ' + arr[1] + ' ha sido creado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible guardar el estatus de asamblea ");
                 })
            }
            if (accion == 1) {
                objEstatusAsamblea.etiqueta_estatus_asamblea = $("#txtetiqueta_estatus_asamblea").val();
                RegistrarAccionBD(objEstatusAsamblea)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El estatus de asamblea con idTipoAsamblea:' + arr[1] + ' ha sido modificado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible editar los cambios en el estatus de asamblea");
                 })

            }

            if (accion == 2) {
                objEstatusAsamblea.cactivo = 0;

                var resp = confirm('¿Desea desactivar el Estatus de Asamblea: ' + objEstatusAsamblea.etiqueta_estatus_asamblea + '?');
                if (resp) {
                    RegistrarAccionBD(objEstatusAsamblea)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El estatus de asamblea con IdEstatusAsamblea: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible desactivar el Estatus de Asamblea solicitada");
                     })
                }

            }

            if (accion == 3) {
                objEstatusAsamblea.cactivo = 1;
                var resp = confirm('¿Desea activar el Estatus de Asamblea: ' + objEstatusAsamblea.etiqueta_estatus_asamblea + '?');
                if (resp) {
                    RegistrarAccionBD(objEstatusAsamblea)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('La estatus de asamblea con IdEstatusAsamblea: ' + arr[1] + ' ha sido activada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el Estatus de Asamblea solicitada");
                     })
                }

            }




        }

        function GestionEstatusAsamblea(objEstatusAsamblea, accion) {

            if (accion == 0) {  /*Alta de Accion*/
                $("#txtetiqueta_estatus_asamblea").val('');
                $("#lblid_estatus_asamblea").html('0');
                $("#lblaccion_estatus_asamblea").html(accion);
            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    $("#lblid_estatus_asamblea").html(objEstatusAsamblea.idestatus_asamblea);
                    $("#lblaccion_estatus_asamblea").html(accion);
                    $("#txtetiqueta_estatus_asamblea").val(objEstatusAsamblea.Etiqueta);

                    if (accion == 2 || accion == 3) {
                        $("#txtetiqueta_estatus_asamblea").prop('disabled', true);                       
                    }
                    else {
                        $("#txtetiqueta_estatus_asamblea").prop('disabled', false);
                       
                    }

                }
            }

            MostrarModalEstatusAsamblea();

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


        function MostrarModalEstatusAsamblea() {
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
            $("#dialogo_EstatusAsamblea").css('top', winH / 2 - $("#dialogo_EstatusAsamblea").height() / 2);
            $("#dialogo_EstatusAsamblea").css('left', winW / 2 - $("#dialogo_EstatusAsamblea").width() / 2);

            //transition effect
            $("#dialogo_EstatusAsamblea").fadeIn(2000);
        };



</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <label>Nombre del Estatus de Asamblea:</label><input type="text" name="nomEstatusAsamblea_q" id="txtnomEstatusAsamblea_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_estatus_asamblea"><== Buscar Estatus Asamblea ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_estatus_asamblea"><== Alta Estatus Asamblea ==></a><br/><br/>        
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
    <div id="dialogo_EstatusAsamblea" class="window"> 
       <div id="titulo_EstatusAsamblea"> 
         <p style="text-align:center">GESTION DE ESTATUS DE ASAMBLEA</p>
         idEstatusAsamblea: <label for="idEstatusAsamblea" id="lblid_estatus_asamblea"></label><br/>         
         Accion:<label for="accion" id="lblaccion_estatus_asamblea"></label><br/>
       </div>
       <div class="datos" id="bodyEstatusAsamblea">                  
          <label for="name" id="lbletiqueta_estatus_asamblea">*Nombre de Estatus de Asamblea:</label><input type="text" name="EtiquetaEstatusAsamblea" id="txtetiqueta_estatus_asamblea" size="80"/><br/><br/>          
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_estatus_asamblea_accion">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_estatus_asamblea">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>



