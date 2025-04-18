﻿<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_trans_pagos.aspx.vb" Inherits="Admin_procesos_consultar_trans_pagos" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

            <script type="text/javascript" language="JavaScript">

                function ConsultaSalidaPredio(idusu, oid, pid) {
                    //alert(img);
                    var url1 = "./salida_predio.html?ResponseType=Edit&idusu=" + idusu + "&oid=" + oid + "&pid=" + pid;
                    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=800,width=1500,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                //Funcion para redimensionar los input de la ventana modal
                function resizeInput() {

                    var valueLength = $(this).prop('value').length;

                    // Para que no arroje error si el input se vacía
                    if (valueLength > 0) {

                        $(this).prop('size', valueLength);
                    }
                }

                function fecha_hoy() {
                    var d = new Date();
                    var month = d.getMonth() + 1;
                    var day = d.getDate();
                    return (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + d.getFullYear();
                }

                function filterFloat(evt, input) {
                    // Backspace = 8, Enter = 13, ‘0′ = 48, ‘9′ = 57, ‘.’ = 46, ‘-’ = 43
                    var key = window.Event ? evt.which : evt.keyCode;
                    var chark = String.fromCharCode(key);
                    var tempValue = input.value + chark;
                    if (key >= 48 && key <= 57) {
                        if (filter(tempValue) === false) {
                            return false;
                        } else {
                            return true;
                        }
                    } else {
                        if (key == 8 || key == 13 || key == 0) {
                            return true;
                        } else if (key == 46) {
                            if (filter(tempValue) === false) {
                                return false;
                            } else {
                                return true;
                            }
                        } else {
                            return false;
                        }
                    }
                }
                function filter(__val__) {
                    var preg = /^([0-9]+\.?[0-9]{0,2})$/;
                    if (preg.test(__val__) === true) {
                        return true;
                    } else {
                        return false;
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
                    var apaterno = $('#txtapaterno').val();
                    if (apaterno.length <= 0 || apaterno.length > 30) {
                        apaterno = "NULL";
                    }
                    var amaterno = $('#txtamaterno').val();
                    if (amaterno.length <= 0 || amaterno.length > 30) {
                        amaterno = "NULL";
                    }
                    var nombres = $('#txtnombres').val();
                    if (nombres.length <= 0 || nombres.length > 30) {
                        nombres = "NULL";
                    }
                    var nomcalle = $('#txtnomcalle').val();
                    if (nomcalle.length <= 0 || nomcalle.length > 30) {
                        nomcalle = "NULL";
                    }
                    var nomcolonia = $('#txtnomcolonia').val();
                    if (nomcolonia.length <= 0 || nomcolonia.length > 30) {
                        nomcolonia = "NULL";
                    }
                    var nomficha = $('#txtnomficha').val();
                    if (nomficha.length <= 0 || nomficha.length > 50) {
                        nomficha = "NULL";
                    }
                    var numcoop = $('#txtidcoop').val();
                    if (numcoop.length <= 0 || !$.isNumeric(numcoop)) {
                        numcoop = "0";
                    }
                    var numcoopS = $('#txtcoopS').val();
                    if (numcoopS.length <= 0 || !$.isNumeric(numcoopS)) {
                        numcoopS = "0";
                    }
                    var ctapredial = $('#txtctapredial').val();
                    if (ctapredial.length <= 0 || ctapredial.length > 12) {
                        ctapredial = '';
                    }

                    var filtro = apaterno.toString() + "," + amaterno.toString() + "," + nombres.toString() + "," + nomcalle.toString() + "," + nomcolonia.toString() + "," + nomficha.toString() + "," + numcoopS.toString() + ',' + numcoop.toString() + ',' + ctapredial.toString() + ',';
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



                function Buscar_Coop(filtro) {

                    var idcoop;
                    var obr_clv_int;

                    if ($("#grid")[0].grid) {
                        $.jgrid.gridUnload("#grid");
                        //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    }

                    if (filtro == 'NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL') {
                        alert("No se ha capturado nigún parámetro de búsqueda");
                    }
                    else {

                        var arrfiltro = filtro.split(",");
                        var apaterno_ref = arrfiltro[0];
                        var amaterno_ref = arrfiltro[1];
                        var nombre_ref = arrfiltro[2];
                        var nom_calle_ref = arrfiltro[3];
                        var nom_col_ref = arrfiltro[4];
                        var nomficha_ref = arrfiltro[5];
                        var obr_clv_int_ref = 0;
                        var coo_clv_txt_ref = arrfiltro[6];
                        var ctapredial_ref = arrfiltro[8];
                        var fid_ref = parseInt(arrfiltro[7]);
                        var accion_coop = 1;



                        $("#grid").jqGrid(
                            {
                                datatype: function () {
                                    $.ajax(
                                        {
                                            url: "../../WebServices/WebServiceCoop.asmx/GetCoops2_psql", //PageMethod
                                            data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                                "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                                "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                                "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                                "','fid':'" + fid_ref +
                                                "','obr_clv_int':'" + obr_clv_int_ref +
                                                "','coo_clv_txt':'" + coo_clv_txt_ref +
                                                "','amaterno':'" + amaterno_ref +
                                                "','apaterno':'" + apaterno_ref +
                                                "','nombre':'" + nombre_ref +
                                                "','nom_ficha':'" + nomficha_ref +
                                                "','nom_calle':'" + nom_calle_ref +
                                                "','nom_col':'" + nom_col_ref +
                                                "','ctapredial':'" + ctapredial_ref +
                                                "','accion':'" + accion_coop + "'}", //PageMethod Parametros de entrada           
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
                                    id: "fid"
                                },
                                colModel: [{
                                    index: 'fid', width: 80, align: 'Center', name: 'fid'
                                },
                                {
                                    index: 'geom_frente', width: 100, align: 'Center', name: 'geom_frente', hidden: true
                                },
                                {
                                    index: 'mts_frente', width: 80, align: 'Center', name: 'MtsFte'
                                },
                                {
                                    index: 'cid', width: 100, align: 'Center', name: 'cid', hidden: true
                                },
                                {
                                    index: 'coopid', width: 100, align: 'Center', name: 'COOP_SIFIDOC'
                                },
                                {
                                    index: 'pid', width: 80, align: 'Center', name: 'pid'
                                },
                                {
                                    index: 'oid', width: 100, align: 'Center', name: 'oid'
                                },
                                {
                                    index: 'obs_grales', width: 100, align: 'Center', name: 'obs_grales', hidden: true
                                },
                                {
                                    index: 'obra_sifidoc', width: 100, align: 'Center', name: 'O_SIFIDOC'
                                },
                                {
                                    index: 'gid', width: 100, align: 'Center', name: 'gid', hidden: true
                                },
                                {
                                    index: 'feccre_frente', width: 100, align: 'Center', name: 'feccre_frente', hidden: true
                                },
                                {
                                    index: 'fecmod_frente', width: 100, align: 'Center', name: 'fecmod_frente', hidden: true
                                },
                                {
                                    index: 'usucre_frente', width: 100, align: 'Center', name: 'usucre_frente', hidden: true
                                },
                                {
                                    index: 'usumod_frente', width: 100, align: 'Center', name: 'usumod_frente', hidden: true
                                },
                                {
                                    index: 'prid', width: 100, align: 'Center', name: 'prid', hidden: true
                                },
                                {
                                    index: 'inc', width: 100, align: 'Center', name: 'inc', hidden: true
                                },
                                {
                                    index: 'did', width: 100, align: 'Center', name: 'did', hidden: true
                                },
                                {
                                    index: 'factor_act_pago', width: 100, align: 'Center', name: 'factor_act_pago', hidden: true
                                },
                                {
                                    index: 'obr_clv_int', width: 100, align: 'Center', name: 'obr_clv_int', hidden: true
                                },
                                {
                                    index: 'coo_clv2', width: 100, align: 'Center', name: 'coo_clv2', hidden: true
                                },
                                {
                                    index: 'activo', width: 100, align: 'Center', name: 'activo', hidden: true
                                },
                                {
                                    index: 'capital', width: 100, align: 'Center', name: 'capital', hidden: true
                                },
                                {
                                    index: 'midcoop', width: 100, align: 'Center', name: 'midcoop', hidden: true
                                },
                                {
                                    index: 'mapellidop', width: 100, align: 'Center', name: 'A.PATERNO'
                                },
                                {
                                    index: 'mapellidom', width: 100, align: 'Center', name: 'A.MATERNO'
                                },
                                {
                                    index: 'mnombres', width: 150, align: 'Center', name: 'NOMBRES'
                                },
                                {
                                    index: 'mcallecoop', width: 100, align: 'Center', name: 'mcallecoop', hidden: true
                                },
                                {
                                    index: 'mcolcoop', width: 100, align: 'Center', name: 'mcolcoop', hidden: true
                                },
                                {
                                    index: 'mnooficial_ext', width: 100, align: 'Center', name: 'mnooficial_ext', hidden: true
                                },
                                {
                                    index: 'mnooficial_int', width: 100, align: 'Center', name: 'mnooficial_int', hidden: true
                                },
                                {
                                    index: 'mtelcoop', width: 100, align: 'Center', name: 'mtelcoop', hidden: true
                                },
                                {
                                    index: 'mnomficha', width: 300, align: 'Center', name: 'NOMBRE_FICHA'
                                },
                                {
                                    index: 'mestado', width: 100, align: 'Center', name: 'mestado', hidden: true
                                },
                                {
                                    index: 'mpais', width: 100, align: 'Center', name: 'mpais', hidden: true
                                },
                                {
                                    index: 'mcorreo', width: 100, align: 'Center', name: 'mcorreo', hidden: true
                                },
                                {
                                    index: 'usrcre_coop', width: 100, align: 'Center', name: 'usrcre_coop', hidden: true
                                },
                                {
                                    index: 'feccre_coop', width: 100, align: 'Center', name: 'feccre_coop', hidden: true
                                },
                                {
                                    index: 'usrmod_coop', width: 100, align: 'Center', name: 'usrmod_coop', hidden: true
                                },
                                {
                                    index: 'fecmod_coop', width: 100, align: 'Center', name: 'fecmod_coop', hidden: true
                                },
                                {
                                    index: 'mcurp', width: 100, align: 'Center', name: 'mcurp', hidden: true
                                },
                                {
                                    index: 'mrelacionpredio', width: 100, align: 'Center', name: 'mrelacionpredio', hidden: true
                                },
                                {
                                    index: 'ine', width: 100, align: 'Center', name: 'ine', hidden: true
                                },
                                {
                                    index: 'doc_identific', width: 100, align: 'Center', name: 'doc_identific', hidden: true
                                },
                                {
                                    index: 'obr_clv', width: 100, align: 'Center', name: 'obr_clv', hidden: true
                                },
                                {
                                    index: 'obr_mts', width: 100, align: 'Center', name: 'obr_mts', hidden: true
                                },
                                {
                                    index: 'obr_cost', width: 100, align: 'Center', name: 'obr_cost', hidden: true
                                },
                                {
                                    index: 'obr_int', width: 100, align: 'Center', name: 'obr_int', hidden: true
                                },
                                {
                                    index: 'obr_fecha', width: 100, align: 'Center', name: 'obr_fecha', hidden: true
                                },
                                {
                                    index: 'obr_cost_total', width: 100, align: 'Center', name: 'obr_cost_total', hidden: true
                                },
                                {
                                    index: 'obr_inc', width: 100, align: 'Center', name: 'obr_inc', hidden: true
                                },
                                {
                                    index: 'obr_fecinip', width: 100, align: 'Center', name: 'obr_fecinip', hidden: true
                                },
                                {
                                    index: 'obr_fecvenp', width: 100, align: 'Center', name: 'obr_fecvenp', hidden: true
                                },
                                {
                                    index: 'obr_npago', width: 100, align: 'Center', name: 'obr_npago', hidden: true
                                },
                                {
                                    index: 'obr_opergob', width: 100, align: 'Center', name: 'obr_opergob', hidden: true
                                },
                                {
                                    index: 'obr_fec_ini_proc', width: 100, align: 'Center', name: 'obr_fec_ini_proc', hidden: true
                                },
                                {
                                    index: 'obr_fec_ini_cob', width: 100, align: 'Center', name: 'obr_fec_ini_cob', hidden: true
                                },
                                {
                                    index: 'obr_clv_int_obra', width: 100, align: 'Center', name: 'obr_clv_int_obra', hidden: true
                                },
                                {
                                    index: 'obr_prog2', width: 100, align: 'Center', name: 'obr_prog2', hidden: true
                                },
                                {
                                    index: 'nomprog', width: 100, align: 'Center', name: 'nomprog', hidden: true
                                },
                                {
                                    index: 'progdescrip', width: 100, align: 'Center', name: 'progdescrip', hidden: true
                                },
                                {
                                    index: 'obr_clv2', width: 100, align: 'Center', name: 'obr_clv2', hidden: true
                                },
                                {
                                    index: 'obr_status', width: 100, align: 'Center', name: 'obr_status', hidden: true
                                },
                                {
                                    index: 'cestatus', width: 100, align: 'Center', name: 'cestatus', hidden: true
                                },
                                {
                                    index: 'oid_obra', width: 100, align: 'Center', name: 'oid_obra', hidden: true
                                },
                                {
                                    index: 'obr_fec_canc', width: 100, align: 'Center', name: 'obr_fec_canc', hidden: true
                                },
                                {
                                    index: 'obr_sis', width: 100, align: 'Center', name: 'obr_sis', hidden: true
                                },
                                {
                                    index: 'col_clv2', width: 100, align: 'Center', name: 'col_clv2', hidden: true
                                },
                                {
                                    index: 'no_contrato', width: 100, align: 'Center', name: 'no_contrato', hidden: true
                                },
                                {
                                    index: 'gastos_admvos', width: 100, align: 'Center', name: 'gastos_admvos', hidden: true
                                },
                                {
                                    index: 'obr_fec_pub1', width: 100, align: 'Center', name: 'obr_fec_pub1', hidden: true
                                },
                                {
                                    index: 'obr_fec_pub2', width: 100, align: 'Center', name: 'obr_fec_pub2', hidden: true
                                },
                                {
                                    index: 'evid_pub1', width: 100, align: 'Center', name: 'evid_pub1', hidden: true
                                },
                                {
                                    index: 'evid_pub2', width: 100, align: 'Center', name: 'evid_pub2', hidden: true
                                },
                                {
                                    index: 'evid_obra_proc', width: 100, align: 'Center', name: 'evid_obra_proc', hidden: true
                                },
                                {
                                    index: 'evid_termino_obra', width: 100, align: 'Center', name: 'evid_termino_obra', hidden: true
                                },
                                {
                                    index: 'obr_nat', width: 100, align: 'Center', name: 'obr_nat', hidden: true
                                },
                                {
                                    index: 'pid_predio', width: 100, align: 'Center', name: 'pid_predio', hidden: true
                                },
                                {
                                    index: 'objectid', width: 100, align: 'Center', name: 'objectid', hidden: true
                                },
                                {
                                    index: 'gid_server', width: 100, align: 'Center', name: 'gid_server', hidden: true
                                },
                                {
                                    index: 'cup', width: 100, align: 'Center', name: 'cup', hidden: true
                                },
                                {
                                    index: 'feccre_pred', width: 100, align: 'Center', name: 'feccre_pred', hidden: true
                                },
                                {
                                    index: 'fecmod_pred', width: 100, align: 'Center', name: 'fecmod_pred', hidden: true
                                },
                                {
                                    index: 'tipo', width: 100, align: 'Center', name: 'tipo', hidden: true
                                },
                                {
                                    index: 'tipopredio', width: 100, align: 'Center', name: 'tipopredio', hidden: true
                                },
                                {
                                    index: 'ctapredial', width: 120, align: 'Center', name: 'CTAPREDIAL'
                                },
                                {
                                    index: 'ctaimuvi', width: 100, align: 'Center', name: 'ctaimuvi', hidden: true
                                },
                                {
                                    index: 'observacio', width: 100, align: 'Center', name: 'observacio', hidden: true
                                },
                                {
                                    index: 'shape_area', width: 100, align: 'Center', name: 'shape_area', hidden: true
                                },
                                {
                                    index: 'shape_len', width: 100, align: 'Center', name: 'shape_len', hidden: true
                                },
                                {
                                    index: 'geom_predio', width: 100, align: 'Center', name: 'geom_predio', hidden: true
                                },
                                {
                                    index: 'uso_predio', width: 100, align: 'Center', name: 'uso_predio', hidden: true
                                },
                                {
                                    index: 'uso_suelo', width: 100, align: 'Center', name: 'uso_suelo', hidden: true
                                },
                                {
                                    index: 'r20', width: 100, align: 'Center', name: 'r20', hidden: true
                                },
                                {
                                    index: 'nooficial', width: 80, align: 'Center', name: 'NoOficial'
                                },
                                {
                                    index: 'sapal', width: 100, align: 'Center', name: 'sapal', hidden: true
                                },
                                {
                                    index: 'usrcre_pred', width: 100, align: 'Center', name: 'usrcre_pred', hidden: true
                                },
                                {
                                    index: 'usrmod_pred', width: 100, align: 'Center', name: 'usrmod_pred', hidden: true
                                },
                                {
                                    index: 'num_escritura', width: 100, align: 'Center', name: 'num_escritura', hidden: true
                                },
                                {
                                    index: 'reg_escritura', width: 100, align: 'Center', name: 'reg_escritura', hidden: true
                                },
                                {
                                    index: 'folio_escritura', width: 100, align: 'Center', name: 'folio_escritura', hidden: true
                                },
                                {
                                    index: 'tomo_escritura', width: 100, align: 'Center', name: 'tomo_escritura', hidden: true
                                },
                                {
                                    index: 'doc_escritura', width: 100, align: 'Center', name: 'doc_escritura', hidden: true
                                },
                                {
                                    index: 'lote', width: 100, align: 'Center', name: 'lote', hidden: true
                                },
                                {
                                    index: 'mzna', width: 100, align: 'Center', name: 'mzna', hidden: true
                                },
                                {
                                    index: 'saldo_sin', width: 100, align: 'Center', name: 'saldo_sin', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }, hidden: true
                                },
                                {
                                    index: 'saldo_sin_act', width: 100, align: 'Center', name: 'saldo_sin_act', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }, hidden: true
                                },
                                {
                                    index: 'pagos', width: 100, align: 'Center', name: 'pagos', hidden: true
                                },
                                {
                                    index: 'recargos', width: 100, align: 'Center', name: 'recargos', hidden: true
                                },
                                {
                                    index: 'clv_inpc_ant', width: 100, align: 'Center', name: 'clv_inpc_ant', hidden: true
                                },
                                {
                                    index: 'clv_inpc_actual', width: 100, align: 'Center', name: 'clv_inpc_actual', hidden: true
                                },
                                {
                                    index: 'clv_inpc_actual_2', width: 100, align: 'Center', name: 'clv_inpc_actual_2', hidden: true
                                },
                                {
                                    index: 'factor_act', width: 100, align: 'Center', name: 'factor_act', hidden: true
                                },
                                {
                                    index: 'monto_act', width: 100, align: 'Center', name: 'monto_act', hidden: true
                                },
                                {
                                    index: 'saldo', width: 100, align: 'Center', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }, name: 'SALDO'
                                },
                                {
                                    index: 'calle', width: 300, align: 'Center', name: 'CALLE'
                                },
                                {
                                    index: 'colonia', width: 300, align: 'Center', name: 'COLONIA'
                                },
                                {
                                    index: 'limite1', width: 100, align: 'Center', name: 'limite1', hidden: true
                                },
                                {
                                    index: 'limite2', width: 100, align: 'Center', name: 'limite2', hidden: true
                                },
                                {
                                    index: 'tramo', width: 400, align: 'Center', name: 'TRAMO'
                                },
                                {
                                    index: 'pae', width: 100, align: 'Center', name: 'pae', hidden: true
                                },
                                {
                                    index: 'iddet', width: 100, align: 'Center', name: 'iddet', hidden: true
                                },
                                {
                                    index: 'det_estatus', width: 100, align: 'Center', name: 'det_estatus', hidden: true
                                },
                                {
                                    index: 'fec_imp_det', width: 100, align: 'Center', name: 'fec_imp_det', hidden: true
                                },
                                {
                                    index: 'fec_ent_det', width: 100, align: 'Center', name: 'fec_ent_det', hidden: true
                                },
                                {
                                    index: 'fec_notif_det', width: 100, align: 'Center', name: 'fec_notif_det', hidden: true
                                },
                                {
                                    index: 'hora_notif_det', width: 100, align: 'Center', name: 'hora_notif_det', hidden: true
                                },
                                {
                                    index: 'idministro', width: 100, align: 'Center', name: 'idministro', hidden: true
                                },
                                {
                                    index: 'musunombre', width: 100, align: 'Center', name: 'nom_ministro', hidden: true
                                },
                                {
                                    index: 'tipo_doc', width: 100, align: 'Center', name: 'tipo_doc', hidden: true
                                },
                                {
                                    index: 'nom_doc', width: 100, align: 'Center', name: 'nom_doc', hidden: true
                                }],
                                pager: "#pager", //Pager.                 
                                loadtext: 'Cargando datos...',
                                recordtext: "{0} - {1} de {2} elementos",
                                emptyrecords: 'No hay resultados',
                                pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                                rowNum: "30", // PageSize.
                                rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                                viewrecords: true, //Show the RecordCount in the pager.
                                multiselect: false,
                                sortname: "fid", //login SortColumn
                                sortorder: "asc", //login SortOrder.
                                width: "1900",
                                height: "800",
                                caption: "Movimientos Financieros",
                                subGrid: true,
                                subGridBeforeExpand: function (subgrid_id, row_id) {
                                    var myGrid = $('#grid');
                                    cooperador = myGrid.jqGrid('getRowData', row_id);
                                    fid = cooperador.fid;
                                    fec_final = fecha_hoy();
                                    obr_clv_int = cooperador.obr_clv_int;
                                },
                                subGridRowExpanded: function (subgrid_id, row_id) {
                                    var subgrid_table_id, pager_id;
                                    subgrid_table_id = subgrid_id + "_t";
                                    pager_id = "p_" + subgrid_table_id;
                                    $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                                    jQuery("#" + subgrid_table_id).jqGrid(
                                        {
                                            datatype: function () {
                                                $.ajax(
                                                    {
                                                        url: "../../WebServices/WebServiceMovs.asmx/GetMovsGrid2_psql", //PageMethod
                                                        data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                            "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                            "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                            "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                            "','fecini':'" + '01/01/1900' +
                                                            "','fecfin':'" + fec_final +
                                                            "','fid':'" + fid + "'}", //PageMethod Parametros de entrada
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
                                                id: "folio_cajas"
                                            },
                                            colModel: [
                                                {
                                                    index: 'mov_obra_sifidoc', width: 100, align: 'Center', name: 'ObraS', hidden: true
                                                },
                                                {
                                                    index: 'mov_coop_sifidoc', width: 50, align: 'Center', name: 'CoopS', hidden: true
                                                },
                                                {
                                                    index: 'fec_mov_as400', width: 100, align: 'Center', name: 'FecMov'
                                                },
                                                {
                                                    index: 'usu_sifidoc', width: 100, align: 'Center', name: 'UsuS', hidden: true
                                                },
                                                {
                                                    index: 'monto_abono_sifidoc', width: 150, align: 'Center', name: 'AbonoS', formatter: 'currency', formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }
                                                },
                                                {
                                                    index: 'monto_recargo_sifidoc', width: 150, align: 'Center', name: 'CargoS', formatter: 'currency', formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }
                                                },
                                                {
                                                    index: 'tipo_mov_sifidoc', width: 80, align: 'Center', name: 'TipoMovS', hidden: true
                                                },
                                                {
                                                    index: 'fec_aplic_mov', width: 200, align: 'Center', name: 'FecAplicMov', hidden: true
                                                },
                                                {
                                                    index: 'clave_sifidoc', width: 80, align: 'Center', name: 'ClaveS', hidden: true
                                                },
                                                {
                                                    index: 'consecutivo_sifidoc', width: 50, align: 'Center', name: 'ConsecS', hidden: true
                                                },
                                                {
                                                    index: 'fid', width: 50, align: 'Center', name: 'fid', hidden: true
                                                },
                                                {
                                                    index: 'usucre', width: 50, align: 'Center', name: 'UsuCre'
                                                },
                                                {
                                                    index: 'monto_mov', width: 150, align: 'Center', name: 'Monto', hidden: true
                                                },
                                                {
                                                    index: 'tipo_mov', width: 50, align: 'Center', name: 'TipoMov', hidden: true
                                                },
                                                {
                                                    index: 'id_mov', width: 50, align: 'Center', name: 'IdMov', hidden: true
                                                },
                                                {
                                                    index: 'folio_cajas', width: 150, align: 'Center', name: 'FolioCajas'
                                                },
                                                {
                                                    index: 'titulo_mov', width: 150, align: 'Center', name: 'ConceptoMov'
                                                },
                                                {
                                                    index: 'estatus_mov', width: 100, align: 'Center', name: 'EstatMov'
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
                                            sortname: "folio_cajas", //login SortColumn
                                            sortorder: "asc", //login SortOrder.
                                            width: "1200",
                                            height: "100%",
                                            caption: "Relación de movimientos fianancieros"
                                        }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                                        .navButtonAdd("#" + pager_id,
                                            {
                                                caption: "Transf_Pago",
                                                buttonicon: "ui-icon-document",
                                                onClickButton: function () {
                                                    var myGrid = $("#" + subgrid_table_id);

                                                    var objCoop = cooperador;
                                                    var mySubGrid = $("#" + subgrid_table_id);
                                                    var selectedSubRowId = mySubGrid.jqGrid('getGridParam', 'selrow');
                                                    var objPago = myGrid.jqGrid('getRowData', selectedSubRowId);

                                                    if (parseInt(objPago.IdMov)) {
                                                        if (objPago.TipoMov == '1') {
                                                            $("#lblref_pago").text(objPago.FolioCajas);
                                                            $("#lblfec_pago").text(objPago.FecMov);
                                                            $("#lblmonto_pago").text(objPago.AbonoS);
                                                            $("#txtMontoTransf").val(objPago.AbonoS);
                                                            $("#bodegadatos").data("id_mov", objPago.IdMov);
                                                            $("#lblfid").text(objCoop.fid);
                                                            $("#lblcoop3").text(" : " + objCoop.O_SIFIDOC + " - " + objCoop.COOP_SIFIDOC);
                                                            $("#lblnom_coop").text(objCoop.NOMBRE_FICHA);
                                                            $("#lblcalle_obra").text(objCoop.CALLE);
                                                            $("#lblnom_col").text(objCoop.COLONIA);
                                                            $("#lbltramo").text(objCoop.TRAMO);
                                                            $("#lblestatus_obra").text(objCoop.cestatus);
                                                            $("#lblnum_oficial").text(objCoop.NoOficial);
                                                            $("#bodegadatos").data("mismo_coop_excluir", objCoop.fid);
                                                            $("#bodegadatos").data("misma_obra_origen_destino", obr_clv_int);

                                                            llenarObrasSGP(1);
                                                            MostrarTransfPagos();
                                                        } else {
                                                            alert("El movimiento seleccionado NO es un pago...");
                                                        }
                                                    }
                                                    else {
                                                        alert("Seleccione el pago a transferir...");
                                                    }
                                                },
                                                position: "last",
                                                title: "Movmientos Financieros del Cooperador",
                                                cursor: "pointer"
                                            })

                                    /* .navButtonAdd("#" + pager_id,
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
                                           })*/
                                }

                            }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                            .navButtonAdd('#pager',
                                {
                                    caption: "FichaPredio",
                                    buttonicon: "ui-icon-document",
                                    onClickButton: function () {
                                        var myGrid = $('#grid');
                                        var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                        var pid = myGrid.jqGrid('getCell', selectedRowId, 'pid');
                                        var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                        var coo_estatus = myGrid.jqGrid('getCell', selectedRowId, 'ObrEstInt');
                                        var usuario = $("#bodegadatos").data("idusu");
                                        var idusu = usuario.split(":");


                                        if (pid) {
                                            ConsultaSalidaPredio(idusu[1], oid, pid);
                                        }
                                        else {
                                            alert("Selecciona un cooperador...");
                                        }
                                    },
                                    position: "last",
                                    title: "EdoCta",
                                    cursor: "pointer"
                                });

                    }
                }






                //// FUNCION PRINCIPAL

                $(document).ready(function () {


                    $(".buscar_coop").click(function () {
                        Buscar_Coop(ObtenerFiltro());
                    });

                    var usuario = $("#lblUsuario").html();

                    $("#bodegadatos").data("idusu", usuario.split(":")[1] + ":" + usuario.split(":")[2]);


                    /*        $(".posicion_boton_accion_obraS").click(function () { //Actualizar datos en el registro            
                    
                    
                                var numobra = $("#lblnumobra").html();
                                var accion = parseInt($("#lblaccionobraS").html());
                    
                                ValidarRegistroObraS(accion, numobra);
                            });*/


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


                    function TransferirPago(fid_o, fid_d, id_mov, monto_trans, idusu) {

                        var objTransPago = {
                            "fid_o": fid_o,
                            "fid_d": fid_d,
                            "id_mov": id_mov,
                            "monto_trans": monto_trans,
                            "idusu": idusu
                        }


                        var stringData = JSON.stringify(objTransPago);
                        return $.ajax({
                            type: 'POST',
                            url: "../../WebServices/WebServiceMovs.asmx/TransPago",
                            data: "{objTransPago:" + stringData + "}",
                            contentType: 'application/json; utf-8',
                            dataType: 'json',
                            success: function (data) {
                                if (data.d != null) {
                                    console.log(data.d);
                                }
                            },
                            error: function (responseText, textStatus, errorThrown) {
                                console.log(textStatus + responseText + errorThrown);
                            }
                        });

                    };



                    $(".accion_aceptar_trans_pago").click(function (e) { //Ver documento                   

                        var fid_o = parseInt($("#lblfid").text());
                        var fid_d = parseInt($("#lstcoops").val());
                        var folio_pago = $("#lblref_pago").text();
                        var id_mov = $("#bodegadatos").data("id_mov");
                        var usuario = $("#bodegadatos").data("idusu");
                        var idusu = usuario.split(":")[1];
                        var monto_trans_txt = $("#txtMontoTransf").val();
                        var monto_trans;
                        var monto_pago = parseFloat($("#lblmonto_pago").text());
                        var nom_coop = $("#lblnomcoop_c").text();


                        /*Validar lo capturado evitando espacios en blanco*/
                        monto_trans_txt = $.trim(monto_trans_txt);

                        if (monto_trans_txt.length > 0) {
                            monto_trans = parseFloat(monto_trans_txt);
                        } else {
                            monto_trans = 0;
                        }

                        if (monto_trans <= 0) {
                            alert('ERROR:Debe introducir un valor válido en el monto a transferir.')
                        } else {
                            if (monto_trans > monto_pago) {
                                $("#txtMontoTransf").val();
                                alert("ERROR: El monto a transferir no es correcto es mayor que el monto del pago");
                            } else {

                                var opcion = confirm("¿Deseas transferir la cantidad: " + monto_trans_txt + ' del pago: ' + folio_pago + ' al cooperador: ' + nom_coop + '?');
                                if (opcion == true) {
                                    TransferirPago(fid_o, fid_d, id_mov, monto_trans, idusu)
                                        .done(function (r) {
                                            var mensaje = r.d;
                                            alert(mensaje);
                                            $('#mask, .window').hide();
                                            RedibujarGrid();
                                        })
                                        .fail(function (xhr) {
                                            alert("No fué posible transferir el pago:" + xhr.responseText);
                                        });
                                }
                            }
                        }
                    });

                    //if mask is clicked
                    $('#mask').click(function () {
                        $(this).hide();
                        $('.window').hide();
                    });

                    $('.accion_cancelar_trans_pago').click(function () {
                        $('#mask').hide();
                        $('.window').hide();
                    });


                    $("#colonia").change(function () {
                        llenarCalles($("#colonia").val(), 0);
                    });

                    $('.pasar_total').click(function () {
                        $("#txtMontoTransf").val($("#lblmonto_pago").text());
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


                function MostrarTransfPagos() {
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
                    $("#transf_pagos").css('top', winH / 2 - $("#transf_pagos").height() / 2);
                    $("#transf_pagos").css('left', winW / 2 - $("#transf_pagos").width() / 2);

                    //transition effect
                    $("#transf_pagos").fadeIn(2000);
                }






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


                function llenarObrasSGP(accion) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                        data: "{'accion':'" + accion + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstobras").html('');
                            $(data.d).find("ObrasSGP").each(function () {
                                var option = $(document.createElement('option'));
                                var obr_clv = $(this).find("obra_s").text();
                                var obr_clv_int = $(this).find("obr_clv_int_r").text();
                                var obr_call = $(this).find("calle_r").text();

                                option.html(obr_clv + ' || ' + obr_clv_int + ' || ' + obr_call);
                                option.val(obr_clv_int);
                                $("#lstobras").append(option);
                            });

                            consulta_obra($("#lstobras").val());

                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                function llenarCoops(accion, obr_clv_int, coop_excluir) {

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCoop.asmx/GetCoopsxObra_psql",
                        data: "{'obr_clv_int':'" + obr_clv_int + "','coop_excluir':'" + coop_excluir + "','accion':'" + accion + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstcoops").html('');
                            if (data.d != '<NewDataSet />') {
                                $(data.d).find("coops").each(function () {
                                    var option = $(document.createElement('option'));
                                    var fid = $(this).find("fid_r").text();
                                    var coop_s = $(this).find("coops_s_r").text();
                                    option.html(coop_s + ":" + fid);
                                    option.val(fid);
                                    //Nombre de combo a poblar
                                    $("#lstcoops").append(option);
                                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                                });
                                consulta_coop($("#lstcoops").val());
                            }
                            else {
                                alert('La obra no tiene cooperadores asignados.')
                            }


                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                function consulta_obra(obr_clv_int) {
                    var accion = 0;

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceObras.asmx/GetObra2_psql",
                        data: "{'accion':'" + accion + "','obr_clv_int':'" + obr_clv_int + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $(data.d).find("obra").each(function () {
                                $("#lblobr_calle_destino").html($(this).find("calle_r").text());
                                $("#lblobr_colonia_destino").html($(this).find("colonia_r").text());
                                $("#lblobr_tramo_destino").html($(this).find("tramo_r").text());
                                $("#lblobr_prog_destino").html($(this).find("programa_r").text());
                                $("#lblobr_estatus_destino").html($(this).find("estatus_obra_r").text());
                                $("#lblobr_cta_contable").html($(this).find("obr_opergob_r").text());
                            });


                            if ($("#bodegadatos").data("misma_obra_origen_destino") == obr_clv_int) {
                                coop_excluir = $("#bodegadatos").data("mismo_coop_excluir");
                            }
                            else {
                                coop_excluir = 0;
                            }

                            llenarCoops(1, obr_clv_int, coop_excluir);

                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }

                function consulta_coop(fid) {
                    var accion = 1;

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCoop.asmx/GetCoop_psql",
                        data: "{'fid':'" + fid + "','accion':'" + accion + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $(data.d).find("coop_fid").each(function () {
                                $("#lblnomcoop_c").html($(this).find("mnomficha_r").text());
                                $("#lblctapredial_c").html($(this).find("ctapredial_r").text());
                                $("#lblnooficial_c").html($(this).find("nooficial_r").text());
                            });
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }




            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


            <label>Apellido Paterno:</label><input type="text" name="calle" id="txtapaterno" style="width:250px"
                maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>Apellido Materno:</label><input
                type="text" name="calle" id="txtamaterno" style="width:250px"
                maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>Nombres:</label><input type="text"
                name="calle" id="txtnombres" style="width:250px" maxlength="120" /><br /><br />
            <label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px"
                maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>Nombre de Colonia:</label><input
                type="text" name="calle" id="txtnomcolonia" style="width:250px"
                maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>Nombre Ficha:</label><input
                type="text" name="calle" id="txtnomficha" style="width:250px" maxlength="120" /><br /><br />
            <label>No.Coop (fid):</label><input type="text" name="coop" id="txtidcoop" style="width:250px"
                maxlength="10" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>No. Cooperador
                SIFIDOC:</label><input type="text" name="obra" id="txtcoopS" style="width:250px"
                maxlength="13" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label>CTA_PREDIAL:</label><input
                type="text" name="ctapredial" id="txtctapredial" style="width:250px"
                maxlength="12" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_coop">
                <== Buscar Cooperador==>
            </a><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp
            <div id="bodegadatos"></div>

            <div id="boxes">
                <div id="transf_pagos" class="window">
                    <table class="t_modulo">
                        <tbody>
                            <tr>
                                <td class="titulo_modulo" colspan="4">TRANSFERENCIA DE PAGO</td>
                            </tr>
                            <tr>
                                <td class="d">Referencia de Pago Origen:</td>
                                <td class="e"><label id="lblref_pago"></label></td>
                                <td class="titulo_modulo2" colspan="2">DATOS DE COOPERADOR DESTINO</td>
                            </tr>
                            <tr>
                                <td class="d">Fecha de Pago:</td>
                                <td class="e"><label id="lblfec_pago"></label></td>
                                <td class="d">OBRA:</td>
                                <td class="e"><select class="list_captura" name="obras" id="lstobras"
                                        onchange="consulta_obra(this.value)"></select></td>
                            </tr>
                            <tr>
                                <td class="d">Monto del Pago:</td>
                                <td class="e"><label id="lblmonto_pago"></label><a href="#" class="pasar_total"> >>>
                                    </a></td>
                                <td class="d">Calle Obra Destino:</td>
                                <td class="e"><label id="lblobr_calle_destino"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Monto de Transf.:</td>
                                <td class="e"><input type="text" name="calle" id="txtMontoTransf" size="10"
                                        onkeypress="return filterFloat(event,this);" /></td>
                                <td class="d">Colonia Obra Destino:</td>
                                <td class="e"><label id="lblobr_colonia_destino"></label></td>
                            </tr>
                            <tr>
                                <td class="titulo_modulo2" colspan="2">DATOS DE COOPERADOR ORIGEN</td>
                                <td class="d">Tramo de Obra Destino:</td>
                                <td class="e"><label id="lblobr_tramo_destino"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Cve_Cooperador (fid:coop_s):</td>
                                <td class="e"><label id="lblfid"></label><label id="lblcoop3"></label></td>
                                <td class="d">Programa de Obra Destino:</td>
                                <td class="e"><label id="lblobr_prog_destino"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Nombre del Cooperador:</td>
                                <td class="e"><label id="lblnom_coop"></label></td>
                                <td class="d">Estatus Obra Destino:</td>
                                <td class="e"><label id="lblobr_estatus_destino"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Calle de Obra:</td>
                                <td class="e"><label id="lblcalle_obra"></label></td>
                                <td class="d">Cuenta Contable:</td>
                                <td class="e"><label id="lblobr_cta_contable"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Colonia de la Obra:</td>
                                <td class="e"><label id="lblnom_col"></label></td>
                                <td class="d">Cooperadores de:</td>
                                <td class="e"><select class="list_captura" name="cooperadores" id="lstcoops"
                                        onchange="consulta_coop(this.value)"></select></td>
                            </tr>
                            <tr>
                                <td class="d">Tramo:</td>
                                <td class="e"><label id="lbltramo"></label></td>
                                <td class="d">Nombre de Cooperador:</td>
                                <td class="e"><label id="lblnomcoop_c"></label></td>
                            </tr>
                            <tr>
                                <td class="d">Estatus de la Obra:</td>
                                <td class="e"><label id="lblestatus_obra"></label></td>
                                <td class="d">Cta. Predial:</td>
                                <td class="e"><label id="lblctapredial_c"></label></td>
                            </tr>
                            <tr>
                                <td class="d">No. Oficial:</td>
                                <td class="e"><label id="lblnum_oficial"></label></td>
                                <td class="d">No. Oficial:</td>
                                <td class="e"><label id="lblnooficial_c"></label></td>
                            </tr>
                            <tr>
                                <td class="boton_dialog" colspan="2"><a href="#"
                                        class="accion_cancelar_trans_pago">CANCELAR</a></td>
                                <td class="boton_dialog" colspan="2"><a href="#"
                                        class="accion_aceptar_trans_pago">TRANSFERIR</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="mask"></div>
            </div>
        </asp:Content>