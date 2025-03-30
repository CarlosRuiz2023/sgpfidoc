<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="consultar_tarea.aspx.vb" Inherits="Admin_procesos_consultar_tarea" Culture="Auto" UICulture="Auto" %>



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



            function MostrarTareas(idusu, filtro) {


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
                                    url: "../../WebServices/WebServiceTarea.asmx/GetTareas_Grid", //PageMethod
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
                            id: "ctareaid"
                        },
                        colModel: [
                            {
                                index: 'idtarea', width: 50, align: 'Center', name: 'idtarea'
                            },
                            {
                                index: 'sp', width: 100, align: 'Center', name: 'Proc. Almac.'
                            },
                            {
                                index: 'descrip_tarea', width: 300, align: 'Center', name: 'Descrip. Tarea'
                            },
                            {
                                index: 'etiqueta_tarea', width: 200, align: 'Center', name: 'Tarea'
                            },
                            {
                                index: 'limite_autorizacion', width: 50, align: 'Center', name: 'Limite Autor.'
                            },
                            {
                                index: 'fec_cre_tarea', width: 100, align: 'Center', name: 'FecCre_Tarea'
                            },
                            {
                                index: 'cactivo', width: 50, align: 'Center', name: 'Estatus'
                            }],
                        pager: "#pager", //Pager.                 
                        loadtext: 'Cargando datos...',
                        recordtext: "{0} - {1} de {2} elementos",
                        emptyrecords: 'No hay resultados',
                        pgtext: 'Pág:{0} de {1}', //Paging input conttarea text format.
                        rowNum: "20", // PageSize.
                        rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                        viewrecords: true, //Show the RecordCount in the pager.
                        multiselect: false,
                        sortname: "idtarea", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1000",
                        height: "800",
                        caption: "CATALOGO DE TAREAS"

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaTarea",
                            id: "alta_tarea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTarea = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionTarea(objTarea, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditTarea",
                            id: "edit_tarea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTarea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTarea.idtarea) {
                                    GestionTarea(objTarea, 1);

                                }
                                else {
                                    alert("Selecciona una Tarea...");
                                }
                            },
                            position: "last",
                            title: "EditaTarea",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "DesactivarTarea",
                            id: "desactivar_tarea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTarea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTarea.idtarea) {
                                    if (objTarea.Estatus == 1) {
                                        GestionTarea(objTarea, 2);
                                    }
                                    else {
                                        alert('La TAREA se encuentra desactivada');
                                    }

                                }
                                else {
                                    alert("Selecciona una TAREA...");
                                }


                            },
                            position: "last",
                            title: "DesactTarea",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "ActivarTarea",
                            id: "activar_tarea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTarea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTarea.idtarea) {
                                    if (objTarea.Estatus == 0) {
                                        GestionTarea(objTarea, 3);
                                    }
                                    else {
                                        alert('La TAREA se encuentra activada.');
                                    }

                                }
                                else {
                                    alert("Selecciona una TAREA...");
                                }


                            },
                            position: "last",
                            title: "ActivarTarea",
                            cursor: "pointer"
                        });


            }



            function ObtenerFiltro() {


                var nom_tarea = $('#txtnomtarea_q').val();
                if (nom_tarea.length <= 0 || nom_tarea.length > 30) {
                    nom_tarea = "NULL";
                }

                var filtro = nom_tarea.toString();
                return filtro;
            }


            function Buscar_Tareas(idusu) {
                MostrarTareas(idusu, ObtenerFiltro());
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




                $(".buscar_tarea").click(function () {
                    Buscar_Tareas(idusu);
                });

                $(".alta_tarea").click(function () {
                    GestionTarea(0, 0);
                });



                $("#bodegadatos").data("idusu", idusu);





                $(".posicion_boton_cancelar_tarea").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_tarea").click(function (e) {
                    EjecutarAccionTarea();
                });


                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });

            function RegistrarTareaBD(objtarea) {

                var stringData = JSON.stringify(objtarea);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceTarea.asmx/GuardarTarea",
                    data: "{objTarea:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionTarea() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

                var descrip_tarea = $("#txttareadescrip").val();
                var nom_tarea = $("#txttareanombre").val();
                var lim_tarea = $("#txtlimtarea").val();
                var idtarea = $("#lblidtarea").html();
                var sp = $("#txtsp").val();
                var estatus_tarea;

                var accion = parseInt($("#lblacciontarea").html());

                var objtarea = {
                    "idtarea": idtarea,
                    "sp": sp,
                    "descrip_tarea": descrip_tarea,
                    "etiqueta_tarea": nom_tarea,
                    "limite_autorizacion": lim_tarea,
                    "cactivo": estatus_tarea,
                    "fec_cre_tarea": hoy,
                    "accion": accion
                }


                if (accion == 0) { /*Registrar tarea*/
                    objtarea.cactivo = 1;
                    RegistrarTareaBD(objtarea)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('La TAREA ' + arr[1] + ' ha sido creada satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);

                            alert("No fue posible guardar la TAREA creada");
                        })
                }
                if (accion == 1) {
                    objtarea.ctareaestatus = 1;
                    RegistrarTareaBD(objtarea)
                        .done(function (r) {
                            var cadena = r.d;
                            if (cadena != '<NewDataSet />') {
                                var arr = cadena.split(':');
                                alert('La TAREA con Idtarea:' + arr[1] + ' ha sido modificada satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        })
                        .fail(function (xhr) {
                            console.log(xhr.responseText);
                            alert("No fue posible editar los cambios en la TAREA");
                        })

                }

                if (accion == 2) {
                    objtarea.ctareaestatus = 0;

                    var resp = confirm('¿Desea desactivar la TAREA: ' + objtarea.etiqueta_tarea + '?');
                    if (resp) {
                        RegistrarTareaBD(objtarea)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('La TAREA con Idtarea: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar la TAREA solicitado");
                            })
                    }

                }

                if (accion == 3) {
                    objtarea.ctareaestatus = 1;
                    var resp = confirm('¿Desea activar la TAREA: ' + objtarea.etiqueta_tarea + '?');
                    if (resp) {
                        RegistrarTareaBD(objtarea)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('La TAREA con Idtarea: ' + arr[1] + ' ha sido activado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar la TAREA solicitada");
                            })
                    }

                }




            }

            function GestionTarea(objTarea, accion) {

                if (accion == 0) {  /*Alta de tarea*/
                    $("#txttareanombre").val('');
                    $("#txttareadescrip").val('');
                    $("#txtlimtarea").val('');
                    $("#txtsp").val('');
                    $("#lblidtarea").html('0');
                    $("#lblacciontarea").html(accion);
                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        var idtarea = parseInt(objTarea.idtarea);
                        ConsultaDatosTarea(idtarea)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    $(cadena).find("tarea").each(function () {
                                        $("#lblidtarea").html($(this).find("idtarear").text());
                                        $("#lblacciontarea").html(accion);
                                        $("#txtsp").val($(this).find("spr").text());
                                        $("#txttareanombre").val($(this).find("etiqueta_tarear").text());
                                        $("#txtlimtarea").val($(this).find("limite_autorizacionr").text());
                                        $("#txttareadescrip").val($(this).find("descrip_tarear").text());
                                    });
                                }
                                if (accion == 2 || accion == 3) {
                                    $("#txttareanombre").prop('disabled', true);
                                    $("#txttareadescrip").prop('disabled', true);
                                    $("#txtlimtarea").prop('disabled', true);
                                    $("#txtsp").prop('disabled', true);
                                }
                                else {
                                    $("#txttareanombre").prop('disabled', false);;
                                    $("#txttareadescrip").prop('disabled', false);
                                    $("#txtlimtarea").prop('disabled', false);
                                    $("#txtsp").prop('disabled', false);

                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible consultar los dato del tarea solicitado");
                            });
                    }
                }

                MostrarModaltarea();

            }

            function ConsultaDatosTarea(idtarea) {
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceTarea.asmx/GetTarea",
                    data: "{idTarea:" + idtarea + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });
            }


            function MostrarModaltarea() {
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
                $("#dialogotarea").css('top', winH / 2 - $("#dialogotarea").height() / 2);
                $("#dialogotarea").css('left', winW / 2 - $("#dialogotarea").width() / 2);

                //transition effect
                $("#dialogotarea").fadeIn(2000);
            };



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Nombre de la Tarea:</label><input type="text" name="nomtarea_q" id="txtnomtarea_q" style="width:250px"
            maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_tarea">
            <== Buscar Tarea==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_tarea">
            <== Alta Tarea==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>


        <div id="boxes">
            <div id="dialogotarea" class="window">
                <div id="titulotarea">
                    <p style="text-align:center">GESTION DE TAREAS</p>
                    idtarea: <label for="idtarea" id="lblidtarea"></label><br />
                    Acción:<label for="accion" id="lblacciontarea"></label><br />
                </div>
                <div class="datos" id="bodytarea">
                    <label for="name" id="lbltareanombre">*Nombre de tarea:</label><input type="text" name="tareanombre"
                        id="txttareanombre" size="80" /><br /><br />
                    <label for="name" id="lbltareadescrip">*Descripción del tarea::</label><input type="text"
                        name="descriptarea" id="txttareadescrip" size="80" /><br /><br />
                    <label for="name" id="lblprocedalmac">Nombre de Precedimiento Almacenado:</label><input type="text"
                        name="procedalmac" id="txtsp" size="80" /><br /><br />
                    <label for="name" id="lbllimautor">*Limite de Autorizacion:</label><input type="text"
                        name="limtarea" id="txtlimtarea" size="80" /><br /><br />


                </div>
                <div class="botonesA" id="botonesC">
                    <p style="text-align:right"><a href="#"
                            class="posicion_boton_accion_tarea">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                            class="posicion_boton_cancelar_tarea">Cancelar</a></p>
                </div>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>