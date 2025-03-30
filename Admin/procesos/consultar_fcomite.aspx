<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_fcomite.aspx.vb"
    Inherits="Admin_procesos_fcomite" %>
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



            function MostrarFormatoComite(idusu, filtro) {


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
                                    url: "../../WebServices/WebServiceFormatoComite.asmx/GetFormatoComite_Grid", //PageMethod
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
                            id: "IdFormatoComite"
                        },
                        colModel: [
                            {
                                index: 'idformato_comite', width: 50, align: 'Center', name: 'idFormatoComite'
                            },
                            {
                                index: 'etiqueta_formato_comite', width: 100, align: 'Center', name: 'Formato_Comite'
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
                        sortname: "idfcomite", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1800",
                        height: "800",
                        caption: "CATALOGO DE FORMATO DE COMITES"

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaFormatoComite",
                            id: "alta_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objFormatoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionFormatoComite(objFormatoComite, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditFormatoComite",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objFormatoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objFormatoComite.idFormatoComite)) {
                                    GestionFormatoComite(objFormatoComite, 1);
                                }
                                else {
                                    alert("Selecciona un Formato de Comité...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "DesactivarFormatoComite",
                            id: "desactivar_Formato_comite",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objFormatoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objFormatoComite.idFormatoComite)) {
                                    if (parseInt(objFormatoComite.Estatus) == 1) {
                                        GestionFormatoComite(objFormatoComite, 2);
                                    }
                                    else {
                                        alert('El Formato de Comité esta desactivado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Formato de Comité...");
                                }


                            },
                            position: "last",
                            title: "DescactFormatoComite",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "ActivarFormatoComite",
                            id: "activar_comite",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objFormatoComite = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objFormatoComite.idFormatoComite)) {
                                    if (parseInt(objFormatoComite.Estatus) == 0) {
                                        GestionFormatoComite(objFormatoComite, 3);
                                    }
                                    else {
                                        alert('El Formato de Comite Técnico esta activado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Formato de Comité Técnico...");
                                }


                            },
                            position: "last",
                            title: "ActFormatoComite",
                            cursor: "pointer"
                        });

            }



            function ObtenerFiltro() {


                var nom_formato_comite = $('#txtformato_comite_q').val();
                if (nom_formato_comite.length <= 0 || nom_formato_comite.length > 30) {
                    nom_formato_comite = "NULL";
                }

                var filtro = nom_formato_comite.toString();
                return filtro;
            }


            function Buscar_FormatoComite(idusu) {
                MostrarFormatoComite(idusu, ObtenerFiltro());
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




                $(".buscar_formato_comite").click(function () {
                    Buscar_FormatoComite(idusu);
                });

                $(".alta_formato_comite").click(function () {
                    GestionFormatoComite(0, 0);
                });

                $("#bodegadatos").data("idusu", idusu);

                $(".posicion_boton_cancelar_formato_comite").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_formato_comite").click(function (e) {
                    EjecutarAccionFormatoComite();
                });


                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });

            function RegistrarFormatoComiteBD(objFormatoComite) {

                var stringData = JSON.stringify(objFormatoComite);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceFormatoComite.asmx/GuardarFormatoComite",
                    data: "{objFormatoComite:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionFormatoComite() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                var usu_cre_Formato_comite = idusu

                var accion = parseInt($("#lblaccion_formatocomite").html());
                var objFormatoComite = {
                    "idfcomite": 0,
                    "etiqueta_formato_comite": '',
                    "descrip": '',
                    "usu_cre": idusu,
                    "fec_cre": hoy,
                    "usu_mod": idusu,
                    "fec_mod": hoy,
                    "cestatus": 0,
                    "accion": accion
                }


                if (accion == 0) { /*Registrar Accion*/
                    objFormatoComite.cestatus = 1;
                    objFormatoComite.etiqueta_formato_comite = $("#txtetiqueta_formato_comite").val();
                    objFormatoComite.descrip = $("#txtdescripcion_formato_comite").val();

                    RegistrarFormatoComiteBD(objFormatoComite)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('El Formato de comité ' + arr[1] + ' ha sido creado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);

                            alert("No fue posible guardar el formato de comité creada");
                        })
                }
                if (accion == 1) {
                    objFormatoComite.cestatus = 1;
                    objFormatoComite.idFormato_comite = parseInt($("#lbl_idformatocomite").html());
                    objFormatoComite.etiqueta_Formato_comite = $("#txtetiqueta_formato_comite").val();
                    objFormatoComite.descrip = $("#txtdescripcion_formato_comite").val();


                    RegistrarFormatoComiteBD(objFormatoComite)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('El Formato de comité con IdFormatoComité:' + arr[1] + ' ha sido modificado satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);
                            alert("No fue posible editar los cambios el Formato de Comité");
                        })

                }

                if (accion == 2) {
                    objFormatoComite.cestatus = 0;
                    objFormatoComite.idformato_comite = parseInt($("#lbl_idformatocomite").html());
                    objFormatoComite.etiqueta_formato_comite = $("#txtetiqueta_formato_comite").val();
                    var resp = confirm('¿Desea desactivar el Formato de Comité: ' + objFormatoComite.etiqueta_formato_comite + '?');
                    if (resp) {
                        RegistrarFormatoComiteBD(objFormatoComite)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Formato de Comité con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar el Formato de Comité solicitada");
                            })
                    }

                }

                if (accion == 3) {
                    objFormatoComite.cestatus = 1;
                    objFormatoComite.idformato_comite = parseInt($("#lbl_idformatocomite").html());
                    objFormatoComite.etiqueta_formato_comite = $("#txtetiqueta_formato_comite").val();
                    var resp = confirm('¿Desea activar el Formato de Comité: ' + objFormatoComite.etiqueta_formato_comite + '?');
                    if (resp) {
                        RegistrarFormatoComiteBD(objFormatoComite)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Formato de Comité con id: ' + arr[1] + ' ha sido activada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar el Formato de Comité solicitado");
                            })
                    }

                }




            }

            function GestionFormatoComite(objFormatoComite, accion) {

                if (accion == 0) {  /*Alta de Accion*/
                    $("#lbl_idformatocomite").html('0');
                    $("#lblaccion_formatocomite").html(accion);
                    $("#txtetiqueta_formato_comite").val('');
                    $("#txtdescripcion_formato_comite").val('');

                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        $("#lbl_idformatocomite").html(objFormatoComite.idFormatoComite);
                        $("#lblaccion_formatocomite").html(accion);
                        $("#txtetiqueta_formato_comite").val(objFormatoComite.Formato_Comite);
                        $("#txtdescripcion_formato_comite").val(objFormatoComite.Descripcion);

                        if (accion == 2 || accion == 3) {
                            $("#txtetiqueta_formato_comite").prop('disabled', true);
                            $("#txtdescripcion_formato_comite").prop('disabled', true);
                        }
                        else {
                            $("#txtetiqueta_formato_comite").prop('disabled', false);
                            $("#txtdescripcion_formato_comite").prop('disabled', false);
                        }

                    }
                }
                MostrarModalFormatoComite();
            }



            function MostrarModalFormatoComite() {
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
                $("#dialogo_fcomite").css('top', winH / 2 - $("#dialogo_fcomite").height() / 2);
                $("#dialogo_fcomite").css('left', winW / 2 - $("#dialogo_fcomite").width() / 2);

                //transition effect
                $("#dialogo_fcomite").fadeIn(2000);
            };



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Formato de Comité Técnico: </label><input type="text" name="Formato_comite" id="txtformato_comite_q"
            style="width:250px" maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
            class="buscar_formato_comite">
            <== Buscar Formato de Comité==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_formato_comite">
            <== Alta Formato Comité==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>

        <div id="boxes">
            <div id="dialogo_fcomite" class="window">
                <div id="titulo_fcomite">
                    <p style="text-align:center">GESTION DE FORMATO DE COMITES TECNICOS</p>
                    idFormatoComite: <label for="id_formato_comite" id="lbl_idformatocomite"></label><br />
                    accion:<label for="accion_formatocomite" id="lblaccion_formatocomite"></label><br />
                </div>
                <div class="datos" id="bodyAccion">
                    <label for="name" id="lbletiqueta_comite">*Nombre de Formato de Comité:</label><input type="text"
                        name="Etiqueta Formato de Comité" id="txtetiqueta_formato_comite" size="60" /><br /><br />
                    <label for="name" id="lbldescripcion_comite">*Descripción del Formato de Comité:</label><input
                        type="text" name="Descripcion del Formato de Comité:" id="txtdescripcion_formato_comite"
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