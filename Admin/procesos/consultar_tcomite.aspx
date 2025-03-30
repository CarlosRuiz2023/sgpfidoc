<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_tcomite.aspx.vb"
    Inherits="Admin_procesos_consultar_tcomite" %>
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



            function MostrarTipoComite(idusu, filtro) {


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
                                    url: "../../WebServices/WebServiceTipoComite.asmx/GetTipoComite_Grid", //PageMethod
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
                            id: "IdTipoComite"
                        },
                        colModel: [
                            {
                                index: 'idtipo_comite', width: 50, align: 'Center', name: 'idTipoComite'
                            },
                            {
                                index: 'etiqueta_tipo_comite', width: 100, align: 'Center', name: 'Tipo_Comite'
                            },
                            {
                                index: 'descrip', width: 300, align: 'Center', name: 'Descripcion'
                            },
                            {
                                index: 'fec_cre', width: 50, align: 'Center', name: 'fec_cre'
                            },
                            {
                                index: 'fec_mod', width: 50, align: 'Center', name: 'fec_mod'
                            },
                            {
                                index: 'usu_cre', width: 50, align: 'Center', name: 'usu_cre'
                            },
                            {
                                index: 'usu_mod', width: 50, align: 'Center', name: 'usu_mod'
                            },
                            {
                                index: 'cestatus', width: 50, align: 'Center', name: 'Estatus'
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
                        sortname: "idtipo_comite", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1800",
                        height: "800",
                        caption: "CATALOGO DE TIPO DE COMITES"

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaTipoComite",
                            id: "alta_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionTipoComite(objTipoComite, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditTipoComite",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoComite.idTipoComite)) {
                                    GestionTipoComite(objTipoComite, 1);
                                }
                                else {
                                    alert("Selecciona un Tipo de Comité...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "DesactivarTipoComite",
                            id: "desactivar_tipo_comite",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoComite.idTipoComite)) {
                                    if (parseInt(objTipoComite.Estatus) == 1) {
                                        GestionTipoComite(objTipoComite, 2);
                                    }
                                    else {
                                        alert('El Tipo de Comité esta desactivado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Comité...");
                                }


                            },
                            position: "last",
                            title: "DescactTipoComite",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "ActivarTipoComite",
                            id: "activar_comite",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoComite.idTipoComite)) {
                                    if (parseInt(objTipoComite.Estatus) == 0) {
                                        GestionTipoComite(objTipoComite, 3);
                                    }
                                    else {
                                        alert('El Tipo de Comite Técnico esta activado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Comité Técnico...");
                                }


                            },
                            position: "last",
                            title: "ActTipoComite",
                            cursor: "pointer"
                        });

            }



            function ObtenerFiltro() {


                var nom_tipo_comite = $('#txttipo_comite_q').val();
                if (nom_tipo_comite.length <= 0 || nom_tipo_comite.length > 30) {
                    nom_tipo_comite = "NULL";
                }

                var filtro = nom_tipo_comite.toString();
                return filtro;
            }


            function Buscar_TipoComite(idusu) {
                MostrarTipoComite(idusu, ObtenerFiltro());
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




                $(".buscar_tipo_comite").click(function () {
                    Buscar_TipoComite(idusu);
                });

                $(".alta_tipo_comite").click(function () {
                    GestionTipoComite(0, 0);
                });

                $("#bodegadatos").data("idusu", idusu);

                $(".posicion_boton_cancelar_tipo_comite").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_tipo_comite").click(function (e) {
                    EjecutarAccionTipoComite();
                });


                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });

            function RegistrarTipoComiteBD(objTipoComite) {

                var stringData = JSON.stringify(objTipoComite);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceTipoComite.asmx/GuardarTipoComite",
                    data: "{objTipoComite:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionTipoComite() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                var usu_cre_tipo_comite = idusu

                var accion = parseInt($("#lblaccion_tipocomite").html());
                var objTipoComite = {
                    "idtipo_comite": 0,
                    "etiqueta_tipo_comite": '',
                    "descrip": '',
                    "usu_cre": idusu,
                    "fec_cre": hoy,
                    "usu_mod": idusu,
                    "fec_mod": hoy,
                    "cestatus": 0,
                    "accion": accion
                }


                if (accion == 0) { /*Registrar Accion*/
                    objTipoComite.cestatus = 1;
                    objTipoComite.etiqueta_tipo_comite = $("#txtetiqueta_tipo_comite").val();
                    objTipoComite.descrip = $("#txtdescripcion_tipo_comite").val();

                    RegistrarTipoComiteBD(objTipoComite)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('El tipo de comité ' + arr[1] + ' ha sido creado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);

                            alert("No fue posible guardar el tipo de comité creada");
                        })
                }
                if (accion == 1) {
                    objTipoComite.cestatus = 1;
                    objTipoComite.idtipo_comite = parseInt($("#lbl_idtipocomite").html());
                    objTipoComite.etiqueta_tipo_comite = $("#txtetiqueta_tipo_comite").val();
                    objTipoComite.descrip = $("#txtdescripcion_tipo_comite").val();


                    RegistrarTipoComiteBD(objTipoComite)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('El tipo de comité con IdTipoComité:' + arr[1] + ' ha sido modificado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);
                            alert("No fue posible editar los cambios el Tipo de Comité");
                        })

                }

                if (accion == 2) {
                    objTipoComite.cestatus = 0;
                    objTipoComite.idtipo_comite = parseInt($("#lbl_idtipocomite").html());
                    objTipoComite.etiqueta_tipo_comite = $("#txtetiqueta_tipo_comite").val();
                    var resp = confirm('¿Desea desactivar el Tipo de Comité: ' + objTipoComite.etiqueta_tipo_comite + '?');
                    if (resp) {
                        RegistrarTipoComiteBD(objTipoComite)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Tipo de Comité con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar el Tipo de Comité solicitada");
                            })
                    }

                }

                if (accion == 3) {
                    objTipoComite.cestatus = 1;
                    objTipoComite.idtipo_comite = parseInt($("#lbl_idtipocomite").html());
                    objTipoComite.etiqueta_tipo_comite = $("#txtetiqueta_tipo_comite").val();
                    var resp = confirm('¿Desea activar el Tipo de Comité: ' + objTipoComite.etiqueta_tipo_comite + '?');
                    if (resp) {
                        RegistrarTipoComiteBD(objTipoComite)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Tipo de Comité con id: ' + arr[1] + ' ha sido activada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar el Tipo de Comité solicitado");
                            })
                    }

                }




            }

            function GestionTipoComite(objTipoComite, accion) {

                if (accion == 0) {  /*Alta de Accion*/
                    $("#lbl_idtipocomite").html('0');
                    $("#lblaccion_tipocomite").html(accion);
                    $("#txtetiqueta_tipo_comite").val('');
                    $("#txtdescripcion_tipo_comite").val('');

                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        $("#lbl_idtipocomite").html(objTipoComite.idTipoComite);
                        $("#lblaccion_tipocomite").html(accion);
                        $("#txtetiqueta_tipo_comite").val(objTipoComite.Tipo_Comite);
                        $("#txtdescripcion_tipo_comite").val(objTipoComite.Descripcion);

                        if (accion == 2 || accion == 3) {
                            $("#txtetiqueta_tipo_comite").prop('disabled', true);
                            $("#txtdescripcion_tipo_comite").prop('disabled', true);
                        }
                        else {
                            $("#txtetiqueta_tipo_comite").prop('disabled', false);
                            $("#txtdescripcion_tipo_comite").prop('disabled', false);
                        }

                    }
                }
                MostrarModalTipoComite();
            }



            function MostrarModalTipoComite() {
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
                $("#dialogo_tcomite").css('top', winH / 2 - $("#dialogo_tcomite").height() / 2);
                $("#dialogo_tcomite").css('left', winW / 2 - $("#dialogo_tcomite").width() / 2);

                //transition effect
                $("#dialogo_tcomite").fadeIn(2000);
            };



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Tipo de Comité Técnico: </label><input type="text" name="tipo_comite" id="txttipo_comite_q"
            style="width:250px" maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
            class="buscar_tipo_comite">
            <== Buscar Tipo de Comité==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_tipo_comite">
            <== Alta Tipo Comité==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>

        <div id="boxes">
            <div id="dialogo_tcomite" class="window">
                <div id="titulo_tcomite">
                    <p style="text-align:center">GESTION DE TIPO DE COMITES TECNICOS</p>
                    idTipoComite: <label for="id_tipo_comite" id="lbl_idtipocomite"></label><br />
                    accion:<label for="accion_tipocomite" id="lblaccion_tipocomite"></label><br />
                </div>
                <div class="datos" id="bodyAccion">
                    <label for="name" id="lbletiqueta_comite">*Nombre de Tipo de Comité:</label><input type="text"
                        name="Etiqueta Tipo de Comité" id="txtetiqueta_tipo_comite" size="60" /><br /><br />
                    <label for="name" id="lbldescripcion_comite">*Descripción del Tipo de Comité:</label><input
                        type="text" name="Descripcion del Tipo de Comité:" id="txtdescripcion_tipo_comite"
                        size="120" /><br /><br />
                </div>
                <div class="botonesA" id="botonesC">
                    <p style="text-align:right"><a href="#"
                            class="posicion_boton_accion_formato_comite">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                            class="posicion_boton_cancelar_formato_comite">Cancelar</a></p>
                </div>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>