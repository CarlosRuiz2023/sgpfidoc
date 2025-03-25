<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_requerimientos.aspx.vb" Inherits="Admin_procesos_consulta_requerimientos" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">



        function ConsultaEdoCtaCoop(idusu, coo_clv2) {
            //alert(img);
            var url1 = "../../Procesos/EdoCtaFteGral_S.html?ResponseType=Edit&idusu=" + idusu + "&coo_clv2=" + coo_clv2;
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1600,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
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
                if (IsNumeric(dia) == false)
                { fecha = ""; }
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


        var primerslap1 = false;
        var segundoslap2 = false;
        var tercerolap2 = false;

        function formateahora(hora) {
            var long = hora.length;
            var cap;
            var valido = true;

            if (long == 1 && valido) {
                cap = parseInt(hora.substr(0, 1));
                if (cap >= 0 && cap <= 1) {
                    valido = true;
                }
                else {
                    valido = false;
                    hora = '';
                }
            }

            if (long == 2 && valido) {
                cap = parseInt(hora.substr(0, 2));
                if (cap >= 0 && cap <= 12) {
                    valido = true;
                    hora = hora.substr(0, 2);
                }
                else {
                    valido = false;
                    hora = hora.substr(0, 1);
                }
            }

            if (long == 3 && valido) {
                cap = parseInt(hora.substr(2, 1));
                if (cap >= 0 && cap <= 5 && valido) {
                    hora = hora.substr(0, 2) + ':' + hora.substr(2, 1);
                }
                else {
                    valido = false;
                    hora = hora.substr(0, 2)
                }
            }

            if (long == 4 && valido) {
                cap = hora.substr(2, 1);
                if (cap == ':') {
                    hora = hora.substr(0, 2) + ':' + hora.substr(3, 1);
                }
                else {
                    cap2 = parseInt(hora.substr(2, 2));
                    if (cap >= 0) {
                        hora = hora.substr(0, 2) + ':' + hora.substr(2, 2);
                    }
                }
            }


            if (long == 5 && valido) {
                cap = parseInt(hora.substr(4, 1));
                if (cap >= 0 && cap <= 9 && valido) {
                    hora = hora.substr(0, 5);
                }
                else {
                    valido = false;
                    hora = hora.substr(0, 4)
                }
            }

            if (long >= 5 && valido) {
                hora = hora.substr(0, 5);
            }

            return (hora);
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

        function FormatoMoneda(parametro) {
            if (!isNaN(parametro)) {
                resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
            } else {
                resultado = 0;
            }
            return resultado
        }

        function MostrarParaDeterminar(accion_coop_det) {


            var idusu = $("#bodegadatos").data("idusu");
            var date = new Date();
            var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
            var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();




            if (accion_coop_det >= 1) {

                if ($("#grid")[0].grid) {
                    $.jgrid.gridUnload("#grid");
                    //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                }

                $("#grid").jqGrid(
                 {
                     datatype: function () {
                         $.ajax(
                           {
                               url: "../../WebServices/WebServiceCoop.asmx/GetCoops3_psql", //PageMethod
                               data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                               "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                               "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                               "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                               "','accion':'" + accion_coop_det + "'}", //PageMethod Parametros de entrada           
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
                     colModel: [
                                     {
                                         index: 'fid', width: 80, align: 'Center', name: 'fid'
                                     },
                                     {
                                         index: 'geom_frente', width: 100, align: 'Center', name: 'geom_frente', hidden: true
                                     },
                                     {
                                         index: 'mts_frente', width: 100, align: 'Center', name: 'MtsFte'
                                     },
                                     {
                                         index: 'cid', width: 100, align: 'Center', name: 'cid', hidden: true
                                     },
                                     {
                                         index: 'coopid', width: 150, align: 'Center', name: 'COOP_SIFIDOC'
                                     },
                                     {
                                         index: 'pid', width: 80, align: 'Center', name: 'pid', hidden: true
                                     },
                                     {
                                         index: 'oid', width: 100, align: 'Center', name: 'oid', hidden: true
                                     },
                                     {
                                         index: 'obs_grales', width: 100, align: 'Center', name: 'obs_grales', hidden: true
                                     },
                                     {
                                         index: 'obra_sifidoc', width: 200, align: 'Center', name: 'O_SIFIDOC'
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
                                         index: 'mapellidop', width: 200, align: 'Center', name: 'APaterno'
                                     },
                                     {
                                         index: 'mapellidom', width: 200, align: 'Center', name: 'AMaterno'
                                     },
                                     {
                                         index: 'mnombres', width: 200, align: 'Center', name: 'NOMBRES'
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
                                         index: 'obr_fec_ini_proc', width: 150, align: 'Center', name: 'FecIniProc'
                                     },
                                     {
                                         index: 'obr_fec_ini_cob', width: 150, align: 'Center', name: 'FecTerm'
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
                                         index: 'obr_fec_pub1', width: 150, align: 'Center', name: 'FecPub1'
                                     },
                                     {
                                         index: 'obr_fec_pub2', width: 150, align: 'Center', name: 'FecPub2'
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
                                         index: 'ctapredial', width: 200, align: 'Center', name: 'CTAPREDIAL'
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
                                         index: 'nooficial', width: 100, align: 'Center', name: 'NoOficial'
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
                                         index: 'saldo_sin_act', width: 100, align: 'Center', name: 'saldo_sin_act', hidden: true
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
                                         index: 'saldo', width: 150, align: 'Center', name: 'SALDO'
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
                                         index: 'iddet', width: 100, align: 'Center', name: 'iddcto', hidden: true
                                     },
                                     {
                                         index: 'det_estatus', width: 100, align: 'Center', name: 'det_estatus', hidden: true
                                     },
                                     {
                                         index: 'fec_imp_det', width: 120, align: 'Center', name: 'FecImpDcto'
                                     },
                                     {
                                         index: 'fec_ent_det', width: 120, align: 'Center', name: 'FecEntDcto'
                                     },
                                     {
                                         index: 'fec_notif_det', width: 120, align: 'Center', name: 'FecNotifDcto'
                                     },
                                     {
                                         index: 'hora_notif_det', width: 120, align: 'Center', name: 'HoraNotifDcto'
                                     },
                                     {
                                         index: 'idministro', width: 100, align: 'Center', name: 'idministro', hidden: true
                                     },
                                     {
                                         index: 'musunombre', width: 300, align: 'Center', name: 'nom_ministro'
                                     },
                                     {
                                         index: 'tipo_doc', width: 100, align: 'Center', name: 'tipo_doc', hidden: true
                                     },
                                     {
                                         index: 'nom_doc', width: 250, align: 'Center', name: 'nom_doc'
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
                     width: "2500",
                     height: "800",
                     caption: "COOPERADORES REQUERIDOS"

                 }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                   .navButtonAdd('#pager',
                            {
                                caption: "EdoCta",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var coo_clv2 = myGrid.jqGrid('getCell', selectedRowId, 'CooClvInt');
                                    var coo_estatus = myGrid.jqGrid('getCell', selectedRowId, 'ObrEstInt');
                                    var idusu = $("#bodegadatos").data("idusu");
                                    if (coo_clv2) {
                                        if (coo_estatus == 5) {
                                            ConsultaEdoCtaCoop(idusu, coo_clv2);
                                        }
                                        else {
                                            alert('Esta en construcción...');
                                        }

                                    }
                                    else {
                                        alert("Selecciona un cooperador...");
                                    }
                                },
                                position: "last",
                                title: "EdoCta",
                                cursor: "pointer"
                            })                     
                     .navButtonAdd('#pager',
                            {
                                caption: "GeneraDctoReq",
                                id: "genera_dcto_req",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {

                                    var myGrid = $('#grid');
                                    var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    objCoop = myGrid.jqGrid('getRowData', selectedRowId);
                                    var coop_s = objCoop.obr_clv + objCoop.COOP_SIFIDOC;

                                    var accion_gestion=7;                                   

                                    var objGestionPAE = {
                                        "fid": objCoop.fid,
                                        "fec_imp_det": ConvertirCadenaToFecha(hoy),
                                        "fec_ent_det": ConvertirCadenaToFecha('01/01/1900'),
                                        "fec_notif_det": ConvertirCadenaToFecha('01/01/1900'),
                                        "fec_cre_det": ConvertirCadenaToFecha('01/02/2022'),
                                        "fec_canc_det": ConvertirCadenaToFecha(hoy),
                                        "obs_det": 'Genera Documento Determinante Obra: ' + hoy,
                                        "hora_notif_det": '00:00:00',
                                        "clv_coop": objCoop.O_SIFIDOC + objCoop.COOP_SIFIDOC,
                                        "idministro": 0,
                                        "iddet": objCoop.iddcto,
                                        "det_estatus": 1,
                                        "usucre": idusu,
                                        "tipo_doc": 2,
                                        "nom_doc": '',
                                        "accion_gestion": accion_gestion
                                    }

                                    if (objCoop.fid) {
                                        if (ValidarDeterminante(objCoop)) {
                                            if (accion_gestion > 0) { /*Valida que se pueda llevar a cabo el registro (accion_gestion= 1) o la actualización (accion_gestion==2) de la carta de término*/
                                                RegistraGestionPAE(objGestionPAE)  /*Registro de Carta de Termno de Obra*/
                                                    .done(function (r) {
                                                        var resp = r.d;
                                                        GeneraDctoDet(objCoop);
                                                        alert('Documento DETERMINANTE generado correctamente');
                                                        $('#mask, .window').hide();
                                                        RedibujarGrid();
                                                    })
                                                    .fail(function (xhr) {
                                                        console.log(xhr.responseText);
                                                        alert("No fué posible registrar el documento determinante...");
                                                    });
                                            }
                                            else {
                                                alert('El Determinante ya se encuentra ENTREGADO AL MINISTRO, por lo tanto no es posible actualizar la fecha de impresión del documento')
                                            }
                                        }
                                    }
                                    else {
                                        alert("Selecciona un cooperador...");
                                    }


                                },
                                position: "last",
                                title: "DctoDet",
                                cursor: "pointer"
                            });
            }

            var myGrid = $('#grid');

            /*Prepara vista segun la opciondel menu*/
            if (accion_coop_det == 1) {
                var $viewBtn1 = $('#ent_termino_obra');
                $viewBtn1.addClass("ui-state-disabled");
                var $viewBtn2 = $('#genera_dcto_det');
                $viewBtn2.addClass("ui-state-disabled");
                var $viewBtn3 = $('#entrega_dcto_det');
                $viewBtn3.addClass("ui-state-disabled");
                var $viewBtn4 = $('#capt_notif_det');
                $viewBtn4.addClass("ui-state-disabled");
            }
            else {
                if (accion_coop_det == 2) {
                    var $viewBtn1 = $('#genera_dcto_det');
                    $viewBtn1.addClass("ui-state-disabled");
                    var $viewBtn2 = $('#genera_dcto_det');
                    $viewBtn2.addClass("ui-state-disabled");
                    var $viewBtn3 = $('#entrega_dcto_det');
                    $viewBtn3.addClass("ui-state-disabled");
                    var $viewBtn4 = $('#capt_notif_det');
                    $viewBtn4.addClass("ui-state-disabled");
                }
                else {
                    if (accion_coop_det == 3) {

                        var $viewBtn1 = $('#gen_termino_obra');
                        $viewBtn1.addClass("ui-state-disabled");

                        var $viewBtn2 = $('#entrega_dcto_det');
                        $viewBtn2.addClass("ui-state-disabled");

                        var $viewBtn3 = $('#capt_notif_det');
                        $viewBtn3.addClass("ui-state-disabled");

                    }
                    else {
                        if (accion_coop_det == 4) {
                            var $viewBtn1 = $('#gen_termino_obra');
                            $viewBtn1.addClass("ui-state-disabled");

                            var $viewBtn2 = $('#ent_termino_obra');
                            $viewBtn2.addClass("ui-state-disabled");

                            var $viewBtn3 = $('#capt_notif_det');
                            $viewBtn3.addClass("ui-state-disabled");
                        }
                        else {
                            if (accion_coop_det == 5) {
                                var $viewBtn1 = $('#gen_termino_obra');
                                $viewBtn1.addClass("ui-state-disabled");

                                var $viewBtn2 = $('#ent_termino_obra');
                                $viewBtn2.addClass("ui-state-disabled");

                                var $viewBtn3 = $('#genera_dcto_det');
                                $viewBtn3.addClass("ui-state-disabled");

                            }
                            else {
                                var $viewBtn1 = $('#gen_termino_obra');
                                $viewBtn1.addClass("ui-state-disabled");

                                var $viewBtn2 = $('#ent_termino_obra');
                                $viewBtn2.addClass("ui-state-disabled");

                                var $viewBtn3 = $('#genera_dcto_det');
                                $viewBtn3.addClass("ui-state-disabled");

                                var $viewBtn4 = $('#entrega_dcto_det');
                                $viewBtn4.addClass("ui-state-disabled");

                            }

                        }

                    }
                }
            }

        }


        function GeneraDctoCartaTermino(rowData) {
            var pdf = new jsPDF('p', 'pt', 'letter');

            var date = new Date();
            obr_fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();


            var img = new Image();
            img.src = '../../imagenes/escudo_armas_leon_dcto.jpg';
            pdf.addImage(img, 'JPG', 30, 15, 60, 90);
            pdf.setFontSize(15);


            var nom_dcto_det = rowData.fid + '_DET' + obr_fecha_hoy + '.pdf';


            pdf.text(CentrarTexto('AVISO', pdf.getTextWidth('AVISO')), 50, 'AVISO');
            pdf.text(CentrarTexto('CONCLUSION DE OBRA DE PAVIMENTACIÓN', pdf.getTextWidth('CONCLUSION DE OBRA DE PAVIMENTACIÓN')), 100, 'CONCLUSION DE OBRA DE PAVIMENTACIÓN');





            pdf.setFontSize(10);
            pdf.text(40, 150, 'NOMBRE:');
            pdf.text(40 + pdf.getTextWidth('NOMBRE: '), 150, rowData.NOMBRE_FICHA);
            pdf.line(40 + pdf.getTextWidth('NOMBRE: '), 152, 40 + pdf.getTextWidth('NOMBRE') + pdf.getTextWidth(rowData.NOMBRE_FICHA), 152);

            pdf.text(40, 165, 'CALLE:');
            pdf.text(40 + pdf.getTextWidth('CALLE: '), 165, rowData.CALLE);
            pdf.line(40 + pdf.getTextWidth('CALLE: '), 167, 40 + pdf.getTextWidth('CALLE: ') + pdf.getTextWidth(rowData.CALLE), 167);

            pdf.text(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE), 165, 'No. OFICIAL: ');
            pdf.text(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: '), 165, rowData.NoOficial);
            pdf.line(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: '), 167, 40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: ') + pdf.getTextWidth(rowData.NoOficial), 167);

            pdf.text(40, 180, 'COLONIA:');
            pdf.text(40 + pdf.getTextWidth('COLONIA: '), 180, rowData.COLONIA);
            pdf.line(40 + pdf.getTextWidth('COLONIA: '), 182, 40 + pdf.getTextWidth('COLONIA: ') + pdf.getTextWidth(rowData.COLONIA), 182);

            pdf.text(40, 195, 'OBRA:');
            pdf.text(40 + pdf.getTextWidth('OBRA: '), 195, rowData.O_SIFIDOC);
            pdf.line(40 + pdf.getTextWidth('OBRA: '), 197, 40 + pdf.getTextWidth('OBRA: ') + pdf.getTextWidth(rowData.O_SIFIDOC), 197);

            pdf.text(40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC), 195, 'COOP: ');
            pdf.text(40 + +pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: '), 195, rowData.COOP_SIFIDOC);
            pdf.line(40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: '), 197, 40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: ') + pdf.getTextWidth(rowData.COOP_SIFIDOC), 197);



            var fecha_termino_obra = GetLargeFecha(ConvertirCadenaToFecha(rowData.FecTerm));



            var texto = 'Estimado cooperador , el Fideicomiso de Obras por Cooperación, de conformidad con los articulos 43 y 44 de la Ley de Hacienda para los Municipios del Estado de Guanajuato, le ' +
            'informa que el termino de obra de pavimentación en calle: ' + rowData.CALLE + ' tramo: ' + rowData.TRAMO + '  con una derrama de: ' + FormatoMoneda(rowData.obr_cost_total) + '  y con un costo por metro lineal de:  ' +
           FormatoMoneda(rowData.obr_cost) + '  concluyó formalmente el: ' + fecha_termino_obra + '; lo cual acredito con la copia simple del Acta administrativa de terminación de obra que se adjunta al presente aviso.'

            pdf.text(texto, 40, 220, { maxWidth: 550, align: "justify" });


            var texto2 = 'Esta contribución de mejora contempla el pago obligatorio que deberán efectuar a la Tesorería  Municipal, los propietarios o poseedores, en su caso de bienes inmuebles que resulten beneficiados por una obra pública, ' +
            ' cuyos inmuebles se encuentren ubicados con frente a la arteria donde se ejecuten las obras de urbanización que señalan los articulos 229 y 230 de la citada Ley.'

            pdf.text(texto2, 40, 290, { maxWidth: 550, align: "justify" });


            var texto3 = 'Estamos a sus ordenes para cualquier aclaración en nuestras oficinas ubicadas en Blvd. Juan José Torreslanda 1701 Ote. Edificio "B" predio "El Tlacuacheo" o llamar a los teléfonos 477-470-86-15 al 18 ' +
                ' o vía whatsapp 477-3-25-25-86, en horario de atención de 8:00 a 19:00 hrs de lunes a viernes.'

            pdf.text(texto3, 40, 350, { maxWidth: 550, align: "justify" });


            pdf.setFontSize(10);
            var atentamente = 'ATENTAMENTE';
            pdf.text(611 / 2 - (pdf.getTextWidth(atentamente) / 2), 430, atentamente);

            var fidoc = 'FIDEICOMISO DE OBRAS POR COOPERACION';
            pdf.text(fidoc, 315, 450, { maxWidth: 550, align: "center" });

            pdf.line(40, 500, 590, 500);

            pdf.setFontSize(10);
            pdf.text(40, 515, 'NOMBRE:');
            pdf.text(40 + pdf.getTextWidth('NOMBRE: '), 515, rowData.NOMBRE_FICHA);
            pdf.line(40 + pdf.getTextWidth('NOMBRE: '), 517, 40 + pdf.getTextWidth('NOMBRE') + pdf.getTextWidth(rowData.NOMBRE_FICHA), 517);

            pdf.text(40, 532, 'CALLE:');
            pdf.text(40 + pdf.getTextWidth('CALLE: '), 532, rowData.CALLE);
            pdf.line(40 + pdf.getTextWidth('CALLE: '), 534, 40 + pdf.getTextWidth('CALLE: ') + pdf.getTextWidth(rowData.CALLE), 534);

            pdf.text(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE), 534, 'No. OFICIAL: ');
            pdf.text(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: '), 534, rowData.NoOficial);
            pdf.line(40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: '), 536, 40 + pdf.getTextWidth('CALLE:          ') + pdf.getTextWidth(rowData.CALLE) + pdf.getTextWidth('No. OFICIAL: ') + pdf.getTextWidth(rowData.NoOficial), 536);

            pdf.text(40, 551, 'COLONIA:');
            pdf.text(40 + pdf.getTextWidth('COLONIA: '), 551, rowData.COLONIA);
            pdf.line(40 + pdf.getTextWidth('COLONIA: '), 553, 40 + pdf.getTextWidth('COLONIA: ') + pdf.getTextWidth(rowData.COLONIA), 553);

            pdf.text(40, 568, 'OBRA:');
            pdf.text(40 + pdf.getTextWidth('OBRA: '), 568, rowData.O_SIFIDOC);
            pdf.line(40 + pdf.getTextWidth('OBRA: '), 570, 40 + pdf.getTextWidth('OBRA: ') + pdf.getTextWidth(rowData.O_SIFIDOC), 570);

            pdf.text(40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC), 568, 'COOP: ');
            pdf.text(40 + +pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: '), 568, rowData.COOP_SIFIDOC);
            pdf.line(40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: '), 570, 40 + pdf.getTextWidth('OBRA:    ') + pdf.getTextWidth(rowData.O_SIFIDOC) + pdf.getTextWidth('COOP: ') + pdf.getTextWidth(rowData.COOP_SIFIDOC), 570);

            var pie2 = 'NOTIFICADO';
            var pie1 = 'EL PERSONAL ADSCRITO AL FIDOC';


            pdf.setFontSize(7);

            pdf.line(80, 750, 80 + pdf.getTextWidth(pie1), 750);
            pdf.line(420, 750, 420 + pdf.getTextWidth(pie2), 750);

            pdf.text(80, 760, pie1);
            pdf.text(420, 760, pie2);


            pdf.setFontSize(10);


            var texto4 = 'Siendo las ___________________  hrs. del día _______________ del mes de ________________________________  del año  __________________. Me constituí en éste domicilio y habiéndome cerciorado por los medios legales, de ser el domicilio del ciudadano arriba señalado' +
           ' para practicar la  presente  notificación de carácter administrativo, le entrego el aviso de terminación de obra para que surta los efectos legales correspondientes.';

            pdf.text(texto4, 40, 600, { maxWidth: 550, align: "justify" });



            var texto4 = 'El C.______________________________________________ se identificó con credencial _____________________________________ con número de identificación ______________________________________________.';

            pdf.text(texto4, 40, 670, { maxWidth: 550, align: "justify" });


            pdf.setFontSize(5);





            pdf.save(nom_dcto_det)

        }


        function GetLargeFecha(date) {
            var m = new Array();
            var d = new Array()
            var an = date.getYear();
            d[1] = "Lunes";
            d[2] = "Martes";
            d[3] = "Miercoles";
            d[4] = "Jueves";
            d[5] = "Viernes";
            d[6] = "Sábado";
            d[0] = "Domingo";
            m[0] = "Enero"; m[1] = "Febrero"; m[2] = "Marzo";
            m[3] = "Abril"; m[4] = "Mayo"; m[5] = "Junio";
            m[6] = "Julio"; m[7] = "Agosto"; m[8] = "Septiembre";
            m[9] = "Octubre"; m[10] = "Noviembre"; m[11] = "Diciembre";
            var largefecha = d[date.getDay()] + " " + date.getDate() + " de " + m[date.getMonth()] + "  " + date.getFullYear();

            return largefecha;
        }

        function GeneraDctoDet(rowData) {

            var pdf = new jsPDF('p', 'pt', 'letter');

            var date = new Date();
            obr_fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();


            var img = new Image();
            img.src = '../../imagenes/escudo_armas_leon_dcto.jpg';
            pdf.addImage(img, 'JPG', 30, 15, 60, 90);
            pdf.setFontSize(15);


            var nom_dcto_det = rowData.fid + '_DET' + obr_fecha_hoy + '.pdf';


            pdf.text(CentrarTexto('MUNICIPIO DE LEON GUANAJUATO', pdf.getTextWidth('MUNICIPIO DE LEON GUANAJUATO')), 50, 'MUNICIPIO DE LEON GUANAJUATO');
            pdf.text(CentrarTexto('TESORERIA MUNICIPAL', pdf.getTextWidth('TESORERIA MUNICIPAL')), 70, 'TESORERIA MUNICIPAL');
            pdf.text(CentrarTexto('DOCUMENTO DETERMINANTE DE CREDITO', pdf.getTextWidth('DOCUMENTO DETERMINANTE DE CREDITO')), 90, 'DOCUMENTO DETERMINANTE DE CREDITO');

            pdf.setFontSize(10);
            pdf.text(459 - pdf.getTextWidth('Número de expediente/Crédito:'), 130, 'Número de expediente/Crédito:');
            pdf.text(460, 130, rowData.O_SIFIDOC + rowData.COOP_SIFIDOC);
            pdf.line(460, 132, 460 + pdf.getTextWidth(rowData.O_SIFIDOC + rowData.COOP_SIFIDOC), 132);

            pdf.text(459 - pdf.getTextWidth('Cuenta predial:'), 148, 'Cuenta predial:');
            pdf.text(460, 148, rowData.CTAPREDIAL);
            pdf.line(460, 150, 460 + pdf.getTextWidth(rowData.CTAPREDIAL), 150);

            pdf.text(40, 170, 'DATOS DEL CONTRIBUYENTE:');

            pdf.text(40, 187, 'Nombre:');
            pdf.text(40 + pdf.getTextWidth('Nombre:'), 187, rowData.NOMBRE_FICHA);
            pdf.line(40 + pdf.getTextWidth('Nombre:'), 190, 40 + pdf.getTextWidth('Nombre:') + pdf.getTextWidth(rowData.NOMBRE_FICHA), 190);

            var colofon = 'de León, Guanajuato.'
            var dom_notif = rowData.mcallecoop + '            ' + rowData.mnooficial_ext + '              ' + rowData.mcolcoop + '      ';


            pdf.text(40, 205, 'Domicilio:');
            pdf.text(40 + pdf.getTextWidth('Domicilio:'), 205, dom_notif + colofon);
            pdf.line(40 + pdf.getTextWidth('Domicilio:'), 208, 40 + pdf.getTextWidth('Domicilio:') + pdf.getTextWidth(dom_notif), 208);
            pdf.setFontSize(7);
            pdf.text(40 + pdf.getTextWidth('Domicilio: ') + 40, 215, 'Calle                                         No. Oficial                                          Colonia');

            pdf.setFontSize(10);


            pdf.text(40, 250, 'DATOS DEL INMUEBLE BENEFICIADO:');
            pdf.text(40, 270, 'Ubicación:');
            pdf.text(305 / 2, 270, rowData.CALLE);
            pdf.line(305 / 2, 273, 305 / 2 + pdf.getTextWidth(rowData.CALLE), 273);

            var no_oficial = '';  /*Valida cuando el número oficial se debe poner S/N o la manzana y el lote*/

            if (rowData.NoOficial == '' || rowData.NoOficial == 'NULL' || rowData.NoOficial == 'null' || rowData.NoOficial == 's/n' || rowData.NoOficial == 'S/N') {
                if (rowData.lote != '' && rowData.lote != 'null') {
                    if (rowData.mzna != '' && rowData.mzna != 'null') {
                        no_oficial = 'L:' + rowData.lote + ' M:' + rowData.mzna;
                    }
                    else {
                        no_oficial = 'S/N';
                    }
                }
                else {
                    no_oficial = 'S/N';
                }
            }
            else {
                no_oficial = rowData.NoOficial;
            }

            pdf.text(305, 270, no_oficial);
            pdf.line(305, 273, 305 + pdf.getTextWidth(no_oficial), 273);


            pdf.text(381, 270, rowData.COLONIA);
            pdf.line(381, 273, 381 + pdf.getTextWidth(rowData.COLONIA), 273);
            pdf.text(381 + pdf.getTextWidth(rowData.COLONIA) + 15, 270, colofon);

            pdf.setFontSize(7);

            pdf.text(305 / 2 + pdf.getTextWidth(rowData.CALLE) - pdf.getTextWidth('CALLE'), 283, 'Calle');
            pdf.text(305 + pdf.getTextWidth(rowData.NoOficial) - pdf.getTextWidth('NoOfic.') / 2, 283, 'NoOfic.');
            pdf.text(381 + pdf.getTextWidth(rowData.COLONIA) - pdf.getTextWidth('COLONIA'), 283, 'COLONIA');

            pdf.setFontSize(10);
            pdf.text(305 - pdf.getTextWidth('ANTECEDENTES'), 320, 'ANTECEDENTES');

            pdf.setFontSize(8);
            var texto = 'En mi caracter de Director(a) del Fideicomiso denominado  Obras por Cooperación, estoy facultada para determinar crédito(s) fidcal (es), dar las bases para su liquidación y ' +
            'fijarlo(s) en cantidad líquida, con cargo a los contribuyentes obligados al pago de la contrubución por ejecución de obras públicas, por ello, con fundamento en los artículos 16 párrafo ' +
            'primero y artículo 115 de la Constitución Política, artículo 121 de la Constitución Política para el Estado de Guanajuato, artículo 5 del Código Fiscal de la Federación, artículo 6 del ' +
            'Código Fiscal para el Estado de Guanajuato, artículos 2 fracción I  inciso A) numeral 3, 6, 15 inicisos c)y d), 16, 17, 23, 24, 43, 44, 45, 89, 145, 146, 148, 149, 150, 152, 153, 154, 229 ' +
            'al 244 de la Ley de Hacienda para los Municipios del Estado de Guanajuato, 381 del Código Reglamentario de Desarrollo Urbano para el Municipio de León Guanajuato y demás articulos aplicables ' +
            'así como con las facultades otorgadas a el(la) suscrito(a) por la Tesorería Municipal mediante el acuerdo delegatorio de fecha 25 de noviembre del 2021, publicado por estrados el 28 de enero ' +
            'del 2022, esta autoridad fiscal municipal se dirige al propietario o poseedor del inmueble beneficiado con una obra pública, y por tanto, contribuyente obligado al pago de la Contribución por' +
            'Ejecución de Obras Públicas para notificarle la resolución determinante de crédito, conforme  lo siguiente:'

            pdf.text(texto, 40, 340, { maxWidth: 550, align: "justify" });


            var texto2 = 'A iniciativa de los vecinos de la calle ' + rowData.CALLE + ' del municipio de León, Guanajuato, de conformidad con lo establecido en la Ley de Hacienda para los ' +
           'Municipios del Estado de Guanajuato, se realizó la siguiente obra de urbanización:'
            pdf.text(texto2, 40, 450, { maxWidth: 550, align: "justify" });
            pdf.line(175, 452, 175 + pdf.getTextWidth(rowData.CALLE), 452);

            var texto3 = 'I. CALLE EN QUE SE REALIZÓ LA OBRA: ' + rowData.CALLE + '       TRAMO: ' + rowData.TRAMO + '       COLONIA: ' + rowData.COLONIA + '  de la ciudad de LEÓN, GUANAJUATO.'
            pdf.text(texto3, 40, 480, { maxWidth: 520, align: "justify" });
            pdf.line(197, 482, 199 + pdf.getTextWidth(rowData.CALLE), 482);
            pdf.line(295, 482, 299 + pdf.getTextWidth(rowData.TRAMO), 482);
            pdf.line(506, 482, 510 + pdf.getTextWidth(rowData.COLONIA), 482);



            var arr = rowData.obr_nat.split(',');



            pdf.text(40, 510, 'II. NATURALEZA DE LA OBRA');

            pdf.text(45, 525, 'a). Banquetas y guarniciones.');
            pdf.text(300, 525, TraducirValorBinario(arr[0]));
            pdf.line(300, 529, 300 + pdf.getTextWidth(TraducirValorBinario(arr[0])), 529);


            pdf.text(45, 537, 'b). Pavimento.');
            pdf.text(300, 537, TraducirValorBinario(arr[1]));
            pdf.line(300, 539, 300 + pdf.getTextWidth(TraducirValorBinario(arr[1])), 539);

            pdf.text(45, 549, 'c). Atarjeas');
            pdf.text(300, 549, TraducirValorBinario(arr[2]));
            pdf.line(300, 551, 300 + pdf.getTextWidth(TraducirValorBinario(arr[2])), 551);


            pdf.text(45, 561, 'd). Instalación de de redes de distribución de agua potable.');
            pdf.text(300, 561, TraducirValorBinario(arr[3]));
            pdf.line(300, 563, 300 + pdf.getTextWidth(TraducirValorBinario(arr[3])), 563);


            pdf.text(45, 573, 'e). Alumbrado público.');
            pdf.text(300, 573, TraducirValorBinario(arr[4]));
            pdf.line(300, 575, 300 + pdf.getTextWidth(TraducirValorBinario(arr[4])), 575);


            pdf.text(45, 585, 'f). Instalación de drenaje.');
            pdf.text(300, 585, TraducirValorBinario(arr[5]));
            pdf.line(300, 587, 300 + pdf.getTextWidth(TraducirValorBinario(arr[5])), 587);


            pdf.text(45, 597, 'g). Apertura de nuevas vías públicas');
            pdf.text(300, 597, TraducirValorBinario(arr[6]));
            pdf.line(300, 599, 300 + pdf.getTextWidth(TraducirValorBinario(arr[6])), 599);


            pdf.text(45, 609, 'h). Jardines y obras de equipamiento urbano');
            pdf.text(300, 609, TraducirValorBinario(arr[7]));
            pdf.line(300, 611, 300 + pdf.getTextWidth(TraducirValorBinario(arr[7])), 611);

            var costo_total_obra = FormatoMoneda(rowData.obr_cost_total);
            var costo_mto_lineal = FormatoMoneda(rowData.obr_cost);

            pdf.text(40, 650, 'III. COSTO DE LA OBRA');
            pdf.text(40, 665, 'Costo total de la obra:');
            pdf.text(439 + (20 - pdf.getTextWidth(costo_total_obra)), 665, costo_total_obra);
            pdf.line(439 + (20 - pdf.getTextWidth(costo_total_obra)), 667, 459, 667);

            pdf.text(40, 675, 'Costo por metro lineal:');
            pdf.text(439 + (20 - pdf.getTextWidth(costo_mto_lineal)), 675, costo_mto_lineal);
            pdf.line(439 + (20 - pdf.getTextWidth(costo_mto_lineal)), 677, 459, 677);


            var texto4 = 'El procedimiento se realizó y publicó conforme a lo establecido en los artículos 236, 237, 241 y 244 de la Ley de Hacienda para los Municipios del Estado de Guanajuato'
            pdf.text(texto4, 40, 720, { maxWidth: 530, align: "justify" });

            pdf.addPage();

            var texto5 = 'Para determinar el crédito fiscal se establece la cantidad líquida y exigible por el concepto de contrbución especial, tomando en consideración los elementos que se establecen en el artúculo 5 del Código Fiscal de la Federación y el artículo 6 del Código Fiscal para el Estado de guanajuato , a saber:'
            pdf.text(texto5, 40, 80, { maxWidth: 530, align: "justify" });


            pdf.text(40, 120, 'SUJETO.-          ' + rowData.NOMBRE_FICHA);
            pdf.line(40 + pdf.getTextWidth('SUJETO.-'), 122, 575, 122);

            var texto6 = 'es propietario (a) o poseedor (a) del inmueble ubicado en la calle: ' + rowData.CALLE + ',  tramo: ' + rowData.TRAMO;
            pdf.text(texto6, 40, 131, { maxWidth: 530, align: "justify" });
            pdf.line(283, 133, 283 + pdf.getTextWidth(rowData.CALLE), 133);
            pdf.line(365, 133, 365 + pdf.getTextWidth(rowData.TRAMO), 133);

            var texto7 = 'de la colonia: ' + rowData.COLONIA + ' de ésta ciudad de León, Guanajuato que resultó beneficiado con una obra pública, situación que lo convierte en sujeto obligado al pago de la contribución especial por ejecución' +
                         'públicas conforme a lo previsto en la Ley de Hacienda para los Municipios del Estado de Guanajuato.';
            pdf.text(texto7, 40, 142, { maxWidth: 530, align: "justify" });
            pdf.line(90, 144, 90 + pdf.getTextWidth(rowData.COLONIA), 144);



            var texto7 = 'BASE: Es sobre la que se debe calcular el monto de la contribución especial, y deriva precisamente en la cantidad de metros lineales que mide el inmueble del contriybuyente en conlindancia con la calle urbanizada;y, dicho inmueble mide: ' + rowData.MtsFte +
                         ' m.l en su colindancia por la calle: ' + rowData.CALLE + ', donde se realizó la obra pública de urbanización';
            pdf.text(texto7, 40, 174, { maxWidth: 530, align: "justify" });
            pdf.line(373, 186, 373 + pdf.getTextWidth(rowData.MtsFte), 186);
            pdf.line(503, 186, 503 + pdf.getTextWidth(rowData.CALLE), 186);



            var saldo = FormatoMoneda(rowData.saldo_sin_act);
            var capital = FormatoMoneda(rowData.capital);
            var pagos = FormatoMoneda(rowData.pagos);

            var texto8 = 'TASA: La contribución especial por la ejecución de una obra pública se determinará y liquidará de acuerdo con los montos y cuotas aprobadas por el comité de contribuyentes a que se refiere el artículo 238 de la Ley de Hacienda para los Municipios del Estado de Guanajuato, donde se acordó que el costo por metro sería la cantidad de ' + costo_mto_lineal +
                         ', por lo que haciendo una multiplicación de los metros lineales que mide el inmueble en su colindancia, más incrementos si existiera, por la calle donde se realizó la obra de urbanización, nos da como resultado la cantidad de ' + capital + ' por concepto de contribución especial por ejecución de una obra pública en la que el inmueble de su propiedad resultó beneficiado.'
            pdf.text(texto8, 40, 210, { maxWidth: 530, align: "justify" });
            pdf.line(180, 231, 180 + pdf.getTextWidth(costo_mto_lineal), 231);
            pdf.line(478, 239, 478 + pdf.getTextWidth(capital), 239);

            var texto9 = 'Por las consideraciones de derecho y hechos consignadas en la presente determinación, esta autoridad fiscal con fundamento en el artículo 45 de la Ley de Hacienda para los Municipios del Estado de Guanajuato, hace saber al contribuyente que tiene un crédito fiscal ' +
                         'que asciende a la cantidad de ' + capital + ' por concepto de contribución especial por la ejecución de una obra pública , en base a lo siguiente:';
            pdf.text(texto9, 40, 270, { maxWidth: 530, align: "justify" });
            pdf.line(40, 290, 40 + pdf.getTextWidth(capital), 290);


            pdf.text(80, 310, 'Contribución por ejecución de obras públicas:');
            pdf.text(439 + (20 - pdf.getTextWidth(capital)), 310, capital);
            pdf.line(439 + (20 - pdf.getTextWidth(capital)), 312, 459, 312);

            pdf.text(80, 322, 'Pagos:');
            pdf.text(439 + (20 - pdf.getTextWidth(pagos)), 322, pagos);
            pdf.line(439 + (20 - pdf.getTextWidth(pagos)), 324, 459, 324);

            pdf.text(80, 333, 'Total del crédito fiscal:');
            pdf.text(439 + (20 - pdf.getTextWidth(saldo)), 333, saldo);
            pdf.line(439 + (20 - pdf.getTextWidth(saldo)), 335, 459, 335);

            var texto9 = 'Asimismo, se le hace saber que cuenta con 15 días hábiles siguientes a la fecha en que surta su efectos la notificación de la presente determinación, para hacer el pago, con el apercibimiento ' +
                         'de que en el supuesto de no cubrir dicho adeudo, el mismo se hará efectivoa través del Precedimiento Administrativo de Ejecución, que se señala en los artículos 89 al 144 de la Ley de Hacienda ' +
                         'para los Municipios del estado de Guanajuato.  Al mismo tiempo se hace de su conocimiento que tiene 20 días hábiles para interponer los recursos contemplados en la Ley de Hacienda para los Municipios de Guanajuato.';
            pdf.text(texto9, 40, 353, { maxWidth: 530, align: "justify" });

            var texto10 = 'No obstante,lo anterior, le informo que es posible llegar antes a un acuerdo para que realice el pago de su adeudo, en mensualidades y en un plazo accesible para usted, para lo cual lo esperamos en el domicilio '
                           + 'y horarios citados al rubro, antes de que secumplan los plazos legalmente establecidos.'
            pdf.text(texto10, 40, 403, { maxWidth: 530, align: "justify" });


            var hoy = 'León Guanajuato, a ' + FechaHoy();
            pdf.text(611 / 2 - (pdf.getTextWidth(hoy) / 2), 460, hoy);


            pdf.setFontSize(10);
            var director = 'ERIKA QUIROZ ROCHA';
            pdf.text(611 / 2 - (pdf.getTextWidth(director) / 2), 600, director);

            var pie = 'DIRECTOR(A) DEL FIDEICOMISO DE OBRAS POR COOPERACION';
            pdf.text(pie, 315, 620, { maxWidth: 200, align: "center" });


            pdf.setFontSize(6);
            var dom_fidoc = 'Blvd. Juan José Torres Landa #1701 Ote. Edificio "B" predio El Tlacuache';
            pdf.text(611 / 2 - (pdf.getTextWidth(pie) / 2), 780, dom_fidoc);

            pdf.save(nom_dcto_det)

        }

        function CentrarTexto(cadena, ancho_texto) {
            var centro_texto = ancho_texto / 2;
            var x = 305 - centro_texto;
            return x
        }

        function TraducirValorBinario(valor_bin) {
            if (valor_bin == '1') {
                return 'SI';
            }
            else {
                return 'NO';
            }
        }


        function MostrarModalNotifTermObra() {
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
            $("#dialogotermobr").css('top', winH / 2 - $("#dialogotermobr").height() / 2);
            $("#dialogotermobr").css('left', winW / 2 - $("#dialogotermobr").width() / 2);

            //transition effect
            $("#dialogotermobr").fadeIn(2000);
        };

        function MostrarModalEntDcto() {
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
            $("#dialogoentdcto").css('top', winH / 2 - $("#dialogoentdcto").height() / 2);
            $("#dialogoentdcto").css('left', winW / 2 - $("#dialogoentdcto").width() / 2);

            //transition effect
            $("#dialogoentdcto").fadeIn(2000);
        };


        function MostrarModaNotifDcto() {
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
            $("#dialogonotifdcto").css('top', winH / 2 - $("#dialogonotifdcto").height() / 2);
            $("#dialogonotifdcto").css('left', winW / 2 - $("#dialogonotifdcto").width() / 2);

            //transition effect
            $("#dialogonotifdcto").fadeIn(2000);
        };

        function RegistraGestionPAE(objGestionPAE) {


            var stringData = JSON.stringify(objGestionPAE);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServicePAE.asmx/RegistraPAEDet",
                data: "{objGestionPAE:" + stringData + "}",
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

        }




        function leerArchivo(nom_archivo) {
            var url = "../../temp/" + nom_archivo;
            window.open(url, '_blank', 'toolbar=0');
        }

        function ValidarDeterminante(objCoop) {
            var valid = true;

            var ctapredial = objCoop.CTAPREDIAL;
            var nombre_ficha = $.trim(objCoop.NOMBRE_FICHA);
            var nooficial = objCoop.NoOficial;
            var saldo = parseFloat(objCoop.SALDO);
            var obr_fec_inic_cob = objCoop.FecTerm;
            var obr_fec_pub1 = objCoop.FecPub1;
            var obr_fec_pub2 = objCoop.FecPub2;
            var mzna = objCoop.mzna;
            var lote = objCoop.lote;
            var costo_obra_total = parseFloat(objCoop.obr_cost_total);
            var costo_mto = parseFloat(objCoop.obr_cost);




            if (nombre_ficha != '' && nombre_ficha != 'NULL') {
                if (nombre_ficha.indexOf("ident") > -1) {
                    valid = false;
                    alert("No esposible generar el determinante porque nombre del cooperador no es válido");
                }
                else {
                    if (costo_obra_total > 0 && costo_mto > 0) {
                        if (ctapredial != '' && ctapredial != 'NULL') {
                            if (saldo > 200) {
                                if (ConvertirCadenaToFecha(obr_fec_inic_cob) > ConvertirCadenaToFecha('01/01/1900')) {
                                    if (ConvertirCadenaToFecha(obr_fec_pub1) > ConvertirCadenaToFecha('01/01/1900')) {
                                        if (ConvertirCadenaToFecha(obr_fec_pub2) > ConvertirCadenaToFecha('01/01/1900')) {
                                            if (nooficial == '' || nooficial == 'NULL') {
                                                if (mzna != '' && lote != '' && mzna != 'NULL' && lote != 'NULL') {
                                                    alert('El número oficial será sustituído por el número de manzana y lote del predio beneficiado');
                                                }
                                                else {
                                                    alert('El número oficial será sustituído por el S/N');
                                                }
                                            }
                                        }
                                        else {
                                            valid = false;
                                            alert('No es posible generar el determinante debido a que la fecha de la publicación 2 es errónea');
                                        }
                                    }
                                    else {
                                        valid = false;
                                        alert('No es posible generar el determinante debido a que la fecha de la publicación 1 es errónea');
                                    }
                                }
                                else {
                                    valid = false;
                                    alert('No es posible generar el determinante debido a que la fecha de término de obra es errónea');
                                }
                            }
                            else {
                                valid = false;
                                alert("No esposible generar el determinante porque el saldo es menor de $200.00");
                            }
                        }
                        else {
                            valid = false;
                            alert("No esposible generar el determinante porque no existe cuenta predial");
                        }
                    }
                    else {
                        valid = false;
                        alert('El valor del costo del metro o el costo de total de obra son erróneos');
                    }
                }
            }
            else {
                valid = false;
                alert("No esposible generar el determinante porque no existe nombre del cooperador");
            }

            return valid;
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

        function FechaHoy() {
            var hoy = new Date();
            var m = new Array();
            var d = new Array()
            var an = hoy.getYear();
            d[1] = "Lunes";
            d[2] = "Martes";
            d[3] = "Miercoles";
            d[4] = "Jueves";
            d[5] = "Viernes";
            d[6] = "Sábado";
            d[0] = "Domingo";
            m[0] = "Enero"; m[1] = "Febrero"; m[2] = "Marzo";
            m[3] = "Abril"; m[4] = "Mayo"; m[5] = "Junio";
            m[6] = "Julio"; m[7] = "Agosto"; m[8] = "Septiembre";
            m[9] = "Octubre"; m[10] = "Noviembre"; m[11] = "Diciembre";
            var fechahoy = d[hoy.getDay()] + " " + hoy.getDate() + " de " + m[hoy.getMonth()] + "  " + hoy.getFullYear();

            return fechahoy;
        }


        function llenarMinistros(idministro) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioMinistros",
                success: function (data) {
                    var elementos = 0;
                    $("#lstministros").html('');
                    $(data.d).find("UsuarioMinistros").each(function () {
                        var option = $(document.createElement('option'));
                        var idusu = $(this).find("musuid").text();
                        var nom_ministro = $(this).find("musunombre").text();
                        option.html(nom_ministro);
                        option.val(idusu);
                        $("#lstministros").append(option);
                    });
                    if (idministro > 0) { //
                        $("#lstministros").val(idministro);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }

        function llenarMinistros2(idministro) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: "{'accion':'" + 'listar_ministros' + "'}",
                url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioMinistros",
                success: function (data) {
                    var elementos = 0;
                    $("#lstministros2").html('');
                    $(data.d).find("UsuarioMinistros").each(function () {
                        var option = $(document.createElement('option'));
                        var idusu = $(this).find("musuid").text();
                        var nom_ministro = $(this).find("musunombre").text();
                        option.html(nom_ministro);
                        option.val(idusu);
                        $("#lstministros2").append(option);
                    });
                    if (idministro > 0) { //                            
                        $("#lstministros2").val(idministro);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
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

        function ExtraerHora(hora, meridiano) {
            var hora_res;
            var horas;
            var mins;
            var long = hora.length;
            var arr_hora = hora.split(':');
            var horas = parseInt(arr_hora[0]);

            if (long == 5) {
                var arr_hora = hora.split(':');
                var horas = parseInt(arr_hora[0]);
                var mins = parseInt(arr_hora[1]);
                if (!meridiano) { /*Si escogió en la tarde p.m*/
                    if (horas >= 1 && horas <= 11) {
                        horas = horas + 12;
                        hora_res = horas.toString() + ':' + arr_hora[1] + ':00';
                    }
                    else {
                        hora_res = hora + ':00';
                    }
                }
                else {
                    hora_res = hora + ':00';
                }

                if (horas < 0 || horas > 24 || mins < 0 || mins > 59) {
                    hora_res = '';
                }

            }
            else {
                hora_res = '';
            }



            return hora_res;
        }



        $(document).ready(function () {


            var usuario = $("#lblUsuario").html();

            $("#bodegadatos").data("idusu", usuario.split(":")[2]);

            var opcmenu = recuperarParametro("opcmenu");
            MostrarParaDeterminar(opcmenu);



            $(".verarchivo_obrterm").click(function (e) { //Ver documento                   
                var archivo = $("#file_ref_obrterm").text();
                leerArchivo(archivo);
            });

            $("#chkam").click(function (e) {
                $("#chkam").prop('checked', 1);
                $("#chkpm").prop('checked', 0);
            });

            $("#chkpm").click(function (e) {
                $("#chkam").prop('checked', 0);
                $("#chkpm").prop('checked', 1);
            });

            $(".verarchivo_dctonotif").click(function (e) { //Ver documento                   
                var archivo = $("#archivo_dctonotif").text();
                leerArchivo(archivo);
            });


            $(".posicion_boton_cancelar_notifdcto").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });

            $(".posicion_boton_cancelar_entdcto").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });

            $(".posicion_boton_cancelar_notiftermobr").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_notifdcto").click(function () { //Actualizar datos en el registro  

                var date = new Date();
                var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
                var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                var meridiano;
                if ($("#chkam:checked").val()) {
                    meridiano = 1;
                }
                else {
                    meridiano = 0;
                }

                var hora_notif = ExtraerHora($("#txthorafecnotif").val(), meridiano);

                var fid_in = parseInt($("#lblfid_notifdcto").html());
                var coop_s_in = $("#lblcoop_s_notifdcto").html();
                var fec_ent_in = ConvertirCadenaToFecha($("#lblfecentdcto2").html());
                var iddcto_in = $("#lbliddcto_notif").html();
                var idusu = $("#bodegadatos").data("idusu");
                var file_notifdet = $("#doc_notif").get(0).files;
                var accion_gestion = parseInt($("#lblaccion_notifdcto").html());
                var idministro_in = $("#lblidministro_dcto_notif").html();
                var fec_notif_in = ConvertirCadenaToFecha($("#txtfecnotifdcto").val());
                var nom_det_notif_in = fid_in.toString() + '_det_notif.pdf';

                var hayarchivo_registrado = $.trim($("#archivo_dctonotif").text()); /*Con esta variable se verifica si existe ya capturado un archivo de determinante notificado capturado*/


                var hayarchivo = file_notifdet.length;
                var archivo_valido = true;
                if (hayarchivo > 0) {
                    archivo_valido = ValidarArchivo($("#doc_notif")[0].files[0]);
                }
                else {
                    if (hayarchivo_registrado != '') {
                        archivo_valido = true;
                    }
                    else {
                        archivo_valido = false;
                    }
                }



                if (hora_notif) {
                    if (fec_ent_in <= fec_notif_in) {
                        if (archivo_valido) {
                            var objGestionPAE = {
                                "fid": fid_in,
                                "fec_imp_det": ConvertirCadenaToFecha(hoy),
                                "fec_ent_det": ConvertirCadenaToFecha(hoy),
                                "fec_notif_det": fec_notif_in,
                                "fec_cre_det": ConvertirCadenaToFecha(hoy),
                                "fec_canc_det": ConvertirCadenaToFecha('01/01/1900'),
                                "obs_det": 'Registra Notificación Carta Termino de Obra: ' + hoy,
                                "hora_notif_det": hora_notif,
                                "clv_coop": coop_s_in,
                                "idministro": idministro_in,
                                "iddet": iddcto_in,
                                "det_estatus": 3,
                                "usucre": idusu,
                                "tipo_doc": 2,
                                "nom_doc": nom_det_notif_in,
                                "accion_gestion": accion_gestion
                            }
                            if (confirm("¿Está seguro que son correctos los datos para registrar la fecha de Notificación del Determinante")) {
                                RegistraGestionPAE(objGestionPAE)  /*Registro de Notificación Carta de Termno de Obra*/
                                 .done(function (r) {
                                     var resp = r.d;
                                     ValidacionGuardadoArchivo(file_notifdet, nom_det_notif_in);
                                     $('#mask, .window').hide();
                                     RedibujarGrid();
                                 })
                                 .fail(function (xhr) {
                                     console.log(xhr.responseText);
                                     alert("No fué posible actualizar la fecha de notificación...");
                                 });
                            }
                            else {
                                console.log('No acepto el registro de la notificación del aviso del término de obra.');
                            }
                        }
                        else {
                            alert('Debes capturar el archivo del Documento Determinante Notificado.');
                        }

                    }
                    else {
                        alert('La fecha de notificación es errónea, debe ser igual o mayor a la fecha de impresion del Aviso de Término de Obra.');
                    }
                }
                else {
                    alert('La hora de notificación es errónea.');
                }
            });

            $(".posicion_boton_accion_entdcto").click(function () { //Actualizar datos en el registro  

                var date = new Date();
                var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();

                var fec_ent_dcto = ConvertirCadenaToFecha($("#txtfecentdcto").val());
                var fid_in = parseInt($("#lblfid_dcto").html());
                var coop_s_in = $("#lblcoop_s_dcto").html();
                var fec_imp_in = ConvertirCadenaToFecha($("#lblfec_imp_doc").html());
                var iddcto_in = $("#lbliddcto").html();
                var idusu = $("#bodegadatos").data("idusu");

                var accion_gestion = parseInt($("#lblaccionentdoc").html());
                var idministro_in = $("#lstministros").val();


                if (fec_imp_in <= fec_ent_dcto) {

                    var objGestionPAE = {
                        "fid": fid_in,
                        "fec_imp_det": fec_imp_in,
                        "fec_ent_det": fec_ent_dcto,
                        "fec_notif_det": ConvertirCadenaToFecha('01/01/1900'),
                        "fec_cre_det": fec_imp_in,
                        "fec_canc_det": ConvertirCadenaToFecha('01/01/1900'),
                        "obs_det": 'Registra fecha de entrega de documento determinante a ministro: ' + hoy,
                        "hora_notif_det": '00:00:00',
                        "clv_coop": coop_s_in,
                        "idministro": idministro_in,
                        "iddet": iddcto_in,
                        "det_estatus": 2,
                        "usucre": idusu,
                        "tipo_doc": 2,
                        "nom_doc": '',
                        "accion_gestion": accion_gestion
                    }
                    if (confirm("¿Está seguro que son correctos los datos para registrar la fecha de entrega del documento Determinante")) {
                        RegistraGestionPAE(objGestionPAE)  /*Registro de Notificación Carta de Termno de Obra*/
                         .done(function (r) {
                             var resp = r.d;

                             $('#mask, .window').hide();
                             RedibujarGrid();
                         })
                         .fail(function (xhr) {
                             console.log(xhr.responseText);
                             alert("No fué posible actualizar el aviso de término de obra...");
                         });
                    }
                    else {
                        console.log('No acepto el registro de la notificación del aviso del término de obra');
                    }

                }
                else {
                    alert('La fecha de entrega del documento  es errónea, debe ser igual o mayor a la fecha de impresion del Determinante');
                }
            });

            $(".posicion_boton_accion_notiftermobr").click(function () { //Actualizar datos en el registro  

                var date = new Date();
                var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
                var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                var fid_in = parseInt($("#lblfid_termobr").html());
                var coop_s_in = $("#lblcoop_s_termobr").html();
                var fec_imp_in = ConvertirCadenaToFecha($("#lblfecimp_termobr").html());
                var iddcto_in = $("#lbliddcto_termobr").html();
                var idusu = $("#bodegadatos").data("idusu");
                var file_termobr = $("#file_termobr").get(0).files;
                var accion_gestion = parseInt($("#lblaccion_gestion_termobr").html());
                var idministro_in = $("#lstministros2").val();
                var fec_notif_in = ConvertirCadenaToFecha($("#txtfec_notif_term_obr").val());
                var nom_doc_termobr_in = fid_in.toString() + '_aviso_term_obr.pdf';


                var hayarchivo_registrado = $.trim($("#file_ref_obrterm").text()); /*Con esta variable se verifica si existe ya capturado un archivo de carta de termino registrado*/
                var hayarchivo = file_termobr.length;
                var archivo_valido = true;
                if (hayarchivo > 0) {
                    archivo_valido = ValidarArchivo($("#file_termobr")[0].files[0]);
                }
                else {
                    if (hayarchivo_registrado != '') {
                        archivo_valido = true;
                    }
                    else {
                        archivo_valido = false;
                    }
                }




                if (fec_imp_in <= fec_notif_in) {

                    if (archivo_valido) {
                        var objGestionPAE = {
                            "fid": fid_in,
                            "fec_imp_det": fec_imp_in,
                            "fec_ent_det": ConvertirCadenaToFecha('01/01/1900'),
                            "fec_notif_det": fec_notif_in,
                            "fec_cre_det": fec_imp_in,
                            "fec_canc_det": ConvertirCadenaToFecha('01/01/1900'),
                            "obs_det": 'Registra Notificación Carta Termino de Obra: ' + hoy,
                            "hora_notif_det": ahorita,
                            "clv_coop": coop_s_in,
                            "idministro": idministro_in,
                            "iddet": iddcto_in,
                            "det_estatus": 2,
                            "usucre": idusu,
                            "tipo_doc": 1,
                            "nom_doc": nom_doc_termobr_in,
                            "accion_gestion": accion_gestion
                        }
                        if (confirm("¿Está seguro que son correctos los datos para registrar el Aviso de Término de Obra")) {
                            RegistraGestionPAE(objGestionPAE)  /*Registro de Notificación Carta de Termno de Obra*/
                             .done(function (r) {
                                 var resp = r.d;
                                 ValidacionGuardadoArchivo(file_termobr, nom_doc_termobr_in);
                                 $('#mask, .window').hide();
                                 RedibujarGrid();
                             })
                             .fail(function (xhr) {
                                 console.log(xhr.responseText);
                                 alert("No fué posible actualizar el aviso de término de obra...");
                             });
                        }
                        else {
                            console.log('No acepto el registro de la notificación del aviso del término de obra');
                        }
                    }
                    else {
                        alert('Se debe capturar el archivo de la Carta de Aviso de Término de Obra');
                    }

                }
                else {
                    alert('La fecha de notificación es errónea, debe ser igual o mayor a la fecha de impresion del Aviso de Término de Obra');
                }
            });



            //if mask is clicked
            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });










</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">      
    <table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>



<div id="boxes">      
    <div id="dialogotermobr" class="window">
       <div id="titulotermobr"> 
         <p style="text-align:center">NOTIFICACION DE CARTA DE CONCLUSION DE OBRA</p>
         fid: <label for="fid" id="lblfid_termobr"></label><br/>                                    
         coopS: <label for="numobra" id="lblcoop_s_termobr"></label><br/>
         FecImpTermObr: <label for="fecimpdoc "id="lblfecimp_termobr"></label><br/>
         iddcto: <label for="numobra" id="lbliddcto_termobr"></label><br/>
         Acción:<label for="accion" id="lblaccion_gestion_termobr"></label><br/> 
       </div>
       <div class="datos" id="bodytermobr">                  
          <label for="name" id="Label8">*Fecha de Notificación de la CARTA DE CONCLUSION:</label><input type="text" name="fecnotidtermobr" id="txtfec_notif_term_obr" size="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>
          <label for="name" id="Label9">*MINISTRO:</label><select name="ministros" id="lstministros2"></select><br/><br/>                    
          <input type="file" name="doc_termobr" id="file_termobr"/>&nbsp&nbsp<a href="#" id="file_ref_obrterm" class="verarchivo_obrterm"></a><br/><br/>
       </div>                  
       <div class="botonesA" id="botonestermobr">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_notiftermobr">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_notiftermobr">Cancelar</a></p>                
       </div>
    </div>           
    <div id="dialogoentdcto" class="window">
       <div id="tituloentdcto"> 
         <p style="text-align:center">ENTREGA DE DOCUMENTO DETERMINANTE</p>
         fid: <label for="fid" id="lblfid_dcto"></label><br/>                                    
         coopS: <label for="numobra" id="lblcoop_s_dcto"></label><br/>
         FecImpDcto: <label for="fecimpdoc "id="lblfec_imp_doc"></label><br/>
         iddcto: <label for="numobra" id="lbliddcto"></label><br/>       
         Acción:<label for="accion" id="lblaccionentdoc"></label><br/> 
       </div>
       <div class="datos" id="bodyentdcto">                  
          <label for="name" id="lblfecentdcto">*Fecha de Entrega del DETERMINANTE:</label><input type="text" name="fecentdcto" id="txtfecentdcto" size="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>
          <label for="name" id="lblministros">*MINISTRO:</label><select name="ministros" id="lstministros"></select><br/><br/>
          
       </div>                  
       <div class="botonesA" id="botonesentdcto">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_entdcto">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_entdcto">Cancelar</a></p>                
       </div>
    </div>        
     <div id="dialogonotifdcto" class="window">
       <div id="titulonotifdcto"> 
         <p style="text-align:center">NOTIFICACION DE DETERMINANTE</p>
         fid: <label for="fid" id="lblfid_notifdcto"></label><br/>                                    
         coopS: <label for="numobra" id="lblcoop_s_notifdcto"></label><br/>
         FecEntDcto: <label for="fecentdoc "id="lblfecentdcto2"></label><br/>
         iddcto: <label for="numobra" id="lbliddcto_notif"></label><br/>
         idministro: <label for="idministro" id="lblidministro_dcto_notif"></label><br/>
         Acción:<label for="accion" id="lblaccion_notifdcto"></label><br/> 
       </div>
       <div class="datos" id="bodynotifdcto">                  
          <label for="name" id="lblnotifdcto">*Fecha de Notificación del DETERMINANTE:</label><input type="text" name="fecnotifdcto" id="txtfecnotifdcto" size="10" onkeyup = "this.value=formateafecha(this.value); maxlength=10"/><br/><br/>
          <label for="name" id="lblhoranotifdcto">*Hora de Notificación del DETERMINANTE:</label><input type="text" name="horanotifdcto" id="txthorafecnotif" size="5" onkeyup = "this.value=formateahora(this.value); maxlength=5"/><label><input type="checkbox" id="chkam" name="am"/>a.m.</label><label><input type="checkbox" id="chkpm" name="pm"/>p.m.</label><br/><br/>
          <input type="file" name="dcto_dotif" id="doc_notif"/><a href="#" id="archivo_dctonotif" class="verarchivo_dctonotif"/><br/><br/>      
       </div>                  
       <div class="botonesA" id="botonesnotifdcto">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_notifdcto">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_notifdcto">Cancelar</a></p>                
       </div>
    </div>     
    
    <div id="mask"></div>
 </div>
</asp:Content>



