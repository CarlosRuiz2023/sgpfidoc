<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="adeudos_sin_det.aspx.vb"
    Inherits="Admin_procesos_adeudos_sin_det" %>
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



                function ObtenerFiltro() {
                    var nomcalle = $('#txtnomcalle').val();
                    if (nomcalle.length <= 0 || nomcalle.length > 20) {
                        nomcalle = "NULL";
                    }
                    var num_obra = $('#txtnumobra').val();
                    if (num_obra.length <= 0 || !$.isNumeric(num_obra)) {
                        num_obra = "0";
                    }
                    var filtro = num_obra + "," + nomcalle + ",";
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



                function Buscar_obra(filtro) {

                    var idcoop;

                    if ($("#grid")[0].grid) {
                        $.jgrid.gridUnload("#grid");
                        //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    }

                    if (filtro == 'NULL,NULL,NULL,NULL,NULL,NULL,0') {
                        alert("No se ha capturado nigún parámetro de búsqueda");
                    }
                    else {

                        $("#grid").jqGrid(
                            {
                                datatype: function () {
                                    $.ajax(
                                        {
                                            url: "../../WebServices/WebServiceObras.asmx/GetObra2_psql", //PageMethod
                                            data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                                "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                                "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                                "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                                "','pFiltro':'" + filtro + "'}", //PageMethod Parametros de entrada
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
                                },
                                jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                                {
                                    root: "Items",
                                    page: "CurrentPage",
                                    total: "PageCount",
                                    records: "RecordCount",
                                    repeatitems: true,
                                    cell: "row",
                                    id: "obr_clv_int"
                                },
                                colModel: [
                                    {
                                        index: 'obr_clv', width: 100, align: 'Center',
                                        name: 'Obra_Antes', hidden: true
                                    },
                                    {
                                        index: 'obr_call', width: 300, align: 'Center',
                                        name: 'Calle'
                                    },
                                    {
                                        index: 'obr_col', width: 100, align: 'Center',
                                        name: 'Colonia', hidden: true
                                    },
                                    {
                                        index: 'obr_mts', width: 100, align: 'Center',
                                        name: 'MetrosTot', hidden: true
                                    },
                                    {
                                        index: 'obr_cost', width: 100, align: 'Center',
                                        name: 'CostoMto', hidden: true
                                    },
                                    {
                                        index: 'obr_stat', width: 200, align: 'center',
                                        name: 'StatObrSIFIDOC', hidden: true
                                    },
                                    {
                                        index: 'obr_int', width: 300, align: 'center',
                                        name: 'TipoObra', hidden: true
                                    },

                                    {
                                        index: 'obr_fecha', width: 350, align: 'center',
                                        name: 'FechaObra', hidden: true
                                    },
                                    {
                                        index: 'obr_cost_total', width: 300, align: 'center',
                                        name: 'CostoTotal', hidden: true
                                    },
                                    {
                                        index: 'obr_inc', width: 100, align: 'center',
                                        name: 'obr_inc', hidden: true
                                    },
                                    {
                                        index: 'obr_contab', width: 220, align: 'center',
                                        name: 'obr_contab', hidden: true
                                    },
                                    {
                                        index: 'obr_sis', width: 135, align: 'center',
                                        name: 'Sistema', hidden: true
                                    },
                                    {
                                        index: 'col_nom', width: 220, align: 'center',
                                        name: 'col_nom'
                                    },
                                    {
                                        index: 'obr_tramo', width: 300, align: 'center',
                                        name: 'obr_tramo'
                                    },
                                    {
                                        index: 'obr_digito', width: 135, align: 'center',
                                        name: 'obr_digito', hidden: true
                                    },
                                    {
                                        index: 'obr_programa', width: 220, align: 'center',
                                        name: 'obr_programa', hidden: true
                                    },
                                    {
                                        index: 'obr_cuentac', width: 220, align: 'center',
                                        name: 'obr_cuentac', hidden: true
                                    },
                                    {
                                        index: 'obr_digagr', width: 220, align: 'center',
                                        name: 'obr_digagr', hidden: true
                                    },
                                    {
                                        index: 'obr_fecinip', width: 220, align: 'center',
                                        name: 'obr_fecinip', hidden: true
                                    },
                                    {
                                        index: 'obr_fecvenp', width: 220, align: 'center',
                                        name: 'obr_fecvenp', hidden: true
                                    },
                                    {
                                        index: 'obr_npago', width: 220, align: 'center',
                                        name: 'obr_npago', hidden: true
                                    },
                                    {
                                        index: 'obr_numera', width: 220, align: 'center',
                                        name: 'obr_numera', hidden: true
                                    },
                                    {
                                        index: 'obr_opergob', width: 220, align: 'center',
                                        name: 'obr_opergob', hidden: true
                                    },
                                    {
                                        index: 'obr_ubic', width: 220, align: 'center',
                                        name: 'obr_ubic', hidden: true
                                    },
                                    {
                                        index: 'obr_tipo', width: 220, align: 'center',
                                        name: 'TipoObraChar', hidden: true
                                    },
                                    {
                                        index: 'obr_fec_ini_proc', width: 220, align: 'center',
                                        name: 'FecIniProc', hidden: true
                                    },
                                    {
                                        index: 'obr_fec_ini_cob', width: 220, align: 'center',
                                        name: 'FecCob', hidden: true
                                    },
                                    {
                                        index: 'obr_fec_pub1', width: 220, align: 'center',
                                        name: 'FecPub1', hidden: true
                                    },
                                    {
                                        index: 'obr_fec_pub2', width: 220, align: 'center',
                                        name: 'FecPub2', hidden: true
                                    },
                                    {
                                        index: 'evid_pub1', width: 220, align: 'center',
                                        name: 'EvidPub1', hidden: true
                                    },
                                    {
                                        index: 'evid_pub2', width: 220, align: 'center',
                                        name: 'EvidPub2', hidden: true
                                    },
                                    {
                                        index: 'obr_clv_int', width: 220, align: 'center',
                                        name: 'ClvObr', hidden: true
                                    },
                                    {
                                        index: 'col_clv2', width: 220, align: 'center',
                                        name: 'ClvCol', hidden: true
                                    },
                                    {
                                        index: 'obr_tipo_descrip', width: 150, align: 'center',
                                        name: 'TipoObra'
                                    },
                                    {
                                        index: 'obr_prog2', width: 220, align: 'center',
                                        name: 'ClvProg', hidden: true
                                    },
                                    {
                                        index: 'obr_programa2', width: 120, align: 'center',
                                        name: 'Prog (Munic-Coops)'
                                    },
                                    {
                                        index: 'obr_clv2', width: 150, align: 'center',
                                        name: 'ClvObra2'
                                    },
                                    {
                                        index: 'obr_status', width: 220, align: 'center',
                                        name: 'ClvEstatusObra', hidden: true
                                    },
                                    {
                                        index: 'obr_estatus2', width: 100, align: 'center',
                                        name: 'EstatusObra'
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
                                sortname: "obr_clv_int", //login SortColumn
                                sortorder: "asc", //login SortOrder.
                                width: "1700",
                                height: "800",
                                caption: "OBRAS",
                                subGrid: true,
                                subGridBeforeExpand: function (subgrid_id, row_id) {
                                    var myGrid = $('#grid');
                                    var obra = myGrid.jqGrid('getRowData', row_id);;
                                    idobra = parseInt(obra.ClvObr);
                                    var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                                    var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                                    idusu = arrusuario[2];
                                },
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
                                                        url: "../../WebServices/WebServiceCoop.asmx/GetCoops2_psql", //PageMethod
                                                        data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                            "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                            "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                            "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                            "','obr_clv_int':'" + idobra + "'}", //PageMethod Parametros de entrada
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
                                                id: "coo_clv2"
                                            },
                                            colModel: [{
                                                index: 'coo_clv', width: 100, align: 'Center',
                                                name: 'ObraCoop', hidden: true
                                            },
                                            {
                                                index: 'coo_clv1', width: 25, align: 'Center',
                                                name: 'Coop'
                                            },
                                            {
                                                index: 'coo_pat', width: 100, align: 'Center',
                                                name: 'coo_pat'
                                            },
                                            {
                                                index: 'coo_mat', width: 100, align: 'Center',
                                                name: 'coo_mat'
                                            },
                                            {
                                                name: 'coo_nom', index: 'coo_nom', width: 100,
                                                align: 'center', editable: false, sortable: false
                                            },
                                            {
                                                index: 'coo_nombre', width: 200, align: 'center',
                                                name: 'coo_nombre'
                                            },
                                            {
                                                index: 'coo_nof', width: 50, align: 'center',
                                                name: 'coo_nof'
                                            },
                                            {
                                                index: 'coo_pred', width: 60, align: 'center',
                                                name: 'coo_pred'
                                            },
                                            {
                                                index: 'coo_mts', width: 50, align: 'center',
                                                name: 'coo_mts'
                                            },
                                            {
                                                index: 'coo_call', width: 40, align: 'center',
                                                name: 'coo_call', hidden: true
                                            },
                                            {
                                                index: 'coo_num', width: 40, align: 'center',
                                                name: 'coo_num', hidden: true
                                            },
                                            {
                                                index: 'coo_col', width: 40, align: 'center',
                                                name: 'coo_col', hidden: true
                                            },
                                            {
                                                index: 'coo_ciu', width: 40, align: 'center',
                                                name: 'coo_ciu', hidden: true
                                            },
                                            {
                                                index: 'coo_est', width: 40, align: 'center',
                                                name: 'coo_est', hidden: true
                                            },
                                            {
                                                index: 'coo_cp', width: 40, align: 'center',
                                                name: 'coo_cp', hidden: true
                                            },
                                            {
                                                index: 'coo_tel', width: 40, align: 'center',
                                                name: 'coo_tel', hidden: true
                                            },
                                            {
                                                index: 'coo_lote', width: 40, align: 'center',
                                                name: 'coo_lote', hidden: true
                                            },
                                            {
                                                index: 'coo_ant', width: 40, align: 'center',
                                                name: 'EstPresup', hidden: true
                                            },
                                            {
                                                index: 'coo_npag', width: 40, align: 'center',
                                                name: 'coo_npag', hidden: true
                                            },
                                            {
                                                index: 'coo_venc1', width: 40, align: 'center',
                                                name: 'coo_venc1', hidden: true
                                            },
                                            {
                                                index: 'coo_obr', width: 30, align: 'center',
                                                name: 'coo_obr', hidden: true
                                            },
                                            {
                                                index: 'coo_inc', width: 40, align: 'center',
                                                name: 'coo_inc', hidden: true
                                            },
                                            {
                                                index: 'coo_pagos', width: 40, align: 'center',
                                                name: 'coo_pagos', hidden: true
                                            },
                                            {
                                                index: 'coo_cargos', width: 40, align: 'center',
                                                name: 'coo_cargos', hidden: true
                                            },
                                            {
                                                index: 'coo_gto_req', width: 40, align: 'center',
                                                name: 'coo_gto_req', hidden: true
                                            },
                                            {
                                                index: 'coo_gto_ejec', width: 30, align: 'center',
                                                name: 'coo_gto_ejec', hidden: true
                                            },
                                            {
                                                index: 'coo_notificado', width: 30, align: 'center',
                                                name: 'coo_notificado', hidden: true
                                            },
                                            {
                                                index: 'coo_requerido', width: 30, align: 'center',
                                                name: 'coo_requerido', hidden: true
                                            },
                                            {
                                                index: 'coo_ejecutado', width: 30, align: 'center',
                                                name: 'coo_ejecutado', hidden: true
                                            },
                                            {
                                                index: 'coo_ultimoaviso', width: 30, align: 'center',
                                                name: 'coo_ultimoaviso', hidden: true
                                            },
                                            {
                                                index: 'coo_propx', width: 30, align: 'center',
                                                name: 'coo_propx', hidden: true
                                            },
                                            {
                                                index: 'coo_rfc', width: 30, align: 'center',
                                                name: 'coo_rfc', hidden: true
                                            },
                                            {
                                                index: 'coo_fiscal', width: 30, align: 'center',
                                                name: 'coo_fiscal', hidden: true
                                            },
                                            {
                                                index: 'coo_razonsoc', width: 30, align: 'center',
                                                name: 'coo_razonsoc', hidden: true
                                            },
                                            {
                                                index: 'coo_grupo', width: 30, align: 'center',
                                                name: 'coo_grupo', hidden: true
                                            },
                                            {
                                                index: 'coo_fecgrupo', width: 30, align: 'center',
                                                name: 'coo_fecgrupo', hidden: true
                                            },
                                            {
                                                index: 'coo_dec', width: 30, align: 'center',
                                                name: 'coo_dec', hidden: true
                                            },
                                            {
                                                index: 'coo_transferida', width: 40, align: 'center',
                                                name: 'coo_transferida', hidden: true
                                            },
                                            {
                                                index: 'obr_clv_int', width: 40, align: 'center',
                                                name: 'obr_clv_int'
                                            },
                                            {
                                                index: 'coo_clv2', width: 40, align: 'center',
                                                name: 'coo_clv2'
                                            }],
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
                                            sortname: "coo_clv2", //login SortColumn
                                            sortorder: "asc", //login SortOrder.
                                            width: "1000",
                                            height: "100%",
                                            caption: "COOPERADORES"
                                        }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                                        .navButtonAdd("#" + pager_id,
                                            {
                                                caption: "EdoCtaCoop...",
                                                buttonicon: "ui-icon-document",
                                                onClickButton: function () {
                                                    var myGrid = $("#" + subgrid_table_id);
                                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                    var idcoop = myGrid.jqGrid('getCell', selectedRowId, 'coo_clv2');
                                                    if (idcoop) {
                                                        GenerarPreEdoCtaCoop(idcopp);
                                                    }
                                                    else {
                                                        alert("Seleccione el cooperador a consultar...");
                                                    }
                                                },
                                                position: "last",
                                                title: "Revisar presupuesto",
                                                cursor: "pointer"
                                            })

                                        .navButtonAdd("#" + pager_id,
                                            {
                                                caption: "",
                                                buttonicon: "ui-icon-document",
                                                onClickButton: function () {
                                                    var myGrid = $("#" + subgrid_table_id);
                                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                                    if (cellValue) {
                                                        SolicitarPresupuesto(cellValue);
                                                    }
                                                    else {
                                                        alert("Selecciona un registro de anuencia...");
                                                    }
                                                },
                                                position: "last",
                                                title: "Solicitar presupuesto",
                                                cursor: "pointer"
                                            });

                                }

                            }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                            .navButtonAdd('#pager',
                                {
                                    caption: "Alta Obra",
                                    buttonicon: "ui-icon-document",
                                    onClickButton: function () {
                                        /* var myGrid = $('#grid');
                                         selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                         cellValue = myGrid.jqGrid('getCell', selectedRowId, 'obr_clv');
                                         if (cellValue) {*/
                                        AccionRegistroObra(0, 0);
                                        /* }
                                         else {
                                             alert("Selecciona una solicitud...");
                                         }*/
                                    },
                                    position: "last",
                                    title: "Alta de Presupuesto",
                                    cursor: "pointer"
                                });

                    }
                }






                //// FUNCION PRINCIPAL

                $(document).ready(function () {


                    $(".buscar_obra").click(function () {
                        Buscar_obra(ObtenerFiltro());
                    });

                    $(".alta_obra").click(function () {
                        AccionRegistroObra(0, 0);
                    });



                    $(".posicion_boton_accion_obraS").click(function () { //Actualizar datos en el registro  

                        var numobra = $("#lblnumobra").html();
                        var accion = parseInt($("#lblaccionobraS").html());

                        ValidarRegistroObraS(accion, numobra);
                    });


                    function ValidarRegistroObraS(accion, numobra) {
                        /*var accion = parseInt($("#lblaccionpresup").html());*/
                        /*var idsol = $("#lblidsol").html();*/

                        if (validarObraS(accion)) {   /*Valida que los datos del documento sean correctos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                            /*Reunir parámetros para guardar el levantamiento capturado en el server*/

                            var hoy = new Date();
                            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                            var arrusuario = bienveusuario.split(":");
                            var usuario = arrusuario[1];
                            var usurec = arrusuario[2];

                            /*var nomcalle = parseInt($("#lstprograma option:selected").val());*/

                            if (accion == 0) {  /*Alta de nueva obra*/

                    /*01*/ var obr_call = $("#txtcalle").val().toUpperCase(); //Nombre de calle, capturada por el usuario del sistema
                    /*02*/ var obr_col = '';
                    /*03*/ var obr_mts = 0;   //Suma de los metros asiganados a los cooperadores
                    /*04*/ var obr_cost = parseFloat($("#txtcostoxmto").val());  // Monto del costo del metro
                    /*05*/ var obr_status = parseInt($("#lstestatusobra").val()); // Estatus de obra utilizado en el SIFIDOC
                    /*06*/ var obr_int = parseInt($("#lsttipoobra").val()); // Contendra el tipo de obra del catalogo de SGPFIDOC                  
                    /*07*/ var obr_tramo = $("#txttramolim1").val().toUpperCase() + ' - ' + $("#txttramolim2").val().toUpperCase(); //Tramo comprendido por la obra
                                var date = new Date();
                    /*08*/ var obr_fecha = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());//Fecha en que se da de alta la obra;
                    /*09*/ var obr_cost_total = 0;
                    /*10*/ var obr_inc = parseInt($("#lsttipoobra").val());
                    /*11*/ var obr_contab = '';
                    /*12*/ var obr_sis = '';
                    /*13*/ var col_nom = '';
                    /*14*/ var obr_digito = '';
                    /*15*/ var obr_programa = '' //Programa de la obra capturado por el usuario
                    /*16*/ var obr_cuentac = '';
                    /*17*/ var obr_digagr = '';
                    /*18*/ var obr_fecinip = ConvertirCadenaToFecha($("#txtfecinipag").val()); //Fecha inicio de pagos                   
                    /*19*/ var obr_npago = parseInt($("#txtnumpagos").val());  //Número de pagos del plazo de promoción.                    
                                var fecvenc = ConvertirCadenaToFecha($("#txtfecinipag").val());
                                fecvenc.setMonth(fecvenc.getMonth() + obr_npago + 1);
                    /*20*/ var obr_fecvenp = ConvertirCadenaToFecha(fecvenc.getDate() + "/" + (fecvenc.getMonth() + 1) + "/" + fecvenc.getFullYear());  //Fecha de vencimiento de pagos
                    /*21*/ var obr_numera = '';
                                var tipo_obra = ("00" + $("#lsttipoobra").val()).substr(-2, 2);
                                var programa_obra = ("00" + $("#lstprograma").val()).substr(-2, 2);
                                var clv_obra_txt = ("0000" + $("#lstubicobra").val()).substr(-4, 4);
                                var aux = date.getFullYear().toString();
                                var year_altaobra = aux.substr(2, 2);
                    /*22*/ var obr_opergob = '22530 0000 0001 ' + programa_obra + year_altaobra + clv_obra_txt; //Cuenta contable geenrada por el area de contabilidad
                    /*23*/ var obr_ubic = parseInt($("#lstubicobra").val());
                    /*24*/ var obr_tipo = tipo_obra;
                    /*25*/ var obr_fec_ini_proc = '01/01/1900';
                    /*26*/ var obr_fec_ini_cob = '01/01/1900';
                    /*27*/ var obr_fec_pub1 = '01/01/1900';
                    /*28*/ var obr_fec_pub2 = '01/01/1900';
                    /*29*/ var evid_pub1 = '';
                    /*30*/ var evid_pub2 = '';
                    /*31*/ var obr_clv = '';   //Antigua clave del SIFIDOC
                    /*31*/ var obr_clv2 = tipo_obra + programa_obra + year_altaobra + clv_obra_txt;   //Antigua clave del SIFIDOC
                    /*32*/ var obr_clv_int = 0;  //clave autonumérica de la obra
                    /*33*/ var col_clv2 = parseInt($("#lstcolonias").val());   //clave de la colonia catalogo:  public3.colonias
                    /*34*/ var obr_prog2 = parseInt($("#lstprograma").val());  // Clave del programa catalogo:  public2.programa

                                RegistrarObraBD(obr_clv,
                                    obr_clv2,
                                    obr_call,
                                    obr_col,
                                    obr_mts,
                                    obr_cost,
                                    obr_status,
                                    obr_int,
                                    obr_tramo,
                                    obr_fecha,
                                    obr_cost_total,
                                    obr_inc,
                                    obr_contab,
                                    obr_sis,
                                    col_nom,
                                    obr_digito,
                                    obr_programa,
                                    obr_cuentac,
                                    obr_digagr,
                                    obr_fecinip,
                                    obr_fecvenp,
                                    obr_npago,
                                    obr_numera,
                                    obr_opergob,
                                    obr_ubic,
                                    obr_tipo,
                                    obr_fec_ini_proc,
                                    obr_fec_ini_cob,
                                    obr_fec_pub1,
                                    obr_fec_pub2,
                                    evid_pub1,
                                    evid_pub2,
                                    obr_clv_int,
                                    col_clv2,
                                    obr_prog2,
                                    accion)
                                    .done(function (r) {

                                        var resp = r.d;

                                        var idobra = parseInt(resp.split(':')[1]);
                                        var mensaje = resp.split(':')[0];
                                        if (idobra) {
                                            alert('Obra registrada correctamente');
                                            $('#mask, .window').hide();
                                            RedibujarGrid();

                                        } else {
                                            alert(mensaje);
                                        }

                                    })
                                    .fail(function (xhr) {
                                        console.log(xhr.responseText);
                                        alert("No fué posible registrar la obra...");
                                    });
                            }


                            if (accion == 1) { /*Cambio de estatus de recaudación a proceso */
                                var ctacont = '12232 0000 0003'
                            }
                            if (accion == 2) { /*Cambio de estatus de proceso a cobranza*/
                                var ctacont = '22530 0000 0002'
                            }
                        }
                    };

                    function RegistrarObraBD(obr_clv,
                        obr_clv2,
                        obr_call,
                        obr_col,
                        obr_mts,
                        obr_cost,
                        obr_status,
                        obr_int,
                        obr_tramo,
                        obr_fecha,
                        obr_cost_total,
                        obr_inc,
                        obr_contab,
                        obr_sis,
                        col_nom,
                        obr_digito,
                        obr_programa,
                        obr_cuentac,
                        obr_digagr,
                        obr_fecinip,
                        obr_fecvenp,
                        obr_npago,
                        obr_numera,
                        obr_opergob,
                        obr_ubic,
                        obr_tipo,
                        obr_fec_ini_proc,
                        obr_fec_ini_cob,
                        obr_fec_pub1,
                        obr_fec_pub2,
                        evid_pub1,
                        evid_pub2,
                        obr_clv_int,
                        col_clv2,
                        obr_prog2,
                        accion) {

                        var enviarObj = {
                            "obr_clv": obr_clv,
                            "obr_clv2": obr_clv2,
                            "obr_call": obr_call,
                            "obr_col": obr_col,
                            "obr_mts": obr_mts,
                            "obr_cost": obr_cost,
                            "obr_status": obr_status,
                            "obr_int": obr_int,
                            "obr_tramo": obr_tramo,
                            "obr_fecha": obr_fecha,
                            "obr_cost_total": obr_cost_total,
                            "obr_inc": obr_inc,
                            "obr_contab": obr_contab,
                            "obr_sis": obr_sis,
                            "col_nom": col_nom,
                            "obr_digito": obr_digito,
                            "obr_programa": obr_programa,
                            "obr_cuentac": obr_cuentac,
                            "obr_digagr": obr_digagr,
                            "obr_fecinip": obr_fecinip,
                            "obr_fecvenp": obr_fecvenp,
                            "obr_npago": obr_npago,
                            "obr_numera": obr_numera,
                            "obr_opergob": obr_opergob,
                            "obr_ubic": obr_ubic,
                            "obr_tipo": obr_tipo,
                            "obr_fec_ini_proc": obr_fec_ini_proc,
                            "obr_fec_ini_cob": obr_fec_ini_cob,
                            "obr_fec_pub1": obr_fec_pub1,
                            "obr_fec_pub2": obr_fec_pub2,
                            "evid_pub1": evid_pub1,
                            "evid_pub2": evid_pub2,
                            "obr_clv_int": obr_clv_int,
                            "col_clv2": col_clv2,
                            "obr_prog2": obr_prog2,
                            "accion": accion
                        }


                        var stringData = JSON.stringify(enviarObj);
                        return $.ajax({
                            type: 'POST',
                            url: "../../WebServices/WebServiceObras.asmx/RegObraS",
                            data: "{objObraS:" + stringData + "}",
                            contentType: 'application/json; utf-8',
                            dataType: 'json',
                            success: function (data) {
                                if (data.d != null) {
                                    console.log(data.d);
                                }
                            },
                            error: function (responseText, textStatus, errorThrown) {
                                alert(textStatus + responseText + errorThrown);
                            }
                        });

                    };

                    $(".verarchivo").click(function (e) { //Ver documento                   
                        var archivo = $("#archivo").text();
                        leerArchivo(archivo);
                    });


                    $(".posicion_boton_cancelar_obraS").click(function (e) {
                        //Cancel the link behavior
                        //e.preventlogin();
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
                });

                function leerArchivo(nom_archivo) {
                    var url = "../../temp/" + nom_archivo;
                    window.open(url, '_blank', 'toolbar=0');
                }

                function AccionRegistroObra(numobra, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
                    $("#lblaccionobraS").text(accion);

                    if (accion == 0) {  //Si la accion es crear un nuevo levantamiento 

                        //Preparación de interfaz para dar de alta la obra.  accion ==0
                        $("#txtcalle").val('');
                        $("#txttramolim1").val('');
                        $("#txttramolim2").val('');

                        llenarPrograma(accion, 0);
                        llenarColonias(0);
                        $("#txtcostoxmto").val('');
                        llenarTipoObra(accion, 0);
                        llenarOpcionPredioMunicipal(accion, 0)
                        $("#txtfecinipag").val('01/01/1900');
                        $("#txtnumpagos").val('');
                        $("#lblfecvenc").html('');
                        $("#lblnumobra").html(0);

                        $("#lblnumobra").html(0);


                        $("#lblfeciniproc").html('');
                        $("#txtfeciniproc").hide('true');

                        $("#lblfecentobr").html('');
                        $("#txtfecentobr").hide('true');

                        $("#lblevidentobr").html('');
                        $("#fileentobr").hide('true');

                        $("#lblfecpub1").html('');
                        $("#txtfecpub1").hide('true');
                        $("#lblEvidPub1").html('');
                        $("#filepub1").hide('true');

                        $("#lblfecpub2").html('');
                        $("#txtfecpub2").hide('true');
                        $("#lblEvidPub2").html('');
                        $("#filepub2").hide('true');

                        $('#lstestatusobra').prop('disabled', 'false')

                        llenarUbicObra(accion, 0);
                        llenarEstatusObra('infestatusobra', 2);

                        $("#txtfecentobr").hide('true');
                        $("#txtfecentobr").hide('true');
                        $("#txtfecentobr").hide('true');

                    }
                    /*
                    }
                    else {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../../WebServices/WebServicePresup.asmx/GetPresup",
                            data: '{idsol:' + idsol + ',idpresup:' + idpresup + '}',
                            success: function (data) {
                                var costo_mto_lineal;
                                var nomarchivo;
                                var idprog;
                                var mts_secc;
                                var mts_banqueta;
                                var mts_arroyo
                                var gastos;
                                var folio;
                                var mts2_banqueta;
                                var mts2_arroyo;
                                var derrama_vec;
                                var derrama_eu;
                                var estatus_presup;                    
                                var usuario_modif;                    
                                var fecha_modif;
                                var cadena = $.trim(data.d);
                                if (cadena == "<NewDataSet />") {
                                    alert("El presupuesto no se encontro, por lo tanto no es posible realizar la acción solicitada.");
                                }
                                else {
                                    // Data.d trae un string con el XML generado dentro del servicio web asmx
                                    $(data.d).find("Presup").each(function () {
                                        costo_mto_lineal = $(this).find("costo_mto_lineal").text();
                                        
                                        idprog = $(this).find("idprog").text();
                                        mts_banqueta = $(this).find("mts_banqueta").text();
                                        mts_arroyo = $(this).find("mts_arroyo").text();
                                        mts_secc = $(this).find("mts_secc").text();
                                        gastos = $(this).find("gastos_admvos").text();
                                        folio = $(this).find("folio_calidad").text();
                                        mts2_banqueta = $(this).find("mts2_banqueta").text();
                                        mts2_arroyo=$(this).find("mts2_arroyo").text();
                                        derrama_vec = $(this).find("derrama_vecinos").text();
                                        derrama_eu = $(this).find("derrama_eu").text();
                                        estatus_presup = $(this).find("estatus_presup").text();                      
                                        iddcto = $(this).find("midDcto").text();
                                        nomarchivo = $(this).find("dcto_presup").text();
                                        
                                        
                                        $("#txtcostomtolineal").val(costo_mto_lineal);                                                        
                                        $("#archivo").text(nomarchivo);
                                        $("#filepresup").prop('disabled', false);
                                        $("#txtfolio").val(folio);
                                        $("#txtmtsbanqueta").val(mts_banqueta);
                                        $("#txtmtsarroyo").val(mts_arroyo);
                                        $("#txtmtsseccion").val(mts_secc);
                                        $("#txtgastosadmvos").val(gastos);
                                        $("#txtmts2arroyo").val(mts2_arroyo);
                                        $("#txt2mtsbanqueta").val(mts2_banqueta);
                                        $("#txtderramavecinos").val(derrama_vec);
                                        $("#txtderramaeu").val(derrama_eu);                            
                                        $("#txtestatuspresup").val('1');
                                        $("#txtestatuspresup").prop('disabled', true);
                                        
                                        if (isNaN(parseInt(iddcto))) {
                                            iddcto = 0
                                        }
                                        $("#lstprograma").text(idprog);
                                        $("#lstprograma").prop('disabled', false);
                                    });
                                }
                                /*if (accion == 2) {
                                    $("#txtFolioAnu").prop('disabled', true);
                                    $("#txtfecentrega").prop('disabled', true);
                                    $("#txtfecrecep").prop('disabled', false);
                                    $("#txtNomProm").prop('disabled', true);
                                    $("#txtDomProm").prop('disabled', true);
                                    $("#txtTelProm").prop('disabled', true);
                                    $("#lstUsuario").prop('disabled', false);
                                    $("#file1").prop('disabled', false);
                                    llenarUsuario(numusuario);
                                }
                                if (accion == 1) {
                                    if (estanu == 2) {
                                        $("#txtfecrecep").prop('disabled', false);
                                        $("#lstUsuario").prop('disabled', false);
                                        $("#file1").prop('disabled', false);
                                    }
                                    if (estanu == 1) {
                                        $("#txtfecrecep").prop('disabled', true);
                                        $("#lstUsuario").prop('disabled', true);
                                        $("#file1").prop('disabled', true);
                                    }
            
                                    $("#txtFolioAnu").prop('disabled', false);
                                    $("#txtfecentrega").prop('disabled', false);
                                    $("#txtNomProm").prop('disabled', false);
                                    $("#txtDomProm").prop('disabled', false);
                                    $("#txtTelProm").prop('disabled', false);
                                    llenarUsuario(numusuario);
                                }*/
                    /*         if (accion == -1) {
                                 $("#txtFolioAnu").prop('disabled', true);
                                 $("#txtfecentrega").prop('disabled', true);
                                 $("#txtfecrecep").prop('disabled', true);
                                 $("#txtNomProm").prop('disabled', true);
                                 $("#txtDomProm").prop('disabled', true);
                                 $("#txtTelProm").prop('disabled', true);
                                 $("#lstUsuario").prop('disabled', true);
                                 $("#file1").prop('disabled', true);
                             }
                             $("#file1").val("");
                         },
                         error: function (xhr) {
                             console.log(xhr.responseText);
                         }
                     });*/
                    /* }*/
                    MostrarModalObraS();

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
                        alert("La fecha capturada como fecha de envío es incorrecta");
                    }
                    return resp;
                }




                function validarObraS(accion) {

                    var valid = true;

                    if (accion == 0) { /*Si el usuario escogió dar de alta una nueva obra*/

                        valid = checkLength($("#txtcalle").val().length, "Calle", 1, 200);
                        valid = valid && checkLength($("#txttramolim1").val().length, "Limite 1 del tramo", 1, 180);
                        valid = valid && checkLength($("#txttramolim2").val().length, "Limite 2 del tramo", 1, 180);
                        valid = valid && checkRegexp($("#txtcalle").val(), /^[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú()]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]+$/, "Captura correctamente el nombre de la calle");
                        valid = valid && checkRegexp($("#txttramolim1").val(), /^[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú()]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]+$/, "Es inválido el LÍMITE 1 capturado");
                        valid = valid && checkRegexp($("#txttramolim2").val(), /^[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú()]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]+$/, "Es inválido el LÍMITE 2 capturado");
                        valid = valid && checkRegexp($("#txtcostoxmto").val(), /\d+(.\d+)?/, "Captura correctamente costo metro lineal");
                        if (isDate($("#txtfecinipag").val())) {
                            var fecinipag = ConvertirCadenaToFecha($("#txtfecinipag").val());
                            if (fecinipag > ConvertirCadenaToFecha('01/01/1900')) {   /*Validación de fechas*/
                                valid = valid && true;
                            }
                            else {
                                alert('La fecha de inicio de pagos no es válida');
                                valid = false;
                            }
                        }
                        else {
                            alert('La fecha de inicio de pagos no es válida');
                            valid = false;
                        }
                        valid = valid && checkRegexp($("#txtnumpagos").val(), /^[0-9]*$/, "El número de pagos debe ser número entero");

                    }

                    /*if ($("#filepresup").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                    /*    if (ValidarArchivo($("#filepresup")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                    /*        valid = valid && true;
                        }
                        else {
                            $("#filepresup").val("");
                            valid = valid && false;
                        }
                    }
                    else {
                        if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                    /* valid = valid && true;*/
                    /* }
                     else {
                         alert("No se ha capturado ningún archivo digital");
                         valid = valid && false;
                     }
                 }*/
                    /*               valid = checkLength($("#txtfolio").val().length, "Folio", 1, 10);
                                   valid = valid && checkLength($("#txtcostomtolineal").val().length, "Costo Metro Lineal", 1, 10);
                                   valid = valid && checkLength($("#txtderramavecinos").val().length, "Derrama de Vecinos", 1, 10);
                                   valid = valid && checkLength($("#txtderramaeu").val().length, "Derrama EU", 1, 10);
                                   valid = valid && checkVacio($("#txtcostomtolineal").val(), /\d+(.\d+)?/, "Captura correctamente metros de sección de la calle");
                                   valid = valid && checkVacio($("#txtmtsseccion").val(), /\d+(.\d+)?/, "Captura correctamente metros de sección de la calle");
                                   valid = valid && checkVacio($("#txtmtsbanqueta").val(), /\d+(.\d+)?/, "Captura correctamente metros lineales de banqueta");
                                   valid = valid && checkVacio($("#txtmtsarroyo").val(), /\d+(.\d+)?/, "Captura correctamente metros lineales de arroyo");
                                   valid = valid && checkVacio($("#txtgastosadmvos").val(), /\d+(.\d+)?/, "Captura correctamente gastos admovos");
                                   valid = valid && checkVacio($("#txtmts2arroyo").val(), /\d+(.\d+)?/, "Captura correctamente metros cuadrados de arroyo");
                                   valid = valid && checkVacio($("#txtmts2banqueta").val(), /\d+(.\d+)?/, "Captura correctamente metros cuadrados de banqueta");
                                   valid = valid && checkVacio($("#txtderramavecinos").val(), /\d+(.\d+)?/, "Captura correctamente derrama de vecinos");
                                   valid = valid && checkVacio($("#txtderramaeu").val(), /\d+(.\d+)?/, "Captura correctamente derrama de EU");
                               }
               
                               if (accion == 1 && estanu == 2) {
                                   valid = checkLength($("#txtFolioAnu").val().length, "Folio de la Anuencia", 1, 20);            
                                   valid = valid && checkLength($("#txtNomProm").val().length, "Nombre del promotor de calle", 1, 60);
                                   valid = valid && checkLength($("#txtDomProm").val().length, "Domicilio del promotor de calle", 1, 80);
                                   valid = valid && checkVacio($("#txtTelProm").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
                                   valid = valid && isDate($("#txtfecentrega").val());
                                   valid = valid && isDate($("#txtfecrecep").val());
                                   var fecrecibo = ConvertirCadenaToFecha($("#txtfecrecep").val());
                                   var fecenvio = ConvertirCadenaToFecha($("#txtfecentrega").val());
                                   if (fecenvio != '01/01/1900') {   
                                       if (fecenvio < fecrecibo) {
                                           valid = valid && true;
                                       }
                                       else {
                                           alert("La fecha de entrega o de recibo es incorrecta, favor de corregir.");
                                           valid = valid && false;
                                       }
                                   }
                                   else {
                                       alert("La fecha de entrega esta vacía debe capturarse algún valor.");
                                       valid = valid && false;
                                   }
                               }
                           }
                       }
                       
                       if (accion == -1) {
                           alert("Has seleccionado cancelar el presupuesto.");
                           valid = true;
                       }
                       */
                    return valid;
                }


                function InsertaRegDcto(idsol, iddcto, idpresup, folioDcto, hoy, hoy, idusuario, nomarchivo, tipodcto, nomusuario, hoy, nomusuario, hoy, archivo, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


                    var enviarObj = {
                        "idsol": idsol,
                        "iddcto": iddcto,
                        "idref": idpresup,
                        "folio": folioDcto,
                        "FecSolic": hoy,
                        "FecRecib": hoy,
                        "NumRecibe": idusuario,
                        "NomArchivo": nomarchivo,
                        "TipoDcto": tipodcto,
                        "UsuCre": nomusuario,
                        "FecCre": hoy,
                        "UsuMod": nomusuario,
                        "FecMod": hoy,
                        "accion": accion
                    }

                    var stringData = JSON.stringify(enviarObj);

                    $.ajax({
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

                /* function RevisaEstatusPresup(idpresup) {
             
                     return $.ajax({
                         type: 'POST',
                         url: "../../WebServices/WebServicePresup.asmx/GetEstatusPresup",
                         data: "{idpresup:" + idpresup + "}",
                         contentType: 'application/json; utf-8',
                         dataType: 'json',
                         error: function (jqXHR, textStatus, errorThrown) {
                             alert(textStatus + jqXHR + errorThrown);
                         }
                     });
             
                 };*/


                function ValidacionGuardadoArchivo(archivo, nomarchivo) {
                    GuardarArchivo(archivo, nomarchivo)
                        .done(function (result) {
                            console.log("El archivo fue guardado correctamente")
                        }).fail(function () {
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


                function MostrarModalObraS() {
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
                    $("#dialogoobraS").css('top', winH / 2 - $("#dialogoobraS").height() / 2);
                    $("#dialogoobraS").css('left', winW / 2 - $("#dialogoobraS").width() / 2);

                    //transition effect
                    $("#dialogoobraS").fadeIn(2000);
                }




                /*  function llenarUsuario(idusu) {
                      $.ajax({
                          type: "POST",
                          dataType: "json",
                          contentType: "application/json",
                          url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioCalidad",
                          data: "",
                          success: function (data) {
                              var elementos = 0;
                              $("#lstUsuario").html('');
                              $(data.d).find("UsuarioCal").each(function () {
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
                  }*/

                function llenarPrograma(accion, idprog) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServicePrograma.asmx/GetProg",
                        data: "{'accion':'" + accion + "','idprog':'" + idprog + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstprograma").html('');
                            $(data.d).find("Prog").each(function () {
                                var option = $(document.createElement('option'));
                                var idprog = $(this).find("idprogr").text();
                                var descripprog = $(this).find("nomprogr").text();
                                option.html(descripprog);
                                option.val(idprog);
                                //Nombre de combo a poblar
                                $("#lstprograma").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            /*if (idestanu != 0) {
                                $("#lstEstAnu").val(idestanu);
                            }*/
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                function llenarTipoObra(accion, tipoobra) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceTipoObra.asmx/GetTipoObra",
                        data: "{'accion':'" + accion + "','tipoobra':'" + tipoobra + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lsttipoobra").html('');
                            $(data.d).find("tipoobra").each(function () {
                                var option = $(document.createElement('option'));
                                var idtipoobra = $(this).find("clv_tipo_obrr").text();
                                var descriptipoobra = $(this).find("descrip_tipo_obrr").text();
                                option.html(descriptipoobra);
                                option.val(idtipoobra);
                                //Nombre de combo a poblar
                                $("#lsttipoobra").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            /*if (idestanu != 0) {
                                $("#lstEstAnu").val(idestanu);
                            }*/
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                function llenarOpcionPredioMunicipal(accion, opcinicial) {

                    $("#lstpredmunic").html('');
                    var prediosmunicip = [
                        { "id": "1", "descrip": "Existen predios municipales" },
                        { "id": "2", "descrip": "No existen predios municipales" }];

                    for (var i = 0; i < prediosmunicip.length; i++) {
                        var option = $(document.createElement('option'));
                        option.html(prediosmunicip[i].descrip);
                        option.val(prediosmunicip[i].id);
                        $("#lstpredmunic").append(option);
                    }
                    if (opcinicial > 1) { /*Se requiere editar los datos de la obra*/
                    }
                }


                function llenarUbicObra(accion, oid) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceObras.asmx/GetUbics",
                        data: "{'accion':'" + accion + "','oid':'" + oid + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstubicobra").html('');
                            $(data.d).find("oids").each(function () {
                                var option = $(document.createElement('option'));
                                var oid = $(this).find("oidr").text();
                                option.html(oid);
                                option.val(oid);
                                //Nombre de combo a poblar
                                $("#lstubicobra").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            /*if (idestanu != 0) {
                                $("#lstEstAnu").val(idestanu);
                            }*/
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }


                function llenarEstatusObra(accion, idestatusobrainicial) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceEstatusObra.asmx/GetEstatusObra",
                        data: "{'accion':'" + accion + "','idestatusobra':'" + idestatusobrainicial + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstestatusobra").html('');
                            $(data.d).find("EstObra").each(function () {
                                var option = $(document.createElement('option'));
                                var idestatusobra = $(this).find("cidestatusobrar").text();
                                var estatusobra = $(this).find("cestatusr");
                                option.html(estatusobra);
                                option.val(idestatusobra);
                                //Nombre de combo a poblar
                                $("#lstestatusobra").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (accion == 'infestatusobra') {
                                $("#lstestatusobra").val(idestatusobrainicial);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }


                function llenarColonias(idcolonia) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCalCol.asmx/GetColoniasS",
                        data: "{'idcolonia':'" + idcolonia + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstcolonias").html('');
                            $(data.d).find("colonia").each(function () {
                                var option = $(document.createElement('option'));
                                var clvcolonia = $(this).find("col_clv2r").text();
                                var colnom = $(this).find("col_nomr").text();
                                option.html(colnom);
                                option.val(clvcolonia);
                                $("#lstcolonias").append(option);
                            });
                            if (idcolonia > 0) { //
                                $("#lstcolonias").val(idcolonia);
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

            <label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px"
                maxlength="120" /><br /><br />
            <label>No. Obra:</label><input type="text" name="obra" id="txtnumobra" style="width:250px"
                maxlength="10" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_obra">
                <== Buscar obra==>
            </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_obra">
                <== Alta obra==>
            </a><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp

            <div id="boxes">
                <div id="dialogoobraS" class="window">
                    <div id="tituloobraS">
                        <p style="text-align:center">GESTION DE OBRA</p>
                        No. de Obra: <label for="numobra" id="lblnumobra"></label><br />
                        Acción:<label for="accion" id="lblaccionobraS"></label><br />
                    </div>
                    <div class="datos" id="bodyobraS">
                        <label for="name" id="lblcalle">*CALLE:</label><input type="text" name="calle" id="txtcalle"
                            size="180" /><br /><br />
                        <label for="name" id="lblcolonia">*COLONIA:</label><select name="colonias"
                            id="lstcolonias"></select><br /><br />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <label for="name" id="lbletiquetatramo">*TRAMO:</label><br /><br />
                        <label for="name" id="lbltramolim1">*Limite 1 del tramo:</label><input type="text" name="tramo"
                            id="txttramolim1" size="150" /><br /><br />
                        <label for="name" id="lbltramolim2">*Limite 2 del tramo:</label><input type="text" name="tramo"
                            id="txttramolim2" size="150" /><br /><br /><br />
                        <label for="name" id="lblprograma">*PROGRAMA:</label><select name="programa"
                            id="lstprograma"></select>&nbsp&nbsp&nbsp<label for="name">*Costo x Mto.
                            Lineal:</label><input type="text" name="costoxmto" id="txtcostoxmto" size="6" /><br /><br />
                        <label for="name" id="lblestatusobra">Estatus de Obra:</label><select name="estatusobra"
                            id="lstestatusobra"></select><br /><br />
                        <label for="name" id="lbltipoobra">*Tipo de Obra:</label><select name="tipoobra"
                            id="lsttipoobra"></select>&nbsp&nbsp&nbsp<label for="name" id="lblpredmunic">*Predios
                            Municipales:</label><select name="prediosmunici" id="lstpredmunic"></select><br /><br />
                        <label for="name" id="lblfecinipag">*Fecha Inicio de Pagos (dd/mm/aaaa): </label><input
                            type="text" name="fecinipag" id="txtfecinipag" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" />&nbsp&nbsp&nbsp<label for="name"
                            id="numpagos">*Número de pagos:</label><input type="text" name="numpagos" id="txtnumpagos"
                            size="6" />&nbsp&nbsp&nbsp<label for="name" id="lblfecvenc"></label><br /><br />
                        <label for="name" id="lblfeciniproc">*Fecha Inicio de Proceso (dd/mm/aaaa):</label><input
                            type="text" name="feciniproc" id="txtfeciniproc" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                        <label for="name" id="lblfecentobr">*Fecha Entrega de Obra (dd/mm/aaaa):</label><input
                            type="text" name="fecentobr" id="txtfecentobr" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" />&nbsp&nbsp&nbsp <label for="name"
                            id="lblevidentobr">*Evidencia entrega obra:</label><input type="file" id="fileentobr"
                            name="file3" /><br /><br />
                        <label for="name" id="lblfecpub1">*Fecha de Publicación 1 (dd/mm/aaaa):</label><input
                            type="text" name="fecpub1" id="txtfecpub1" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" />&nbsp&nbsp&nbsp<label for="name"
                            id="lblEvidPub1"></label><input type="file" id="filepub1" name="file1" /><br /><br />
                        <label for="name" id="lblfecpub2">*Fecha de Publicación 2 (dd/mm/aaaa):</label><input
                            type="text" name="fecpub2" id="txtfecpub2" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" />&nbsp&nbsp&nbsp<label for="name"
                            id="lblEvidPub2"></label><input type="file" id="filepub2" name="file2" /><br /><br />
                        <label for="name" id="lblctacont">Cuenta contable:</label><br /><br />
                        <label for="name" id="lblubic">*Ubicación obra:</label><select name="ubicobra"
                            id="lstubicobra"></select><br />
                    </div>
                    <div class="botonesA" id="botonesC">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_obraS">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_obraS">Cancelar</a></p>
                    </div>
                </div>
                <div id="mask"></div>
            </div>
        </asp:Content>