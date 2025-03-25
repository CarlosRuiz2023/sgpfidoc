<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_obras_vencidas_rec.aspx.vb" Inherits="Admin_procesos_consultar_obras_vencidas_rec" %>
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
            if (fs > 1000000) {
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



        function MostrarObrasVencidaRec(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceObras.asmx/GetObrasVencidasRec_Grid", //PageMethod
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
                     id: "obr_clv_int"
                 },
                 colModel: [
                                 {
                                     index: 'num_coops', width: 50, align: 'Center', name: 'NumCoops', hidden: true
                                 },
                                 {
                                     index: 'total_metros_obra', width: 100, align: 'Center', name: 'TotalMetros', hidden: true
                                 },
                                 {
                                     index: 'obr_costo', width: 80, align: 'Center', name: 'CostoMto', hidden: true
                                 },
                                 {
                                     index: 'oid', width: 300, align: 'Center', name: 'oid', hidden: true
                                 },
                                 {
                                     index: 'calle', width: 300, align: 'Center', name: 'Calle'
                                 },
                                 {
                                     index: 'colonia', width: 300, align: 'Center', name: 'Colonia'
                                 },
                                 {
                                     index: 'tramo', width: 400, align: 'Center', name: 'Tramo'
                                 },
                                 {
                                     index: 'obr_clv_int', width: 50, align: 'Center', name: 'obr_clv_int', hidden: true
                                 },
                                 {
                                     index: 'obr_clv', width: 80, align: 'Center', name: 'obr_clv'
                                 },
                                 {
                                     index: 'obr_opergob', width: 50, align: 'Center', name: 'CtaOpergob', hidden: true
                                 },
                                 {
                                     index: 'obr_prog2', width: 50, align: 'Center', name: 'IdProg', hidden: true
                                 },
                                 {
                                     index: 'nomprog', width: 150, align: 'Center', name: 'NomProg'
                                 },
                                 {
                                     index: 'descrip_tipo_obr', width: 50, align: 'Center', name: 'DescripTipoObra', hidden: true
                                 },
                                 {
                                     index: 'obr_status', width: 50, align: 'Center', name: 'CveEstatusObra', hidden: true
                                 },
                                 {
                                     index: 'cestatus', width: 120, align: 'Center', name: 'EstatusObra'
                                 },
                                 {
                                     index: 'obr_fecinip', width: 100, align: 'Center', name: 'FecIniPag'
                                 },
                                 {
                                     index: 'obr_fecvenp', width: 100, align: 'Center', name: 'FecVenPag'
                                 },
                                 {
                                     index: 'obr_fec_ini_proc', width: 50, align: 'Center', name: 'FecInicProc', hidden: true
                                 },
                                 {
                                     index: 'obr_fec_ini_cob', width: 50, align: 'Center', name: 'FecIniCob', hidden: true
                                 },
                                 {
                                     index: 'plazo_rec', width: 100, align: 'Center', name: 'PlazoRec'
                                 },
                                 {
                                     index: 'num_meses_a_fecact', width: 100, align: 'Center', name: 'NumMesesFecAct'
                                 },
                                 {
                                     index: 'incremento_frente', width: 50, align: 'Center', name: 'TotalIncFtes', hidden: true
                                 },
                                 {
                                     index: 'capital_inicial_frente_sin_inc', width: 50, align: 'Center', name: 'CapIniFtesSinInc', hidden: true
                                 },
                                 {
                                     index: 'capital_inicial_frente_con_inc', width: 50, align: 'Center', name: 'CapIniFtesConInc', hidden: true
                                 },
                                 {
                                     index: 'capital_pagado_frente', width: 50, align: 'Center', name: 'CapPagFte', hidden: true
                                 },
                                 {
                                     index: 'descto_capital_frente', width: 50, align: 'Center', name: 'DesctoCapFte', hidden: true
                                 },
                                 {
                                     index: 'ayudas_sociales_frente', width: 50, align: 'Center', name: 'AyudaSoc', hidden: true
                                 },
                                 {
                                     index: 'total_recargos_frente', width: 50, align: 'Center', name: 'TotRecFte', hidden: true
                                 },
                                 {
                                     index: 'cargos_pagados_frente', width: 50, align: 'Center', name: 'RecPagados', hidden: true
                                 },
                                 {
                                     index: 'descto_recargos_frente', width: 50, align: 'Center', name: 'DesctoRecFte', hidden: true
                                 },
                                 {
                                     index: 'saldo_capital_frente', width: 50, align: 'Center', name: 'SaldoCapFte', hidden: true
                                 },
                                 {
                                     index: 'saldo_recargos_frente', width: 50, align: 'Center', name: 'SaldoRecFte', hidden: true
                                 },
                                 {
                                     index: 'saldo_gral_frente', width: 50, align: 'Center', name: 'SaldoGralFte', hidden: true
                                 },
                                 {
                                     index: 'saldo_sin', width: 50, align: 'Center', name: 'SaldoSin', hidden: true
                                 },
                                 {
                                     index: 'saldo_con', width: 50, align: 'Center', name: 'SaldoCon', hidden: true
                                 },
                                 {
                                     index: 'avance_pago_con_inc', width: 50, align: 'Center', name: 'AvancePagoConInc', hidden: true
                                 },
                                 {
                                     index: 'avance_pago_sin_inc', width: 50, align: 'Center', name: 'AvancePagoSinInc', hidden: true
                                 },
                                 {
                                     index: 'id_act_costo_obra', width: 50, align: 'Center', name: 'IdActCostObr', hidden: true
                                 },
                                 {
                                     index: 'idcomite', width: 50, align: 'Center', name: 'IdComite', hidden: true
                                 },
                                 {
                                     index: 'idacuerdo', width: 50, align: 'Center', name: 'IdAcuerdo', hidden: true
                                 },
                                 {
                                     index: 'fec_cap_aprob_comite', width: 50, align: 'Center', name: 'FecCapAprobCom', hidden: true
                                 },
                                 {
                                     index: 'fec_comite', width: 100, align: 'Center', name: 'FecAprobComite', hidden: true
                                 },
                                 {
                                      index: 'num_sesion', width: 80, align: 'Center', name: 'NumSesion'
                                 },
                                 {
                                      index: 'folio_acuerdo', width: 120, align: 'Center', name: 'FolioAcuerdo'
                                 },
                                 {
                                     index: 'idusu_aprob_comite', width: 50, align: 'Center', name: 'IdUsuAprobComite', hidden: true
                                 },
                                 {
                                     index: 'costo_mto_nuevo', width: 50, align: 'Center', name: 'CostoMtoNvo', hidden: true
                                 },
                                 {
                                     index: 'fec_cap_costo_mto', width: 100, align: 'Center', name: 'FecCapCostoMto'
                                 },
                                 {
                                     index: 'idusu_cap_costo_mto', width: 50, align: 'Center', name: 'IdUsuCapCostoMto', hidden: true
                                 },
                                 {
                                     index: 'idasamblea', width: 50, align: 'Center', name: 'IdAsamblea', hidden: true
                                 },
                                 {
                                     index: 'num_coops_act', width: 100, align: 'Center', name: 'NumCoopsAct'
                                 },                                
                                 {
                                     index: 'acta_comite', width: 50, align: 'Center', name: 'ActaComite', hidden: true
                                 },
                                 {
                                     index: 'presup_nuevo', width: 100, align: 'Center', name: 'PresupNvo', hidden: true
                                 }],
                 pager: "#pager", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input contAccion text format.
                 rowNum: "30", // PageSize.
                 rowList: [10, 20, 30], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "obr_clv_int", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1800",
                 height: "800",
                 caption: "OBRAS CON PLAZO DE RECAUDACION VENCIDO"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AsigComiteAprob",
                            id: "alta_comite_aprob",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objActCostoObra = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objActCostoObra.obr_clv_int) {
                                    ConsultaPermisoEjecutarTarea(idusu, 155, 3)
                                        .done(function (result) {
                                            var data = result.d;
                                            var no_tiene_permiso = data.split(":");
                                            var no_tiene = parseInt(no_tiene_permiso[1]);
                                            if (!no_tiene) {
                                                if (objActCostoObra.IdProg != '29') {
                                                    if (objActCostoObra.IdComite == '0') {
                                                        $("#bodegadatos").data("accion_act_costo_obra", 0);
                                                        GestionComiteAprobatorio(objActCostoObra, 0);
                                                    } else {
                                                        $("#bodegadatos").data("accion_act_costo_obra", 1);
                                                        GestionComiteAprobatorio(objActCostoObra, 1);
                                                    }
                                                } else {
                                                    alert('La obra tiene asignado un programa de Predios Municipales, por tanto no es viable asignar Actualización de Costo de Obra');
                                                }
                                            }
                                            else {
                                                alert('El usuario ' + idusu + ' no cuenta con el permiso para asignar Comité Técnico Aprobatorio');
                                            }
                                        
                                        })
                                        .fail(function (xhr) {
                                            console.log(xhr.responseText);
                                            alert("Falló consultar permiso de ejecución de tarea.");
                                        });
                                } else {
                                    alert("Selecciona una obra...");
                                }

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                
                   .navButtonAdd('#pager',
                        {
                            caption: "AltaNuevoCostoMto",
                            id: "capturar_nvo_costo",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objActCostoObra = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objActCostoObra.obr_clv_int) {
                                    ConsultaPermisoEjecutarTarea(idusu, 156, 3)
                                    .done(function (result) {
                                        var data = result.d;
                                        var no_tiene_permiso = data.split(":");
                                        var no_tiene = parseInt(no_tiene_permiso[1]);
                                        if (!no_tiene) {
                                            if (parseInt(objActCostoObra.IdComite) > 0) {
                                                if (parseInt(objActCostoObra.IdAsamblea) > 0) {
                                                    alert('Imposible modificar el costo de metro nuevo, porque la obra ya tiene incrementos aplicados.');                                                    
                                                } else {
                                                    GestionCostoNuevoObra(objActCostoObra, 2);
                                                }
                                            } else {
                                                alert('No es posible asignar un costo nuevo, cuando la obra no se encuentra aprobada por un Comité Técnico.');
                                            }
                                        }else {
                                            alert('El usuario ' + idusu + ' no cuenta con el permiso para asignar Costo Metro Lineal Nuevo.');
                                        }
                                    })
                                    .fail(function (xhr) {
                                        console.log(xhr.responseText);
                                        alert("Falló consultar permiso de ejecución de tarea.");
                                    });                                   
                                }
                                else {
                                    alert("Selecciona una obra...");
                                }
                                
                            },
                            position: "last",
                            title: "AsigCostoMtoNuevo",
                            cursor: "pointer"
                        })


                       .navButtonAdd('#pager',
                        {
                            caption: "VerActaComite",
                            id: "VerActaComite",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objActCostoObra = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objActCostoObra.obr_clv_int) {
                                    if (parseInt(objActCostoObra.IdComite)) {
                                        AbreVisorDocto(objActCostoObra.ActaComite);
                                    }
                                    else {
                                        alert("La obra no tiene asignada Comité de Aprobación de Actualización de Costo...");
                                    }
                                }
                                else {
                                    alert("Selecciona una obra...");
                                }
                            },
                            position: "last",
                            title: "VerActaComite",
                            cursor: "pointer"
                        })

                        .navButtonAdd('#pager',
                        {
                           caption: "VerPresupNvo",
                           id: "VerPresupNvo",
                           buttonicon: "ui-icon-document",
                           onClickButton: function () {

                            var myGrid = $('#grid');
                            var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var objActCostoObra = myGrid.jqGrid('getRowData', selectedRowId);

                            if (objActCostoObra.obr_clv_int) {
                                if (parseFloat(objActCostoObra.CostoMtoNvo)>0) {
                                    AbreVisorDocto(objActCostoObra.PresupNvo);
                                }
                                else {
                                    alert("La obra no tiene asignado un costo de metro nuevo de obra...");
                                }
                            }
                            else {
                                alert("Selecciona una obra...");
                            }
                        },
                        position: "last",
                        title: "VerActaComite",
                        cursor: "pointer"
                        });

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


            var nom_calle = $('#txtnomcalle').val();
            if (nom_calle.length <= 0 || nom_calle.length > 30) {
                nom_calle = "NULL";
            }

            var obr_clv_int_txt = $('#txtclvsgp').val();
            if (obr_clv_int_txt.length <= 0 || obr_clv_int_txt.length > 30) {
                obr_clv_int_txt = "NULL";
            }

            var obra_s = $('#txtnumobra').val();
            if (obra_s.length <= 0 || obra_s.length > 30) {
                obra_2 = "NULL";
            }

            var filtro = obr_clv_int_txt + ',' + obra_s + ',' + nom_calle + ',';
            return filtro;
        }


        function Buscar_ObrasVencRec(idusu) {
            MostrarObrasVencidaRec(idusu, ObtenerFiltro());
        }


        function FormatoMoneda(parametro) {
            if (!isNaN(parametro)) {
                resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
            } else {
                resultado = 0;
            }
            return resultado
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




            $(".buscar_obra").click(function () {
                Buscar_ObrasVencRec(idusu);
            });

         

            $(".ver_doc_comite").click(function () {
                var acta_comite = $('#lblacta_comite').html()
                if (acta_comite != '' || acta_comite != 'null') {
                    AbreVisorDocto(acta_comite);
                }
            });


            $(".verarchivo").click(function (e) {
                var presup_nuevo= $('#archivo_presup_nuevo').text()
                if (presup_nuevo != '' || presup_nuevo != 'null') {
                    AbreVisorDocto(presup_nuevo);
                }
            });
            
        

            $("#bodegadatos").data("idusu", idusu);

            $(".posicion_boton_cancelar_comite_obra, .posicion_boton_cancelar_costo_nuevo_obra").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_comite_obra").click(function (e) {
                EjecutarAccionComiteAprobatorio();
            });

            $(".posicion_boton_accion_costo_nuevo_obra").click(function (e) {
                EjecutarAccionCostoNuevoObra();
            });

            

            $("#lstcomite_tecnico").change(function () {
                var idcomite = $("#lstcomite_tecnico").val();                

                var opcion_selec = $("#lstcomite_tecnico").find('option:selected').text();
                var doc_acta_comite = opcion_selec.split('||');
                $("#lblacta_comite").html($.trim(doc_acta_comite[2]));

                llenarAcuerdosComite(0, idcomite, 0);
            });




            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

           


            $('.numbersOnly').keyup(function () {

                var preg = /^([0-9]+\.?[0-9]{0,2})$/;
                if (preg.test(this.value) === false) {
                    this.value = '0';
                }
            });


        });

        function RegistrarActCostoObra(objActCostoObra) {

            var stringData = JSON.stringify(objActCostoObra);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/GuardarActCostoObra",
                data: "{objActCostoObra:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function ConsultaPermisoEjecutarTarea(idusu, idtarea, idaccion) {
            return $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; utf-8',
                url: "../../WebServices/WebServiceTarea.asmx/ConsultaPermisoTarea",
                data: "{'idusu':'" + idusu + "','idtarea':'" + idtarea + "','idaccion':'" + idaccion + "'}"
            });
        }

        function EjecutarAccionComiteAprobatorio() {

            var accion_act_costo_obra = parseInt($("#lblaccion_proc1").html());

            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];
            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

            var objActCostoObra = {
                "id_act_costo_obra": 0,
                "obr_clv_s": '',
                "obr_clv_int": 0,
                "oid": 0,
                "idcomite": 0,
                "idacuerdo": 0,
                "fec_cap_aprob_comite": hoy,
                "idusu_aprob_comite": idusu,
                "costo_mto_nuevo": 0,
                "fec_cap_costo_mto": ConvertirCadenaToFecha('01/01/1900'),
                "idusu_cap_costo_mto": 0,
                "idasamblea": 0,
                "num_coops_act": 0,
                "presup_nuevo":'',
                "accion":0
            }


            if (accion_act_costo_obra == 0) { /*ALTA DE ACTUALIZACION DE COSTO DE OBRA (comite y acuerdo aprobatorio)*/
                if (ValidarDatosComiteAcuerdoAprob()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                    
                    objActCostoObra.accion = 0;
                    objActCostoObra.obr_clv_s = $("#lblobra_s").html();
                    objActCostoObra.obr_clv_int = parseInt($("#lblobr_clv_int_obra").html());
                    objActCostoObra.oid = parseInt($("#lbloid_obra").html());
                    objActCostoObra.idcomite = parseInt($("#lstcomite_tecnico").val());
                    objActCostoObra.idacuerdo = parseInt($("#lstacuerdo_comite").val());
                    objActCostoObra.fec_cap_aprob_comite = hoy;
                    objActCostoObra.idusu_aprob_comite = idusu;

                    RegistrarActCostoObra(objActCostoObra)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            var arr = cadena.split(':');
                            var error = $.trim(arr[1]);
                            if (error == '0') {                               
                                alert('El Comité ha sido asignado a la Actualización de Obra:' + arr[3] + ' satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            } else {
                                alert(cadena);
                            }
                        }
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        $('#mask, .window').hide();
                        alert("No fue posible guardar la Actualizacion de Costo de Obra");
                    })
                }
            }

            if (accion_act_costo_obra == 1) {
                if (ValidarDatosComiteAcuerdoAprob()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                    objActCostoObra.accion = 1;
                    objActCostoObra.oid = parseInt($("#lbloid_obra").html());
                    objActCostoObra.id_act_costo_obra = parseInt($("#lblid_costo_obra").html());
                    objActCostoObra.idcomite = parseInt($("#lstcomite_tecnico").val());
                    objActCostoObra.idacuerdo = parseInt($("#lstacuerdo_comite").val());
                    objActCostoObra.fec_cap_aprob_comite = hoy;
                    objActCostoObra.idusu_aprob_comite = idusu;


                    RegistrarActCostoObra(objActCostoObra)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            var arr = cadena.split(':');
                            var error = $.trim(arr[1]);
                            if (error == '0') {                              
                                alert('El Comité ha sido asignado a la Actualización de Obra:' + arr[3] + ' satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            } else {
                                alert(cadena);
                            }
                        }
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        $('#mask, .window').hide();
                        alert("No fue posible modificar la Actualizacion de Costo de Obra");
                    })
                }

            }

           

        }


        function EjecutarAccionCostoNuevoObra() {

            var accion_cn = parseInt($("#lblaccion_cn").html());

            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];
            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

            var objActCostoObra = {
                "id_act_costo_obra": 0,
                "obr_clv_s": '',
                "obr_clv_int": 0,
                "oid": 0,
                "idcomite": 0,
                "idacuerdo": 0,
                "fec_cap_aprob_comite": hoy, 
                "idusu_aprob_comite": idusu,
                "costo_mto_nuevo": 0,
                "fec_cap_costo_mto": hoy,
                "idusu_cap_costo_mto": idusu,
                "idasamblea": 0,
                "num_coops_act": 0,
                "presup_nuevo":'',
                "accion": 0
            }


            if (accion_cn == 2) { /*MODIFICACION DE ACTUALIZACION DE COSTO DE OBRA (MODIFICAR COSTO DE OBRA)*/
                if (ValidarDatosCostoMto()) {  /*Valida que se haya capturado COSTO DE METRO VALIDO*/
                    objActCostoObra.accion = 2;                    
                    objActCostoObra.id_act_costo_obra = parseInt($("#lblid_act_costo_obra_cn").html());
                    objActCostoObra.fec_cap_aprob_comite = hoy;
                    objActCostoObra.idusu_aprob_comite = idusu;
                    objActCostoObra.costo_mto_nuevo = parseFloat($("#txtcosto_nuevo_obra").val());
                    objActCostoObra.presup_nuevo = 'Presup_Nvo_' + $("#lblid_act_costo_obra_cn").html() + '.pdf';


                    RegistrarActCostoObra(objActCostoObra)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            var arr = cadena.split(':');
                            var error = $.trim(arr[1]);
                            if (error == '0') {
                                ValidacionGuardadoArchivo($("#file_presup_nuevo").get(0).files, objActCostoObra.presup_nuevo);
                                alert('El costo del metro lineal ha sido registrado de la Act.Costo Obra:' + arr[3] + ' satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            } else {
                                alert(cadena);
                            }
                        }
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        $('#mask, .window').hide();
                        alert("No fue posible guardar el costo del metro nuevo de la obra de la Actualizacion de Costo de Obra");
                    })
                }
            }           

        }


        function ValidarDatosComiteAcuerdoAprob() {

            var valid;

            if (parseInt($("#lstcomite_tecnico").val()) > 0) {
                valid = true;
            } else {
                valid = false;
                alert('No se ha seleccionado un comite válido')
            }

            if (parseInt($("#lstacuerdo_comite").val()) > 0) {
                valid = true;
            } else {
                valid = false;
                alert('No se ha seleccionado acuerdo válido')
            }

            return valid;
        }

        

        function ValidarDatosCostoMto() {

            var valid;

            valor_nuevo = parseFloat($("#txtcosto_nuevo_obra").val());
            if (valor_nuevo >= 200 && valor_nuevo <= 100000) {
                valid = true;
            } else {
                valid = false;
                alert('No se ha capturado un valor válido, debe ser entre Mayuor a $200.00 y Menor a $100,000.00')
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
                url: "http://192.1.126.122/fidoc/WebServices/WebServiceFileUpload.asmx/GuardarArchivo",
                contentType: false,
                processData: false,
                data: formdata
            });
        }


        function GestionComiteAprobatorio(objActCostoObra, accion) {
          

            if (accion == 0) {  /*Alta de Accion*/
                $("#lblobra_s").html(objActCostoObra.obr_clv);
                $("#lblcalle_obra").html(objActCostoObra.Calle);
                $("#lblcolonia_obra").html(objActCostoObra.Colonia);
                $("#lbltramo_obra").html(objActCostoObra.Tramo);
                $("#lblacta_comite").html('');
                $("#lbloid_obra").html(objActCostoObra.oid);
                $("#lblobr_clv_int_obra").html(objActCostoObra.obr_clv_int);
                $("#lblid_costo_obra").html(objActCostoObra.IdActCostObr);
                $("#lblaccion_proc1").html(accion);
                llenarComiteTecnico(0,0, accion);
                
            }
            else {
                if (accion == 1) {
                    $("#lblobra_s").html(objActCostoObra.obr_clv);
                    $("#lblcalle_obra").html(objActCostoObra.Calle);
                    $("#lblcolonia_obra").html(objActCostoObra.Colonia);
                    $("#lbltramo_obra").html(objActCostoObra.Tramo);
                    $("#lblacta_comite").html('');
                    $("#lbloid_obra").html(objActCostoObra.oid);
                    $("#lblobr_clv_int_obra").html(objActCostoObra.obr_clv_int);
                    $("#lblid_costo_obra").html(objActCostoObra.IdActCostObr);
                    $("#lblaccion_proc1").html(accion);
                    llenarComiteTecnico(objActCostoObra.IdComite, objActCostoObra.IdAcuerdo,0);

                }
            }
            MostrarModalComiteAprobatorio();
        }


        function GestionCostoNuevoObra(objActCostoObra, accion) {

            if (accion == 2) {  /*Alta de Accion*/
                $("#lblobra_s_cn").html(objActCostoObra.obr_clv);
                $("#lblcalle_cn").html(objActCostoObra.Calle);
                $("#lblcolonia_cn").html(objActCostoObra.Colonia);
                $("#lbltramo_cn").html(objActCostoObra.Tramo);
                $("#lblcosto_mto_viejo").html(FormatoMoneda(objActCostoObra.CostoMto));
                var costo_mto_nuevo = 0;
                if (parseFloat(objActCostoObra.CostoMtoNvo) > 0) {
                    costo_mto_nuevo = parseFloat(objActCostoObra.CostoMtoNvo);
                    $("#txtcosto_nuevo_obra").val(costo_mto_nuevo.toFixed(2).toString());
                } else {
                    $("#txtcosto_nuevo_obra").val('');
                }
                
                $("#lbloid_cn").html(objActCostoObra.oid);
                $("#lblobr_clv_int_cn").html(objActCostoObra.obr_clv_int);
                $("#lblid_act_costo_obra_cn").html(objActCostoObra.IdActCostObr);
                $("#archivo_presup_nuevo").html(objActCostoObra.PresupNvo);
                $("#lblaccion_cn").html(accion);             

            }           
            MostrarModalNuevoCostoObra();
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


        function MostrarModalComiteAprobatorio() {
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
            $("#dialogo_comite_obra").css('top', winH / 2 - $("#dialogo_comite_obra").height() / 2);
            $("#dialogo_comite_obra").css('left', winW / 2 - $("#dialogo_comite_obra").width() / 2);

            //transition effect
            $("#dialogo_comite_obra").fadeIn(2000);
        };

        function MostrarModalNuevoCostoObra() {
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
            $("#dialogo_costo_nuevo").css('top', winH / 2 - $("#dialogo_costo_nuevo").height() / 2);
            $("#dialogo_costo_nuevo").css('left', winW / 2 - $("#dialogo_costo_nuevo").width() / 2);

            //transition effect
            $("#dialogo_costo_nuevo").fadeIn(2000);
        };

        


        function llenarAcuerdosComite(idacuerdo,idcomite, accion) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: "{'idacuerdo':'" + idacuerdo + "','idcomite':'" + idcomite + "','accion':'" + accion + "'}",
                url: "../../WebServices/WebServiceAcuerdo.asmx/GetAcuerdo",
                success: function (data) {
                    var elementos = 0;
                    $("#lstacuerdo_comite").html('');
                    $(data.d).find("acuerdo").each(function () {
                        var option = $(document.createElement('option'));
                        var idacuerdo_opc = $(this).find("idacuerdo_r").text();
                        var num_acuerdo_opc = $(this).find("num_acuerdo_r").text();
                        var descrip_acuerdo_opc = $(this).find("descrip_acuerdo_r").text();                        

                        option.html(descrip_acuerdo_opc + ' || ' + ' (' + num_acuerdo_opc + ')');
                        option.val(idacuerdo_opc);
                        $("#lstacuerdo_comite").append(option);
                    });
                    if (idacuerdo > 0) { //
                        $("#lstacuerdo_comite").val(idacuerdo);
                    }

                  

                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }

        function llenarComiteTecnico(idcomite,idacuerdo, accion) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                data: "{'idcomite':'" + idcomite + "','accion':'" + accion + "'}",
                url: "../../WebServices/WebServiceComite.asmx/GetComite",                
                success: function (data) {
                    var elementos = 0;
                    $("#lstcomite_tecnico").html('');
                    $(data.d).find("comites").each(function () {
                        var option = $(document.createElement('option'));
                        var idcomite_opc = $(this).find("idcomite_r").text();
                        var num_comite_opc = $(this).find("num_sesion_r").text();
                        var leyenda_comite_opc = $(this).find("leyenda_r").text();
                        var acta_comite_opc = $(this).find("acta_comite_r").text();
                        
                        option.html(leyenda_comite_opc + ' || ' + ' (' + num_comite_opc + ')' + '|| ' + acta_comite_opc);
                        option.val(idcomite_opc);
                        $("#lstcomite_tecnico").append(option);
                    });

                    if (idcomite > 0) { //
                        $("#lstcomite_tecnico").val(idcomite);
                                   
                    } else {
                        idcomite = $("#lstcomite_tecnico").val();
                    }

                    var opcion_selec = $("#lstcomite_tecnico").find('option:selected').text();
                    var doc_acta_comite = opcion_selec.split('||');
                    $("#lblacta_comite").html($.trim(doc_acta_comite[2]));

                    llenarAcuerdosComite(idacuerdo, idcomite, 0);
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }




</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

   
<label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px" maxlength ="120"/><br/><br/>
<label>ClvObra (SGPFIDOC):</label><input type="text" name="obr_clv_int" id="txtclvsgp" style="width:250px" maxlength ="10"/><br/><br/>
<label>Obra (SIFIDOC):</label><input type="text" name="obra" id="txtnumobra" style="width:250px" maxlength="10"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_obra"><== Buscar obra ==></a><br/><br/>

         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
   <div id="dialogo_comite_obra" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">GESTION DE COMITE Y ACUERDO APROBATORIO</td>
              </tr>   
              <tr>
                  <td class="f">Obra_S:</td>                                    
                  <td class="e" colspan="3"><label id="lblobra_s"/></td>
              </tr>                                                                                                                                                                                                                                                                                                                                                                       
              <tr>                  
                  <td class="f">CALLE:</td>
                  <td class="e" colspan="3"><label id="lblcalle_obra"/></td>
              </tr>             
              <tr>
                  <td class="f">COLONIA:</td>
                  <td class="e" colspan="3"><label id="lblcolonia_obra"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td class="e" colspan="3"><label id="lbltramo_obra"/></td>                  
              </tr>
              <tr>
                  <td class="f">Comite Tecnico:</td>
                  <td class="e" colspan="3"><select class="select_captura" name="comite_tecnico" id="lstcomite_tecnico"></select></td>                  
              </tr>
              <tr>
                  <td class="f">Acuerdo:</td>
                  <td class="e" colspan="3"><select class="select_captura" name="acuerdo_comite" id="lstacuerdo_comite"></select></td>                                    
              </tr>
              <tr>    
                  <td class="boton_dialog" colspan="4"><a href="#" class ="ver_doc_comite"><label id="lblacta_comite"/></a></td>                  
              </tr>
              <tr class="renglon_sistema">
                  <td>oid:</td>
                  <td class="columna_sistema"><label id="lbloid_obra"/></td>                                           
                  <td>obr_clv_int:</td>
                  <td class="columna_sistema"><label id="lblobr_clv_int_obra"/></td>                                           
              </tr>
              <tr class="renglon_sistema">
                  <td>id_act_costo_obra:</td>
                  <td class="columna_sistema"><label id="lblid_costo_obra"/></td>                                           
                  <td>accion:</td>
                  <td class="columna_sistema"><label id="lblaccion_proc1"/></td>                                           
              </tr>               
              <tr>                                              
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_comite_obra">ACEPTAR</a></td>                  
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_comite_obra">CANCELAR</a></td>                  
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="dialogo_costo_nuevo" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">NUEVO COSTO DEL METRO LINEAL</td>
              </tr>   
              <tr>
                  <td class="f">Obra_S:</td>                                    
                  <td class="e" colspan="3"><label id="lblobra_s_cn"/></td>
              </tr>                                                                                                                                                                                                                                                                                                                                                                       
              <tr>                  
                  <td class="f">CALLE:</td>
                  <td class="e" colspan="3"><label id="lblcalle_cn"/></td>
              </tr>             
              <tr>
                  <td class="f">COLONIA:</td>
                  <td class="e" colspan="3"><label id="lblcolonia_cn"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td class="e" colspan="3"><label id="lbltramo_cn"/></td>                  
              </tr>
              <tr>
                  <td class="f">Costo Actual Mto. Lineal:</td>
                  <td class="e" colspan="3"><label id="lblcosto_mto_viejo"/></td>                  
              </tr>
              <tr>
                  <td class="f">Costo Nuevo Mto. Lineal:</td>
                  <td class="e" colspan="3"><input type="text" class="numbersOnly" name="monto_con_iva" id="txtcosto_nuevo_obra" size="10" maxlength="15"/></td>                                    
              </tr>       
               <tr>
                  <td class="f">Presupuesto Nuevo:</td>
                  <td class="e" colspan="3"><input type="file" id="file_presup_nuevo" name="file"/>&nbsp&nbsp<a href="#" id="archivo_presup_nuevo" class="verarchivo"></a></td>                                    
              </tr>             
              <tr class="renglon_sistema">
                  <td>oid:</td>
                  <td class="columna_sistema"><label id="lbloid_cn"/></td>                                           
                  <td>obr_clv_int:</td>
                  <td class="columna_sistema"><label id="lblobr_clv_int_cn"/></td>                                           
              </tr>
              <tr class="renglon_sistema">
                  <td>id_act_costo_obra:</td>
                  <td class="columna_sistema"><label id="lblid_act_costo_obra_cn"/></td>                                           
                  <td>accion:</td>
                  <td class="columna_sistema"><label id="lblaccion_cn"/></td>                                           
              </tr>               
              <tr>                                              
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_costo_nuevo_obra">ACEPTAR</a></td>                  
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_costo_nuevo_obra">CANCELAR</a></td>                  
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>
