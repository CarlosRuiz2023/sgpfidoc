<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_cartera_vencida.aspx.vb" Inherits="Admin_procesos_consultar_cartera_vencida" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>



        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

            <script type="text/javascript" language="JavaScript">


                function ConsultaSalidaFichaCV_all(idusu, obra_coop_s) {
                    //alert(img);
                    var url1 = "./salida_coop_cv.html?ResponseType=Edit&idusu=" + idusu + "&obra_coop_s=" + obra_coop_s;
                    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=850,width=1500,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                //// FUNCION PRINCIPAL

                function ObtenerFiltro() {
                    var clvcoop_s = $.trim($('#txtclvcoop_s').val());
                    if (clvcoop_s.length <= 0 || clvcoop_s.length != 13) {
                        clvcoop_s = '';
                    }

                    var clvcoop_sgp = $.trim($('#txtclvcoop_sgp').val());
                    if (clvcoop_sgp.length <= 0 || !$.isNumeric(clvcoop_sgp)) {
                        clvcoop_sgp = '';
                    }

                    var ctapredial = $.trim($('#txtctapredial').val());
                    if (ctapredial.length <= 0 || ctapredial.length != 12) {
                        ctapredial = '';
                    }

                    var nomcoop = $.trim($('#txtnomcoop').val());
                    if (nomcoop.length <= 0 || nomcoop.length > 50) {
                        nomcoop = '';
                    }

                    var filtro = nomcoop + "," + ctapredial + "," + clvcoop_s + "," + clvcoop_sgp + ",";
                    return filtro;
                }


                $(document).ready(function () {

                    var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                    var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                    idusu = arrusuario[2];


                    $(".buscar_coop_cv ").click(function (e) {
                        //Cancel the link behavior 

                        var filtro = ObtenerFiltro();
                        if (filtro != '') {
                            ConsultaPermisoEjecutarTarea(idusu, 149, 3)
                                .done(function (result) {
                                    var data = result.d;
                                    var no_tiene_permiso = data.split(":");
                                    var no_tiene = parseInt(no_tiene_permiso[1]);
                                    if (!no_tiene) {
                                         /*var opcion = confirm("Desea realmente CANCELAR la obra:" + objObra.obr_clv + '---> ADVERTENCIA: Se eliminarán TODOS los frentes activos de la obra, posteriormente es necesario realizar la actualizacion de la Obra en Cajas de Tesorería');
                                        if (opcion == true) {
                                            CancelarObra_psql(objObra)
                                                .done(function (r) {
                                                    var resp = r.d;
                                                    var idobra = parseInt(resp.split(':')[1]);
                                                    var obr_clv_txt = resp.split(':')[2];
                                                    var mensaje = resp.split(':')[0];
                                                    CancelarObra_access(objObra)
                                                        .done(function (r) {
                                                            alert('Obra: ' + obr_clv_txt + ' cancelada correctamente');
                                                            $('#mask, .window').hide();
                                                            RedibujarGrid();
                                                        })
                                                        .fail(function (xhr) {
                                                            console.log(xhr.responseText);
                                                            alert("No fué posible cancelar la obra en ACCESS...");
                                                        })
                                                })
                                                .fail(function (xhr) {
                                                    console.log(xhr.responseText);
                                                    alert("No fué posible cancelar la obra en PostgresSql...");
                                                });*/
                                            LlenarGrid_coop_allCV(filtro, idusu);
                                        } else {
                                            alert('El usuario ' + idusu + ' no cuenta con el permiso para consultar la cartera vencida.');
                                        }
                                    })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falló consultar permiso de ejecución de tarea.");
                                });
                        }
                        else {
                            alert('No se tiene ningún parámetro para realizar la búsqueda.');
                        }
                    });

                });


                function ConsultaPermisoEjecutarTarea(idusu, idtarea, idaccion) {
                    return $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json; utf-8',
                        url: "../../WebServices/WebServiceTarea.asmx/ConsultaPermisoTarea",
                        data: "{'idusu':'" + idusu + "','idtarea':'" + idtarea + "','idaccion':'" + idaccion + "'}"
                    });
                }


                function LlenarGrid_coop_allCV(filtro, idusu) {


                    if ($("#grid")[0].grid) {
                        $.jgrid.gridUnload("#grid");
                        //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    }

                    $("#grid").jqGrid(
                        {
                            datatype: function () {
                                $.ajax(
                                    {
                                        url: "../../WebServices/WebServiceCoop.asmx/GetCoop_allC", //PageMethod
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
                                id: "coop_s"
                            },
                            colModel: [{
                                index: 'coo_clv', width: 50, align: 'Center', name: 'coo_clv'
                            },
                            {
                                index: 'coo_pat', width: 50, align: 'Center', name: 'APaterno_s', hidden: true
                            },
                            {
                                index: 'coo_mat', width: 80, align: 'Center', name: 'AMaterno_s', hidden: true
                            },
                            {
                                index: 'coo_nom', width: 50, align: 'Center', name: 'NombresCoop_s', hidden: true
                            },
                            {
                                index: 'coo_nombre', width: 100, align: 'Center', name: 'NombreCoop_s'
                            },
                            {
                                index: 'coo_nof', width: 100, align: 'Center', name: 'NoOfic_s', hidden: true
                            },
                            {
                                index: 'coo_call', width: 100, align: 'Center', name: 'Calle_Coop_s', hidden: true
                            },
                            {
                                index: 'coo_num', width: 100, align: 'Center', name: 'Num_Coop_s', hidden: true
                            },
                            {
                                index: 'coo_col', width: 100, align: 'Center', name: 'Col_Coop_s', hidden: true
                            },
                            {
                                index: 'coo_npag', width: 100, align: 'Center', name: 'NumPag_s', hidden: true
                            },
                            {
                                index: 'coo_obr', width: 100, align: 'Center', name: 'obra_s', hidden: true
                            },
                            {
                                index: 'coo_mts', width: 100, align: 'Center', name: 'mts_fte_s', hidden: true
                            },
                            {
                                index: 'coo_inc', width: 100, align: 'Center', name: 'inc_s', hidden: true
                            },
                            {
                                index: 'capital', width: 50, align: 'Center', name: 'Capital_s', hidden: true
                            },
                            {
                                index: 'coo_clv1', width: 50, align: 'Center', name: 'coop_s', hidden: true
                            },
                            {
                                index: 'coo_pred', width: 50, align: 'Center', name: 'CtaPredial_s'
                            },
                            {
                                index: 'obr_call', width: 100, align: 'Center', name: 'Calle_s'
                            },
                            {
                                index: 'obr_col', width: 200, align: 'Center', name: 'CveColonia_s', hidden: true
                            },
                            {
                                index: 'col_nom', width: 100, align: 'Center', name: 'Colonia_s'
                            },
                            {
                                index: 'obr_tramo', width: 100, align: 'Center', name: 'Tramo_s'
                            },
                            {
                                index: 'obr_opergob', width: 100, align: 'Center', name: 'CtaOpergob_s', hidden: true
                            },
                            {
                                index: 'obr_npago', width: 100, align: 'Center', name: 'NumPagos_s', hidden: true
                            },
                            {
                                index: 'obr_fec_proc', width: 150, align: 'Center', name: 'FecObrProc_s', hidden: true
                            },
                            {
                                index: 'obr_fec_cob', width: 100, align: 'Center', name: 'FecObrCob_s', hidden: true
                            },
                            {
                                index: 'obr_fec_rec', width: 100, align: 'Center', name: 'FecObrRec_s', hidden: true
                            },
                            {
                                index: 'midcoop', width: 50, align: 'Center', name: 'IdCoop', hidden: true
                            },
                            {
                                index: 'mcallecoop', width: 50, align: 'Center', name: 'CalleCoop', hidden: true
                            },
                            {
                                index: 'mcolcoop', width: 50, align: 'Center', name: 'ColCoop', hidden: true
                            },
                            {
                                index: 'mnooficial_ext', width: 50, align: 'Center', name: 'NumOficCoop', hidden: true
                            },
                            {
                                index: 'mtelcoop', width: 50, align: 'Center', name: 'TelCoop', hidden: true
                            },
                            {
                                index: 'mnomficha', width: 50, align: 'Center', name: 'NombreFicha', hidden: true
                            },
                            {
                                index: 'mcurp', width: 50, align: 'Center', name: 'CURP', hidden: true
                            },
                            {
                                index: 'mcorreo', width: 50, align: 'Center', name: 'Email', hidden: true
                            },
                            {
                                index: 'mrelacionpredio', width: 50, align: 'Center', name: 'cve_relpredio', hidden: true
                            },
                            {
                                index: 'crelacionpredio', width: 50, align: 'Center', name: 'RelCoopPredio', hidden: true
                            },
                            {
                                index: 'fid', width: 50, align: 'Center', name: 'fid', hidden: true
                            },
                            {
                                index: 'obra_coop_s', width: 50, align: 'Center', name: 'ObraCoop_s', hidden: true
                            },
                            {
                                index: 'mts_frente', width: 50, align: 'Center', name: 'mts_fte', hidden: true
                            },
                            {
                                index: 'cid', width: 50, align: 'Center', name: 'cid', hidden: true
                            },
                            {
                                index: 'pid', width: 50, align: 'Center', name: 'pid', hidden: true
                            },
                            {
                                index: 'ctapredial', width: 50, align: 'Center', name: 'ctapredial', hidden: true
                            },
                            {
                                index: 'nooficial', width: 50, align: 'Center', name: 'nooficial', hidden: true
                            },
                            {
                                index: 'lote', width: 50, align: 'Center', name: 'lote', hidden: true
                            },
                            {
                                index: 'mzna', width: 50, align: 'Center', name: 'mzna', hidden: true
                            },
                            {
                                index: 'obr_clv_int', width: 50, align: 'Center', name: 'obr_clv_int', hidden: true
                            },
                            {
                                index: 'obr_clv2', width: 50, align: 'Center', name: 'obr_clv2', hidden: true
                            },
                            {
                                index: 'calle', width: 300, align: 'Center', name: 'Calle', hidden: true
                            },
                            {
                                index: 'colonia', width: 300, align: 'Center', name: 'Colonia', hidden: true
                            },
                            {
                                index: 'tramo', width: 300, align: 'Center', name: 'Tramo', hidden: true
                            },
                            {
                                index: 'obr_fecinip', width: 50, align: 'Center', name: 'FecIniPag', hidden: true
                            },
                            {
                                index: 'obr_fecvenp', width: 50, align: 'Center', name: 'FecVencPag', hidden: true
                            },
                            {
                                index: 'obr_fec_ini_proc', width: 50, align: 'Center', name: 'FecIniProc', hidden: true
                            },
                            {
                                index: 'obr_fec_ini_cob', width: 50, align: 'Center', name: 'FecIniCob', hidden: true
                            },
                            {
                                index: 'obr_cost', width: 50, align: 'Center', name: 'CostoMto', hidden: true
                            },
                            {
                                index: 'obr_prog2', width: 50, align: 'Center', name: 'IdProg', hidden: true
                            },
                            {
                                index: 'nomprog', width: 50, align: 'Center', name: 'NombrePrograma', hidden: true
                            },
                            {
                                index: 'obr_opergob_sgp', width: 50, align: 'Center', name: 'CtaOPERGOB', hidden: true
                            },
                            {
                                index: 'inc_sgp', width: 50, align: 'Center', name: 'Incremento', hidden: true
                            },
                            {
                                index: 'capital_sgp', width: 50, align: 'Center', name: 'Capital', hidden: true
                            },
                            {
                                index: 'num_pagos', width: 50, align: 'Center', name: 'num_pagos', hidden: true
                            },
                            {
                                index: 'total_capital_pagado', width: 50, align: 'Center', name: 'TotCapPag', hidden: true
                            },
                            {
                                index: 'total_cargos_pagados', width: 50, align: 'Center', name: 'TotCargPag', hidden: true
                            },
                            {
                                index: 'total_cargos', width: 50, align: 'Center', name: 'TotCarg', hidden: true
                            },
                            {
                                index: 'total_cargos_no_pagados', width: 50, align: 'Center', name: 'TotCargNoPag', hidden: true
                            },
                            {
                                index: 'total_cargo_t5', width: 50, align: 'Center', name: 'TotCarg_t5', hidden: true
                            },
                            {
                                index: 'total_cargo_t6', width: 50, align: 'Center', name: 'TotCarg_t6', hidden: true
                            },
                            {
                                index: 'total_cargo_t7', width: 50, align: 'Center', name: 'TotCarg_t7', hidden: true
                            },
                            {
                                index: 'total_cargo_t16', width: 50, align: 'Center', name: 'ActArt45_t16', hidden: true
                            },
                            {
                                index: 'descto_cargo_t3', width: 50, align: 'Center', name: 'DesctoCarg_t3', hidden: true
                            },
                            {
                                index: 'saldo_sin', width: 50, align: 'Center', name: 'SALDO_SIN'
                            },
                            {
                                index: 'saldo_con', width: 50, align: 'Center', name: 'SALDO_CON'
                            },
                            {
                                index: 'fec_notif_det', width: 50, align: 'Center', name: 'FecNotifDet', hidden: true
                            },
                            {
                                index: 'notif_det', width: 50, align: 'Center', name: 'CveUsuNotifDet', hidden: true
                            },
                            {
                                index: 'nom_notif_det', width: 50, align: 'Center', name: 'UsuNotifDet', hidden: true
                            },
                            {
                                index: 'fec_notif_req', width: 50, align: 'Center', name: 'FecNotifReq', hidden: true
                            },
                            {
                                index: 'notif_req', width: 50, align: 'Center', name: 'CveUsuNotifReq', hidden: true
                            },
                            {
                                index: 'nom_notif_req', width: 50, align: 'Center', name: 'UsuNotifReq', hidden: true
                            },
                            {
                                index: 'fec_notif_ejec', width: 50, align: 'Center', name: 'FecNotifEjec', hidden: true
                            },
                            {
                                index: 'notif_ejec', width: 50, align: 'Center', name: 'CveUsuNotifEjec', hidden: true
                            },
                            {
                                index: 'nom_notif_ejec', width: 50, align: 'Center', name: 'UsuNotifEjec', hidden: true
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
                            sortname: "coo_clv", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1900",
                            height: "800",
                            caption: "COOPERADOR"
                            /* ,
                            subGrid: true,
                             subGridBeforeExpand: function (subgrid_id, row_id) {
                                 var myGrid = $('#grid');
                                 obra = myGrid.jqGrid('getRowData', row_id);
                                 filtro2 = ',,,,,,,,' + obra.ClvObra + ',,';
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
                                                     url: "../../WebServices/WebServiceFrente.asmx/GetFrentexO", //PageMethod
                                                     data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                           "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                           "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                           "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                           "','pFiltro':'" + filtro2 + "'}", //PageMethod Parametros de entrada                                   
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
                                                id: "coop_s"
                                            },
                                           colModel: [
                                                 {
                                                     index: 'coop_s', width: 80, align: 'Center', name: 'Coop_S', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_nom', width: 100, align: 'Center', name: 'Nom_Coop', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_nof', width: 50, align: 'Center', name: 'NoOfic', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_calle', width: 80, align: 'Center', name: 'obr_clv', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_num', width: 50, align: 'Center', name: 'coopid', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_colonia', width: 100, align: 'Center', name: 'calle', hidden: true
                                                 },
                                                 {
                                                     index: 'num_pagos', width: 100, align: 'Center', name: 'colonia', hidden: true
                                                 },
                                                 {
                                                     index: 'obra_s', width: 80, align: 'Center', name: 'tramo', hidden: true
                                                 },
                                                 {
                                                     index: 'mts_fte', width: 100, align: 'Center', name: 'costo_mto', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_inc', width: 100, align: 'Center', name: 'obr_fecinip', hidden: true
                                                 },
                                                 {
                                                     index: 'capital', width: 100, align: 'Center', name: 'obr_fecvenp', hidden: true
                                                 },
                                                 {
                                                     index: 'obra_coop_s', width: 100, align: 'Center', name: 'obr_npago', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_pred', width: 100, align: 'Center', name: 'descrip_tipo_obr', hidden: true
                                                 },
                                                 {
                                                     index: 'fid', width: 100, align: 'Center', name: 'estatus_obra', hidden: true
                                                 },
                                                 {
                                                     index: 'midcoop', width: 100, align: 'Center', name: 'nomprog', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_tel', width: 100, align: 'Center', name: 'progdescrip', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_curp', width: 50, align: 'Center', name: 'fid', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_relacion_predio', width: 50, align: 'Center', name: 'nooficial', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_cid', width: 80, align: 'Center', name: 'ctapredial', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_pid', width: 100, align: 'Center', name: 'coo_clv2', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_lote', width: 200, align: 'Center', name: 'mnomficha', hidden: true
                                                 },
                                                 {
                                                     index: 'coop_mzna', width: 50, align: 'Center', name: 'mts_frente', hidden: true
                                                 },
                                                 {
                                                     index: 't_capital_pag', width: 50, align: 'Center', name: 'inc', hidden: true
                                                 },
                                                 {
                                                     index: 't_cargos_pag', width: 100, align: 'Center', name: 'capital_sin_inc', hidden: true
                                                 },
                                                 {
                                                     index: 't_cargos', width: 100, align: 'Center', name: 'capital', hidden: true
                                                 },
                                                 {
                                                     index: 't_cargos_no_pag', width: 150, align: 'Center', name: 'capital_pagado', hidden: true
                                                 },
                                                 {
                                                     index: 'saldo_sin', width: 100, align: 'Center', name: 'cargos_pagados', hidden: true
                                                 },
                                                 {
                                                     index: 'saldo_con', width: 100, align: 'Center', name: 'desctos_aplicados', hidden: true
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
                                           sortname: "coop_s", //login SortColumn
                                           sortorder: "asc", //login SortOrder.
                                           width: "1200",
                                           height: "100%",
                                           caption: "COOPERADORES EN CARTERA VENCIDA"
                                       }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                                      .navButtonAdd("#" + pager_id,
                                             {
                                                 caption: "FichaPredio...",
                                                 buttonicon: "ui-icon-document",
                                                 onClickButton: function () {
                                                     var myGrid = $("#" + subgrid_table_id);
                                                     selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                     var pid = myGrid.jqGrid('getCell', selectedRowId, 'pid');
                                                     var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                                     if (pid) {
                                                         ConsultaSalidaPredio(idusu, oid, pid);
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
                                                      caption: "Gestion_Coops",
                                                      buttonicon: "ui-icon-document",
                                                      onClickButton: function () {
                                                          var myGrid = $("#" + subgrid_table_id);
            
                                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                          var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                                          var coopid = myGrid.jqGrid('getCell', selectedRowId, 'coopid');
                                                          var estatus_obra = obra.obr_estatus;
            
                                                          var programa = obra.obr_prog2 + ':' + obra.Prog;
                                                          if (fid) {
                                                              GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv, estatus_obra, programa, idusu, fid, obra.NumPagos, obra.FecVenP, coopid);
                                                          }
                                                          else {
                                                              GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv, estatus_obra, programa, idusu, 0, obra.NumPagos, obra.FecVenP, '000');
                                                          }
                                                      },
                                                      position: "last",
                                                      title: "Cooperadores",
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




                        }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                        .navButtonAdd('#pager',
                            {
                                caption: "VerFicha",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var coop_cv_all = myGrid.jqGrid('getRowData', selectedRowId);
                                    if (typeof coop_cv_all.coo_clv != 'undefined') {
                                        ConsultaSalidaFichaCV_all(idusu, coop_cv_all.coo_clv)

                                    }
                                    else {
                                        alert('Selecciona un registro de la relación de Cooperadores.')
                                    }
                                },
                                position: "last",
                                title: "Exportar Excela",
                                cursor: "pointer"
                            });

                }


            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="bodegadatos"></div>

            <label>Nombre de COOPERADOR:</label><input type="text" name="calle" id="txtnomcoop" style="width:250px"
                maxlength="120" /><br /><br />
            <label>CTA_PREDIAL:</label><input type="text" name="calle" id="txtctapredial" style="width:250px"
                maxlength="120" /><br /><br />
            <label>Clave Cooperador (SIFIDOC):</label><input type="text" name="obr_clv_int" id="txtclvcoop_s"
                style="width:250px" maxlength="13" /><br /><br />
            <label>Clave Frente (SGPFIDOC):</label><input type="text" name="obra" id="txtclvcoop_sgp"
                style="width:250px" maxlength="10" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
                class="buscar_coop_cv">
                <== Buscar Cooperador==>
            </a><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp

        </asp:Content>