<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_exp_coops_txt.aspx.vb" Inherits="Admin_procesos_consultar_exp_coops_txt" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>



        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

            <script type="text/javascript" language="JavaScript">

                //// FUNCIONES EXTERNAS





                function ActualizarPagos(idusu) {
                    //alert(img);
                    var url1 = "../Procesos/cargar_pagos.html?ResponseType=Edit&idusu=" + idusu;
                    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=800,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
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


                var primerslap = false;
                var segundoslap = false;

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

                ///**** FUNCION PRINCIPAL  ******/////

                $(document).ready(function () {

                    var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                    var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                    idusu = arrusuario[2];
                    $("#bodegadatos").data("idusu", idusu);
                    $("#bodegadatos").data("obr_clv_int_in", 0);


                    $(".btn_cancelar_rep2").click(function (e) {
                        //Cancel the link behavior
                        //e.preventlogin();
                        $('#mask, .window').hide();
                    });


                    $(".btn_aceptar_rep2").click(function (e) {

                        var fec_lim_rep2 = ConvertirCadenaToFecha($("#txtfec_act_rep2").val());
                        var estatus_obra = $("#lstestatus_obra").val();


                        var date = new Date();
                        var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                        if (fec_lim_rep2 <= hoy) {
                            var fec_lim_txt = fec_lim_rep2.getDate().toString() + '/' + (fec_lim_rep2.getMonth() + 1).toString() + '/' + fec_lim_rep2.getFullYear().toString();
                            LeerObrasRep2(fec_lim_txt, estatus_obra)
                                .done(function (r) {
                                    var obras_rep2 = [];
                                    var data = r.d;

                                    if (data != '<NewDataSet />') {
                                        $(data).find("obras_rep2").each(function () {
                                            var objObraRep2 = {
                                                "oid": 0,
                                                "calle": '',
                                                "colonia": '',
                                                "tramo": '',
                                                "obr_clv_int": 0,
                                                "obr_clv": '',
                                                "obr_cost": 0,
                                                "obr_prog2": 0,
                                                "nomprog": '',
                                                "cestatus": '',
                                                "obr_opergob": '',
                                                "total_mts_frente": 0,
                                                /*"total_inc": 0,
                                                "costo_total_obra": 0,
                                                "capital_pagado": 0,
                                                "total_recargos": 0,
                                                "cargos_pagados": 0,*/
                                                "saldo_sin": 0,
                                                "saldo_con": 0,
                                            }

                                            objObraRep2.oid = $(this).find("out_oid").text();
                                            objObraRep2.calle = $(this).find("out_calle").text();
                                            objObraRep2.colonia = $(this).find("out_colonia").text();
                                            objObraRep2.tramo = $(this).find("out_tramo").text();
                                            objObraRep2.obr_clv_int = $(this).find("out_obr_clv_int").text();
                                            objObraRep2.obr_clv = '\'' + $(this).find("out_obr_clv").text();
                                            objObraRep2.obr_cost = $(this).find("out_obr_cost").text();
                                            objObraRep2.obr_prog2 = $(this).find("out_obr_prog2").text();
                                            objObraRep2.nomprog = $(this).find("out_nomprog").text();
                                            objObraRep2.cestatus = $(this).find("out_cestatus").text();
                                            objObraRep2.obr_opergob = $(this).find("out_obr_opergob").text();
                                            objObraRep2.total_mts_frente = $(this).find("out_total_mts_frente").text();
                                            /* objObraRep2.total_inc = $(this).find("out_total_inc").text();
                                             objObraRep2.costo_total_obra = $(this).find("out_costo_total_obra").text();
                                             objObraRep2.capital_pagado = $(this).find("out_capital_pagado").text();
                                             objObraRep2.total_recargos = $(this).find("out_total_recargos").text();
                                             objObraRep2.cargos_pagados = $(this).find("out_cargos_pagados").text();*/
                                            objObraRep2.saldo_sin = $(this).find("out_saldo_sin").text();
                                            objObraRep2.saldo_con = $(this).find("out_saldo_con").text();
                                            obras_rep2.push(objObraRep2);
                                        });


                                        $("#rep2_xls").excelexportjs({
                                            containerid: "dvjson",
                                            datatype: 'json',
                                            dataset: obras_rep2,
                                            columns: getColumns(obras_rep2),
                                            worksheetName: "Obras_Rep2",
                                            encoding: "utf-8",
                                            locale: 'es-MX'
                                        });

                                        /* $(this).attr('isaul.xls', fileName).attr('href', uri).attr('target', '_blank');*/

                                    } else {

                                        alert('No se encontraron datos que relacionar.')
                                    }
                                })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falle al recuperar datos de las obras.");
                                })
                        }
                        else {
                            alert('Fecha errónea, favor de verificar.');
                        }
                    });


                    $(".btn_cancelar_rep3").click(function (e) {
                        //Cancel the link behavior
                        //e.preventlogin();
                        $('#mask, .window').hide();
                    });

                    $(".btn_aceptar_rep3").click(function (e) {

                        var fec_lim_rep3 = ConvertirCadenaToFecha($("#txtfec_act_rep3").val());
                        var obr_clv_int = $("#bodegadatos").data("obr_clv_int_in");


                        var date = new Date();
                        var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
                        var hoy_txt = date.getDate().toString() + (date.getMonth() + 1).toString() + date.getFullYear().toString();



                        if (fec_lim_rep3 <= hoy) {
                            var fec_lim_txt = fec_lim_rep3.getDate().toString() + '/' + (fec_lim_rep3.getMonth() + 1).toString() + '/' + fec_lim_rep3.getFullYear().toString();
                            LeerObrasRep3(fec_lim_txt, obr_clv_int)
                                .done(function (r) {
                                    var obras_rep3 = [];
                                    var data = r.d;

                                    if (data != '<NewDataSet />') {
                                        registro = 'obr_clv_int,' + 'opergob,' + 'fid,' + 'obra_s,' + 'coops_s,' + 'mnomficha,' + 'mts_frente,' + 'cosot_mto,' + 'costos_total,' + 'saldo_sin,' + 'saldo_con' + '\r\n';
                                        $(data).find("obras_rep3").each(function () {
                                            registro = registro + $(this).find("out_obr_clv_int").text() + ',' +
                                                $(this).find("out_opergob").text() + ',' +
                                                $(this).find("out_fid").text() + ',' +
                                                '\'' + $(this).find("out_obra_s").text() + ',' +
                                                $(this).find("out_coop_s").text() + ',' +
                                                $(this).find("out_mnomficha").text() + ',' +
                                                $(this).find("out_mts_frente").text() + ',' +
                                                $(this).find("out_costo_mto").text() + ',' +
                                                $(this).find("out_costo_total").text() + ',' +
                                                $(this).find("out_saldo_sin").text() + ',' +
                                                $(this).find("out_saldo_con").text() + '\r\n';

                                        });

                                        var blob = new Blob([registro], { type: "text/plain;charset=utf-8" });
                                        saveAs(blob, "Coops_" + hoy_txt + ".csv");
                                        $("#bodegadatos").data("obr_clv_int_in", 0);
                                        /* $(this).attr('isaul.xls', fileName).attr('href', uri).attr('target', '_blank');*/

                                    } else {

                                        alert('No se encontraron datos que relacionar.')
                                    }
                                })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falle al recuperar datos de las obras.");
                                })
                        }
                        else {
                            alert('Fecha errónea, favor de verificar.');
                        }
                    });

                    $(".btn_cancelar_rep4").click(function (e) {
                        //Cancel the link behavior
                        //e.preventlogin();
                        $('#mask, .window').hide();
                    });

                    $(".btn_aceptar_rep4").click(function (e) {

                        var fec_lim_rep4 = ConvertirCadenaToFecha($("#txtfect_act_rep4").val());
                        var obr_clv_int = $("#bodegadatos").data("obr_clv_int_in");


                        var date = new Date();
                        var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
                        var hoy_txt = date.getDate().toString() + (date.getMonth() + 1).toString() + date.getFullYear().toString();



                        if (fec_lim_rep4 <= hoy) {
                            if (obr_clv_int != 0) {
                                var fec_lim_txt = fec_lim_rep4.getDate().toString() + '/' + (fec_lim_rep4.getMonth() + 1).toString() + '/' + fec_lim_rep4.getFullYear().toString();
                                LeerObrasRep4(fec_lim_txt, obr_clv_int)
                                    .done(function (r) {
                                        var obras_rep3 = [];
                                        var data = r.d;

                                        if (data != '<NewDataSet />') {
                                            registro = 'oid,' + 'obr_clv_int,' + 'fid,' + 'obra_sifidoc,' + 'coopid,' + 'costo_total,' + 'fecha_mov,' + 'monto_mov,' + 'id_mov,' + 'folio_cajas' + '\r\n';
                                            $(data).find("obras_rep4").each(function () {
                                                registro = registro + $(this).find("out_oid").text() + ',' +
                                                    $(this).find("out_obr_clv_int").text() + ',' +
                                                    $(this).find("out_fid").text() + ',' +
                                                    '\'' + $(this).find("out_obra_sifidoc").text() + ',' +
                                                    $(this).find("out_coopid").text() + ',' +
                                                    $(this).find("out_costo_total").text() + ',' +
                                                    $(this).find("out_fecha_mov").text() + ',' +
                                                    $(this).find("out_monto_mov").text() + ',' +
                                                    $(this).find("out_id_mov").text() + ',' +
                                                    $(this).find("out_folio_cajas").text() + '\r\n';
                                            });

                                            var blob = new Blob([registro], { type: "text/plain;charset=utf-8" });
                                            saveAs(blob, "MovsCoops_" + hoy_txt + ".csv");
                                            $("#bodegadatos").data("obr_clv_int_in", 0);
                                            /* $(this).attr('isaul.xls', fileName).attr('href', uri).attr('target', '_blank');*/
                                        } else {

                                            alert('No se encontraron datos que relacionar.')
                                        }
                                    })
                                    .fail(function (xhr) {
                                        console.log(xhr.responseText);
                                        alert("Falle al recuperar datos de las obras.");
                                    })
                            }
                            else {
                                alert('Selecciona una obra...');
                            }
                        }
                        else {
                            alert('Fecha errónea, favor de verificar.');
                        }
                    });


                    $('#mask').click(function () {
                        $(this).hide();
                        $('.window').hide();
                    });



                    $(".boton_dialog ").click(function (e) {

                        var reglas_usu = [];

                        var idusu = $("#bodegadatos").data("idusu");

                        ConsultaReglasUsuario(idusu, 0)
                            .done(function (r) {
                                var regla = $.trim(r.d);
                                if (regla != "<NewDataSet />") {  // Si encontró reglas para el usuario, preparar las propiedades correspondientes

                                    $(r.d).find("regla").each(function () {

                                        var objReglaUsu = {
                                            "idrol": 0,
                                            "crolnombre": '',
                                            "croldescripcion": 0,
                                            "idaccion": 0,
                                            "etiqueta_accion": 0,
                                            "idtarea": 0,
                                            "etiqueta_tarea": '',
                                            "fec_cre": '01/01/1900',
                                            "musuid": 0,
                                            "musunombre": '',
                                            "musucuenta": 0
                                        }

                                        objReglaUsu.idrol = parseInt($(this).find("idrol_r").text());
                                        objReglaUsu.crolnombre = $(this).find("crolnombre_r").text();
                                        objReglaUsu.croldescripcion = $(this).find("croldescripcion_r").text();
                                        objReglaUsu.idaccion = parseInt($(this).find("idaccion_r").text());
                                        objReglaUsu.etiqueta_accion = $(this).find("etiqueta_accion_r").text();
                                        objReglaUsu.idtarea = parseInt($(this).find("idtarea_r").text());
                                        objReglaUsu.etiqueta_tarea = $(this).find("etiqueta_tarea_r").text();
                                        objReglaUsu.fec_cre = $(this).find("fec_cre_r").text();
                                        objReglaUsu.musuid = parseInt($(this).find("musuid_r").text());
                                        objReglaUsu.musunombre = $(this).find("musunombre_r").text();
                                        objReglaUsu.musucuenta = parseInt($(this).find("musucuenta_r").text());
                                        reglas_usu.push(objReglaUsu);
                                    });

                                    /*Tarea 23*/

                                    var puede_consultar_obra = reglas_usu.find(tarea => (tarea.idtarea == 23 && tarea.idaccion == 3));

                                    if (puede_consultar_obra == null) {
                                        alert('Su usuario no tiene permiso de consultar las obras.');
                                    }
                                    else {
                                        Buscar_obra();
                                    }

                                    /*Tarea 24*/
                                    var puede_emitir_rep_obras_xls = reglas_usu.find(tarea => (tarea.idtarea === 24 && tarea.idaccion == 3));

                                    if (puede_emitir_rep_obras_xls == null) {
                                        $("#bodegadatos").data("emitir_rep_obras_xls", 0);
                                    }
                                    else {
                                        $("#bodegadatos").data("emitir_rep_obras_xls", 1);
                                    }

                                    /*Tarea 25*/

                                    var puede_emitir_rep_coops_txt = reglas_usu.find(tarea => (tarea.idtarea === 25 && tarea.idaccion == 3));

                                    if (puede_emitir_rep_coops_txt.idtarea == 'null') {
                                        $("#bodegadatos").data("emitir_rep_coops_txt", 0);
                                    }
                                    else {
                                        $("#bodegadatos").data("emitir_rep_coops_txt", 1);
                                    }

                                    /*Tarea 26*/

                                    var puede_emitir_rep_obra_coops_xls = reglas_usu.find(tarea => (tarea.idtarea === 26 && tarea.idaccion == 3));

                                    if (puede_emitir_rep_obra_coops_xls.idtarea == 'null') {
                                        $("#bodegadatos").data("emitir_rep_obra_coops_xls", 0);
                                    }
                                    else {
                                        $("#bodegadatos").data("emitir_rep_obra_coops_xls", 1);
                                    }

                                    /*Tarea 27*/

                                    var puede_emitir_rep_coops_movs_xls = reglas_usu.find(tarea => (tarea.idtarea === 27 && tarea.idaccion == 3));

                                    if (puede_emitir_rep_coops_movs_xls.idtarea == 'null') {
                                        $("#bodegadatos").data("emitir_rep_coops_movs_xls", 0);
                                    }
                                    else {
                                        $("#bodegadatos").data("emitir_rep_coops_movs_xls", 1);
                                    }

                                }
                                else {
                                    alert("El usuario no tiene permiso para consultar las Obras.");
                                }

                            }).fail(function (r) {
                                alert("No fué posible consultar las reglas del usuario.");
                            });



                    });

                });






                function ConsultaReglasUsuario(idusu, accion) {

                    return $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json; utf-8',
                        url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetUsuAccionTarea",
                        data: "{'idusu':'" + idusu + "','accion':'" + accion + "'}",
                    });
                }

                function ObtenerFiltro() {
                    var nomcalle = $.trim($('#txtnomobra').val());
                    if (nomcalle.length <= 0 || nomcalle.length > 20) {
                        nomcalle = '';
                    }

                    var num_obra = $.trim($('#txtobra_s').val());
                    if (num_obra.length <= 0 || !$.isNumeric(num_obra)) {
                        num_obra = '';
                    }

                    var num_obra_sgp = $.trim($('#txtobra_sgp').val());
                    if (num_obra_sgp.length <= 0 || !$.isNumeric(num_obra_sgp)) {
                        num_obra_sgp = '';
                    }

                    var filtro = num_obra + "," + nomcalle + ",," + num_obra_sgp + ",";
                    return filtro;
                }



                function Buscar_obra() {



                    var filtro = ObtenerFiltro();
                    var filtro2;


                    var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                    var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                    var idusu = arrusuario[2];

                    if ($("#grid")[0].grid) {
                        $.jgrid.gridUnload("#grid");
                        //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    }

                    $("#grid").jqGrid(
                        {
                            datatype: function () {
                                $.ajax(
                                    {
                                        url: "../../WebServices/WebServiceObras.asmx/GetObra_psql", //PageMethod
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
                                id: "b.obr_clv_int"
                            },
                            colModel: [
                                {
                                    index: 'obr_clv_int', width: 120, align: 'center',
                                    name: 'ClvObra'
                                },
                                {
                                    index: 'obr_clv2', width: 220, align: 'center',
                                    name: 'Obra'
                                },
                                {
                                    index: 'calle', width: 300, align: 'center',
                                    name: 'Calle'
                                },
                                {
                                    index: 'colonia', width: 300, align: 'center',
                                    name: 'Colonia'
                                },
                                {
                                    index: 'tramo', width: 500, align: 'Center',
                                    name: 'Tramo'
                                },
                                {
                                    index: 'nomprog', width: 100, align: 'center',
                                    name: 'Prog'
                                },
                                {
                                    index: 'descrip_tipo_obr', width: 200, align: 'center',
                                    name: 'TipoObra'
                                },
                                {
                                    index: 'cestatus', width: 300, align: 'center',
                                    name: 'EstObra'
                                },
                                {
                                    index: 'obr_fec_pub1', width: 160, align: 'center',
                                    name: 'FecPub1'
                                },
                                {
                                    index: 'evid_pub1', width: 200, align: 'center',
                                    name: 'EvidPub1', hidden: true
                                },
                                {
                                    index: 'evid_pub1', width: 200, align: 'center',
                                    name: 'EvidPub1_vinc', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                    }
                                },
                                {
                                    index: 'obr_fec_pub2', width: 160, align: 'center',
                                    name: 'FecPub2'
                                },
                                {
                                    index: 'evid_pub2', width: 200, align: 'center',
                                    name: 'EvidPub2', hidden: true
                                },
                                {
                                    index: 'evid_pub2', width: 200, align: 'center',
                                    name: 'EvidPub2_vinc', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                    }
                                },
                                {
                                    index: 'obr_fecinip', width: 160, align: 'center',
                                    name: 'FecIniPag'
                                },
                                {
                                    index: 'obr_fecvenp', width: 160, align: 'center',
                                    name: 'FecVenP'
                                },
                                {
                                    index: 'obr_npago', width: 80, align: 'center',
                                    name: 'NumPagos'
                                },
                                {
                                    index: 'obr_fec_ini_proc', width: 160, align: 'center',
                                    name: 'FecIniProc'
                                },
                                {
                                    index: 'obr_idtipo_recurso', width: 60, align: 'center',
                                    name: 'IdTipoRecurso', hidden: true
                                },
                                {
                                    index: 'obr_descrip_tipo_recurso', width: 200, align: 'center',
                                    name: 'DescripTipoRec'
                                },
                                {
                                    index: 'evid_obra_proc', width: 200, align: 'center',
                                    name: 'EvidObrProc', hidden: true
                                },
                                {
                                    index: 'evid_obra_proc', width: 200, align: 'center',
                                    name: 'EvidObrProc_vinc', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                    }
                                },
                                {
                                    index: 'obr_fec_ini_cob', width: 160, align: 'center',
                                    name: 'FecIniCob'
                                },
                                {
                                    index: 'evid_termino_obra', width: 200, align: 'center',
                                    name: 'EvidTermObr', hidden: true
                                },
                                {
                                    index: 'evid_termino_obra', width: 200, align: 'center',
                                    name: 'EvidTermObr_vinc', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                    }
                                },
                                {
                                    index: 'obr_fec_canc', width: 160, align: 'center',
                                    name: 'ObrFecCanc'
                                },
                                {
                                    index: 'no_contrato', width: 300, align: 'center',
                                    name: 'NumContrato'
                                },
                                {
                                    index: 'gastos_admvos', width: 300, align: 'center',
                                    name: 'GastosAdmvos'
                                },
                                {
                                    index: 'oid', width: 80, align: 'Center',
                                    name: 'oid'
                                },
                                {
                                    index: 'geom', width: 300, align: 'Center',
                                    name: 'Geom', hidden: true
                                },
                                {
                                    index: 'idsol', width: 100, align: 'Center',
                                    name: 'IdSol', hidden: true
                                },
                                {
                                    index: 'sector', width: 100, align: 'Center',
                                    name: 'Sector', hidden: true
                                },
                                {
                                    index: 'subsector', width: 200, align: 'center',
                                    name: 'SubSector', hidden: true
                                },
                                {
                                    index: 'cvecalle', width: 300, align: 'center',
                                    name: 'CveCalle', hidden: true
                                },
                                {
                                    index: 'idpoligono', width: 350, align: 'center',
                                    name: 'idpoligono', hidden: true
                                },
                                {
                                    index: 'id_implan', width: 220, align: 'center',
                                    name: 'Id_Implan', hidden: true
                                },
                                {
                                    index: 'usrmod', width: 135, align: 'center',
                                    name: 'usrmod', hidden: true
                                },
                                {
                                    index: 'fec_mod', width: 220, align: 'center',
                                    name: 'fec_mod', hidden: true
                                },
                                {
                                    index: 'col_clv2', width: 220, align: 'center',
                                    name: 'col_clv2', hidden: true
                                },
                                {
                                    index: 'limite1', width: 220, align: 'center',
                                    name: 'limite1', hidden: true
                                },
                                {
                                    index: 'limite2', width: 220, align: 'center',
                                    name: 'limite2', hidden: true
                                },
                                {
                                    index: 'obr_estatus', width: 100, align: 'center',
                                    name: 'obr_estatus', hidden: true
                                },
                                {
                                    index: 'progmun', width: 220, align: 'center',
                                    name: 'progmun', hidden: true
                                },
                                {
                                    index: 'progcoop', width: 220, align: 'center',
                                    name: 'progcoop', hidden: true
                                },
                                {
                                    index: 'obr_clv', width: 220, align: 'center',
                                    name: 'obr_clv', hidden: true
                                },
                                {
                                    index: 'obr_mts', width: 220, align: 'center',
                                    name: 'obr_mts', hidden: true
                                },
                                {
                                    index: 'obr_cost', width: 220, align: 'center',
                                    name: 'obr_cost', hidden: true
                                },
                                {
                                    index: 'obr_int', width: 220, align: 'center',
                                    name: 'obr_int', hidden: true
                                },
                                {
                                    index: 'obr_fecha', width: 220, align: 'center',
                                    name: 'obr_fecha', hidden: true
                                },
                                {
                                    index: 'obr_cost_total', width: 220, align: 'center',
                                    name: 'obr_cost_total', hidden: true
                                },
                                {
                                    index: 'obr_inc', width: 220, align: 'center',
                                    name: 'obr_inc', hidden: true
                                },
                                {
                                    index: 'obr_opergob', width: 220, align: 'center',
                                    name: 'obr_opergob', hidden: true
                                },
                                {
                                    index: 'obr_prog2', width: 150, align: 'center',
                                    name: 'obr_prog2', hidden: true
                                },
                                {
                                    index: 'obr_sis', width: 150, align: 'center',
                                    name: 'obr_sis', hidden: true
                                },
                                {
                                    index: 'col_nom', width: 220, align: 'center',
                                    name: 'col_nom', hidden: true
                                },
                                {
                                    index: 'obr_nat', width: 220, align: 'center',
                                    name: 'obr_nat', hidden: true
                                }
                            ],
                            pager: "#pager", //Pager.                 
                            loadtext: 'Cargando datos...',
                            recordtext: "{0} - {1} de {2} elementos",
                            emptyrecords: 'No hay resultados',
                            pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                            rowNum: "20", // PageSize.
                            rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                            viewrecords: true, //Show the RecordCount in the pager.
                            multiselect: false,
                            sortname: "obr_clv", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1900",
                            height: "800",
                            caption: "OBRAS",
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
                                            id: "fid"
                                        },
                                        colModel: [
                                            {
                                                index: 'oid', width: 80, align: 'Center', name: 'oid', hidden: true
                                            },
                                            {
                                                index: 'obr_clv_int', width: 100, align: 'Center', name: 'obr_clv_int', hidden: true
                                            },
                                            {
                                                index: 'pid', width: 50, align: 'Center', name: 'pid'
                                            },
                                            {
                                                index: 'obr_clv', width: 80, align: 'Center', name: 'obr_clv'
                                            },
                                            {
                                                index: 'coopid', width: 50, align: 'Center', name: 'coopid'
                                            },
                                            {
                                                index: 'calle', width: 100, align: 'Center', name: 'calle', hidden: true
                                            },
                                            {
                                                index: 'colonia', width: 100, align: 'Center', name: 'colonia', hidden: true
                                            },
                                            {
                                                index: 'tramo', width: 80, align: 'Center', name: 'tramo', hidden: true
                                            },
                                            {
                                                index: 'costo_mto', width: 100, align: 'Center', name: 'costo_mto', hidden: true
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
                                                index: 'descrip_tipo_obr', width: 100, align: 'Center', name: 'descrip_tipo_obr', hidden: true
                                            },
                                            {
                                                index: 'estatus_obra', width: 100, align: 'Center', name: 'estatus_obra', hidden: true
                                            },
                                            {
                                                index: 'nomprog', width: 100, align: 'Center', name: 'nomprog', hidden: true
                                            },
                                            {
                                                index: 'progdescrip', width: 100, align: 'Center', name: 'progdescrip', hidden: true
                                            },
                                            {
                                                index: 'fid', width: 50, align: 'Center', name: 'fid'
                                            },
                                            {
                                                index: 'nooficial', width: 50, align: 'Center', name: 'nooficial'
                                            },
                                            {
                                                index: 'ctapredial', width: 80, align: 'Center', name: 'ctapredial'
                                            },
                                            {
                                                index: 'coo_clv2', width: 100, align: 'Center', name: 'coo_clv2', hidden: true
                                            },
                                            {
                                                index: 'mnomficha', width: 200, align: 'Center', name: 'mnomficha'
                                            },
                                            {
                                                index: 'mts_frente', width: 50, align: 'Center', name: 'mts_frente'
                                            },
                                            {
                                                index: 'inc', width: 50, align: 'Center', name: 'inc', hidden: true
                                            },
                                            {
                                                index: 'capital_sin_inc', width: 100, align: 'Center', name: 'capital_sin_inc', hidden: true
                                            },
                                            {
                                                index: 'capital', width: 100, align: 'Center', name: 'capital', hidden: true
                                            },
                                            {
                                                index: 'capital_pagado', width: 150, align: 'Center', name: 'capital_pagado', hidden: true
                                            },
                                            {
                                                index: 'cargos_pagados', width: 100, align: 'Center', name: 'cargos_pagados', hidden: true
                                            },
                                            {
                                                index: 'desctos_aplicados', width: 100, align: 'Center', name: 'desctos_aplicados', hidden: true
                                            },
                                            {
                                                index: 'recargos_netos', width: 100, align: 'Center', name: 'recargos_netos', hidden: true
                                            },
                                            {
                                                index: 'total_pagar', width: 100, align: 'Center', name: 'total_pagar', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }
                                            },
                                            {
                                                index: 'mapellidom', width: 100, align: 'Center', name: 'mapellidom', hidden: true
                                            },
                                            {
                                                index: 'mapellidop', width: 300, align: 'Center', name: 'mapellidop', hidden: true
                                            },
                                            {
                                                index: 'mnombres', width: 100, align: 'Center', name: 'mnombres', hidden: true
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
                                        sortname: "fid", //login SortColumn
                                        sortorder: "asc", //login SortOrder.
                                        width: "1200",
                                        height: "100%",
                                        caption: "COOPERADORES"
                                    }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                                /* .navButtonAdd("#" + pager_id,
                                       {
                                           caption: "RepCoopsTXT...",
                                           buttonicon: "ui-icon-document",
                                           onClickButton: function () {
                                               var myGrid = $("#" + subgrid_table_id);
                                               selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                               var obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'obr_clv_int');
                                               
                                               if (obr_clv_int) {
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
                                                    var programa = obra.obr_prog2 + ':' + obra.Prog;
                                                    if (fid) {
                                                        GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv, programa, idusu, fid, obra.NumPagos, obra.FecVenP, coopid);
                                                    }
                                                    else {
                                                        GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv, programa, idusu, 0, obra.NumPagos, obra.FecVenP, '000');
                                                    }
                                                },
                                                position: "last",
                                                title: "Cooperadores",
                                                cursor: "pointer"
                                            })*/


                            }

                        }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                        /*.navButtonAdd('#pager',
                                 {
                                     caption: "RepObras_XLS",
                                     buttonicon: "ui-icon-document",
                                     onClickButton: function () {
                                         var myGrid = $('#grid');
                                         var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                         var obr_clv_int_txt = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
         
                                         
                                         if ($("#bodegadatos").data("emitir_rep_obras_xls")==1) { --Si tiene permiso para extraer el archivo de actualización de cooperadores
                                             llenarEstatusObra();
                                             
                                             $("#txtfec_act_rep2").val('');
                                             MostrarModuloFecLimRep2();
                                             }
                                             else {
                                                 alert('No cuenta con los privilegios para generar el reporte.')
                                             }                                
                                     },
                                     position: "last",
                                     title: "Cooperadores",
                                     cursor: "pointer"
                                    
                                 })*/

                        .navButtonAdd('#pager',
                            {
                                caption: "RepCoops_XLS",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var obr_clv_int_txt = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                                    $("#bodegadatos").data("obr_clv_int_in", obr_clv_int_txt);


                                    if ($("#bodegadatos").data("emitir_rep_obra_coops_xls") == 1) { /*Si tiene permiso para extraer el archivo de saldo_sin y saldo_con de cooperadores*/
                                        $("#txtfec_act_rep3").val('');
                                        MostrarModuloFecLimRep3();
                                    }
                                    else {
                                        alert('No cuenta con los privilegios para generar el reporte.')
                                    }
                                },
                                position: "last",
                                title: "Cooperadores",
                                cursor: "pointer"

                            })

                        .navButtonAdd('#pager',
                            {
                                caption: "RepMovsCoops_XLS",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var obr_clv_int_txt = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                                    $("#bodegadatos").data("obr_clv_int_in", obr_clv_int_txt);


                                    if ($("#bodegadatos").data("emitir_rep_coops_movs_xls") == 1) { /*Si tiene permiso para extraer el archivo de saldo_sin y saldo_con de cooperadores*/
                                        $("#txtfec_act_rep4").val('');
                                        MostrarModuloFecLimRep4();
                                    }
                                    else {
                                        alert('No cuenta con los privilegios para generar el reporte.')
                                    }
                                },
                                position: "last",
                                title: "MovsCoops",
                                cursor: "pointer"

                            })
                        /********   OBRA SELECCIONADA FORMATO TXT*******/

                        .navButtonAdd('#pager',
                            {
                                caption: "ObraCoops_TXT",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var obr_clv_int_txt = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');

                                    if ($("#bodegadatos").data("emitir_rep_coops_txt") == 1) {
                                        if (parseInt(obr_clv_int_txt) > 0) { /*Si tiene permiso para extraer el archivo de actualización de cooperadores*/
                                            LeerCoopsTXT(parseInt(obr_clv_int_txt))
                                                .done(function (r) {
                                                    var registro = '';
                                                    var datos = r.d;

                                                    $(datos).find("obras").each(function () {

                                                        registro = registro + $(this).find("sistemar").text() + '|' +
                                                            $(this).find("cooperadorr").text() + '|' +
                                                            $(this).find("nombrer").text() + '|' +
                                                            $(this).find("caller").text() + '|' +
                                                            $(this).find("numeror").text() + '|' +
                                                            $(this).find("coloniar").text() + '|' +
                                                            $(this).find("obrar").text() + '|' +
                                                            $(this).find("numero_cooperadorr").text() + '|' +
                                                            $(this).find("estatusr").text() + '|' +
                                                            $(this).find("rfcr").text() + '|' +
                                                            $(this).find("razon_socialr").text() + '|' +
                                                            $(this).find("domicilior").text() + '\r\n';

                                                    });

                                                    var blob = new Blob([registro], { type: "text/plain;charset=utf-8" });
                                                    saveAs(blob, "CooperadoresObra.txt");

                                                })
                                                .fail(function (xhr) {
                                                    console.log(xhr.responseText);
                                                })
                                        }
                                        else {
                                            alert('Seleccione una obra...');
                                        }
                                    }
                                    else {
                                        alert('No posee permiso para generar el reporte.');
                                    }


                                },
                                position: "last",
                                title: "RepObra_TXT",
                                cursor: "pointer"
                            })

                        /********   TODAS LAS OBRAS FORMATO TXT*******/


                        .navButtonAdd('#pager',
                            {
                                caption: "Todo_TXT",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {

                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var obr_clv_int_txt = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');

                                    if ($("#bodegadatos").data("emitir_rep_coops_txt") == 1) {
                                        LeerCoopsTXT(parseInt(0))
                                            .done(function (r) {
                                                var registro = '';
                                                var datos = r.d;

                                                $(datos).find("obras").each(function () {

                                                    registro = registro + $(this).find("sistemar").text() + '|' +
                                                        $(this).find("cooperadorr").text() + '|' +
                                                        $(this).find("nombrer").text() + '|' +
                                                        $(this).find("caller").text() + '|' +
                                                        $(this).find("numeror").text() + '|' +
                                                        $(this).find("coloniar").text() + '|' +
                                                        $(this).find("obrar").text() + '|' +
                                                        $(this).find("numero_cooperadorr").text() + '|' +
                                                        $(this).find("estatusr").text() + '|' +
                                                        $(this).find("rfcr").text() + '|' +
                                                        $(this).find("razon_socialr").text() + '|' +
                                                        $(this).find("domicilior").text() + '\r\n';

                                                });

                                                var blob = new Blob([registro], { type: "text/plain;charset=utf-8" });
                                                saveAs(blob, "CooperadoresObra.txt");

                                            })
                                            .fail(function (xhr) {
                                                console.log(xhr.responseText);
                                            })
                                    }
                                    else {
                                        alert('No posee permiso para generar el reporte.');
                                    }
                                },
                                position: "last",
                                title: "Exportar Coops TXT",
                                cursor: "pointer"
                            });

                }


                function LeerCoopsTXT(obr_clv_int) {
                    return $.ajax({
                        url: "../../WebServices/WebServiceObras.asmx/GetObraCoops_txt", //PageMethod
                        data: "{'obr_clv_int':'" + obr_clv_int + "'}", //PageMethod Parametros de entrada
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.d != null) {
                                console.log(data.d);
                            }
                        },
                        error: function (responseText, textStatus, errorThrown) {
                            alert('Falla al recuperar los datos: ' + textStatus + responseText + errorThrown);
                        }
                    });
                }

                function llenarEstatusObra() {
                    var accion = 'infestatusobra';
                    var estatus_obra = 0;

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceEstatusObra.asmx/GetEstatusObra",
                        data: "{'accion':'" + accion + "','idestatusobra':'" + estatus_obra + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstestatus_obra").html('');
                            $(data.d).find("EstObra").each(function () {
                                var option = $(document.createElement('option'));
                                var clv_estatus_obra = $(this).find("cidestatusobrar").text();
                                var estatus_obra = $(this).find("cestatusr").text();
                                option.html(estatus_obra);
                                option.val(clv_estatus_obra);
                                $("#lstestatus_obra").append(option);
                            });
                            var option_adic = $(document.createElement('option'));
                            option_adic.html('TODOS');
                            option_adic.val('0');
                            $("#lstestatus_obra").append(option_adic);

                            if (estatus_obra > 0) { //
                                $("#lstestatus_obra").val(clv_estatus_obra);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }


                function MostrarModuloFecLimRep2() {
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
                    $("#dialogo_rep2").css('top', winH / 2 - $("#dialogo_rep2").height() / 2);
                    $("#dialogo_rep2").css('left', winW / 2 - $("#dialogo_rep2").width() / 2);

                    //transition effect
                    $("#dialogo_rep2").fadeIn(2000);
                }

                function MostrarModuloFecLimRep3() {
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
                    $("#dialogo_rep3").css('top', winH / 2 - $("#dialogo_rep3").height() / 2);
                    $("#dialogo_rep3").css('left', winW / 2 - $("#dialogo_rep3").width() / 2);

                    //transition effect
                    $("#dialogo_rep3").fadeIn(2000);
                }

                function MostrarModuloFecLimRep4() {
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
                    $("#dialogo_rep4").css('top', winH / 2 - $("#dialogo_rep4").height() / 2);
                    $("#dialogo_rep4").css('left', winW / 2 - $("#dialogo_rep4").width() / 2);

                    //transition effect
                    $("#dialogo_rep4").fadeIn(2000);
                }


                function LeerObrasRep2(fecha_lim, estatus_obra) {
                    return $.ajax({
                        url: "../../WebServices/WebServiceObras.asmx/GetObras_Rep2", //PageMethod
                        data: "{'fecha_lim':'" + fecha_lim + "','estatus_obra':'" + estatus_obra + "'}", //PageMethod Parametros de entrada
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.d != null) {
                                console.log(data.d);
                            }
                        },
                        error: function (responseText, textStatus, errorThrown) {
                            alert(textStatus + responseText + errorThrown);
                        }
                    });
                }


                function LeerObrasRep3(fecha_lim, obr_clv_int) {
                    return $.ajax({
                        url: "../../WebServices/WebServiceObras.asmx/GetObras_Rep3", //PageMethod
                        data: "{'fecha_lim':'" + fecha_lim + "','obr_clv_int':'" + obr_clv_int + "'}", //PageMethod Parametros de entrada
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.d != null) {
                                console.log(data.d);
                            }
                        },
                        error: function (responseText, textStatus, errorThrown) {
                            alert(textStatus + responseText + errorThrown);
                        }
                    });
                }


                function LeerObrasRep4(fecha_lim, obr_clv_int) {
                    return $.ajax({
                        url: "../../WebServices/WebServiceObras.asmx/GetObras_Rep4", //PageMethod
                        data: "{'fecha_lim':'" + fecha_lim + "','obr_clv_int':'" + obr_clv_int + "'}", //PageMethod Parametros de entrada
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            if (data.d != null) {
                                console.log(data.d);
                            }
                        },
                        error: function (responseText, textStatus, errorThrown) {
                            alert(textStatus + responseText + errorThrown);
                        }
                    });
                }


            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div id="bodegadatos"></div>
            <div id="edit_coop">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">EXPORTACION DE COOPERADORES</td>
                        </tr>
                        <tr>
                            <td class="f">Nombre de Calle:</td>
                            <td class="e"><input class="dato_captura" type="text" name="nomobra" id="txtnomobra"
                                    size="80" maxlength="120" /></td>
                        </tr>
                        <tr>
                            <td class="f">Obra_SIFIDOC:</td>
                            <td class="e"><input class="dato_captura" type="text" name="obra_s" id="txtobra_s" size="10"
                                    maxlength="10" /></td>
                        </tr>
                        <tr>
                            <td class="f">Obra_SGPFIDOC:</td>
                            <td class="e"><input class="dato_captura" type="text" name="obra_sgp" id="txtobra_sgp"
                                    size="10" maxlength="10" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="boton_dialog"><a>Buscar Obras >>></a></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table id="grid"></table>
                                <div id="pager"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="boxes">
                <div id="dialogo_rep2" class="window">
                    <table class="t_modulo">
                        <tbody>
                            <tr>
                                <td colspan="2" class="titulo_modulo">REPORTE GENERAL DE OBRAS</td>
                            </tr>
                            <tr>
                                <td class="f">Fecha de Actualización del Reporte:</td>
                                <td class="e"><input class="dato_captura" type="text" name="fecrepact"
                                        id="txtfec_act_rep2" size="10" maxlength="10"
                                        onkeyup="this.value=formateafecha(this.value);" /></td>
                            </tr>
                            <tr>
                                <td class="f">Estatus de Obra:</td>
                                <td class="e"><select class="dato_captura" name="estatus_obra"
                                        id="lstestatus_obra"></select></td>
                            </tr>
                            <tr>
                                <td class="boton_dialog"><a href="#" class="btn_aceptar_rep2">ACEPTAR</a></td>
                                <td class="boton_dialog"><a href="#" class="btn_cancelar_rep2">CANCELAR</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dialogo_rep3" class="window">
                    <table class="t_modulo">
                        <tbody>
                            <tr>
                                <td colspan="2" class="titulo_modulo">REPORTE GENERAL DE COOPERADORES</td>
                            </tr>
                            <tr>
                                <td class="f">Fecha de Actualización del Reporte:</td>
                                <td class="e"><input class="dato_captura" type="text" name="fecrepact"
                                        id="txtfec_act_rep3" size="10" maxlength="10"
                                        onkeyup="this.value=formateafecha(this.value);" /></td>
                            </tr>
                            <tr>
                                <td class="boton_dialog"><a href="#" class="btn_aceptar_rep3">ACEPTAR</a></td>
                                <td class="boton_dialog"><a href="#" class="btn_cancelar_rep3">CANCELAR</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dialogo_rep4" class="window">
                    <table class="t_modulo">
                        <tbody>
                            <tr>
                                <td colspan="2" class="titulo_modulo">REPROTE GENERAL PAGOS DE COOPERADORES</td>
                            </tr>
                            <tr>
                                <td class="f">Fecha de Actualización del Reporte:</td>
                                <td class="e"><input class="dato_captura" type="text" name="fecrepact"
                                        id="txtfect_act_rep4" size="10" maxlength="10"
                                        onkeyup="this.value=formateafecha(this.value);" /></td>
                            </tr>
                            <tr>
                                <td class="boton_dialog"><a href="#" class="btn_aceptar_rep4">ACEPTAR</a></td>
                                <td class="boton_dialog"><a href="#" class="btn_cancelar_rep4">CANCELAR</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            <div id="mask"></div>
            <div id="rep2_xls"></div>
            <div id="rep3_xls"></div>

        </asp:Content>