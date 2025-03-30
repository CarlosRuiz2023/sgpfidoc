<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_reportes_obras.aspx.vb" Inherits="Admin_procesos_consultar_reportes_obras" %>
    <asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">

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

            function zfill(number, width) {
                var numberOutput = Math.abs(number); /* Valor absoluto del número */
                var length = number.toString().length; /* Largo del número */
                var zero = "0"; /* String de cero */

                if (width <= length) {
                    if (number < 0) {
                        return ("-" + numberOutput.toString());
                    } else {
                        return numberOutput.toString();
                    }
                } else {
                    if (number < 0) {
                        return ("-" + (zero.repeat(width - length)) + numberOutput.toString());
                    } else {
                        return ((zero.repeat(width - length)) + numberOutput.toString());
                    }
                }
            }


            function ConvertirFechaCapturada_yyyymmdd_txt(cadenafec) {
                if (cadenafec != "") {
                    var from = cadenafec.split("/");
                    var mes_int = parseInt(from[1]);
                    var mes_txt = zfill(mes_int, 2);
                    var fecha = from[2] + '-' + mes_txt + '-' + from[0];
                }
                else {
                    /*var fecha = new Date('2200', '01', '01');*/
                    var fecha = '1900-01-01';
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


                $(".btn_cancelar_rep").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".btn_aceptar_rep1").click(function (e) {

                    var fec_lim_rep1 = ConvertirCadenaToFecha($("#txtfec_act_rep2").val());
                    var estatus_obra = parseInt($("#lstestatus_obra").val());


                    var date = new Date();
                    var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                    if (fec_lim_rep1 <= hoy) {
                        var fec_lim_txt = fec_lim_rep1.getDate().toString() + '/' + (fec_lim_rep1.getMonth() + 1).toString() + '/' + fec_lim_rep1.getFullYear().toString();
                        LeerDatosRep1(fec_lim_txt, estatus_obra)
                            .done(function (r) {
                                var obras_rep1 = [];
                                var data = r.d;

                                if (data != '<NewDataSet />') {
                                    $(data).find("obras_rep1").each(function () {
                                        var objObraRep1 = {
                                            "oid": 0,
                                            "calle": '',
                                            "colonia": '',
                                            "tramo": '',
                                            "obr_clv_int": 0,
                                            "obr_clv": '',
                                            "obr_cost": 0,
                                            "obr_prog2": 0,
                                            "nomprog": '',
                                            "cve_estatus": 0,
                                            "cestatus": '',
                                            "fec_ini_pag": '',
                                            "fec_fin_pag": '',
                                            "plazo_rec": 0,
                                            "num_meses_a_fecact": 0,
                                            "num_coops": 0,
                                            "coops_con_saldo": 0,
                                            "coops_sin_saldo": 0,
                                            "obr_opergob": '',
                                            "total_mts_frente": 0,
                                            "incremento_obra": 0,
                                            "costo_total_obra_sin_inc": 0,
                                            "costo_total_obra_con_inc": 0,
                                            "capital_pagado": 0,
                                            "descto_capital": 0,
                                            "total_recargos": 0,
                                            "cargos_pagados": 0,
                                            "descto_recargos": 0,
                                            "saldo_sin": 0,
                                            "saldo_con": 0,
                                            "avance_sin_inc": 0,
                                            "avance_con_inc": 0,

                                        }

                                        objObraRep1.oid = $(this).find("clave_poligono").text();
                                        objObraRep1.calle = $(this).find("calle_obra").text();
                                        objObraRep1.colonia = $(this).find("colonia_obra").text();
                                        objObraRep1.tramo = $(this).find("tramo_obra").text();
                                        objObraRep1.obr_clv_int = $(this).find("clave_obra_SGP").text();
                                        objObraRep1.obr_clv = '\'' + $(this).find("obra_s_out").text();
                                        objObraRep1.obr_cost = $(this).find("costo_mto_out").text();
                                        objObraRep1.obr_prog2 = $(this).find("cve_prog_obra_out").text();
                                        objObraRep1.nomprog = $(this).find("prog_obra_out").text();
                                        objObraRep1.cve_estatus = $(this).find("cve_estatus_obra_out").text();
                                        objObraRep1.cestatus = $(this).find("estatus_obra_out").text();
                                        objObraRep1.fec_ini_pag = $(this).find("fec_ini_pag_out2").text();
                                        objObraRep1.fec_fin_pag = $(this).find("fec_fin_pag_out2").text();
                                        objObraRep1.plazo_rec = $(this).find("plazo_rec_out2").text();
                                        objObraRep1.num_meses_a_fecact = $(this).find("num_meses_a_fecact_out2").text();
                                        objObraRep1.num_coops = $(this).find("nums_coops_out").text();
                                        objObraRep1.coops_con_saldo = $(this).find("coops_con_saldo_out").text();
                                        objObraRep1.coops_sin_saldo = $(this).find("coops_sin_saldo_out").text();
                                        objObraRep1.obr_opergob = $(this).find("cve_opergob_out").text();
                                        objObraRep1.total_mts_frente = $(this).find("total_mts_obra_out").text();
                                        objObraRep1.incremento_obra = $(this).find("incremento_obra_out").text();
                                        objObraRep1.costo_total_obra_sin_inc = $(this).find("capital_inicial_sin_inc_obra_out").text();
                                        objObraRep1.costo_total_obra_con_inc = $(this).find("capital_inicial_con_inc_obra_out").text();
                                        objObraRep1.capital_pagado = $(this).find("capital_pagado_obra_out").text();
                                        objObraRep1.descto_capital = $(this).find("descto_capital_obra_out").text();
                                        objObraRep1.total_recargos = $(this).find("total_recargos_obra_out").text();
                                        objObraRep1.cargos_pagados = $(this).find("cargos_pagados_obra_out").text();
                                        objObraRep1.descto_recargos = $(this).find("descto_recargos_obra_out").text();
                                        objObraRep1.saldo_sin = $(this).find("saldo_sin_obra_out").text();
                                        objObraRep1.saldo_con = $(this).find("saldo_con_obra_out").text();
                                        objObraRep1.avance_sin_inc = $(this).find("avance_pago_obra_sin_inc_out").text();
                                        objObraRep1.avance_con_inc = $(this).find("avance_pago_obra_con_inc_out").text();
                                        obras_rep1.push(objObraRep1);
                                    });


                                    $("#rep1_xls").excelexportjs({
                                        containerid: "dvjson",
                                        datatype: 'json',
                                        dataset: obras_rep1,
                                        columns: getColumns(obras_rep1),
                                        worksheetName: "Obras_Rep1",
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
                                alert("Falla al recuperar datos de las obras.");
                            })
                    }
                    else {
                        alert('Fecha errónea, favor de verificar.');
                    }
                });



                $(".btn_aceptar_rep2").click(function (e) {

                    var fec_lim = ConvertirCadenaToFecha($("#txtfec_lim_coop").val());
                    var obr_clv_int = parseInt($("#lstobras_rep2").val());


                    var date = new Date();
                    var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                    if (fec_lim <= hoy) {
                        var fec_lim_txt = fec_lim.getDate().toString() + '/' + (fec_lim.getMonth() + 1).toString() + '/' + fec_lim.getFullYear().toString();
                        LeerDatosRep2(obr_clv_int, fec_lim_txt)
                            .done(function (r) {
                                var obras_rep2 = [];
                                var data = r.d;

                                if (data != '<NewDataSet />') {
                                    $(data).find("obras_rep2").each(function () {
                                        var objObraRep2 = {
                                            "fid": 0,
                                            "nom_coop": '',
                                            "mts_frente": '',
                                            "obr_cost": '',
                                            "oid": 0,
                                            "calle": '',
                                            "colonia": 0,
                                            "tramo": 0,
                                            "obr_clv_int": '',
                                            "obr_clv": 0,
                                            "obr_opergob": '',
                                            "obr_prog2": 0,
                                            "nomprog2": 0,
                                            "obr_status": 0,
                                            "cestatus": '',
                                            "fec_ini_pag": '',
                                            "fec_fin_pag": '',
                                            "plazo_rec": 0,
                                            "num_meses_a_fecact": 0,
                                            "incremento_frente": 0,
                                            "capital_inicial_frente_sin_inc": 0,
                                            "capital_inicial_frente_con_inc": 0,
                                            "capital_pagado_frente": 0,
                                            "descto_capital_frente": 0,
                                            "total_recargos_frente": 0,
                                            "cargos_pagados_frente": 0,
                                            "descto_recargos_frente": 0,
                                            "saldo_capital_frente": 0,
                                            "saldo_recargos_frente": 0,
                                            "saldo_gral_frente": 0,
                                            "saldo_sin": 0,
                                            "saldo_con": 0,
                                            "avance_pago_con_inc_x_frente": 0,
                                            "avance_pago_sin_inc_x_frente": 0
                                        }

                                        objObraRep2.fid = $(this).find("fid_out").text();
                                        objObraRep2.nom_coop = $(this).find("nom_coop").text();
                                        objObraRep2.mts_frente = $(this).find("mts_frente_out").text();
                                        objObraRep2.obr_cost = $(this).find("obr_cost_out").text();
                                        objObraRep2.oid = $(this).find("oid_out").text();
                                        objObraRep2.calle = '\'' + $(this).find("calle_out").text();
                                        objObraRep2.colonia = $(this).find("colonia_out").text();
                                        objObraRep2.tramo = $(this).find("tramo_out").text();
                                        objObraRep2.obr_clv_int = $(this).find("obr_clv_int_out").text();
                                        objObraRep2.obr_clv = $(this).find("obr_clv_out").text();
                                        objObraRep2.obr_opergob = $(this).find("obr_opergob_out").text();
                                        objObraRep2.obr_prog2 = $(this).find("obr_prog2_out").text();
                                        objObraRep2.nomprog2 = $(this).find("nomprog_out").text();
                                        objObraRep2.obr_status = $(this).find("obr_status_out").text();
                                        objObraRep2.fec_ini_pag = $(this).find("fec_ini_pag_out").text();
                                        objObraRep2.fec_fin_pag = $(this).find("fec_fin_pag_out").text();
                                        objObraRep2.num_meses_rec = $(this).find("num_meses_out").text();
                                        objObraRep2.cestatus = $(this).find("cestatus_out").text();
                                        objObraRep2.fec_ini_pag = $(this).find("fec_ini_pag_out").text();
                                        objObraRep2.fec_fin_pag = $(this).find("fec_fin_pag_out").text();
                                        objObraRep2.plazo_rec = $(this).find("plazo_rec_out2").text();
                                        objObraRep2.num_meses_a_fecact = $(this).find("num_meses_a_fecact_out2").text();
                                        objObraRep2.incremento_frente = $(this).find("incremento_frente_out").text();
                                        objObraRep2.capital_inicial_frente_sin_inc = $(this).find("capital_inicial_frente_sin_inc_out").text();
                                        objObraRep2.capital_inicial_frente_con_inc = $(this).find("capital_inicial_frente_con_inc_out").text();
                                        objObraRep2.capital_pagado_frente = $(this).find("capital_pagado_frente_out").text();
                                        objObraRep2.descto_capital_frente = $(this).find("descto_capital_frente_out").text();
                                        objObraRep2.total_recargos_frente = $(this).find("total_recargos_frente_out").text();
                                        objObraRep2.cargos_pagados_frente = $(this).find("cargos_pagados_frente_out").text();
                                        objObraRep2.descto_recargos_frente = $(this).find("descto_recargos_frente_out").text();
                                        objObraRep2.saldo_capital_frente = $(this).find("saldo_capital_frente_out").text();
                                        objObraRep2.saldo_recargos_frente = $(this).find("saldo_recargos_frente_out").text();
                                        objObraRep2.saldo_gral_frente = $(this).find("saldo_gral_frente_out").text();
                                        objObraRep2.saldo_sin = $(this).find("saldo_sin_out").text();
                                        objObraRep2.saldo_con = $(this).find("saldo_con_out").text();
                                        objObraRep2.avance_pago_con_inc_x_frente = $(this).find("avance_pago_con_inc_x_frente_out").text();
                                        objObraRep2.avance_pago_sin_inc_x_frente = $(this).find("avance_pago_sin_inc_x_frente_out").text();
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
                                alert("Falla al recuperar datos de las obras.");
                            })
                    }
                    else {
                        alert('Fecha errónea, favor de verificar.');
                    }
                });


                $(".btn_aceptar_rep3").click(function (e) {



                    var fec_ini_pag_txt = ConvertirFechaCapturada_yyyymmdd_txt($("#txtfecinipag").val());
                    var fec_fin_pag_txt = ConvertirFechaCapturada_yyyymmdd_txt($("#txtfecfinpag").val());
                    var obra_clv_int = parseInt($("#lstobras_rep3").val());

                    var fec_ini_pag = moment(fec_ini_pag_txt);
                    var fec_fin_pag = moment(fec_fin_pag_txt);

                    var diferencia = fec_fin_pag.diff(fec_ini_pag, 'days');

                    var date = new Date();
                    var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                    if (diferencia <= 29 && diferencia >= 0) {

                        LeerDatosRep3(obra_clv_int, $("#txtfecinipag").val(), $("#txtfecfinpag").val())
                            .done(function (r) {
                                var obras_rep3 = [];
                                var data = r.d;

                                if (data != '<NewDataSet />') {
                                    $(data).find("obras_rep3").each(function () {
                                        var objObraRep3 = {
                                            "fid": 0,
                                            "clave_sifidoc": '',
                                            "monto_mov": '',
                                            "fec_mov": '',
                                            "folio_cajas": 0,
                                            "programa": '',
                                            "prog_descrip": 0,
                                            "cta_contable": 0
                                        }

                                        objObraRep3.fid = $(this).find("fid").text();
                                        objObraRep3.clave_sifidoc = '\'' + $(this).find("clave_sifidoc").text();
                                        objObraRep3.monto_mov = $(this).find("monto_mov").text();
                                        objObraRep3.fec_mov = $(this).find("fec_mov_as400").text();
                                        objObraRep3.folio_cajas = $(this).find("folio_cajas").text();
                                        objObraRep3.programa = $(this).find("programa").text();
                                        objObraRep3.prog_descrip = $(this).find("prog_descrip").text();
                                        objObraRep3.cta_contable = $(this).find("cta_contable").text();
                                        obras_rep3.push(objObraRep3);
                                    });


                                    $("#rep3_xls").excelexportjs({
                                        containerid: "dvjson",
                                        datatype: 'json',
                                        dataset: obras_rep3,
                                        columns: getColumns(obras_rep3),
                                        worksheetName: "Obras_Rep3",
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
                                alert("Falla al recuperar datos de las obras.");
                            })
                    }
                    else {
                        alert('Sólo es aceptado menor o igual a 31 días de pagos');
                    }
                });




                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });



                $(".t_accion").click(function (e) {

                    var campo_accion = e.target.id;

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

                                if (campo_accion == 'lblrep1') {

                                    /*Tarea 24: Reporte general de obras en estatus "capturado" y hasta la fecha de actualización de pagos "capturada"*/
                                    var puede_consultar_rep1_obra = reglas_usu.find(tarea => (tarea.idtarea == 24 && tarea.idaccion == 3));

                                    if (puede_consultar_rep1_obra == null) {
                                        alert('Su usuario no tiene permiso de consultar el reporte de obras.');
                                    }
                                    else {
                                        reporte = 1;
                                    };

                                }

                                if (campo_accion == 'lblrep2') {

                                    /*Tarea 26: Reporte general de cooperadores por obra*/
                                    var puede_consultar_rep2_obra = reglas_usu.find(tarea => (tarea.idtarea == 26 && tarea.idaccion == 3));

                                    if (puede_consultar_rep2_obra == null) {
                                        alert('Su usuario no tiene permiso de consultar el reporte de cooperadores por obra.');
                                    }
                                    else {
                                        reporte = 2;
                                    };

                                }


                                if (campo_accion == 'lblrep3') {

                                    /*Tarea 27: Reporte general de PAGOS POR OBRA*/
                                    var puede_consultar_rep2_obra = reglas_usu.find(tarea => (tarea.idtarea == 27 && tarea.idaccion == 3));

                                    if (puede_consultar_rep2_obra == null) {
                                        alert('Su usuario no tiene permiso de consultar el reporte PAGOS por OBRA.');
                                    }
                                    else {
                                        reporte = 3;
                                    };

                                }

                                MostrarFormularioReporte(reporte);




                            }
                            else {
                                alert("El usuario no tiene permiso para consultar reportes.");
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



            function ver_act_costo_obra(obr_clv_int, idusu) {
                var url1 = "../Procesos/salida_act_costo_obra.html?ResponseType=Edit&obr_clv_int=" + obr_clv_int + "&idusu=" + idusu;
                newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                if (newWindow.focus()) {
                    newWindow.focus()
                }

            };




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


            function llenarObrasSGP_rep2(accion) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                    data: "{'accion':'" + accion + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lstobras_rep2").html('');

                        $(data.d).find("ObrasSGP").each(function () {
                            var option = $(document.createElement('option'));
                            var obr_clv = $(this).find("obra_s").text();
                            var obr_clv_int = $(this).find("obr_clv_int_r").text();
                            var obr_call = $(this).find("calle_r").text();

                            option.html(obr_clv + ' || ' + obr_clv_int + ' || ' + obr_call);
                            option.val(obr_clv_int);
                            $("#lstobras_rep2").append(option);

                        });

                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }

            function llenarObrasSGP_rep3(accion) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                    data: "{'accion':'" + accion + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lstobras_rep3").html('');
                        var optionx = $(document.createElement('option'));
                        var texto_adicional = 'TODAS LAS OBRAS';
                        optionx.html(texto_adicional);
                        optionx.val(0);
                        $("#lstobras_rep3").append(optionx);

                        $(data.d).find("ObrasSGP").each(function () {
                            var option = $(document.createElement('option'));
                            var obr_clv = $(this).find("obra_s").text();
                            var obr_clv_int = $(this).find("obr_clv_int_r").text();
                            var obr_call = $(this).find("calle_r").text();

                            option.html(obr_clv + ' || ' + obr_clv_int + ' || ' + obr_call);
                            option.val(obr_clv_int);
                            $("#lstobras_rep3").append(option);
                        });


                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }




            function MostrarFormularioReporte(num_reporte) {
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

                if (num_reporte == 1) {
                    //Set the popup window to center
                    $("#dialogo_rep1").css('top', winH / 2 - $("#dialogo_rep1").height() / 2);
                    $("#dialogo_rep1").css('left', winW / 2 - $("#dialogo_rep1").width() / 2);

                    //transition effect
                    $("#dialogo_rep1").fadeIn(2000);
                    llenarEstatusObra();
                }


                if (num_reporte == 2) {
                    //Set the popup window to center
                    $("#dialogo_rep2").css('top', winH / 2 - $("#dialogo_rep2").height() / 2);
                    $("#dialogo_rep2").css('left', winW / 2 - $("#dialogo_rep2").width() / 2);

                    //transition effect
                    $("#dialogo_rep2").fadeIn(2000);
                    llenarObrasSGP_rep2(0)
                }

                if (num_reporte == 3) {
                    //Set the popup window to center
                    $("#dialogo_rep3").css('top', winH / 2 - $("#dialogo_rep3").height() / 2);
                    $("#dialogo_rep3").css('left', winW / 2 - $("#dialogo_rep3").width() / 2);

                    //transition effect
                    $("#dialogo_rep3").fadeIn(2000);
                    llenarObrasSGP_rep3(0)
                }
            }




            function LeerDatosRep1(fec_lim_txt, estatus_obra_int) {
                return $.ajax({
                    url: "../../WebServices/WebServiceObras.asmx/GetObras_Rep1", //PageMethod
                    data: "{'estatus_obra_int':'" + estatus_obra_int + "','fecha_lim':'" + fec_lim_txt + "'}", //PageMethod Parametros de entrada
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


            function LeerDatosRep2(obr_clv_int, fec_lim_txt) {
                return $.ajax({
                    url: "../../WebServices/WebServiceFrente.asmx/GetRep2", //PageMethod
                    data: "{'obr_clv_int':'" + obr_clv_int + "','fecha_lim':'" + fec_lim_txt + "'}", //PageMethod Parametros de entrada
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

            function LeerDatosRep3(obr_clv_int, fecha_ini_txt, fecha_fin_txt) {
                return $.ajax({
                    url: "../../WebServices/WebServicePagos.asmx/GetRep3", //PageMethod
                    data: "{'obr_clv_int':'" + obr_clv_int + "','fecha_ini':'" + fecha_ini_txt + "','fecha_fin':'" + fecha_fin_txt + "'}", //PageMethod Parametros de entrada
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
        <table class="t_modulo">
            <tbody>
                <tr>
                    <td colspan="2" class="titulo_modulo">REPORTES GENERALES</td>
                </tr>
                <tr>
                    <td class="f"><a href="#" class="t_accion"><label id="lblrep1">REPORTE DE OBRA POR ESTATUS Y FECHA
                                DE PAGOS >>></label></a></td>
                </tr>
                <tr>
                    <td class="f"><a href="#" class="t_accion"><label id="lblrep2">REPORTE DE COOPERADORES POR OBRA
                                >>></label></a></td>
                </tr>
                <tr>
                    <td class="f"><a href="#" class="t_accion"><label id="lblrep3">REPORTE DE PAGOS POR OBRA (SOLO <=31
                                    DIAS)>>></label></a></td>
                </tr>
            </tbody>
        </table>

        <div id="bodegadatos"></div>

        <div id="boxes">
            <div id="dialogo_rep1" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">REPORTES DE OBRAS</td>
                        </tr>
                        <tr>
                            <td class="f">Considerar pagos hasta el día:</td>
                            <td class="e"><input class="dato_captura" type="text" name="fecrepact" id="txtfec_act_rep2"
                                    size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="f">Estatus de Obra:</td>
                            <td class="e"><select class="dato_captura" name="estatus_obra"
                                    id="lstestatus_obra"></select></td>
                        </tr>
                        <tr>
                            <td class="boton_dialog"><a href="#" class="btn_aceptar_rep1">ACEPTAR</a></td>
                            <td class="boton_dialog"><a href="#" class="btn_cancelar_rep">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="dialogo_rep2" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">REPORTE DE COPERADORES POR OBRA</td>
                        </tr>
                        <tr>
                            <td class="f">Obra:</td>
                            <td class="e"><select class="dato_captura" name="obr_clv_int" id="lstobras_rep2"></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="f">Considerar movimientos hasta el día:</td>
                            <td class="e"><input class="dato_captura" type="text" name="fecrepact" id="txtfec_lim_coop"
                                    size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="boton_dialog"><a href="#" class="btn_aceptar_rep2">ACEPTAR</a></td>
                            <td class="boton_dialog"><a href="#" class="btn_cancelar_rep">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="dialogo_rep3" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="2" class="titulo_modulo">REPORTE DE PAGOS POR OBRA</td>
                        </tr>
                        <tr>
                            <td class="f">Obra:</td>
                            <td class="e"><select class="dato_captura" name="obr_clv_int" id="lstobras_rep3"></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="f">Fecha Inicial:</td>
                            <td class="e"><input class="dato_captura" type="text" name="fecini" id="txtfecinipag"
                                    size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="f">Fecha Final:</td>
                            <td class="e"><input class="dato_captura" type="text" name="fecfin" id="txtfecfinpag"
                                    size="10" maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                        </tr>
                        <tr>
                            <td class="boton_dialog"><a href="#" class="btn_aceptar_rep3">ACEPTAR</a></td>
                            <td class="boton_dialog"><a href="#" class="btn_cancelar_rep">CANCELAR</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="mask"></div>
        <div id="rep1_xls"></div>
        <div id="rep2_xls"></div>
        <div id="rep3_xls"></div>

    </asp:Content>