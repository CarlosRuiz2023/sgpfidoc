<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_accion.aspx.vb"
    Inherits="Admin_procesos_consultar_accion" %>


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
                    if (IsNumeric(dia) == false) { fecha = ""; }
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



            function MostrarAcciones(idusu, filtro) {


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
                                    url: "../../WebServices/WebServiceAccion.asmx/GetAcciones_Grid", //PageMethod
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
                                index: 'idaccion', width: 50, align: 'Center', name: 'idAccion'
                            },
                            {
                                index: 'etiqueta_accion', width: 100, align: 'Center', name: 'Acción'
                            },
                            {
                                index: 'fec_alta_accion', width: 100, align: 'Center', name: 'FecCreAcc'
                            },
                            {
                                index: 'cactivo', width: 50, align: 'Center', name: 'Estatus'
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
                        sortname: "idaccion", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1000",
                        height: "800",
                        caption: "CATALOGO DE ACCIONES"

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaAccion",
                            id: "alta_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objAccion = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionAccion(objAccion, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditAccion",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objAccion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objAccion.idAccion) {
                                    GestionAccion(objAccion, 1);

                                }
                                else {
                                    alert("Selecciona una accion...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
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
                                var objAccion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objAccion.idAccion) {
                                    if (objAccion.Estatus == 1) {
                                        GestionAccion(objAccion, 2);
                                    }
                                    else {
                                        alert('La ACCION esta desactivada');
                                    }

                                }
                                else {
                                    alert("Selecciona una ACCION...");
                                }


                            },
                            position: "last",
                            title: "DctoDet",
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
                                var objAccion = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objAccion.idAccion) {
                                    if (objAccion.Estatus == 0) {
                                        GestionAccion(objAccion, 3);
                                    }
                                    else {
                                        alert('La ACCION se encuentra activada.');
                                    }

                                }
                                else {
                                    alert("Selecciona una acción...");
                                }


                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        });

            }



            function ObtenerFiltro() {


                var nom_Accion = $('#txtnomAccion_q').val();
                if (nom_Accion.length <= 0 || nom_Accion.length > 30) {
                    nom_Accion = "NULL";
                }

                var filtro = nom_Accion.toString();
                return filtro;
            }


            function Buscar_Acciones(idusu) {
                MostrarAcciones(idusu, ObtenerFiltro());
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




                $(".buscar_accion").click(function () {
                    Buscar_Acciones(idusu);
                });

                $(".alta_accion").click(function () {
                    GestionAccion(0, 0);
                });

                $("#bodegadatos").data("idusu", idusu);

                $(".posicion_boton_cancelar_accion_accion").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_accion").click(function (e) {
                    EjecutarAccionAccion();
                });


                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });

            function RegistrarAccionBD(objAccion) {

                var stringData = JSON.stringify(objAccion);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceAccion.asmx/GuardarAccion",
                    data: "{objAccion:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionAccion() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());


                var nom_accion = $("#txtetiqueta_accion").val();
                var idaccion = $("#lblidaccion").html();
                var estatus_accion;
                var accion = parseInt($("#lblaccion_accion").html());
                var hoy = moment();
                var objAccion = {
                    "idaccion": idaccion,
                    "etiqueta_accion": nom_accion,
                    "fec_alta_accion": hoy,
                    "cactivo": estatus_accion,
                    "accion": accion
                }


                if (accion == 0) { /*Registrar Accion*/
                    objAccion.cactivo = 1;
                    RegistrarAccionBD(objAccion)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('La Accion ' + arr[1] + ' ha sido creado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);

                            alert("No fue posible guardar la Accion creada");
                        })
                }
                if (accion == 1) {
                    objAccion.cactivo = 1;
                    RegistrarAccionBD(objAccion)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('La Accion con IdAccion:' + arr[1] + ' ha sido modificado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);
                            alert("No fue posible editar los cambios en la Accion");
                        })

                }

                if (accion == 2) {
                    objAccion.cactivo = 0;

                    var resp = confirm('¿Desea desactivar la ACCION: ' + objAccion.etiqueta_accion + '?');
                    if (resp) {
                        RegistrarAccionBD(objAccion)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('La ACCION con IdAccion: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar la ACCION solicitada");
                            })
                    }

                }

                if (accion == 3) {
                    objAccion.cactivo = 1;
                    var resp = confirm('¿Desea activar la ACCION: ' + objAccion.etiqueta_accion + '?');
                    if (resp) {
                        RegistrarAccionBD(objAccion)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('La ACCION con IdAccion: ' + arr[1] + ' ha sido activada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar la ACCION solicitada");
                            })
                    }

                }




            }

            function GestionAccion(objAccion, accion) {

                if (accion == 0) {  /*Alta de Accion*/
                    $("#txtetiqueta_accion").val('');
                    $("#lblidaccion").html('0');
                    $("#lblaccion_accion").html(accion);
                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        var idAccion = parseInt(objAccion.idAccion);
                        ConsultaDatosAccion(idAccion)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    $(cadena).find("accion").each(function () {
                                        $("#lblidaccion").html($(this).find("idaccionr").text());
                                        $("#lblaccion_accion").html(accion);
                                        $("#txtetiqueta_accion").val($(this).find("etiqueta_accionr").text());
                                    });
                                }
                                if (accion == 2 || accion == 3) {
                                    $("#txtetiqueta_accion").prop('disabled', true);

                                }
                                else {
                                    $("#txtetiqueta_accion").prop('disabled', false);;
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible consultar los datos de la ACCION solicitada");
                            });
                    }
                }

                MostrarModalAccion();

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


            function MostrarModalAccion() {
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
                $("#dialogoAccion").css('top', winH / 2 - $("#dialogoAccion").height() / 2);
                $("#dialogoAccion").css('left', winW / 2 - $("#dialogoAccion").width() / 2);

                //transition effect
                $("#dialogoAccion").fadeIn(2000);
            };



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Nombre del Accion:</label><input type="text" name="nomAccion_q" id="txtnomAccion_q" style="width:250px"
            maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_accion">
            <== Buscar Accion==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_accion">
            <== Alta Accion==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>


        <div id="boxes">
            <div id="dialogoAccion" class="window">
                <div id="tituloAccion">
                    <p style="text-align:center">GESTION DE ACCIONES</p>
                    idAccion: <label for="idAccion" id="lblidaccion"></label><br />
                    Acción:<label for="accion" id="lblaccion_accion"></label><br />
                </div>
                <div class="datos" id="bodyAccion">
                    <label for="name" id="lblAccionnombre">*Nombre de Accion:</label><input type="text"
                        name="EtiquetaAccion" id="txtetiqueta_accion" size="80" /><br /><br />
                </div>
                <div class="botonesA" id="botonesC">
                    <p style="text-align:right"><a href="#"
                            class="posicion_boton_accion_accion">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                            class="posicion_boton_cancelar_accion_accion">Cancelar</a></p>
                </div>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>