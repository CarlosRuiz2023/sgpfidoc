<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_obra_contrato.aspx.vb" Inherits="Admin_procesos_consultar_obra_contrato" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">

        function GestionCooperadores(oid, obr_clv_int, obr_clv, obr_estatus, idprog, idusu, fid, num_pagos, fec_venc, coopid) {
            //alert(img);
            var url1 = "../Procesos/gCoops.html?ResponseType=Edit&oid=" + oid + "&obr_clv_int=" + obr_clv_int + "&obr_clv=" + obr_clv + "&obr_estatus=" + obr_estatus + "&programa=" + idprog + "&idusu=" + idusu + "&fid=" + fid + "&num_pagos=" + num_pagos + "&fec_venc=" + fec_venc + "&coopid=" + coopid;
            newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }

        function ConsultaSalidaObra(obr_clv_int, idusu) {
            //alert(img);
            var url1 = "../Procesos/salida_obra.html?ResponseType=Edit&obr_clv_int=" + obr_clv_int + "&idusu=" + idusu;
            newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1900,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }


        function ConsultaSalidaPredio(idusu, oid, pid) {
            //alert(img);
            var url1 = "../Procesos/salida_predio.html?ResponseType=Edit&idusu=" + idusu + "&oid=" + oid + "&pid=" + pid;
            newWindow = window.open(url1, "_blank", "top=150,left=150,menubar=no,toolbar=no,location=no, resizable=no,height=846,width=1674,status=no,scrollbars=yes,minimizable=no,maxmizable=no,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
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

        //Funcion para redimensionar los input de la ventana modal
        function resizeInput() {

            var valueLength = $(this).prop('value').length;

            // Para que no arroje error si el input se vacía
            if (valueLength > 0) {

                $(this).prop('size', valueLength);
            }
        }



        //Fecha de vencimiento de pagos
        function FechaVencPagos(obr_npago) {
            var obr_fecvenp = '';
            var fecvenc2 = new Date();
            var fecvenc = new Date();

            var fecvenc = ConvertirCadenaToFecha($("#txtfecinipag").val());
            if (fecvenc > ConvertirCadenaToFecha('01/01/1900')) {
                fecvenc.setMonth(fecvenc.getMonth() + (parseInt(obr_npago) - 1));
                fecvenc2 = new Date(fecvenc.getFullYear(), fecvenc.getMonth() + 1, 0);
                obr_fecvenp = CompletaCerosIzq(fecvenc2.getDate(), 2) + "/" + CompletaCerosIzq(fecvenc2.getMonth() + 1, 2) + "/" + CompletaCerosIzq(fecvenc2.getFullYear());  //Fecha de vencimiento de pagos            
            }
            else {
                obr_fecvenp = '01/01/1900';  //Fecha de vencimiento de pagos
            }
            $("#lblfecvenc").html(obr_fecvenp);
            $("#lblfecvenc").css("background", "white");
        }

        function FormatoMoneda(parametro) {
            if (!isNaN(parametro)) {
                resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
            } else {
                resultado = 0;
            }
            return resultado
        }


        function formateacantidad(cantidad) {
            cantidad = cantidad.replace(/\\d+(.\\d+)?/g, '');
            return (cantidad);
        }

        function formateaMesCorresp(parametro) {
            resultado = parametro;
            if (!IsNumeric(parametro)) {
                resultado = 0;
            }
            return resultado
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



        function FechaHora() {
            var hora = new Date()
            var hrs = hora.getHours();
            var min = hora.getMinutes();
            if (min < 10) min = "0" + min;
            var hoy = new Date();
            var m = new Array();
            var d = new Array()
            var an = hoy.getYear();
            d[1] = "lunes";
            d[2] = "martes";
            d[3] = "miercoles";
            d[4] = "jueves";
            d[5] = "viernes";
            d[6] = "sábado";
            d[0] = "domingo";
            m[0] = "enero"; m[1] = "febrero"; m[2] = "marzo";
            m[3] = "abril"; m[4] = "mayo"; m[5] = "junio";
            m[6] = "julio"; m[7] = "agosto"; m[8] = "septiembre";
            m[9] = "octubre"; m[10] = "noviembre"; m[11] = "diciembre";
            var lugarfechahora = d[hoy.getDay()] + " " + hoy.getDate() + " de " + m[hoy.getMonth()] + "  " + hoy.getFullYear() + "," + hrs + ":" + min + ' hrs';

            return lugarfechahora;
        }


        function NombreMes(num_mes) {

            var m = new Array();

            m[0] = "Enero"; m[1] = "Febrero"; m[2] = "Marzo";
            m[3] = "Abril"; m[4] = "Mayo"; m[5] = "Junio";
            m[6] = "Julio"; m[7] = "Agosto"; m[8] = "Septiembre";
            m[9] = "Octubre"; m[10] = "Noviembre"; m[11] = "Diciembre";
            var nom_mes = m[num_mes];
            return nom_mes;
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

        function CompletaCerosIzq(valor, longitud) {
            var cadena = valor.toString();
            var j = cadena.length;
            if (j < longitud) {
                for (var i = 1; i < longitud; i++) {
                    cadena = '0' + cadena;
                }
            }
            return cadena;
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
            var nomcalle = $.trim($('#txtnomcalle').val());
            if (nomcalle.length <= 0 || nomcalle.length > 20) {
                nomcalle = '';
            }

            var num_obra = $.trim($('#txtnumobra').val());
            if (num_obra.length <= 0 || !$.isNumeric(num_obra)) {
                num_obra = '';
            }

            var num_obra_sgp = $.trim($('#txtclvsgp').val());
            if (num_obra_sgp.length <= 0 || !$.isNumeric(num_obra_sgp)) {
                num_obra_sgp = '';
            }

            var filtro = num_obra + "," + nomcalle + ",," + num_obra_sgp + ",";
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


   


        function Buscar_obra() {



            var filtro = ObtenerFiltro();
            var filtro2;

            var estatus_obra_seleccionado;


            var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
            var idusu = arrusuario[2];
            
            var contratos_obra = {
                "oid": 0,
                "contratos": '',
                "obr_clv_int": 0,
                "accion": 0                
            }

            if ($("#grid")[0].grid) {
                $.jgrid.gridUnload("#grid");
                //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
            }

            $("#grid").jqGrid(
             {
                 datatype: function () {
                     $.ajax(
                       {
                           url: "../../WebServices/WebServiceObras.asmx/GetObraProc_psql", //PageMethod
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
                     id: "obr_clv_int_x"
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
                      name: 'EstObra', hidden: true
                  },
                  {
                      index: 'obr_fec_pub1', width: 160, align: 'center',
                      name: 'FecPub1', hidden: true
                  },
                  {
                      index: 'evid_pub1', width: 200, align: 'center',
                      name: 'EvidPub1', hidden: true
                  },
                  {
                      index: 'evid_pub1', width: 200, align: 'center',
                      name: 'EvidPub1_vinc', formatter: function (cellvalue) {
                          var archivo = cellvalue;
                          var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                          return url;
                      }, hidden: true
                  },
                  {
                      index: 'obr_fec_pub2', width: 160, align: 'center',
                      name: 'FecPub2', hidden: true
                  },
                  {
                      index: 'evid_pub2', width: 200, align: 'center',
                      name: 'EvidPub2', hidden: true
                  },
                  {
                      index: 'evid_pub2', width: 200, align: 'center',
                      name: 'EvidPub2_vinc', formatter: function (cellvalue) {
                          var archivo = cellvalue;
                          var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                          return url;
                      }, hidden: true
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
                      name: 'NumPagos', hidden: true
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
                          var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                          return url;
                      }, hidden: true
                  },
                  {
                      index: 'obr_fec_ini_cob', width: 160, align: 'center',
                      name: 'FecIniCob', hidden: true
                  },
                  {
                      index: 'evid_termino_obra', width: 200, align: 'center',
                      name: 'EvidTermObr', hidden: true
                  },
                   {
                       index: 'evid_termino_obra', width: 200, align: 'center',
                       name: 'EvidTermObr_vinc', formatter: function (cellvalue) {
                           var archivo = cellvalue;
                           var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                           return url;
                       }, hidden: true
                   },
                  {
                      index: 'obr_fec_canc', width: 160, align: 'center',
                      name: 'ObrFecCanc', hidden: true
                  },
                  {
                      index: 'no_contrato', width: 300, align: 'center',
                      name: 'NumContrato', hidden: true
                  },
                  {
                      index: 'gastos_admvos', width: 100, align: 'center',
                      name: 'GastosAdmvos', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }
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
                 sortname: "b.obr_clv_int", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1900",
                 height: "800",
                 caption: "OBRAS EN ETAPA DE PROCESO",
                 subGrid: true,
                 subGridBeforeExpand: function (subgrid_id, row_id) {
                     var myGrid = $('#grid');
                     obra = myGrid.jqGrid('getRowData', row_id);
                     
                     contratos_obra.oid = obra.oid;
                     contratos_obra.contratos = obra.NumContrato + '0';
                     contratos_obra.obr_clv_int = obra.ClvObra;
                     contratos_obra.accion = 0;

                     filtro2 = + obra.ClvObra + ',';
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
                                         url: "../../WebServices/WebServiceContrato.asmx/GetContrato_x_ObraGrid", //PageMethod
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
                                    id: "obr_clv_int"
                                },
                               colModel: [
                                     {
                                         index: 'oid', width: 80, align: 'Center', name: 'oid', hidden: true
                                     },
                                     {
                                         index: 'obr_clv_int', width: 100, align: 'Center', name: 'obr_clv_int', hidden: true
                                     },
                                     {
                                         index: 'obr_clv', width: 50, align: 'Center', name: 'Obra_S', hidden: true
                                     },
                                     {
                                         index: 'idcontrato', width: 50, align: 'Center', name: 'IdContrato', hidden: true
                                     },
                                     {
                                         index: 'num_contrato', width: 100, align: 'Center', name: 'NumContrato'
                                     },
                                     {
                                         index: 'calle', width: 100, align: 'Center', name: 'CALLE', hidden: true
                                     },
                                     {
                                         index: 'colonia', width: 100, align: 'Center', name: 'COLONIA', hidden: true
                                     },
                                     {
                                         index: 'tramo', width: 80, align: 'Center', name: 'TRAMO', hidden: true
                                     },
                                     {
                                         index: 'idprog', width: 100, align: 'Center', name: 'IdProg', hidden: true
                                     },
                                     {
                                         index: 'nom_prog', width: 100, align: 'Center', name: 'NomPrograma', hidden: true
                                     },
                                     {
                                         index: 'docto_contrato', width: 100, align: 'Center', name: 'DoctoContrato', hidden: true
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
                               sortname: "obr_clv_int", //login SortColumn
                               sortorder: "asc", //login SortOrder.
                               width: "1200",
                               height: "100%",
                               caption: "CONTRATOS POR OBRA"
                           }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                           .navButtonAdd("#" + pager_id,
                                 {
                                     caption: "AsignarContrato",
                                     buttonicon: "ui-icon-document",
                                     onClickButton: function () {
                                         var mySubGrid = $("#" + subgrid_table_id);
                                         selectedRowId = mySubGrid.jqGrid('getGridParam', 'selrow');
                                         
                                         $("#lbloid_contrato_obra").text(contratos_obra.oid);
                                         $("#lblobr_clv_int_contrato_obra").text(contratos_obra.obr_clv_int);
                                         $("#lblidusu_contrato_obra").text(idusu);
                                         $("#lblaccion_contrato_obra").text(contratos_obra.accion);

                                         var ids_subgrid = jQuery("#" + subgrid_table_id).getDataIDs();
                                         if (ids_subgrid.length < 4) {
                                             if (ids_subgrid.length == 0) {
                                                 alert('No es posible asignar contratos a la obra seleccionada, hasta que sea ejecutado el cambio de estatus RECAUDACION ---> PROCESO');                                                 
                                             } else {
                                                 MostrarAsignarContrato();
                                                 llenarContratos(contratos_obra.contratos, 0);
                                             }

                                         } else {
                                             alert('No es posible asignar un nuevo contrato, el limite son 4');                       
                                         }
                                         
                                     },
                                     position: "last",
                                     title: "AsigCont",
                                     cursor: "pointer"
                                 })

                           .navButtonAdd("#" + pager_id,
                                      {
                                          caption: "QuitarContrato",
                                          buttonicon: "ui-icon-document",
                                          onClickButton: function () {                                             

                                              var myGrid = $("#" + subgrid_table_id);
                                              var contratos = jQuery("#" + subgrid_table_id).getDataIDs();

                                              if (contratos.length > 1) {
                                                  selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                  var idcontrato = myGrid.jqGrid('getCell', selectedRowId, 'IdContrato');
                                                  var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');                                                  
                                                  if (idcontrato) {
                                                      RegistraContratoObra(oid, idcontrato, idusu, 1)
                                                      .done(function (result) {
                                                                alert('Contrato desvinculado correctamente');
                                                                RedibujarGrid();
                                                                $('#mask, .window').hide();
                                                            })
                                                      .fail(function (xhr) {
                                                            console.log(xhr.responseText);
                                                            alert("Fallo la desvinculacion  del contrato en BD.");
                                                       });
                                                  }
                                                  else {
                                                      
                                                  }
                                              } else {
                                                  alert('No es posible desvincular todos los contratos de la obra.')
                                              }
                                          },
                                          position: "last",
                                          title: "Cooperadores",
                                          cursor: "pointer"
                                      })

                           .navButtonAdd("#" + pager_id,
                                    {
                                        caption: "VerContrato",
                                        id: "VerContrato",
                                        buttonicon: "ui-icon-document",
                                        onClickButton: function () {    
                                            var myGrid = $("#" + subgrid_table_id);
                                            var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                            var objContrato = myGrid.jqGrid('getRowData', selectedRowId);
                                            if (objContrato.DoctoContrato) {
                                                AbreVisorDocto(objContrato.DoctoContrato);

                                            }
                                            else {
                                                alert("Selecciona un Contrato...");
                                            }
                                        },
                                        position: "last",
                                        title: "DctoCont",
                                        cursor: "pointer"
                                    });;
                 }

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

               
        }


        function MostrarAsignarContrato() {
        
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
                $("#dialogo_contrato_obra").css('top', winH / 2 - $("#dialogo_contrato_obra").height() / 2);
                $("#dialogo_contrato_obra").css('left', winW / 2 - $("#dialogo_contrato_obra").width() / 2);

                //transition effect
                $("#dialogo_contrato_obra").fadeIn(2000);
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

        function llenarContratos(contratos, idaccion) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceContrato.asmx/GetContrato_q2",
                data: "{'contratos':'" + contratos + "','idaccion':'" + idaccion + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lstcontratos_contrato_obra").html('');
                    $(data.d).find("contratos").each(function () {
                        var option = $(document.createElement('option'));
                        var idcontrato = $(this).find("idcontrato_r").text();
                        var num_contrato = $(this).find("num_contrato_limpio_r").text();
                        var rfc_contratista = $(this).find("rfc_contratista_r").text();
                        option.html(num_contrato);
                        option.val(idcontrato);
                        $("#lstcontratos_contrato_obra").append(option);
                    });

                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }





      
        //// FUNCION PRINCIPAL

        $(document).ready(function () {

            var usuario = $("#lblUsuario").html();
            $("#bodegadatos").data("idusu", usuario.split(":")[1] + ":" + usuario.split(":")[2]);

            /*  $("#lstobrassifidoc").change(function () {
                  llenarObrasSIFIDOC($("#lstobrassifidoc").val());
                  if ($("#lstobrassifidoc").val() == '0000000000') {
                      $("#lstcolonias_s").attr('disabled', false);
                      $("#lstprograma_s").attr('disabled', false);
                      $("#lstsistema_s").attr('disabled', false);
                  }
                  else {
                      $("#lstcolonias_s").attr('disabled', true);
                      $("#lstprograma_s").attr('disabled', true);
                      $("#lstsistema_s").attr('disabled', true);
                  }
              });*/


            $(".buscar_obra").click(function () {
                var noobra = $("#txtnumobra").val();
                Buscar_obra(noobra);
            });

      

            $(".posicion_boton_accion_contrato_obra").click(function () { //Actualizar datos en el registro  

                var oid = $("#lbloid_contrato_obra").html();
                var idcontrato = $("#lstcontratos_contrato_obra").val();
                var idusu = $("#lblidusu_contrato_obra").html();
                RegistraContratoObra(oid, idcontrato, idusu, 0)
                 .done(function (result) {
                     alert('Contrato registrado correctamente');
                     RedibujarGrid();
                     $('#mask, .window').hide();
                 })
                 .fail(function (xhr) {
                       console.log(xhr.responseText);
                       alert("Fallo el registro del contrato en BD.");
                 });

            });        
            

            $(".posicion_boton_cancelar_contrato_obra").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });



            //if mask is clicked
            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

            


        });

       


        function ConsultaObraProc(objObra) {
            var stringData = JSON.stringify(objObra);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/GetObra_obr_clv_int",
                data: "{'accion':'" + objObra.accion + "','obr_clv_int':'" + objObra.obr_clv_int + "'}",
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




        function ConvertirCadenaToFecha(cadenafec) {
            if (cadenafec != "") {
                var from = cadenafec.split("/");
                var from2 = from[2].split(" ");
                var fecha = new Date(from2[0], from[1] - 1, from[0]);
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
        

        function RegistraContratoObra(oid, idcontrato, idusu, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/
            
            var enviarObj = {
                "oid": oid,  
                "obr_clv_int":0,
                "obr_clv":'',
                "idcontrato": idcontrato,
                "num_contrato":'',
                "calle":'',
                "colonia":'',
                "tramo":'',
                "idprog":0,
                "nomprog":'',                
                "idusu": idusu,                
                "accion": accion
            }

            var stringData = JSON.stringify(enviarObj);

           return  $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceContrato.asmx/RegistraContratoObra",
                data: "{objObraContrato:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }

     
       

</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
    <div id="bodegadatos"></div>
         
<label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px" maxlength ="120"/><br/><br/>        
<label>ClvObra (SGPFIDOC):</label><input type="text" name="obr_clv_int" id="txtclvsgp" style="width:250px" maxlength ="10"/><br/><br/>        
<label>Obra (SIFIDOC):</label><input type="text" name="obra" id="txtnumobra" style="width:250px" maxlength="10"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_obra"><== Buscar obra ==></a><br/><br/>
 
<table id="grid"></table>
<div id="pager"></div>&nbsp       
 
<div id="boxes"> 
     <div id="dialogo_contrato_obra" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">ASIGNAR CONTRATO A OBRA EN  PROCESO</td>
              </tr>              
              <tr>
                  <td  class="f" colspan="2">*No. Contrato:</td>
                  <td  colspan="2"><select class="select_captura" name="num_contrato" id="lstcontratos_contrato_obra"></select></td>                   
              </tr>
              
              <tr class="renglon_sistema">                    
                  <td>oid:</td>
                  <td  class="columna_sistema"><label id="lbloid_contrato_obra"/></td>
                  <td>obr_clv_int:</td>
                  <td  class="columna_sistema"><label id="lblobr_clv_int_contrato_obra"/></td>                               
              </tr>              
              <tr class="renglon_sistema">
                  <td>idusu:</td>
                  <td  class="columna_sistema"><label id="lblidusu_contrato_obra"/></td>                  
                  <td>accion:</td>
                  <td  class="columna_sistema"><label id="lblaccion_contrato_obra"/></td>    
              </tr>                  
              <tr>                               
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_contrato_obra">ACEPTAR</a></td>
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_contrato_obra">CANCELAR</a></td>
              </tr>
          </tbody>
       </table>
    </div>                    
    <div id="mask"></div>    
</div>
</asp:Content>



