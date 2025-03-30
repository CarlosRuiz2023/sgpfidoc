<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_contrato.aspx.vb" Inherits="Admin_procesos_consultar_contrato" %>
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

            function AbreVisorDocto(nombre_docto) {
                //alert(img);
                /*var url1 = "../Procesos/visor_docto.html?ResponseType=Edit&nombre_docto=" + nombre_docto;*/

                var url1 = "../../js/powerful_pdf_viewer/viewer_pdf.html?ResponseType=Edit&nombre_docto=" + nombre_docto;
                newWindow = window.open(url1, "_blank", "top=200,left=900,menubar=no,toolbar=no,location=no,height=720,width=880,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }



            function ValidarArchivo(archivo) {              /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/

                var fn = archivo.name;
                var fs = archivo.size;
                var ext = fn.split(".").pop();
                if (fs > 9000000) {
                    alert("El tamaño del archivo: " + fn + " debe ser menor que 1 MB");
                    return false;
                }
                else {
                    switch (ext) {
                        case 'jpg':
                            alert("El archivo: " + fn + " no tiene extensión .PDF");
                            return false
                        case 'jpeg':
                            alert("El archivo: " + fn + " no tiene extensión .PDF");
                            return false
                        case 'png':
                            alert("El archivo: " + fn + " no tiene extensión .PDF");
                            return false
                        case 'pdf':
                            return true;
                        default:
                            alert("El archivo: " + fn + " no tiene extensión .PDF");
                            return false
                    }
                }
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



            function valida_alfanumericos(texto) {
                var long = texto.length;

                if (texto.match(/[^a-zA-Z0-9 ]/g)) {
                    texto = texto.replace(/[^a-zA-Z0-9 ]/g, '');
                }

                if (long == 26) {
                    $('#lblnum_contrato_limpio').html(CreaNumeroContrato(texto));
                }
                else {
                    $('#lblnum_contrato_limpio').html('');
                }

                return texto;
            }


            function asigna_valores_calculados(texto) {

                var valor_con_iva = parseFloat(texto);


                var valor_iva = (valor_con_iva * 16) / 100;
                var valor_sin_iva = valor_con_iva - valor_iva;

                var valor_iva_txt = valor_iva.toFixed(2).toString();
                var valor_sin_iva = valor_sin_iva.toFixed(2).toString();


                $('#txtiva').val(valor_iva_txt);
                $('#txtmonto_sin_iva').val(valor_sin_iva);


            }

            function CreaNumeroContrato(texto_captura) {

                var envio_resultado = true;
                var parte1 = texto_captura.substr(0, 1);
                var parte2 = texto_captura.substr(1, 4);
                var parte3 = texto_captura.substr(5, 1);
                var parte4 = texto_captura.substr(6, 6);
                var parte5 = texto_captura.substr(12, 5);
                var parte6 = texto_captura.substr(17, 1);
                var parte7 = texto_captura.substr(18, 4);
                var parte8 = texto_captura.substr(22, 4);


                if (esLetra(parte1)) {
                    parte1 = parte1.toUpperCase();
                } else {
                    envio_resultado = false;
                }

                if (!($.isNumeric(parte2))) {
                    envio_resultado = false;
                }

                if (esLetra(parte3)) {
                    parte3 = parte3.toUpperCase();
                } else {
                    envio_resultado = false;
                }

                if (!($.isNumeric(parte4))) {
                    envio_resultado = false;
                }

                if (!($.isNumeric(parte5))) {
                    envio_resultado = false;
                }

                if (esLetra(parte6)) {
                    parte6 = parte6.toUpperCase();
                } else {
                    envio_resultado = false;
                }

                if (!($.isNumeric(parte7))) {
                    envio_resultado = false;
                }

                if (!($.isNumeric(parte8))) {
                    envio_resultado = false;
                }


                if (envio_resultado) {
                    resultado = parte1 + '-' + parte2 + '-' + parte3 + parte4 + '-' + parte5 + '-' + parte6 + '_' + parte7 + '_' + parte8;
                } else {
                    resultado = '';
                }


                return resultado;
            }

            function esLetra(texto) {
                var regex = /^[A-Za-z]+$/;
                return regex.test(texto);
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



            function MostrarContrato(idusu, filtro) {


                var date = new Date();
                var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
                var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                var objContrato;

                if ($("#grid")[0].grid) {
                    $.jgrid.gridUnload("#grid");
                    //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                }

                $("#grid").jqGrid(
                    {
                        datatype: function () {
                            $.ajax(
                                {
                                    url: "../../WebServices/WebServiceContrato.asmx/GetContrato_Grid", //PageMethod
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
                                                alert('No se encontraron contratos registrados...');
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
                            id: "IdContrato"
                        },
                        colModel: [
                            {
                                index: 'idcontrato', width: 50, align: 'Center', name: 'idContrato', hidden: true
                            },
                            {
                                index: 'num_contrato', width: 100, align: 'Center', name: 'NumContratoReal', hidden: true
                            },
                            {
                                index: 'num_contrato_limpio', width: 120, align: 'Center', name: 'NumContrato'
                            },
                            {
                                index: 'obs_contrato', width: 300, align: 'Center', name: 'Observ_Contrato', hidden: true
                            },
                            {
                                index: 'monto_contrato_sin_iva', width: 50, align: 'Center', name: 'MontoContrato_SinIVA', hidden: true
                            },
                            {
                                index: 'monto_contrato', width: 50, align: 'Center', name: 'MontoContrato', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }, hidden: true
                            },
                            {
                                index: 'iva_contrato', width: 50, align: 'Center', name: 'IVA_Contrato', hidden: true
                            },
                            {
                                index: 'idcontratista', width: 50, align: 'Center', name: 'IdContratista', hidden: true
                            },
                            {
                                index: 'nom_razonsoc', width: 250, align: 'Center', name: 'NomContratista'
                            },
                            {
                                index: 'rfc_contratista', width: 120, align: 'Center', name: 'RFC_Contratista'
                            },
                            {
                                index: 'fec_contrato', width: 50, align: 'Center', name: 'Fec_Contrato'
                            },
                            {
                                index: 'fec_ini_contrato', width: 50, align: 'Center', name: 'Fec_Ini_Contrato'
                            },
                            {
                                index: 'fec_fin_contrato', width: 50, align: 'Center', name: 'Fec_Fin_Contrato'
                            },
                            {
                                index: 'fec_prorroga', width: 50, align: 'Center', name: 'Fec_Prorroga'
                            },
                            {
                                index: 'dcto_contrato', width: 50, align: 'Center', name: 'Dcto_Contrato', hidden: true
                            },
                            {
                                index: 'anticipo', width: 50, align: 'Center', name: 'Anticipo', hidden: true
                            },
                            {
                                index: 'idtipoasignacion', width: 50, align: 'Center', name: 'idTipoAsignacion', hidden: true
                            },
                            {
                                index: 'tipo_asignacion', width: 50, align: 'Center', name: 'TipoAsignacion'
                            },
                            {
                                index: 'fec_cre', width: 50, align: 'Center', name: 'fec_cre', hidden: true
                            },
                            {
                                index: 'fec_mod', width: 50, align: 'Center', name: 'fec_mod', hidden: true
                            },
                            {
                                index: 'usu_cre', width: 50, align: 'Center', name: 'usu_cre', hidden: true
                            },
                            {
                                index: 'usu_mod', width: 50, align: 'Center', name: 'usu_mod', hidden: true
                            },
                            {
                                index: 'cestatus', width: 50, align: 'Center', name: 'EstatusContrato'
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
                        sortname: "idcontrato", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1500",
                        height: "800",
                        caption: "CATALOGO DE CONTRATOS",
                        subGrid: true,
                        subGridBeforeExpand: function (subgrid_id, row_id) {
                            var myGrid = $('#grid');
                            objContrato = myGrid.jqGrid('getRowData', row_id);
                            filtro2 = objContrato.idContrato + ',';
                        },
                        subGridRowExpanded: function (subgrid_id, row_id) {
                            var subgrid_table_id, pager_id;
                            subgrid_table_id = subgrid_id + "_t";
                            pager_id = "p_" + subgrid_table_id;
                            $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                            var anexo_contrato = jQuery('#grid').jqGrid('getRowData', row_id);
                            jQuery("#" + subgrid_table_id).jqGrid(
                                {
                                    datatype: function () {
                                        $.ajax(
                                            {
                                                url: "../../WebServices/WebServiceAnexoContrato.asmx/GetAnexoContrato_Grid", //PageMethod
                                                data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                    "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                    "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                    "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                    "','filtro':'" + filtro2 + "'}", //PageMethod Parametros de entrada                                   
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
                                        id: "idanexo_contrato"
                                    },
                                    colModel: [
                                        {
                                            index: 'idcontrato', width: 60, align: 'Center', name: 'IdContrato', hidden: true
                                        },
                                        {
                                            index: 'idanexo_contrato', width: 60, align: 'Center', name: 'IdAnexoContrato', hidden: true
                                        },
                                        {
                                            index: 'idtipo_anexo_contrato', width: 60, align: 'Center', name: 'IdTipoAnexoContrato', hidden: true
                                        },
                                        {
                                            index: 'etiqueta_anexo_contrato', width: 200, align: 'Center', name: 'TipoAnexo'
                                        },
                                        {
                                            index: 'docto_param1', width: 80, align: 'Center', name: 'Param1', hidden: true
                                        },
                                        {
                                            index: 'fecha_param2', width: 80, align: 'Center', name: 'Param2'
                                        },
                                        {
                                            index: 'valor_param3', width: 100, align: 'Center', name: 'Param3'
                                        },
                                        {
                                            index: 'valor_param4', width: 100, align: 'Center', name: 'Param4'
                                        },
                                        {
                                            index: 'usu_cre', width: 60, align: 'Center', name: 'UsuCre', hidden: true
                                        },
                                        {
                                            index: 'usu_mod', width: 60, align: 'Center', name: 'UsuMod', hidden: true
                                        },
                                        {
                                            index: 'fec_cre', width: 80, align: 'Center', name: 'FecCre', hidden: true
                                        },
                                        {
                                            index: 'fec_mod', width: 80, align: 'Center', name: 'FecMod', hidden: true
                                        },
                                        {
                                            index: 'cactivo', width: 60, align: 'Center', name: 'Estatus'
                                        }
                                    ],
                                    pager: pager_id, //Pager.                 
                                    loadtext: 'Cargando datos...',
                                    recordtext: "{0} - {1} de {2} elementos",
                                    emptyrecords: 'No hay resultados',
                                    pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                                    rowNum: "8", // PageSize.
                                    rowList: [4, 6, 8], //Variable PageSize DropDownList. 
                                    viewrecords: true, //Show the RecordCount in the pager.
                                    ajaxGridOptions: row_id,
                                    multiselect: false,
                                    sortname: "idanexo_contrato", //login SortColumn
                                    sortorder: "asc", //login SortOrder.
                                    width: "1300",
                                    height: "100%",
                                    caption: "ANEXOS AL CONTRATO"
                                }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })

                                .navButtonAdd("#" + pager_id,
                                    {
                                        caption: "AltaAnexo",
                                        buttonicon: "ui-icon-document",
                                        onClickButton: function () {
                                            /* var myGrid = $("#" + subgrid_table_id);
                                             selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');                                    
                                             objAnexoContrato = myGrid.jqGrid('getRowData', selectedRowId);*/


                                            ConsultaPermisoEjecutarTarea(idusu, 162, 3)
                                                .done(function (result) {
                                                    var data = result.d;
                                                    var no_tiene_permiso = data.split(":");
                                                    var no_tiene = parseInt(no_tiene_permiso[1]);
                                                    //!no_tiene
                                                    if (true) {
                                                        llenarTipoAnexosContrato(0);
                                                        $("#lblidcontrato_1").html(objContrato.idContrato);
                                                        $("#lblaccion_1").html(0);

                                                        MostrarListaTipoAnexosContrato();
                                                    } else {
                                                        alert('El usuario ' + idusu + ' no cuenta con el permiso para capturar anexos de contrato.');
                                                    }
                                                })
                                                .fail(function (xhr) {
                                                    console.log(xhr.responseText);
                                                    alert("Falló consultar permiso de ejecución de tarea.");
                                                });
                                        },
                                        position: "last",
                                        title: "Alta de Anexo de Contrato",
                                        cursor: "pointer"
                                    })

                                .navButtonAdd("#" + pager_id,
                                    {
                                        caption: "EditAnexo",
                                        buttonicon: "ui-icon-document",
                                        onClickButton: function () {
                                            /* var myGrid = $("#" + subgrid_table_id);
                                             selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');                                    
                                             objAnexoContrato = myGrid.jqGrid('getRowData', selectedRowId);*/

                                            var myGrid = $("#" + subgrid_table_id);
                                            var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                            var objAnexocontrato = myGrid.jqGrid('getRowData', selectedRowId);



                                            ConsultaPermisoEjecutarTarea(idusu, 163, 3)
                                                .done(function (result) {
                                                    var data = result.d;
                                                    var no_tiene_permiso = data.split(":");
                                                    var no_tiene = parseInt(no_tiene_permiso[1]);
                                                    //!no_tiene
                                                    if (true) {


                                                        if (parseInt(objAnexocontrato.IdAnexoContrato)) {
                                                            if (parseInt(objAnexocontrato.IdTipoAnexoContrato) == 4) {
                                                                if (parseInt(objAnexocontrato.Estatus) == 1) {
                                                                    $('#lbletiqueta_anexo_contrato').html('CARTA DE TERMINACION DE OBRA');
                                                                    $('#txtfecha_param1').show();
                                                                    $('#txtvalor_param3_integer').hide();
                                                                    $('#txtvalor_param4_double').hide();
                                                                    $('#docto_anexo_contrato').show();
                                                                    $('#link_file_anexo_contrato').show();
                                                                    $('#lblfecha_terminacion_obra').html('Fecha de Terminación de Obra:');
                                                                    $('#txtfecha_param1').val(objAnexocontrato.Param2);
                                                                    $('#docto_anexo_contrato').val('');
                                                                    $('#link_file_anexo_contrato').text(objAnexocontrato.Param1);
                                                                    $('#lblvalor_param3_integer').html('');
                                                                    $('#lblvalor_param4_double').html('');
                                                                    $('#lbldocto_anexo').html('Docto. de Carta de Terminación');


                                                                    $('#lblidcontrato_2').html(objAnexocontrato.IdContrato);
                                                                    $('#lblanexo_contrato_2').html(objAnexocontrato.IdAnexoContrato);
                                                                    $('#lblidtipo_anexo_contrato_2').html(objAnexocontrato.IdTipoAnexoContrato);
                                                                    $('#lblidusu_2').html(idusu);
                                                                    $('#lblaccion_2').html('1');

                                                                    MostrarGestionAnexoContrato();
                                                                }
                                                                else {
                                                                    if (parseInt(objAnexocontrato.Estatus) == 0) {
                                                                        alert('La carta de terminación no es posible editarla porque se encuentra desactivada');
                                                                    }
                                                                    else {
                                                                        alert('La carta de terminación no es posible editarla porque se encuentra asignada a una obra');
                                                                    }
                                                                }

                                                            }
                                                            if (parseInt(objAnexocontrato.IdTipoAnexoContrato) == 5) {
                                                                $('#lbletiqueta_anexo_contrato').html('CARTA DE TERMINACION DE OBRA');
                                                                $('#txtfecha_param1').show();
                                                                $('#txtvalor_param3_integer').hide();
                                                                $('#txtvalor_param4_double').hide();
                                                                $('#docto_anexo_contrato').show();
                                                                $('#link_file_anexo_contrato').show();
                                                                $('#lblfecha_terminacion_obra').html('Fecha de Terminación de Obra:');
                                                                $('#lblvalor_param3_integer').html('');
                                                                $('#lblvalor_param4_double').html('');
                                                                $('#lbldocto_anexo').html('Docto. de Carta de Terminación');
                                                                $('#lblanexo_contrato_2').html('0');

                                                                $('#lblidcontrato_2').html(objAnexocontrato.IdContrato);
                                                                $('#lblanexo_contrato_2').html(objAnexocontrato.IdAnexoContrato);
                                                                $('#lblidtipo_anexo_contrato_2').html(objAnexocontrato.IdTipoAnexoContrato);
                                                                $('#lblidusu_2').html(idusu);
                                                                $('#lblaccion_2').html('1');

                                                                MostrarGestionAnexoContrato();
                                                            }

                                                        } else {
                                                            alert('Seleccione un anexo de contrato...');
                                                        }

                                                    } else {
                                                        alert('El usuario ' + idusu + ' no cuenta con el permiso para capturar anexos de contrato.');
                                                    }
                                                })
                                                .fail(function (xhr) {
                                                    console.log(xhr.responseText);
                                                    alert("Falló consultar permiso de ejecución de tarea.");
                                                });
                                        },
                                        position: "last",
                                        title: "Alta de Anexo de Contrato",
                                        cursor: "pointer"
                                    })


                                .navButtonAdd("#" + pager_id,
                                    {
                                        caption: "VerDocAnexo",
                                        buttonicon: "ui-icon-document",
                                        onClickButton: function () {
                                            var myGrid = $("#" + subgrid_table_id);

                                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                            var idanexo_contrato = myGrid.jqGrid('getCell', selectedRowId, 'IdAnexoContrato');
                                            var nom_docto = myGrid.jqGrid('getCell', selectedRowId, 'Param1');

                                            if (idanexo_contrato) {

                                                AbreVisorDocto(nom_docto);
                                            }
                                            else {
                                                alert('Selcciona un anexo de contrato...');
                                            }
                                        },
                                        position: "last",
                                        title: "VerDoctoAnexo",
                                        cursor: "pointer"
                                    })

                            /* .navButtonAdd("#" + pager_id,
                                {
                                  caption: "ActPagos",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                  var myGrid = $("#" + subgrid_table_id);
                                  selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                  var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                  var coo_clv = myGrid.jqGrid('getCell', selectedRowId, 'coopid');
                                  var obr_clv_txt = obra.obr_clv;

                                  if (fid) {
                                     ActualizacionPagosCoop(fid, obra.ClvObra, obr_clv_txt, coo_clv, idusu);
                                  }
                                  else {
                                     alert('Es necesario que selecciones un cooperador')
                                  }
                                },
                                  position: "last",
                                  title: "Cooperadores",
                                  cursor: "pointer"
                                })*/


                        }

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaContrato",
                            id: "alta_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContrato = myGrid.jqGrid('getRowData', selectedRowId);
                                GestionContrato(objContrato, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditContrato",
                            id: "edit_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContrato = myGrid.jqGrid('getRowData', selectedRowId);


                                if (objContrato.idContrato) {
                                    if (objContrato.Estatus == '1') {
                                        GestionContrato(objContrato, 1);
                                    } else {
                                        if (objContrato.Estatus == '0') {
                                            alert('El contrato seleccionado ha sido deshabilitado y no es posible editarlo')
                                        }
                                        if (objContrato.Estatus == '4') {
                                            alert('El contrato seleccionado se encuentra referenciado a un proceso de obra y no es posible editarlo')
                                        }
                                    }
                                }
                                else {
                                    alert("Selecciona un Contrato...");
                                }

                            },
                            position: "last",
                            title: "EditarContrato",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "DesactivarContrato",
                            id: "desactivar_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContrato = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContrato.idContrato) {
                                    if (objContrato.Estatus == 1) {
                                        GestionContrato(objContrato, 2);
                                    } else {
                                        if (objContrato.Estatus == '0') {
                                            alert('El contrato seleccionado se encuentra deshabilitado')
                                        } else {
                                            if (objContrato.Estatus == '4') {
                                                alert('El contrato seleccionado se encuentra referenciado a un proceso de obra y NO es posible deshabilitarlo')
                                            }
                                        }
                                    }
                                }
                                else {
                                    alert("Selecciona un Contrato...");
                                }
                            },
                            position: "last",
                            title: "DesactContrato",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "ActivarContrato",
                            id: "activar_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContrato = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContrato.idContrato) {
                                    if (objContrato.Estatus == 0) {
                                        GestionContrato(objContrato, 3);
                                    }
                                    else {
                                        if (objContrato.Estatus == '1') {
                                            alert('El contrato seleccionado se encuentra habilitado')
                                        } else {
                                            if (objContrato.Estatus == '4') {
                                                alert('El contrato seleccionado se encuentra referenciado a un proceso de obra, por lo tanto se encuentra habilitado.')
                                            }
                                        }
                                    }
                                }
                                else {
                                    alert("Selecciona un Contrato...");
                                }


                            },
                            position: "last",
                            title: "ActivarContrato",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "VerDocto",
                            id: "VerDocto",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContrato = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContrato.Dcto_Contrato) {
                                    AbreVisorDocto(objContrato.Dcto_Contrato);

                                }
                                else {
                                    alert("Selecciona una Contrato...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        });;

            }

            /* Es una extensión de funciones para el objeto jqgrid, sirve para dar formato a una celda de acuerdo a su valor. importante poner la propiedad editable: true en la columna correspondiente para que pueda cambiar */

            jQuery.extend($.fn.fmatter, {
                EstatusContrato: function (cellvalue, options, rowdata) {
                    var estatus_contrato = '';
                    var x = cellvalue;
                    if (rowdata[21] == '1') {
                        estatus_contrato = 'ACTIVO';
                    }
                    if (rowdata[21] == '0') {
                        estatus_contrato = 'INHABILITADO';
                    }
                    if (rowdata[21] == '4') {
                        estatus_contrato = 'REFERENCIADO';
                    }
                    return estatus_contrato;
                }
            });


            function ObtenerFiltro() {


                var num_contrato = $('#txtnum_contrato_q').val();
                if (num_contrato.length <= 0 || num_contrato.length > 30) {
                    num_contrato = "NULL";
                }

                var nom_contratista = $('#txtnom_contratista_q').val();
                if (nom_contratista.length <= 0 || nom_contratista.length > 30) {
                    nom_contratista = "NULL";
                }


                var rfc_contratista = $('#txtrfc_contratista_q').val();
                if (rfc_contratista.length <= 0 || rfc_contratista.length > 13) {
                    rfc_contratista = "NULL";
                }


                var filtro = num_contrato + ',' + nom_contratista + ',' + rfc_contratista + ',';
                return filtro;
            }


            function Buscar_Contrato(idusu) {
                MostrarContrato(idusu, ObtenerFiltro());
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




                $(".buscar_contrato").click(function () {
                    Buscar_Contrato(idusu);
                });

                $(".alta_contrato").click(function () {
                    GestionContrato(0, 0);
                });

                $("#bodegadatos").data("idusu", idusu);

                $(".posicion_boton_cancelar_contrato").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_contrato").click(function (e) {
                    EjecutarAccionContrato();
                });


                $(".posicion_boton_accion_anexo_contrato").click(function (e) {
                    EjecutarAccionAnexoContrato();
                });




                $(".posicion_boton_accion_tipo_anexo_contrato").click(function (e) {

                    $('#mask, .window').hide();
                    var tipo_anexo_contrato_sel = parseInt($('#lsttipo_anexo_contrato').val());

                    $('#lblidcontrato_2').html($('#lblidcontrato_1').html());
                    $('#lblidtipo_anexo_contrato_2').html(tipo_anexo_contrato_sel);
                    $('#lblidusu_2').html($("#bodegadatos").data("idusu"));
                    $('#lblaccion_2').html($('#lblaccion_1').html());

                    if (tipo_anexo_contrato_sel == 4) {

                        RevisaSiExisteCartaTerminacion($('#lblidcontrato_2').html(), 3)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('No es posible capturar una Carta de Terminación más, porque existe una carta de terminación registrada.');

                                } else {
                                    $('#lbletiqueta_anexo_contrato').html('CARTA DE TERMINACION DE OBRA');

                                    $('#txtfecha_param1').show();
                                    $('#txtvalor_param3_integer').hide();
                                    $('#txtvalor_param4_double').hide();
                                    $('#docto_anexo_contrato').show();
                                    $('#link_file_anexo_contrato').show();

                                    $('#lblfecha_terminacion_obra').html('Fecha de Terminación de Obra:');
                                    $('#lblvalor_param3_integer').html('');
                                    $('#lblvalor_param4_double').html('');
                                    $('#lbldocto_anexo').html('Docto. de Carta de Terminación');

                                    $('#lblanexo_contrato_2').html('0');
                                    $('#txtfecha_param1').val('');
                                    $('#link_file_anexo_contrato').text('');


                                    MostrarGestionAnexoContrato();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar el Contrato solicitado");
                            })

                    }


                    if (tipo_anexo_contrato_sel == 5) {

                        $('#lbletiqueta_anexo_contrato').html('AMPLIACION DE CONTRATO');

                        $('#txtfecha_param1').hide();
                        $('#txtvalor_param3_integer').hide();
                        $('#txtvalor_param4_double').hide();
                        $('#docto_anexo_contrato').hide();
                        $('#link_file_anexo_contrato').hide();

                        $('#lblfecha_terminacion_obra').html('Fecha de Ampliación de Contrato:');
                        $('#lblvalor_param3_integer').html('');
                        $('#lblvalor_param4_double').html('');
                        $('#lbldocto_anexo').html('Docto. de Ampliación de Contrato:');

                    }



                });


                $(".posicion_boton_cancelar_tipo_anexo_contrato, .posicion_boton_cancelar_anexo_contrato").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });



                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

                $('#verarchivo_contrato').click(function () {
                    var nom_archivo = $('#archivo').text()
                    if (nom_archivo != '' || nom_archivo != 'null') {
                        AbreVisorDocto(nom_archivo);
                    }
                });

                $(".verarchivo_anexo_contrato").click(function (e) { //Ver documento                   
                    var nom_archivo = $("#link_file_anexo_contrato").text();
                    if (nom_archivo != '' || nom_archivo != 'null') {
                        AbreVisorDocto(archivo);
                    }
                });


                $('.numbersOnly').keyup(function () {

                    var preg = /^([0-9]+\.?[0-9]{0,2})$/;
                    if (preg.test(this.value) === false) {
                        this.value = '0';
                    }
                });







            });



            function RevisaSiExisteCartaTerminacion(idcontrato, accion) {

                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceContrato.asmx/GetContrato_q",
                    data: "{'idcontrato':'" + idcontrato + "','idaccion':'" + accion + "'}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function RegistrarContratoBD(objContrato) {

                var stringData = JSON.stringify(objContrato);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceContrato.asmx/GuardarContrato",
                    data: "{objContrato:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };


            function RegAnexoContrato_BD(objAnexocontrato) {

                var stringData = JSON.stringify(objAnexocontrato);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceAnexoContrato.asmx/GuardarAnexoContrato_BD",
                    data: "{objAnexoContrato:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionContrato() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                var usu_cre_contrato = idusu;

                var accion = parseInt($("#lblaccion_contrato").html());
                var objContrato = {
                    "idcontrato": 0,
                    "num_contrato": '',
                    "num_contrato_limpio": '',
                    "obs_contrato": '',
                    "monto_contrato_sin_iva": 0,
                    "monto_contrato": 0,
                    "idcontratista": 0,
                    "iva_contrato": 0,
                    "fec_contrato": '01/01/1900',
                    "fec_ini_contrato": '01/01/1900',
                    "fec_fin_contrato": '01/01/1900',
                    "fec_prorroga": '01/01/1900',
                    "anticipo": 0,
                    "docto_contrato": '',
                    "fec_cre": hoy,
                    "fec_mod": hoy,
                    "usu_cre": idusu,
                    "usu_mod": idusu,
                    "idtipoasignacion": 0,
                    "cestatus": 0
                }


                if (accion == 0) { /*Registrar contrato*/
                    if (ValidarDatosContrato()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objContrato.cestatus = 1;
                        objContrato.accion = 0;
                        objContrato.num_contrato = $("#txtnum_contrato").val();
                        objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();
                        objContrato.obs_contrato = $("#txtobserv_contrato").val();
                        objContrato.monto_contrato_sin_iva = $("#txtmonto_sin_iva").val();
                        objContrato.monto_contrato = $("#txtmonto_con_iva").val();
                        objContrato.idcontratista = $("#lstcontratista").val();
                        objContrato.iva_contrato = $("#txtiva").val();
                        objContrato.fec_contrato = ConvertirCadenaToFecha($("#txtfec_contrato").val());
                        objContrato.fec_ini_contrato = ConvertirCadenaToFecha($("#txtfec_ini_contrato").val());
                        objContrato.fec_fin_contrato = ConvertirCadenaToFecha($("#txtfec_fin_contrato").val());
                        objContrato.fec_prorroga = ConvertirCadenaToFecha($("#txtfec_prorroga").val());
                        objContrato.anticipo = $("#txtanticipo").val();
                        objContrato.docto_contrato = $("#lblnum_contrato_limpio").html() + '.pdf';
                        objContrato.idtipoasignacion = $("#lsttasignacion").val();


                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = $.trim(arr[1]);
                                    if (error == '0') {
                                        ValidacionGuardadoArchivo($("#file1").get(0).files, objContrato.docto_contrato);
                                        alert('El contrato con id: ' + arr[3] + ' ha sido creado satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible guardar el contrato creado");
                            })
                    }
                }

                if (accion == 1) {
                    if (ValidarDatosContrato()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objContrato.cestatus = 1;
                        objContrato.idcontrato = $("#lblidcontrato").html();
                        objContrato.accion = 1;
                        objContrato.num_contrato = $("#txtnum_contrato").val();
                        objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();

                        objContrato.obs_contrato = $("#txtobserv_contrato").val();
                        objContrato.monto_contrato_sin_iva = $("#txtmonto_sin_iva").val();
                        objContrato.monto_contrato = $("#txtmonto_con_iva").val();
                        objContrato.idcontratista = $("#lstcontratista").val();
                        objContrato.iva_contrato = $("#txtiva").val();
                        objContrato.fec_contrato = ConvertirCadenaToFecha($("#txtfec_contrato").val());
                        objContrato.fec_ini_contrato = ConvertirCadenaToFecha($("#txtfec_ini_contrato").val());
                        objContrato.fec_fin_contrato = ConvertirCadenaToFecha($("#txtfec_fin_contrato").val());
                        objContrato.fec_prorroga = ConvertirCadenaToFecha($("#txtfec_prorroga").val());
                        objContrato.anticipo = $("#txtanticipo").val();
                        objContrato.docto_contrato = $("#lblnum_contrato_limpio").html() + '.pdf';
                        objContrato.idtipoasignacion = $("#lsttasignacion").val();


                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = $.trim(arr[1]);
                                    if (error == '0') {
                                        ValidacionGuardadoArchivo($("#file1").get(0).files, objContrato.docto_contrato);
                                        alert('El contrato con id: ' + arr[3] + ' ha sido modificado satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible ejecutar la edición del contrato solicitado");
                            })
                    }

                }

                if (accion == 2) {
                    objContrato.cestatus = 0;
                    objContrato.accion = 2;
                    objContrato.idcontrato = parseInt($("#lblidcontrato").html());
                    objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();
                    var resp = confirm('¿Desea desactivar el Contrato: ' + objContrato.num_contrato_limpio + '?');
                    if (resp) {
                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Contrato con id: ' + arr[3] + ' ha sido desactivado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar el Contrato solicitado");
                            })
                    }

                }

                if (accion == 3) {
                    objContrato.cestatus = 0;
                    objContrato.accion = 3;
                    objContrato.idcontrato = parseInt($("#lblidcontrato").html());
                    objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();
                    var resp = confirm('¿Desea activar el Contrato: ' + objContrato.num_contrato_limpio + '?');
                    if (resp) {
                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Contrato con id: ' + arr[3] + ' ha sido activado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar el Contrato solicitado");
                            })
                    }

                }

            }


            function EjecutarAccionAnexoContrato() {


                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());


                var accion = parseInt($("#lblaccion_2").html());
                var idusu = parseInt($("#lblidusu_2").html());
                var idcontrato = parseInt($("#lblidcontrato_2").html());
                var idtipo_anexo_contrato = parseInt($("#lblidtipo_anexo_contrato_2").html());


                var objAnexoContrato = {
                    "idcontrato": idcontrato,
                    "idanexo_contrato": 0,
                    "idtipo_anexo_contrato": idtipo_anexo_contrato,
                    "docto_param1": '',
                    "fecha_param2": '01/01/1900',
                    "valor_param3": 0,
                    "valor_param4": 0,
                    "usu_cre": idusu,
                    "usu_mod": idusu,
                    "fec_cre": hoy,
                    "fec_mod": hoy,
                    "cactivo": 0,
                    "accion": 0
                }


                if (accion == 0) { /*Registrar contrato*/
                    if (ValidarDatosAnexoContrato()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objAnexoContrato.cactivo = 1;
                        objAnexoContrato.accion = 0;
                        objAnexoContrato.fecha_param2 = ConvertirCadenaToFecha($("#txtfecha_param1").val());
                        objAnexoContrato.docto_param1 = objAnexoContrato.idcontrato.toString() + '_Carta_Term' + '.pdf';
                        objAnexoContrato.valor_param3 = $("#txtvalor_param3_integer").val();
                        objAnexoContrato.valor_param4 = $("#txtvalor_param4_double").val();


                        RegAnexoContrato_BD(objAnexoContrato)
                            .done(function (r) {
                                var resp = r.d;
                                var arr = resp.split(':');

                                var error = $.trim(arr[1]);
                                if (error == '0') {
                                    ValidacionGuardadoArchivo($("#docto_anexo_contrato").get(0).files, objAnexoContrato.docto_param1);
                                    alert('Los datos del anexo  ha sido registrado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                } else {
                                    alert(cadena);
                                }

                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible guardar el anexo de contrato creado");
                            })
                    }
                }

                if (accion == 1) {
                    if (ValidarDatosAnexoContrato()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objAnexoContrato.cactivo = 1;
                        objAnexoContrato.accion = 1;
                        objAnexoContrato.fecha_param2 = ConvertirCadenaToFecha($("#txtfecha_param1").val());
                        objAnexoContrato.valor_param3 = parseInt($("#txtvalor_param3_integer").val());
                        objAnexoContrato.valor_param4 = parseFloat($("#txtvalor_param4_double").val());
                        objAnexoContrato.idanexo_contrato = parseInt($("#lblanexo_contrato_2").html());
                        objAnexoContrato.docto_param1 = $("#lblidcontrato_2").html() + '_Carta_Term' + '.pdf';

                        RegAnexoContrato_BD(objAnexoContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                var arr = cadena.split(':');
                                var error = $.trim(arr[1]);
                                if (error == '0') {
                                    ValidacionGuardadoArchivo($("#docto_anexo_contrato").get(0).files, objAnexoContrato.docto_param1);
                                    alert('Los datos del anexo han sido modificado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                } else {
                                    alert(cadena);
                                }

                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible guardar el anexo de contrato creado");
                            })
                    }

                }

                if (accion == 2) {
                    objContrato.cestatus = 0;
                    objContrato.accion = 2;
                    objContrato.idcontrato = parseInt($("#lblidcontrato").html());
                    objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();
                    var resp = confirm('¿Desea desactivar el Contrato: ' + objContrato.num_contrato_limpio + '?');
                    if (resp) {
                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Contrato con id: ' + arr[3] + ' ha sido desactivado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible desactivar el Contrato solicitado");
                            })
                    }

                }

                if (accion == 3) {
                    objContrato.cestatus = 0;
                    objContrato.accion = 3;
                    objContrato.idcontrato = parseInt($("#lblidcontrato").html());
                    objContrato.num_contrato_limpio = $("#lblnum_contrato_limpio").text();
                    var resp = confirm('¿Desea activar el Contrato: ' + objContrato.num_contrato_limpio + '?');
                    if (resp) {
                        RegistrarContratoBD(objContrato)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Contrato con id: ' + arr[3] + ' ha sido activado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar el Contrato solicitado");
                            })
                    }

                }

            }




            function ValidarDatosAnexoContrato() {

                var valid = true;
                var idtipo_anexo_contrato = parseInt($("#lblidtipo_anexo_contrato_2").html());

                if (idtipo_anexo_contrato == 4) { /*Validar los parametros para una carta de terminación*/

                    var fec_terminancion_obra = $("#txtfecha_param1").val();
                    if ($.trim(fec_terminancion_obra).length == 0 || fec_terminancion_obra == '' || $.trim(fec_terminancion_obra).length > 10) {
                        alert("No es correcta la fecha de terminación de la obra.");
                        valid = false;
                    }

                    var valor_param3 = $("#txtvalor_param3_integer").val();

                    if ($.trim(valor_param3).length == 0 || valor_param3 == '') {
                        $("#txtvalor_param3_integer").val('0');
                        valid = true;
                    }

                    var valor_param4 = $("#txtvalor_param4_double").val();

                    if ($.trim(valor_param4).length == 0 || valor_param4 == '') {
                        $("#txtvalor_param4_double").val('0');
                        valid = true;
                    }


                    if (valid) {
                        if ($("#docto_anexo_contrato").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                            if (ValidarArchivo($("#docto_anexo_contrato")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                valid = true;
                            }
                            else {
                                $("#docto_anexo_contrato").val("");
                                valid = false;
                            }
                        }
                        else {
                            if ($("#link_file_anexo_contrato").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                valid = true;
                            }
                            else {
                                alert("No se ha capturado el documento de la Carta de Terminación de la Obra ");
                                valid = false;
                            }
                        }
                    }
                }

                return valid;
            }



            function ValidarDatosContrato() {

                var fec_contrato = $("#txtfec_contrato").val();
                var fec_ini_contrato = $("#txtfec_ini_contrato").val();
                var fec_fin_contrato = $("#txtfec_ini_contrato").val();
                var fec_prorroga = $("#txtfec_prorroga").val();

                var valid;

                if ($.trim(fec_contrato).length == 0 || fec_contrato == '' || $.trim(fec_contrato).length > 10) {
                    $("#txtfec_contrato").val('01/01/1900');
                }

                if ($.trim(fec_ini_contrato).length == 0 || fec_ini_contrato == '' || $.trim(fec_ini_contrato).length > 10) {
                    $("#txtfec_ini_contrato").val('01/01/1900');
                }

                if ($.trim(fec_fin_contrato).length == 0 || fec_fin_contrato == '' || $.trim(fec_fin_contrato).length > 10) {
                    $("#txtfec_ini_contrato").val('01/01/1900');
                }

                if ($.trim(fec_prorroga).length == 0 || fec_prorroga == '' || $.trim(fec_prorroga).length > 10) {
                    $("#txtfec_prorroga").val('01/01/1900')
                }


                if ($("#lblnum_contrato_limpio").html().length > 0) {
                    valid = true;
                } else {
                    valid = false;
                    alert('El número de contrato es erróneo.')
                }

                if (valid) {
                    if ($("#file1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                        if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                            valid = true;
                        }
                        else {
                            $("#file1").val("");
                            valid = false;
                        }
                    }
                    else {
                        if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                            valid = true;
                        }
                        else {
                            alert("No se capturado el documento del contrato");
                            valid = false;
                        }
                    }
                }

                return valid;
            }



            function ValidacionGuardadoArchivo(archivo, nomarchivo) {
                GuardarArchivo(archivo, nomarchivo)
                    .done(function (result) {
                        console.log("Archivo " + nomarchivo + " guardado correctamente");
                    }).fail(function (result) {
                        alert("No fue posible guardar archivo de documento de identificación");
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


            function GestionContrato(objContrato, accion) {
                $("#lblaccion_contrato").html(accion);

                if (accion == 0) {  /*Alta de Accion*/
                    $("#txtnum_contrato").val('');
                    $("#lblnum_contrato_limpio").html('');
                    $("#txtmonto_con_iva").val('');
                    $("#txtmonto_sin_iva").val('');
                    $("#txtiva").val('');
                    $("#txtanticipo").val('');
                    $("#txtfec_contrato").val('');
                    $("#txtfec_ini_contrato").val('');
                    $("#txtfec_fin_contrato").val('');
                    $("#txtfec_prorroga").val('');
                    $("#txtobserv_contrato").val('');
                    $("#lblidcontrato").html(0);
                    $("#file1").val('');
                    $("#archivo").text('');
                    llenarTipoAsignacion(0, accion)
                    llenarContratista(0, accion)
                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        $("#txtnum_contrato").val(objContrato.NumContratoReal);
                        $("#txtnum_contrato").prop('disabled', true);
                        $("#lblnum_contrato_limpio").html(objContrato.NumContrato);
                        $("#txtmonto_con_iva").val(objContrato.MontoContrato);
                        $("#txtmonto_sin_iva").val(objContrato.MontoContrato_SinIVA);
                        $("#txtiva").val(objContrato.IVA_Contrato);
                        $("#txtanticipo").val(objContrato.Anticipo);
                        $("#txtfec_contrato").val(objContrato.Fec_Contrato);
                        $("#txtfec_ini_contrato").val(objContrato.Fec_Ini_Contrato);
                        $("#txtfec_prorroga").val(objContrato.Fec_Prorroga);
                        $("#txtfec_fin_contrato").val(objContrato.Fec_Fin_Contrato);
                        $("#archivo").html(objContrato.Dcto_Contrato);
                        $("#lstcontratista").val(parseInt(objContrato.IdContratista));
                        $("#lsttasignacion").val(parseInt(objContrato.idTipoAsignacion));
                        $("#txtobserv_contrato").val(objContrato.Observ_Contrato);
                        $("#lblidcontrato").html(parseInt(objContrato.idContrato));


                        llenarTipoAsignacion(objContrato.idTipoAsignacion, 0);
                        llenarContratista(objContrato.IdContratista, 0);

                        if (accion == 2 || accion == 3) {
                            $("#txtetiqueta_tipo_asamblea").prop('disabled', true);
                            $("#txtdescripcion_tipo_asamblea").prop('disabled', true);
                            $("#txtmonto_con_iva").prop('disabled', true);
                            $("#txtmonto_sin_iva").prop('disabled', true);
                            $("#txtiva").prop('disabled', true);
                            $("#txtanticipo").prop('disabled', true);
                            $("#txtfec_contrato").prop('disabled', true);
                            $("#txtfec_ini_contrato").prop('disabled', true);
                            $("#txtfec_prorroga").prop('disabled', true);
                            $("#txtfec_fin_contrato").prop('disabled', true);
                            $("#file1").prop('disabled', true);
                            $("#lstcontratista").prop('disabled', true);
                            $("#lsttasignacion").prop('disabled', true);
                            $("#txtobserv_contrato").prop('disabled', true);

                        }
                        else {
                            $("#txtetiqueta_tipo_asamblea").prop('disabled', false);
                            $("#txtdescripcion_tipo_asamblea").prop('disabled', false);
                            $("#txtmonto_con_iva").prop('disabled', false);
                            $("#txtmonto_sin_iva").prop('disabled', false);
                            $("#txtiva").prop('disabled', false);
                            $("#txtanticipo").prop('disabled', false);
                            $("#txtfec_contrato").prop('disabled', false);
                            $("#txtfec_ini_contrato").prop('disabled', false);
                            $("#txtfec_prorroga").prop('disabled', false);
                            $("#txtfec_fin_contrato").prop('disabled', false);
                            $("#file1").prop('disabled', false);
                            $("#lstcontratista").prop('disabled', false);
                            $("#lsttasignacion").prop('disabled', false);
                            $("#txtobserv_contrato").prop('disabled', false);
                        }

                    }
                }
                MostrarModalContrato();
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

            function ConsultaPermisoEjecutarTarea(idusu, idtarea, idaccion) {
                return $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; utf-8',
                    url: "../../WebServices/WebServiceTarea.asmx/ConsultaPermisoTarea",
                    data: "{'idusu':'" + idusu + "','idtarea':'" + idtarea + "','idaccion':'" + idaccion + "'}"
                });
            }


            function MostrarModalContrato() {
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
                $("#dialogo_contrato").css('top', winH / 2 - $("#dialogo_contrato").height() / 2);
                $("#dialogo_contrato").css('left', winW / 2 - $("#dialogo_contrato").width() / 2);

                //transition effect
                $("#dialogo_contrato").fadeIn(2000);
            };


            function MostrarListaTipoAnexosContrato() {
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
                $("#dialogo_tipo_anexos_contrato").css('top', winH / 2 - $("#dialogo_tipo_anexos_contrato").height() / 2);
                $("#dialogo_tipo_anexos_contrato").css('left', winW / 2 - $("#dialogo_tipo_anexos_contrato").width() / 2);

                //transition effect
                $("#dialogo_tipo_anexos_contrato").fadeIn(2000);
            }



            function MostrarGestionAnexoContrato() {
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
                $("#dialogo_anexos_contrato").css('top', winH / 2 - $("#dialogo_anexos_contrato").height() / 2);
                $("#dialogo_anexos_contrato").css('left', winW / 2 - $("#dialogo_anexos_contrato").width() / 2);

                //transition effect
                $("#dialogo_anexos_contrato").fadeIn(2000);
            }







            function llenarTipoAsignacion(idasignacion, accion) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    data: "{'idasignacion':'" + idasignacion + "','accion':'" + accion + "'}",
                    url: "../../WebServices/WebServiceTipoAsignacion.asmx/GetTipoAsignacion",
                    /*url: "../../WebServices/WebServiceCoop.asmx/GetCoopSIFIDOC",*/
                    success: function (data) {
                        var elementos = 0;
                        $("#lsttasignacion").html('');
                        $(data.d).find("tipo_asignacion").each(function () {
                            var option = $(document.createElement('option'));
                            var idasignacion = $(this).find("idasignacion_r").text();
                            var etiqueta = $(this).find("etiqueta_r").text();

                            option.html(etiqueta);
                            option.val(idasignacion);
                            $("#lsttasignacion").append(option);
                        });
                        if (idasignacion > 0) { //
                            $("#lsttasignacion").val(idasignacion);
                        }

                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }

            function llenarContratista(idcontratista, accion) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    data: "{'idcontratista':'" + idcontratista + "','accion':'" + accion + "'}",
                    url: "../../WebServices/WebServiceContratista.asmx/GetContratista_q",
                    /*url: "../../WebServices/WebServiceCoop.asmx/GetCoopSIFIDOC",*/
                    success: function (data) {
                        var elementos = 0;
                        $("#lstcontratista").html('');
                        $(data.d).find("contratista").each(function () {
                            var option = $(document.createElement('option'));
                            var idcontratista = $(this).find("idcontratista_r").text();
                            var nombre = $(this).find("razonsoc_cont_r").text();
                            var rfc = $(this).find("rfc_cont_r").text();

                            option.html(nombre + ' || ' + rfc);
                            option.val(idcontratista);
                            $("#lstcontratista").append(option);
                        });
                        if (idcontratista > 0) { //
                            $("#lstcontratista").val(idcontratista);
                        }

                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }


            function llenarTipoAnexosContrato(idtipo_anexo_contrato) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    data: "{'idTipoAnexoContrato':'" + idtipo_anexo_contrato + "'}",
                    url: "../../WebServices/WebServiceTipoAnexoContrato.asmx/GetTipoAnexoContrato",
                    /*url: "../../WebServices/WebServiceCoop.asmx/GetCoopSIFIDOC",*/
                    success: function (data) {
                        var elementos = 0;
                        $("#lsttipo_anexo_contrato").html('');
                        $(data.d).find("tipo_anexo_contrato").each(function () {
                            var option = $(document.createElement('option'));
                            var idtipo_anexo_contratista = $(this).find("idtipo_anexo_contrato_r").text();
                            var etiqueta_anexo_contrato = $(this).find("etiqueta_anexo_r").text();

                            option.html(etiqueta_anexo_contrato);
                            option.val(idtipo_anexo_contratista);
                            $("#lsttipo_anexo_contrato").append(option);
                        });
                        if (idtipo_anexo_contrato > 0) { //
                            $("#lsttipo_anexo_contrato").val(idtipo_anexo_contrato);
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

        <label>Contrato:</label><input type="text" name="contrato" id="txtnum_contrato_q" style="width:250px"
            maxlength="120" /><br /><br />
        <label>RFC Contratista:</label><input type="text" name="contrato" id="txtrfc_contratista_q" style="width:250px"
            maxlength="13" /><br /><br />
        <label>Nombre Contratista:</label><input type="text" name="contrato" id="txtnom_contratista_q"
            style="width:300px" maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
            class="buscar_contrato">
            <== Buscar CONTRATO==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_contrato">
            <== Alta CONTRATO==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>


        <div id="boxes">
            <div id="dialogo_contrato" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="4" class="titulo_modulo">GESTION DE CONTRATO</td>
                        </tr>
                        <tr>
                            <td class="f">Num. Contrato:</td>
                            <td class="e"><input class="dato_captura" type="text" name="num_contrato"
                                    id="txtnum_contrato" size="26" maxlength="26"
                                    onkeyup="this.value=valida_alfanumericos(this.value);" /></td>
                            <td class="e"><label id="lblnum_contrato_limpio" /></td>
                        </tr>
                        <tr>
                            <td class="f">Monto con IVA:</td>
                            <td class="e"><input type="text" class="numbersOnly" name="monto_con_iva"
                                    id="txtmonto_con_iva" size="12" maxlength="15"
                                    onkeyup="asigna_valores_calculados(this.value);" /></td>
                            <td class="f">Monto sin IVA:</td>
                            <td class="e"><input type="text" class="numbersOnly" name="monto_sin_iva"
                                    id="txtmonto_sin_iva" size="12" maxlength="15" /></td>
                        </tr>
                        <tr>
                            <td class="f">IVA:</td>
                            <td class="e"><input type="text" class="numbersOnly" name="iva" id="txtiva" size="12"
                                    maxlength="15" /></td>
                            <td class="f">Anticipo:</td>
                            <td class="e"><input type="text" class="numbersOnly" name="anticipo" id="txtanticipo"
                                    size="12" maxlength="15" /></td>
                        </tr>
                        <tr>
                            <td class="f">Fecha Adjudicación:</td>
                            <td class="e"><input type="text" name="fec_contrato" id="txtfec_contrato" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                            <td class="f">Fecha Inicio Obra:</td>
                            <td class="e"><input type="text" name="fec_ini_contrato" id="txtfec_ini_contrato" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="f">Fecha Prorroga:</td>
                            <td class="e"><input type="text" name="fec_prorroga" id="txtfec_prorroga" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                            <td class="f">Fecha Fin Obra:</td>
                            <td class="e"><input type="text" name="fec_fin_contrato" id="txtfec_fin_contrato" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="f">Documento Contrato:</td>
                            <td class="e" colspan="3"><input type="file" id="file1" name="file" /> <a href="#"
                                    id="archivo" class="verarchivo_contrato"></a></td>
                        </tr>
                        <tr>
                            <td class="f">Contratista:</td>
                            <td class="e" colspan="3"><select class="select_captura" name="contratista"
                                    id="lstcontratista"></select></td>
                        </tr>
                        <tr>
                            <td class="f">Tipo Asignación:</td>
                            <td class="e" colspan="3"><select class="select_captura" name="tasignacion"
                                    id="lsttasignacion"></select></td>
                        </tr>
                        <tr>
                            <td class="f">Observaciones:</td>
                            <td class="e" colspan="3"><textarea name="observ_contrato" id="txtobserv_contrato"
                                    cols="100" rows="5"></textarea></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idContrato:</td>
                            <td class="columna_sistema"><label id="lblidcontrato" /></td>
                            <td>Accion:</td>
                            <td class="columna_sistema"><label id="lblaccion_contrato" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="boton_dialog"><a href="#"
                                    class="posicion_boton_accion_contrato">ACEPTAR</a></td>
                            <td colspan="2" class="boton_dialog"><a href="#"
                                    class="posicion_boton_cancelar_contrato">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="dialogo_tipo_anexos_contrato" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">TIPOS DE ANEXOS DE CONTRATO</td>
                        </tr>
                        <tr>
                            <td class="f">Tipo de Anexo de Contrato:</td>
                            <td class="e"><select class="select_captura" name="tipo_anexo_contrato"
                                    id="lsttipo_anexo_contrato"></select></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idContrato:</td>
                            <td class="columna_sistema"><label id="lblidcontrato_1" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>accion:</td>
                            <td class="columna_sistema"><label id="lblaccion_1" /></td>
                        </tr>
                        <tr>
                            <td class="boton_dialog"><a href="#"
                                    class="posicion_boton_accion_tipo_anexo_contrato">ACEPTAR</a></td>
                            <td class="boton_dialog"><a href="#"
                                    class="posicion_boton_cancelar_tipo_anexo_contrato">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="dialogo_anexos_contrato" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">ANEXOS DE CONTRATO</td>
                        </tr>
                        <tr>
                            <td colspan="2" class="titulo_modulo2"><label id="lbletiqueta_anexo_contrato" /></td>
                        </tr>
                        <tr>
                            <td class="f"><label id="lblfecha_terminacion_obra" /></td>
                            <td class="e"><input type="text" name="fec_contrato" id="txtfecha_param1" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="f"><label id="lblvalor_param3_integer" /></td>
                            <td class="e"><input class="numbersOnly" type="text" name="valor_param_3_integer"
                                    id="txtvalor_param3_integer" size="10" maxlength="10" /></td>
                        </tr>
                        <tr>
                            <td class="f"><label id="lblvalor_param4_double" /></td>
                            <td class="e"><input class="numbersOnly" type="text" name="valor_param_4_double"
                                    id="txtvalor_param4_double" size="10" maxlength="10" /></td>
                        </tr>
                        <tr>
                            <td class="f"><label id="lbldocto_anexo" /></td>
                            <td class="e"><input type="file" id="docto_anexo_contrato" name="file" /><a href="#"
                                    id="link_file_anexo_contrato" class="verarchivo_anexo_contrato"></a></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idContrato:</td>
                            <td class="columna_sistema"><label id="lblidcontrato_2" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idAnexoContrato:</td>
                            <td class="columna_sistema"><label id="lblanexo_contrato_2" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idTipoAnexoCont:</td>
                            <td class="columna_sistema"><label id="lblidtipo_anexo_contrato_2" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>idusu:</td>
                            <td class="columna_sistema"><label id="lblidusu_2" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>accion:</td>
                            <td class="columna_sistema"><label id="lblaccion_2" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td class="boton_dialog"><a href="#"
                                    class="posicion_boton_accion_anexo_contrato">ACEPTAR</a></td>
                            <td class="boton_dialog"><a href="#"
                                    class="posicion_boton_cancelar_anexo_contrato">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>