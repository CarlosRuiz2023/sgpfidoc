<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="edo_cta_fte_gral.aspx.vb" Inherits="Admin_procesos_edo_cta_fte_gral" %>
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

    function QuitarGrid() {       
        $('#grid').remove();        
    }

    function fecha_hoy() {
        var d = new Date();
        var month = d.getMonth() + 1;
        var day = d.getDate();
        return (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + d.getFullYear();
    }
    
    function GenerarEdoCta(rowData) {

        var pdf = new jsPDF('p', 'pt', 'letter');

        var img = new Image();
        img.src = '../../imagenes/logo_fidoc.png';
        pdf.addImage(img, 'PNG', 30, 15, 150, 100);
        pdf.setFontSize(20);
        pdf.text(210, 80, "ESTADO DE CUENTA DE COOPERADOR");

        pdf.setFontSize(15);
        pdf.text(218,156,'fid: ' + rowData.fid);
        pdf.text(80,170,'Cooperador (SIFIDOC): ' + rowData.obra_sifidoc + rowData.coopid);
        pdf.text(76,186,'Nombre del cooperador: ' + rowData.nomcoop);
        pdf.text(36,202,'Fecha pavimentación de obra: ' + rowData.fec_pav);
        pdf.text(146,218,'Estatus Obra: ' + rowData.status_fidoc);
        pdf.text(170,250, 'DOMICILIO DEL PREDIO BENEFICIADO');

        pdf.setFontSize(12);
        pdf.text(120, 270, 'Calle: ' + rowData.calle + ' ' + rowData.nooficial + '  Colonia: ' + rowData.colonia);
        pdf.text(112, 285, 'Tramo: ' + rowData.tramo);        
        pdf.text(70, 310, 'Mts. de Frente: ' + rowData.mtsfrente);
        pdf.text(63, 325, 'Costo del Metro:  $' + rowData.costomto);
        pdf.setFontSize(14);
        pdf.text(107,350, 'Adeudo:  $' + rowData.adeudo);
        pdf.text(115,365, 'Pagos:                          $' + rowData.pagos);
        pdf.text(48, 380, 'Cargos_pagados:                          $' + rowData.cargos_pagados);        
        pdf.text(38, 410, 'Saldo sin recargos: $' + rowData.saldosin);
        pdf.text(35, 425, 'Actualización saldo: $' + rowData.saldoact);
        pdf.text(43, 440, 'Saldo actualizado: $' + rowData.saldoact);
        pdf.setFontSize(14);
        pdf.text(45,505, 'Gasto_ejecución.:  $' + rowData.gasto_ejec);
        pdf.text(108,520, 'Cargos:  $' + rowData.recxpagar);
        pdf.text(22, 535, 'Gasto_requermiento.:  $' + rowData.gasto_req);

        pdf.setFontSize(18);
        pdf.text(300, 600, 'Saldo a Pagar:  $' + rowData.saldocon);
 
        var nom_edo_cta = 'edo_cta_' + fecha_hoy(); + '.pdf';
        
        pdf.save(nom_edo_cta.toString());
    }

    function ObtenerFiltro() {
        var fid = $("#txtfid").val();
        var nomcoop = $("#txtnomcoop").val();
        var coop = $("#txtcoop").val();

        if (nomcoop.length <= 0 || nomcoop.length > 80) {
            nomcoop = "";
        }

        if (fid.length <= 0 || !$.isNumeric(fid)) {
            fid = "0";
        }

        if (coop.length <= 0 || coop.length > 13) {
            coop = "";
        }
        var filtro = fid + "," + coop + "," + nomcoop;
        return filtro;
    }


        function MostrarEdoCtaFte() {        

            if ($("#grid")[0].grid) {  
                $.jgrid.gridUnload("#grid");
                //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
            }
        
            var filtro = ObtenerFiltro();            
                $("#grid").jqGrid({
                    datatype: function ()
                    {filtro},
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
                       index: 'fid', width: 300, align: 'center',
                       name: 'fid'
                   },
                   {
                       index: 'geomfrente', width: 50, align: 'right',
                       name: 'GEO_FTE'
                   },
                   {
                       index: 'obra_sifidoc', width: 300, align: 'center',
                       name: 'obra_sifidoc'
                   },
                   {
                       index: 'coopid', width: 200, align: 'center',
                       name: 'coopid'
                   },                                      
                   {
                       index: 'prid', width: 200, align: 'center',
                       name: 'Presup.'
                   },
                   {
                       index: 'cid', width: 200, align: 'center',
                       name: 'cid'
                   },
                   {
                       index: 'mapellidop', width: 500, align: 'center',
                       name: 'A_PATERNO'
                   },
                   {
                       index: 'mapellidom', width: 500, align: 'center',
                       name: 'A_MATERNO'
                   },
                   {
                       index: 'mnombres', width: 500, align: 'center',
                       name: 'NOMBRES'
                   },
                   {
                       index: 'nom_coop', width: 1000, align: 'center',
                       name: 'NOMBRE COOP'
                   },
                   {
                       index: 'mts_frente', width: 200, align: 'center',
                       name: 'MtsFrente'
                   },
                   {
                       index: 'costo_mto_lineal', width: 300, align: 'center',
                       name: 'CostoMto',
                       formatter:'currency',
                       formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }
                   },
                   {
                       index: 'adeudo', width: 300, align: 'center',
                       name: 'Capital',
                       formatter: 'currency',
                       formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }

                   },
                   {
                       index: 'saldo', width: 300, align: 'center',
                       name: 'SALDO',
                       formatter: 'currency',
                       formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }
                   },
                   {
                       index: 'saldo_act', width: 300, align: 'center',
                       name: 'SALDO_ACT',
                       formatter: 'currency',
                       formatoptions: { prefix: '$', thousandsSeparator: ',', decimalSeparator: '.' }
                   },
                   {
                       index: 'geomobra', width: 50, align: 'right',
                       name: 'GEO_OBRA'
                   },
                   {
                       index: 'calle', width: 500, align: 'center',
                       name: 'CALLE'
                   },
                   {
                       index: 'colonia', width: 500, align: 'center',
                       name: 'COLONIA'
                   },
                   {                      
                       index: 'tramo', width: 1000, align: 'center',
                       name: 'TRAMO'
                   },
                   {
                       index: 'ctapredial', width: 300, align: 'center',
                       name: 'CTAPREDIAL'
                   },
                   {
                       index: 'nooficial', width: 300, align: 'center',
                       name: 'No_Oficial'
                   },
                   {
                       index: 'noobra', width: 300, align: 'center',
                       name: 'noobra'
                   },
                   {
                       index: 'noobra2', width: 300, align: 'center',
                       name: 'noobra2'
                   },
                   {
                       index: 'noobra3', width: 300, align: 'center',
                       name: 'noobra3'
                   },
                   {
                       index: 'fec_rec', width: 300, align: 'center',
                       name: 'FEC_REC'
                   },
                   { 
                       index: 'fec_ini_pag', width: 300, align: 'center',
                       name: 'FEC_INI_PAG'
                   },
                   {
                       index: 'fec_venc', width: 300, align: 'center',
                       name: 'FEC_VENC'
                   },                                      
                   {
                       index: 'fec_proceso', width: 300, align: 'center',
                       name: 'FECHA_PROC'
                   },
                   {
                       index: 'fec_cob', width: 300, align: 'center',
                       name: 'FEC_COB'
                   },
                   {
                       index: 'fec_pav', width: 300, align: 'center',
                       name: 'FEC_PAV'
                   },                   
                   {
                       index: 'status_sifidoc', width: 300, align: 'center',
                       name: 'ESTATUS_OBRA'
                   },
                   {
                       index: 'geompredio', width: 50, align: 'right',
                       name: 'GEO_PREDIO'
                   },                                                   
                   {
                       index: 'feccre', width: 200, align: 'center',
                       name: 'FEC_CRE'
                   },
                   {
                       index: 'fecmod', width: 200, align: 'center',
                       name: 'FEC_MOD'
                   },
                   {
                       index: 'usucre', width: 200, align: 'center',
                       name: 'USU_CRE'
                   },
                   {
                       index: 'usumod', width: 200, align: 'center',
                       name: 'USU_MOD'
                   }],
                    pager: "#pager", //Pager.                 
                    loadtext: 'Cargando datos...',
                    recordtext: "{0} - {1} de {2} elementos",
                    emptyrecords: 'No hay resultados',
                    pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                    rowNum: "12", // PageSize.
                    rowList: [4, 8, 12], //Variable PageSize DropDownList. 
                    viewrecords: true, //Show the RecordCount in the pager.
                    multiselect: false,
                    sortname: "a.fid", //login SortColumn
                    sortorder: "asc", //login SortOrder.
                    width: "4000",
                    height: "600",
                    caption: "RESULTADO DE CONSULTA DE COOPERADORES",
                    subGrid: false
                }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
            .navButtonAdd('#pager',
                    {
                        caption: "Exportar Edo.Cta.",
                        buttonicon: "ui-icon-export",
                        onClickButton: function () {
                            var myGrid = $('#grid');
                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var rowData = myGrid.jqGrid("getRowData", selectedRowId);
                            cell_fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                            cell_nomcoop = myGrid.jqGrid('getCell', selectedRowId, 'nom_coop');
                            cell_nomcoop = myGrid.jqGrid('getCell', selectedRowId, 'nom_coop');
                            if (cell_fid) {
                                GenerarEdoCta(rowData);
                            }
                            else {
                                alert("No has seleccionado registro alguno.")
                            }
                        },
                        position: "last",
                        title: "exportar",
                        cursor: "pointer"
                    })

           .navButtonAdd('#pager',
               {
                   caption: "Buscar frente",
                   buttonicon: "ui-icon-document",
                   onClickButton: function () {                       
                       var myGrid = $('#grid');
                       selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                       cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                       if (cellValue) {
                           RevisaAnuencias(cellValue)
                           .done(function (r) {
                               if (r.d == "<NewDataSet />") {
                                   AccionRegistroAnu(cellValue, 0, 0);
                               }
                               else {
                                   $(r.d).find("rAnuencia").each(function () {
                                       var idsol = $(this).find("idsol").text();
                                       var idanu = $(this).find("idanu").text();
                                       var idAnuEst = $(this).find("idAnuEst").text();
                                       var AnuEstDesc = $(this).find("AnuEstDesc").text();
                                       if (idsol) {
                                           alert("Existe una ANUENCIA en trámite de: " + AnuEstDesc + ", no es permitido crear una nueva.");
                                       }
                                   })
                               }
                           })
                          .fail(function (x) {
                              alert("No es posible guardar la anuencia...");
                          });
                       }
                       else {
                           alert("Selecciona un registro...");
                       }
                   },
                   position: "last",
                   title: "Alta_Anuencia",
                   cursor: "pointer"
               });        
                

                if (filtro != '0,,') {
                    $.ajax(
                     {
                         url: "../../WebServices/WebServiceEdoCta.asmx/GetEdoCtaFte_gral", //PageMethod
                         data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                 "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                 "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                 "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                 "','pFiltro':'" + ObtenerFiltro() + "'}", //PageMethod Parametros de entrada
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
                else {
                    $("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    alert("No hay parámetros de búsqueda, por lo tanto no existe registro que mostrar");
                }
    
       }

    

        //// FUNCION PRINCIPAL

        $(document).ready(function () {
            $(".posicion_boton_consultar_edo").click(function (e) { //Actualizar datos en el registro            
                e.preventlogin();                
                MostrarEdoCtaFte();                
            });            
        });

    

    




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




        function validaranu(accion) {

            var estanu = parseInt($("#lblestanu").html());

            if (accion == 0 || (accion == 1 && estanu == 1)) { /*Si el usuario escogió dar de alta una anuencia*/
                var valid = checkLength($("#txtFolioAnu").val().length, "Folio de la Anuencia", 1, 20);            /*Valida la longitud del Folio del documento*/
                valid = valid && checkLength($("#txtNomProm").val().length, "Nombre del promotor de calle", 1, 60);
                valid = valid && checkLength($("#txtDomProm").val().length, "Domicilio del promotor de calle", 1, 80);
                valid = valid && checkVacio($("#txtTelProm").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
                valid = valid && isDate($("#txtfecentrega").val());
                var fecenvio = ConvertirCadenaToFecha($("#txtfecentrega").val());
                if (fecenvio == '01/01/1900') {
                    alert("La fecha de entrega es incorrecta.");
                    valid = valid && false;
                }
            }

            if (accion == 2) { /*Si el usuario recibe una anuencia de parte de un cooperador*/
                var valid = isDate($("#txtfecrecep").val());
                var fecenvio = ConvertirCadenaToFecha($("#txtfecentrega").val());
                var fecrecep = ConvertirCadenaToFecha($("#txtfecrecep").val());
                if (fecrecep == '01/01/1900') {
                    alert("La fecha de recibo es incorrecta.");
                    valid = valid && false;
                }
                else {
                    if (fecenvio > fecrecep) {
                        alert("La fecha de recibo es antes de la fecha de entrega, por lo tanto es incorrecta.");
                        valid = valid && false;
                    }
                }

                if ($("#file1").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        valid = valid && true;
                    }
                    else {
                        $("#file1").val("");
                        valid = valid && false;
                    }
                }
                else {
                    alert("Falta capturar el archivo digital del documento...")
                    valid = valid && false;
                }
            }


            if (accion == 1 && estanu == 2) {
                var valid = checkLength($("#txtFolioAnu").val().length, "Folio de la Anuencia", 1, 20);            /*Valida la longitud del Folio del documento*/
                valid = valid && checkLength($("#txtNomProm").val().length, "Nombre del promotor de calle", 1, 60);
                valid = valid && checkLength($("#txtDomProm").val().length, "Domicilio del promotor de calle", 1, 80);
                valid = valid && checkVacio($("#txtTelProm").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
                valid = valid && isDate($("#txtfecentrega").val());
                valid = valid && isDate($("#txtfecrecep").val());
                var fecrecibo = ConvertirCadenaToFecha($("#txtfecrecep").val());
                var fecenvio = ConvertirCadenaToFecha($("#txtfecentrega").val());
                if (fecenvio != '01/01/1900') {   /*Validación de fechas*/
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

                if ($("#file1").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        valid = valid && true;
                    }
                    else {
                        $("#file1").val("");
                        valid = valid && false;
                    }
                }
                else {
                    if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                        valid = valid && true;
                    }
                    else {
                        alert("No se capturado ningún archivo digital");
                        valid = valid && false;
                    }
                }
            }

            if (accion == -1) {
                alert("Has seleccionado cancelar la anuencia.");
                valid = true;
            }

            return valid;
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


        function RevisaEstatusAnuencia(idanu) {

            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceAnuencia.asmx/GetEstatusAnuencia",
                data: "{idanu:" + idanu + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(textStatus + jqXHR + errorThrown);
                }
            });

        };

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


      

</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  

<b>Cooperador:<input type="text" name="Cooperador:" id="txtcoop" style="width:80px"/>&nbsp &nbsp Nombre de Cooperador:<input type="text" name="NomCoop" id="txtnomcoop" style="width:250px"/>&nbsp &nbsp Frente:</><input type="text" name="fid" id="txtfid" style="width:50px" /></b>&nbsp &nbsp &nbsp &nbsp<a href="#" class="posicion_boton_consultar_edo">CONSULTAR ESTADO DE CUENTA</a><br/><br/>
<table id="grid"></table>
<div id="pager"></div>&nbsp 
 
</asp:Content>


