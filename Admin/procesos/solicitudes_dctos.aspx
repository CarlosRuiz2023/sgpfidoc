<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="solicitudes_dctos.aspx.vb"
    Inherits="Admin_procesos_solicitudes_dctos" %>

    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


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

                function IsNumeric(valor) {
                    var log = valor.length; var sw = "S";
                    for (x = 0; x < log; x++) {
                        v1 = valor.substr(x, 1);
                        v2 = parseInt(v1);
                        //Compruebo si es un valor numérico 
                        if (isNaN(v2)) { sw = "N"; }
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
                    if (conten == "" || conten == " ") {
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


                function ObtenerFiltro() {
                    var nomcalle = $('#txtnomcalle').val();
                    if (nomcalle.length <= 0 || nomcalle.length > 20) {
                        nomcalle = "";
                    }
                    var idsol = $('#txtidsol').val();
                    if (idsol.length <= 0 || !$.isNumeric(idsol)) {
                        idsol = "0";
                    }
                    var filtro = idsol + "," + nomcalle;
                    return filtro;
                }

                function RedibujarGrid() {
                    //    jQuery("#grid").jqGrid('setGridParam',
                    //        {
                    //          datatype: function () { ObtenerDatos(ObtenerFiltro()) }                
                    //        })
                    //.trigger("reloadGrid");
                    $("#grid").trigger("reloadGrid");
                }



                function ObtenerDatos(filtro, EstatusSolicitud, EstatusFactib, EstatusAnuencia) {
                    $.ajax(
                        {
                            url: "../../WebServices/WebServiceSolic.asmx/GetSolicitudes", //PageMethod
                            data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                "','pFiltro':'" + filtro +
                                "','pEstatusSolicitud':'" + EstatusSolicitud +
                                "','pEstatusFactib':'" + EstatusFactib +
                                "','pEstatusAnuencia':'" + EstatusAnuencia + "'}", //PageMethod Parametros de entrada
                            dataType: "json",
                            type: "post",
                            contentType: "application/json; charset=utf-8",
                            complete: function (jsondata, stat) {
                                if (stat == "success") {
                                    jQuery("#grid")[0].addJSONData(JSON.parse(jsondata.responseText).d);
                                }
                                else
                                    alert(JSON.parse(jsondata.responseText).Message);
                            }
                        });
                }






                //// FUNCION PRINCIPAL

                $(document).ready(function () {


                    /*$('#verdcto').click(function () {
                        var nom_archivo = $('#verdcto').val();
                        leerArchivo(nom_archivo);                
                    });*/

                    var lastSel;
                    var band_grid2 = 0;
                    $("#grid").jqGrid(
                        {
                            datatype: function () { ObtenerDatos(ObtenerFiltro(), "1,2,3,8", "1,2,3,4", "1,2,3,4") },
                            jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                            {
                                root: "Items",
                                page: "CurrentPage",
                                total: "PageCount",
                                records: "RecordCount",
                                repeatitems: true,
                                cell: "row",
                                id: "idsol"
                            },
                            colModel: [
                                {
                                    index: 'idsol', width: 50, align: 'Right',
                                    name: 'idsol'
                                },
                                {
                                    index: 'mSolFecha', width: 110, align: 'Center',
                                    name: 'FechaSolicitud'
                                },
                                {
                                    index: 'mSolNombre', width: 300, align: 'Center',
                                    name: 'Nom. Solicitante'
                                },
                                {
                                    index: 'mSolCalle', width: 350, align: 'center',
                                    name: 'Calle'
                                },
                                {
                                    index: 'mSolColonia', width: 300, align: 'center',
                                    name: 'Colonia'
                                },
                                {
                                    index: 'mSolTramo', width: 380, align: 'center',
                                    name: 'Tramo'
                                },
                                {
                                    index: 'cEstDescripcion', width: 100, align: 'center',
                                    name: 'Est.Solicitud'
                                },
                                {
                                    index: 'ubic', width: 50, align: 'center',
                                    name: 'Ubic.'
                                },
                                {
                                    //index: 'mSolSECFNO', width: 70, align: 'center',
                                    //name: 'CveSector'
                                    index: 'UsuCre', width: 220, align: 'center',
                                    name: 'Usu_Crea'
                                },
                                {
                                    //index: 'mSolSSCFNO', width: 70, align: 'center',
                                    //name: 'CveSubSector'
                                    index: 'FechaCre', width: 135, align: 'center',
                                    name: 'Fec_Crea'
                                },
                                {
                                    //index: 'mSolCLACNO', width: 70, align: 'center',
                                    //name: 'CveCalle'
                                    index: 'UsuModif', width: 220, align: 'center',
                                    name: 'Usu_Modif'
                                },
                                {
                                    //index: 'Calle', width: 440, align: 'center',
                                    //name: 'Calle'
                                    index: 'FechaMod', width: 135, align: 'center',
                                    name: 'Fec_Modif'
                                }
                            ],
                            pager: "#pager", //Pager.                 
                            loadtext: 'Cargando datos...',
                            recordtext: "{0} - {1} de {2} elementos",
                            emptyrecords: 'No hay resultados',
                            pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                            rowNum: "12", // PageSize.
                            rowList: [4, 8, 12], //Variable PageSize DropDownList. 
                            viewrecords: true, //Show the RecordCount in the pager.
                            multiselect: false,
                            sortname: "midsol", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1900",
                            height: "600",
                            caption: "SOLICITUDES DE PAVIMENTACION DE CALLES (DOCUMENTOS)",
                            subGrid: true,
                            subGridRowExpanded: function (subgrid_id, row_id) {
                                var subgrid_table_id, pager_id;
                                subgrid_table_id = subgrid_id + "_t";
                                pager_id = "p_" + subgrid_table_id;
                                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                                var solicitud = jQuery('#grid').jqGrid('getRowData', row_id);
                                jQuery("#" + subgrid_table_id).jqGrid(
                                    {
                                        datatype: function () {
                                            var solicitud = jQuery('#grid').jqGrid('getRowData', row_id);
                                            $.ajax(
                                                {
                                                    url: "../../WebServices/WebServiceDcto.asmx/GetDctos", //PageMethod
                                                    data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                        "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                        "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                        "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                        "','idsol':'" + parseInt(solicitud.idsol) + "'}", //PageMethod Parametros de entrada
                                                    dataType: "json",
                                                    type: "post",
                                                    contentType: "application/json; charset=utf-8",
                                                    complete: function (jsondata, stat) {
                                                        if (stat == "success") {
                                                            jQuery("#" + subgrid_table_id)[0].addJSONData(JSON.parse(jsondata.responseText).d);
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
                                            id: "midsol"
                                        },
                                        colModel: [{
                                            index: 'idsol', width: 15, align: 'Center',
                                            name: 'IdSol'
                                        },
                                        {
                                            index: 'midDcto', width: 15, align: 'Center',
                                            name: 'IdDcto'
                                        },
                                        {
                                            index: 'mfolio', width: 20, align: 'Center',
                                            name: 'FolioDcto'
                                        },
                                        {
                                            index: 'mFecEnvio', width: 30, align: 'center',
                                            name: 'Fecha_Envío'
                                        },
                                        {
                                            index: 'mFecRecibo', width: 30, align: 'center', name: 'Fecha_Recibe', formatter: function (cellvalue) {
                                                var fecha = cellvalue;
                                                if (fecha == '01/01/1900') {
                                                    fecha = '';
                                                }
                                                return fecha;
                                            }
                                        },
                                        {
                                            index: 'mNomRecibe', width: 80, align: 'center',
                                            name: 'Nombre_Recibe'
                                        },
                                        {
                                            index: 'cDescrip', width: 80, align: 'center',
                                            name: 'Tipo_Dcto'
                                        },
                                        {
                                            index: 'mUsuCre', width: 40, align: 'center',
                                            name: 'Usu_Crea'
                                        },
                                        {
                                            index: 'mFecCre', width: 30, align: 'center',
                                            name: 'Fecha_Crea'
                                        },
                                        {
                                            index: 'mUsuMod', width: 40, align: 'center',
                                            name: 'Usu_Modif'
                                        },
                                        {
                                            index: 'mFecMod', width: 30, align: 'center',
                                            name: 'Fecha_Mod'
                                        },
                                        {
                                            name: 'Documento', index: 'mNomArchivo', width: 60, align: 'center', editable: false, sortable: false, formatter: function (cellvalue) {
                                                var archivo = cellvalue;
                                                var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                                return url;
                                            }
                                        }],
                                        pager: pager_id, //Pager.                 
                                        loadtext: 'Cargando datos...',
                                        recordtext: "{0} - {1} de {2} elementos",
                                        emptyrecords: 'No hay resultados',
                                        pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                                        rowNum: "12", // PageSize.
                                        rowList: [4, 6, 8], //Variable PageSize DropDownList. 
                                        viewrecords: true, //Show the RecordCount in the pager.
                                        ajaxGridOptions: row_id,
                                        multiselect: false,
                                        sortname: "midsol", //login SortColumn
                                        sortorder: "asc", //login SortOrder.
                                        width: "1800",
                                        height: "100%",
                                        caption: "DOCUMENTOS"
                                    }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Editar Dcto",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                                cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdDcto');
                                                cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Tipo_Dcto');

                                                if (cellValue) {
                                                    if (cellValue3 == 'FACTIBILIDAD' || cellValue3 == 'ANUENCIA') {
                                                        alert("Todos los documentos se pueden editar excepto los de FACTIBILIDAD, ANUENCIA.");//------ Envío valor de idsol   y "accion = 1" para editar registro                                                                      }                                              
                                                    }
                                                    else {
                                                        AccionRegistroDcto(cellValue, cellValue2, 1);
                                                    }
                                                }
                                                else {
                                                    alert("No existen registros ó selecciona un registro para modificar...");
                                                }
                                            },
                                            position: "last",
                                            title: "Editar_Dcto",
                                            cursor: "pointer"
                                        })
                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Eliminar Dcto",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                                cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdDcto');
                                                cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Tipo_Dcto');

                                                if (cellValue) {
                                                    if (cellValue3 == 'FACTIBILIDAD') {
                                                        alert("Los documentos de factibilidad NO pueden ser cancelados...");
                                                    }
                                                    else {
                                                        AccionRegistroDcto(cellValue, cellValue2, -1); //------ Envío valor de idsol   y "accion = 1" para editar registro
                                                    }
                                                }
                                                else {
                                                    alert("No existen registros ó selecciona un registro para cancelar...")
                                                }
                                            },
                                            position: "last",
                                            title: "Eliminar_Dcto",
                                            cursor: "pointer"
                                        });


                            }



                        }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                        .navButtonAdd('#pager',
                            {
                                caption: "Buscar Sol",
                                buttonicon: "ui-icon-search",
                                onClickButton: function () {
                                    RedibujarGrid();
                                },
                                position: "last",
                                title: "Buscar Sol",
                                cursor: "pointer"
                            })

                        .navButtonAdd('#pager',
                            {
                                caption: "Alta Dcto",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                                    if (cellValue) {
                                        AccionRegistroDcto(cellValue, 0, 0); //------ Envío valor de idsol   y "accion = 0" para alta de registro
                                    }
                                    else {
                                        alert("Selecciona un registro...");
                                    }
                                },
                                position: "last",
                                title: "Alta_Dcto",
                                cursor: "pointer"
                            });
                    //Crear botón de editar
                    /* .navButtonAdd('#pager',
                            {
                                caption: "Alta Sol",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    AccionRegistroSolicitud(0, 0); //----- No envío valor de idsol porque es nuevo registro y "accion=0" como nuevo registro                
                                },
                                position: "last",
                                title: "Alta Sol",
                                cursor: "pointer"
                            })
                     .navButtonAdd('#pager',
                            {
                                caption: "Editar Sol",
                                buttonicon: "ui-icon-pencil",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'mSolId');
                                    if (cellValue) {
                                        AccionRegistroSolicitud(cellValue, 1); //------ Envío valor de idsol   y "accion = 1" para editar registro                        
                                    }
                                    else {
                                        alert("Selecciona un registro...");
                                    }
                                },
                                position: "last",
                                title: "Editar Sol",
                                cursor: "pointer"
                            })
                     .navButtonAdd('#pager',
                            {
                                caption: "Cancelar Sol",
                                buttonicon: "ui-icon-closethick",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                    if (cellValue) {
                                        AccionRegistroDcto(cellValue, -1); //----- Envío valor de idsol y "accion=-1" para cancelar registro
                                    }
                                    else {
                                        alert("Selecciona un registro...");
                                    }
                                },
                                position: "last",
                                title: "Cancelar Sol",
                                cursor: "pointer"
                            })
                     .navButtonAdd('#pager',
                            {
                                caption: "Buscar Sol",
                                buttonicon: "ui-icon-search",
                                onClickButton: function () {
                                    RedibujarGrid();
                                },
                                position: "last",
                                title: "Buscar Sol",
                                cursor: "pointer"
                            })
                     .navButtonAdd('#pager',
                           {
                               caption: "Ubicación Tramo",
                               buttonicon: "ui-icon-image",
                               onClickButton: function () {
                                   var myGrid = $('#grid');
                                   selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                   cellValue = myGrid.jqGrid('getCell', selectedRowId, 'Ubic.');
                                   if (cellValue) {
                                       if (cellValue > 0) {
                                           ubicFactis(cellValue);
                                       }
                                       else {
                                           alert("Solicitud sin UBICACION asignada");
                                       }
                                   }
                                   else {
                                       alert("Selecciona un registro...");
                                   }
                               },
                               position: "last",
                               title: "Ubicar tramo",
                               cursor: "pointer"
                           })*/






                    //// Procedimiento para capturar el click en las imagenes que se presenten 

                    // $("img").click(function () {  //Caza el CLICK DE TODAS LAS IMAGENES
                    //     var nombre = $(this);     //Cacha el  objeto imagen donde se hizo click                
                    //     var bandera = nombre.attr("src"); // Asigna el texto de la ruta de la propiedad src
                    //     if (bandera.indexOf("buscar") !== -1) {  //  Encontro la imagen que en su path tiene la cadena "Buscar"                                         
                    //         RedibujarGrid();
                    //     }
                    // });

                    // $("#btnAgregar").click(function () {
                    //     AbrirModal(0, 0);
                    // });

                    $(".posicion_boton_accion_sol").click(function (e) { //Actualizar datos en el registro            
                        e.preventlogin();
                        var accion = $('#lblaccion').html();
                        ejecutarAccion(accion);
                    });

                    $(".posicion_boton_accion_dcto").click(function (e) { //Actualizar datos en el registro            
                        e.preventlogin();
                        var accion = $("#lblacciondcto").html();
                        var idsol = parseInt($("#lblsoldcto").html());

                        if (validardcto(accion)) {   /*Valida que los datos del documento sean coreectos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                            /*Reunir parámetros para guardar el registro del archivo y el archivo capturado en el server*/
                            var folioDcto = $("#txtFolioDcto").val();      /*Recupera folio del documento capturado*/
                            var iddcto = parseInt($("#lbliddcto").html());
                            if (isNaN(iddcto)) {
                                iddcto = 0;
                            }
                            var fecenvio = ConvertirCadenaToFecha($("#txtfecenvio").val());
                            var fecrecibo = ConvertirCadenaToFecha($("#txtfecrecep").val());

                            var usurec = parseInt($("#lstUsuario").val());
                            var hoy = new Date();
                            var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                            var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                            var usuario = arrusuario[1];
                            var idtipodcto = parseInt($("#lsttipodoc").val());
                            var opcion = $("#lsttipodoc option:selected").text();
                            var sufijo_nom_archivo = opcion.split(":");
                            var nomarchivo = idsol + '_' + folioDcto + sufijo_nom_archivo[1]; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                            var archivo = $("#file1").get(0).files;


                            InsertaRegDcto(idsol, iddcto, 0, folioDcto, fecenvio, fecrecibo, usurec, nomarchivo, idtipodcto, usuario, hoy, usuario, hoy, archivo, accion)
                                .done(function (r) { /*Si se tiene éxito al guardar la factibilidad*/
                                    alert("Accion ejecutada correctamente")
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                })
                                .fail(function (x) {
                                    alert("No es posible ejecutar la acción requerida...");
                                });
                        }
                    });

                    $(".verarchivo").click(function (e) { //Ver documento                   
                        var archivo = $("#archivo").text();
                        leerArchivo(archivo);
                    });





                    $(".window .posicion_boton_cancelar_dcto").click(function (e) {
                        //Cancel the link behavior
                        e.preventlogin();
                        $('#mask, .window').hide();
                    });

                    //if mask is clicked
                    $('#mask').click(function () {
                        $(this).hide();
                        $('.window').hide();
                    });

                    $("#colonia").change(function () {
                        llenarCalles($("#colonia").val(), 0);
                    });

                    /* var map = new ol.Map({
                         layers: [
                           new ol.layer.Tile({
                               source: new ol.source.OSM()
                           })
                         ],
                         target: 'map',
                         controls: ol.control.defaults({
                             attributionOptions: /** @type {olx.control.AttributionOptions}  ({*/
                    /*            collapsible: false
                            })
                        }),
                        view: new ol.View({
                            center: [1, -19],
                            zoom: 10
                        })
                    })
            
                    document.getElementById('zoom-out').onclick = function () {
                        var view = map.getView();
                        var zoom = view.getZoom();
                        view.setZoom(zoom - 1);
                    };
            
                    document.getElementById('zoom-in').onclick = function () {
                        var view = map.getView();
                        var zoom = view.getZoom();
                        view.setZoom(zoom + 1);
                    };*/

                });

                function leerArchivo(nom_archivo) {
                    var url = "../../temp/" + nom_archivo;
                    window.open(url, '_blank', 'toolbar=0');
                }


                /* function enviardatosBD(accion) {
                     var claves = $("#colonia").val();
                     var arr = claves.split("*");
                     var sector = parseInt(arr[0]);
                     var subsector = parseInt(arr[1]);
                     var bienvusuario = $("#lblUsuario").html();
                     var arrusuario = bienvusuario.split(":");
                     var usuario = arrusuario[1];
             
                     var date = new Date();
                     var strDate = date.getDate() + '/' + (date.getMonth() + 1) + '/' + (date.getFullYear());
             
                     var enviarObj = {
                         "IdSol": parseInt($("#lblidsol").text()),
                         "IdEstatus": 1,
                         "IdOrigen": parseInt($("#origsol").val()),
                         "Fecha": date,
                         "Fecha1": date,
                         "Fecha2": date,
                         "Nombre": $("#nomsol").val().toUpperCase(),
                         "Direccion": $("#domsol").val().toUpperCase(),
                         "Telefono": $("#telsol").val(),
                         "Correo": $("#emailsol").val(),
                         "SECFNO": sector,
                         "SSCFNO": subsector,
                         "CLACNO": $("#calle").val(),
                         "Tramo": $("#tramo").val().toUpperCase(),
                         "Distancia": "0",
                         "Observaciones": $("#observ").val().toUpperCase(),
                         "Accion": accion,
                         "Busqueda": "Buscar",
                         "listado": "listado",
                         "UsuCre": usuario,
                         "FecCre": date,
                         "UsuMod": usuario,
                         "FecMod": date,
                         "Atencion": "noatencion",
                         "TramoO": $("#tramo").val().toUpperCase(),
                         "Ordena": "ordena",
                         "Inicio": 0,
                         "Fin": 0,
                         "Calle": $("#calle option:selected").text(),
                         "Col": $("#colonia option:selected").text(),
                         "ubic": parseInt($("#ubic").val()),
                         "Autorizar": 0,
                         "Mensaje": "mensaje"
                     }
                     var stringData = JSON.stringify(enviarObj);
                     $.ajax({
                         type: 'POST',
                         url: "../../WebServices/WebServiceSolic.asmx/ActSolicitud",
                         data: "{objSol:" + stringData + "}",
                         contentType: 'application/json; utf-8',
                         dataType: 'json',
                         success: function (data) {
                             if (data.d != null) {
                                 alert(data.d);
                             }
                             RedibujarGrid();
                         },
                         error: function (jqXHR, textStatus, errorThrown) {
                         }
                     });
             
                 };*/

                /* function GuardarFactBD(accion) {
                     var bienvusuario = $("#lblUsuario").html();
                     var arrusuario = bienvusuario.split(":");
                     var usuario = arrusuario[1];
                     var date = new Date();
                     var strDate = date.getDate() + '/' + (date.getMonth() + 1) + '/' + (date.getFullYear());
                     var idsol = parseInt($("#lblsolfact").text());
                     var opciones = [];
                     var usuario_facti = parseInt($("#lstUsuario").val());
             
                     $("input:checkbox").each(
                       function () {
                           if ($(this).attr('checked')) {
                               opciones.push(1);
                           }
                           else {
                               opciones.push(0);
                           }
                       });
                     var idfact;
                     if ($("#lblfact").text().length > 0) {
                         idfact = parseInt($("#lblfact").text())
                     }
                     else {
                         idfact = 0;
                     }
             
             
                     var enviarObj = {
                         "idSol": parseInt($("#lblsolfact").text()),
                         "idfact": idfact,
                         "usufact": $("#lstUsuario").val(),
                         "opc1": opciones[0],
                         "opc2": opciones[1],
                         "opc3": opciones[2],
                         "opc4": opciones[3],
                         "opc5": opciones[4],
                         "opc6": opciones[5],
                         "opc7": opciones[6],
                         "opc8": opciones[7],
                         "opc9": opciones[8],
                         "opc10": opciones[9],
                         "opc11": 0,            /*Se deshabilita porque solo se estan utilizando 10 opciones
                         "opc12": 0,            /*Se deshabilita porque solo se estan utilizando 10 opciones
                         "factfile": "ocupado",
                         "estatusfact": $("#lstEstFact").val(),
                         "UsuCre": usuario,
                         "FecCre": date,
                         "UsuMod": usuario,
                         "FecMod": date,
                         "observtec": $("#txtobservtec").val().toUpperCase(),
                         "observgral": $("#txtobservgral").val().toUpperCase(),
                         "accion": accion
                     }
                     var stringData = JSON.stringify(enviarObj);
                     return $.ajax({
                         type: 'POST',
                         url: "../../WebServices/WebServiceFact.asmx/ActFactibilidad",
                         data: "{objFact:" + stringData + "}",
                         contentType: 'application/json; utf-8',
                         dataType: 'json',
                         success: function (data) {
                             if (data.d != null) {
                                 alert(data.d);
                             }
                         },
                         error: function (jqXHR, textStatus, errorThrown) {
                             alert(textStatus + jqXHR + errorThrown);
                         }
                     });
             
                 };*/

                function InsertaRegDcto(idsol, iddcto, idref, folioDcto, fecenvio, fecrecibo, usurec, nomarchivo, tipodcto, usuario, hoy, usuario, hoy, archivo, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


                    var enviarObj = {
                        "idsol": idsol,
                        "iddcto": iddcto,
                        "idref": idref,
                        "folio": folioDcto,
                        "FecSolic": fecenvio,
                        "FecRecib": fecrecibo,
                        "NumRecibe": usurec,
                        "NomArchivo": nomarchivo,
                        "TipoDcto": tipodcto,
                        "UsuCre": usuario,
                        "FecCre": hoy,
                        "UsuMod": usuario,
                        "FecMod": hoy,
                        "accion": accion
                    }
                    var stringData = JSON.stringify(enviarObj);


                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceDcto.asmx/ActDcto",
                        data: "{objDcto:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                ValidacionGuardadoArchivo(archivo, nomarchivo);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        }
                    });
                }


                function checkUbicSolicitud(idpolig) {
                    return $.ajax({
                        url: "../../WebServices/WebServiceMap.asmx/GetPolygonoFact",
                        data: "{'idpoligono':'" + idpolig + "'}",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                    });
                }



                /*function ejecutarAccion(accion) {
            
                    /*IMPORTANTE*/
                /*EXPRESIONES REGULARES SE MANEJAN DE ACUERDO A LA DEFINICION: /^ significa que la cadena coincide con cualquier cosa que no esté en la expresión regular  */

                /*    var valid = checkLength($("#nomsol").val().length, "Nombre solicitante", 10, 200);
                    valid = valid && checkLength($("#domsol").val().length, "Domicilio solicitante", 1, 200);
                    valid = valid && checkLength($("#tramo").val().length, "Tramo", 8, 200);
                    valid = valid && checkRegexp($("#nomsol").val(), /^[a-zA-Z]+( *[a-zA-Z]*)*[a-zA-Z]+$/, "El nombre solo acepta letras");
                    valid = valid && checkVacio($("#emailsol").val(), /^[\w-+]+(\.[\w-]{1,62}){0,126}@[\w-]{1,63}(\.[\w-]{1,62})+[\w-]+$/, "Introduce dirección email correctamente ejem.: micorreo@dominio.com");
                    valid = valid && checkVacio($("#telsol").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
                    valid = valid && checkRegexp($("#domsol").val(), /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+/, "El domicilio acepta letras, números y carcatéres especiales.");
                    valid = valid && checkRegexp($("#tramo").val(), /^[a-zA-Z0-9]+[a-zA-Z0-9 .#]*[ ]*[-]+[ ]*[a-zA-Z0-9]+[a-zA-Z0-9 .#]*$/, "El tramo debe constar dos limites: límite1 - límite2");
                    valid = valid && checkRegexp($("#ubic").val(), /^[0-9]*$/, "La ubicación debe ser numero entero");
                    if (valid) {
                        checkUbicSolicitud(parseInt($("#ubic").val()))
                            .done(function (r) {
                                if (r.d == "<NewDataSet />") {
                                    $("#ubic").val("");
                                    alert("No existe ubicación registrada, favor capturar una ubicación válida");
                                }
                                else {
                                    $(r.d).find("PolygonoFact").each(function () {
                                        var idpolig = $(this).find("gid").text();
                                        enviardatosBD(accion);
                                        $('#mask, .window').hide();
                                    })
                                }
                            })
                           .fail(function (x) {
                               alert("No fue posible leer la ubicación");
                           });
                    }
            
                }*/

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

                function isDate(txtDate) {
                    var currVal = $.trim(txtDate);
                    var resp;

                    if (currVal == '')
                        resp = false;

                    //Declare Regex            
                    var rxDatePattern = /^(\d{1,2})(\/)(\d{1,2})(\/)(\d{4})$/;
                    var dtArray = currVal.match(rxDatePattern); // is format OK?

                    if (dtArray == null) {
                        resp = false;
                    }
                    else {
                        dtDay = parseInt(dtArray[1]);
                        dtMonth = parseInt(dtArray[3]);
                        dtYear = parseInt(dtArray[5]);
                        if (dtMonth < 1 || dtMonth > 12)
                            resp = false;
                        else if (dtDay < 1 || dtDay > 31)
                            resp = false;
                        else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
                            resp = false;
                        else if (dtMonth == 2) {
                            var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
                            if (dtDay > 29 || (dtDay == 29 && !isleap))
                                resp = false;
                        }
                        resp = true;
                    }

                    //Checks for dd/mm/yyyy format.

                    if (!resp) {
                        alert("La fecha capturado como fecha de envío es incorrecta");
                    }
                    return resp;
                }




                function validardcto(accion) {
                    if (accion >= 0) {
                        var valid = checkLength($("#txtFolioDcto").val().length, "Folio del Documento", 1, 20);            /*Valida la longitud del Folio del documento*/
                        valid = valid && isDate($("#txtfecenvio").val());
                        fecenvio = ConvertirCadenaToFecha($("#txtfecenvio").val());
                        fecrecibo = ConvertirCadenaToFecha($("#txtfecrecep").val());
                        if (fecrecibo != '01/01/1900') {
                            if (fecenvio > fecrecibo) {
                                alert("La fecha de envio no es correcta, favor de verificar");
                                $("#txtfecenvio").val('');
                                valid = false;
                            }
                        }

                        if (valid) {
                            if ($("#file1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                                if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                    return true;
                                }
                                else {
                                    $("#file1").val("");
                                    return false;
                                }
                            }
                            else {
                                if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                    return true;
                                }
                                else {
                                    alert("No se capturado ningún archivo digital");
                                    return false;
                                }
                            }
                        }
                    }
                    else {
                        return true;
                    }
                }


                function ValidarArchivo(archivo) {              /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/

                    var fn = archivo.name;
                    var fs = archivo.size;
                    var ext = fn.split(".").pop();
                    if (fs > 1000000) {
                        alert("El tamaño del archivo: " + fn + " debe ser menor que 1 MB");
                        return false;
                    }
                    else {
                        switch (ext) {
                            case 'jpg':
                            case 'jpeg':
                            case 'png':
                            case 'pdf':
                                return true;
                                login:
                                alert("El archivo: " + fn + " no tiene extensión .PDF");
                                return false
                        }
                    }
                }


                function ValidacionGuardadoArchivo(archivo, nomarchivo) {
                    GuardarArchivo(archivo, nomarchivo)
                        .done(function (result) {
                            console.log("El archivo fue guardado correctamente")
                        }).fail(function (result) {
                            alert("No fue posible guardar el archivo");
                        });
                }


                function GuardarArchivo(archivo, nomarchivo) {

                    var formdata = new FormData();

                    formdata.append("UploadedImage", archivo[0]);
                    var objParametro = "{'nomarchivo':'" + nomarchivo + "'}";

                    formdata.append("objParametros", objParametro);

                    return $.ajax({
                        type: "POST",
                        url: "../../WebServices/WebServiceFileUpload.asmx/GuardarArchivo",
                        contentType: false,
                        processData: false,
                        data: formdata
                    });
                }


                /* function MostrarModal() {
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
                     $("#dialog").css('top', winH / 2 - $("#dialog").height() / 2);
                     $("#dialog").css('left', winW / 2 - $("#dialog").width() / 2);
             
                     //transition effect
                     $("#dialog").fadeIn(2000);
                 }*/

                function MostrarModalDcto() {
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
                    $("#dialogoDcto").css('top', winH / 2 - $("#dialogoDcto").height() / 2);
                    $("#dialogoDcto").css('left', winW / 2 - $("#dialogoDcto").width() / 2);

                    //transition effect
                    $("#dialogoDcto").fadeIn(2000);
                }

                function AccionRegistroDcto(idsol, iddcto, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
                    $("#lblacciondcto").text(accion);

                    if (accion == 0) {  //Si la accion es crear un nuevo registro
                        $("#lstUsuario").prop('disabled', false);
                        $("#txtfecenvio").prop('disabled', false);
                        $("#txtfecrecep").prop('disabled', false);
                        $("#txtFolioDcto").prop('disabled', false);
                        $("#lsttipodoc").prop('disabled', false);
                        $("#file1").prop('disabled', false);

                        $("#lblsoldcto").text(idsol);
                        $("#lbliddcto").text('');
                        $("#txtFolioDcto").val("");
                        $("#txtfecenvio").text('');
                        $("#txtfecrecep").text('');
                        $("#file1").val("");
                        $("#archivo").text("");
                        llenarUsuario(0);
                        llenarTiposDctos(0);
                        MostrarModalDcto();

                    }
                    else {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../../WebServices/WebServiceDcto.asmx/GetDcto",
                            data: '{idsol:' + idsol + ',iddcto:' + iddcto + '}',
                            success: function (data) {
                                var numusuario;
                                var idtipodcto;
                                var fecenvio;
                                var fecrecibe;
                                var nom_archivo;
                                var cadena = $.trim(data.d);
                                if (cadena == "<NewDataSet />") {
                                    alert("El documento está cancelado, por lo tanto no es posible realizar la acción solicitada.");
                                }
                                else {

                                    // Data.d trae un string con el XML generado dentro del servicio web asmx
                                    $(data.d).find("Documento").each(function () {
                                        /*var idDcto = $(this).find("midDcto").text();*/
                                        var folioDcto = $(this).find("mfolio").text();
                                        var iddcto = $(this).find("midDcto").text();
                                        idtipodcto = $(this).find("mTipoDcto").text();
                                        fecenvio = $(this).find("mFechaEnvio").text();
                                        fecrecibe = $(this).find("mFechaRecibe").text();
                                        numusuario = parseInt($(this).find("mNumUsuRec").text());
                                        nom_archivo = $(this).find("mNomArchivo").text();
                                        $("#lbliddcto").text(iddcto);
                                        $("#txtfecenvio").val(fecenvio);
                                        if (fecrecibe == '01/01/1900') {
                                            fecrecibe = '';
                                        }
                                        $("#txtfecrecep").val(fecrecibe);
                                        $("#lblsoldcto").text(idsol);
                                        $("#lbldcto").text(iddcto);
                                        $("#txtFolioDcto").val(folioDcto);
                                        $("#archivo").text(nom_archivo);
                                    });
                                    llenarUsuario(numusuario);
                                    llenarTiposDctos(accion, idtipodcto);
                                    if (accion < 0) {
                                        $("#lstUsuario").prop('disabled', true);
                                        $("#txtfecenvio").prop('disabled', true);
                                        $("#txtfecrecep").prop('disabled', true);
                                        $("#txtFolioDcto").prop('disabled', true);
                                        $("#file1").prop('disabled', true);
                                        $("#lsttipodoc").prop('disabled', true);
                                        alert("ATENCION: seleccionó cancelar la documento...");
                                    }
                                    else {
                                        $("#lstUsuario").prop('disabled', false);
                                        $("#txtfecenvio").prop('disabled', false);
                                        $("#txtfecrecep").prop('disabled', false);
                                        $("#txtFolioDcto").prop('disabled', false);
                                        $("#lsttipodoc").prop('disabled', false);
                                        $("#file1").prop('disabled', false);
                                    }
                                    MostrarModalDcto();
                                }

                            },
                            error: function (xhr) {
                                console.log(xhr.responseText);
                            }
                        });

                    }

                }

                /*   function AccionRegistroSolicitud(idsol, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
               
                       if (accion == 0) {  //Si la accion es crear un nuevo registro
                           $("#lblidsol").text('');
                           //Formatear fecha de solicitud                   
                           $("#nomsol").val('');
                           $("#telsol").val('');
                           $("#emailsol").val('');
                           $("#domsol").val('');
                           $("#callepav").val('');
                           $("#colonia").val('');
                           $("#tramo").val('');
                           $("#observ").val('');
                           $("#ubic").val('');
                           llenarOrigenSolicitud(0);
                           llenarColonias(0, 0, 0);
                           MostrarModal();
                       }
                       else { // si la acción indica editar o cancelar un registro
                           $.ajax({
                               type: "POST",
                               dataType: "json",
                               contentType: "application/json",
                               url: "../../WebServices/WebServiceSolic.asmx/GetSolicitud",
                               data: '{idsol:' + idsol + '}',
                               success: function (data) {
                                   
                                   var cadena = $.trim(data.d);
                                   if (cadena == "<NewDataSet />") {
                                       alert("La solicitud está cancelada, por lo tanto no es posible realizar la acción solicitada.");
                                   }
                                   else {
                                       var idorigsol;
                                       var idsolvalid = 0;
                                       var cvesector;
                                       var cvesubsector;
                                       var cvecalle;
                                       // Data.d trae un string con el XML generado dentro del servicio web asmx
                                       $(data.d).find("Solicitud").each(function () {
                                           var fecsol = $(this).find("msolfecha").text();
                                           idsolvalid = parseInt($(this).find("mSolId").text());
                                           var nomsol = $(this).find("mSolNombre").text();
                                           var telsol = $(this).find("mSoltel").text();
                                           var emailsol = $(this).find("mSolcorreo").text();
                                           idorigsol = $(this).find("cOrigId").text();
                                           var domsol = $(this).find("msoldireccion").text();
                                           var callepav = $(this).find("mSolcalle").text();
                                           var colonia = $(this).find("mSolcolonia").text();
                                           var tramo = $(this).find("mSoltramo").text();
                                           var observ = $(this).find("mSolObserva").text();
                                           var ubic = parseInt($(this).find("ubic").text());
                                           cvesector = $(this).find("mSolSECFNO").text();
                                           cvesubsector = $(this).find("mSolSSCFNO").text();
                                           cvecalle = $(this).find("mSolCLACNO").text();
                                           $("#lblidsol").text(idsolvalid);
                                           //Formatear fecha de solicitud
                                           var date = new Date(fecsol);
                                           $("#lblfecsol").text((date.getDate() + '/' + date.getMonth() + 1) + '/' + date.getFullYear());
                                           $("#nomsol").val(nomsol);
                                           $("#telsol").val(telsol);
                                           $("#emailsol").val(emailsol);
                                           $("#domsol").val(domsol);
                                           $("#callepav").val(callepav);
                                           $("#colonia").val(colonia);
                                           $("#tramo").val(tramo);
                                           $("#observ").val(observ);
                                           $("#ubic").val(ubic);
                                       });
                                       llenarOrigenSolicitud(idorigsol);
                                       llenarColonias(cvesector, cvesubsector, cvecalle);
                                       if (accion < 0) {
                                           $("#nomsol").prop('disabled', true);
                                           $("#telsol").prop('disabled', true);
                                           $("#emailsol").prop('disabled', true);
                                           $("#origsol").prop('disabled', true);
                                           $("#domsol").prop('disabled', true);
                                           $("#colonia").prop('disabled', true);
                                           $("#tramo").prop('disabled', true);
                                           $("#calle").prop('disabled', true);
                                           $("#observ").prop('disabled', true);
                                           $("#ubic").prop('disabled', true);
                                       }
                                       else {
                                           $("#nomsol").prop('disabled', false);
                                           $("#telsol").prop('disabled', false);
                                           $("#emailsol").prop('disabled', false);
                                           $("#origsol").prop('disabled', false);
                                           $("#domsol").prop('disabled', false);
                                           $("#colonia").prop('disabled', false);
                                           $("#tramo").prop('disabled', false);
                                           $("#calle").prop('disabled', false);
                                           $("#observ").prop('disabled', false);
                                           $("#ubic").prop('disabled', false);
                                       }
                                       MostrarModal();
                                   }
               
                               },
                               error: function (xhr) {
                                   console.log(xhr.responseText);
                               }
                           });
                       }
                       $("#lblaccion").text(accion);
                   }*/


                /*   function llenarOrigenSolicitud(idOrigSol) {
                       $.ajax({
                           type: "POST",
                           dataType: "json",
                           contentType: "application/json",
                           url: "../../WebServices/WebServiceSolic.asmx/GetOrigenSolicitud",
                           data: "",
                           success: function (data) {
                               var elementos = 0;
                               $("#origsol").html('');
                               $(data.d).find("OrigSolicitud").each(function () {
                                   var option = $(document.createElement('option'));
                                   var origsol = $(this).find("cOrigId").text();
                                   var orignom = $(this).find("cOrigNombre").text();
                                   option.html(orignom);
                                   option.val(origsol);
                                   //Nombre de combo a poblar
                                   $("#origsol").append(option);
                                   elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                               });
                               if (idOrigSol != 0) {
                                   $("#origsol").val(idOrigSol);
                               }
                           },
                           error: function (xhr) {
                               console.log(xhr.responseText);
                           }
                       });
                   }*/

                function llenarUsuario(idusu) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceUsuario.asmx/GetUsuario",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstUsuario").html('');
                            $(data.d).find("Usuario").each(function () {
                                var option = $(document.createElement('option'));
                                var idusu = $(this).find("mUsuId").text();
                                var usunom = $(this).find("mUsuNombre").text();
                                option.html(usunom);
                                option.val(idusu);
                                //Nombre de combo a poblar
                                $("#lstUsuario").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (idusu != 0) {
                                $("#lstUsuario").val(idusu);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                /*function llenarEstatusFact(idestfact) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceFact.asmx/GetEstFact",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstEstFact").html('');
                            $(data.d).find("EstatusFact").each(function () {
                                var option = $(document.createElement('option'));
                                var idestfact = $(this).find("cEstId").text();
                                var descrip = $(this).find("cEstDescripcion").text();
                                option.html(descrip);
                                option.val(idestfact);
                                //Nombre de combo a poblar
                                $("#lstEstFact").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (idestfact != 0) {
                                $("#lstEstFact").val(idestfact);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }*/


                function llenarTiposDctos(accion, idtipodcto) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceDcto.asmx/GetTipoDcto",
                        data: '{accion:' + accion + '}',
                        success: function (data) {
                            var elementos = 0;
                            $("#lsttipodoc").html('');
                            $(data.d).find("TipoDcto").each(function () {
                                var option = $(document.createElement('option'));
                                var idtipodoc = $(this).find("cidtipodoc").text();
                                var nomtipodoc = $(this).find("cdescrip").text() + ":" + $(this).find("prefijo").text();;
                                option.html(nomtipodoc);
                                option.val(idtipodoc);
                                $("#lsttipodoc").append(option);
                            });
                            if (idtipodcto != 0) { //Si la clave del tipo de dcto es diferente de 0, es decir si el registro es para editar
                                $("#lsttipodoc").val(idtipodcto);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                /*function llenarCalles(cvecolonia, cvecallesel) {
                    var arr = cvecolonia.split("*");
                    var colonia = arr[0] + arr[1];
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCalCol.asmx/GetCalles",
                        data: "{'parametro':'" + colonia + "'}",
                        success: function (data) {
                            $("#calle").html('');
                            // Data.d trae un string con el XML generado dentro del servicio web asmx
                            $(data.d).find("CallesDU").each(function () {
                                var option = $(document.createElement('option'));
                                var cvecalle = $(this).find("CveCalle").text();
                                var callenom = $(this).find("Calle").text();
                                option.html(callenom);
                                option.val(cvecalle);
                                $("#calle").append(option);
                            });
                            if (cvecallesel > 0) {
                                $("#calle").val(cvecallesel);
                            }
                        },
                        error: function (response) {
                            if (response.length != 0)
                                alert(response);
                        }
                    });
                }*/

            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


            <b>Nombre de Calle:<input type="text" name="Calle" id="txtnomcalle" style="width:250px" />&nbsp &nbsp No.
                Solicitud:</><input type="text" name="idsol" id="txtidsol" style="width:50px" /></b><br /><br />


            <table id="grid"></table>
            <div id="pager"></div>&nbsp


            <div id="boxes">
                <div id="dialogoDcto" class="window">
                    <div id="titulofact" style="text-align:right">
                        <p style="text-align:center">GESTION DE DOCUMENTOS</p>
                        No. de solicitud: <label for="idsol" id="lblsoldcto"></label><br />
                        No. de Documento: <label for="iddcto" id="lbliddcto"></label><br />
                        <label for="accion" id="lblacciondcto"></label><br />
                    </div>
                    <div class="datos" id="bodyfact">
                        <label for="name">Tipo de DOCUMENTO:</label> <select name="tipodoc"
                            id="lsttipodoc"></select><br /><br />
                        <label for="name">Folio de DOCUMENTO: </label><input type="text" name="txtFolioDcto"
                            id="txtFolioDcto" size="20" /><br /><br />
                        <label for="name">Fecha envío:</label> <input type="text" name="fecenvio" id="txtfecenvio"
                            size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" />
                        dd/mm/aaaa<br /><br />
                        <label for="name">Fecha recepción:</label> <input type="text" name="fecrecep" id="txtfecrecep"
                            size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" />
                        dd/mm/aaaa<br /><br />
                        <label for="name">Nombre de usuario quien recibe:</label> <select name="Usuario"
                            id="lstUsuario"></select><br /><br />
                        <label for="name">Factibilidad:</label><input type="file" id="file1" name="file" /> <a href="#"
                            id="archivo" class="verarchivo" />
                    </div>
                    <div class="botonesf">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_dcto">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_dcto">Cancelar</a></p>
                    </div>
                </div>
                <div id="mask"></div>
            </div>
        </asp:Content>