<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="obras.aspx.vb"
    Inherits="Admin_procesos_obras" Culture="Auto" UICulture="Auto" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script type="text/javascript" language="JavaScript">




                function GestionCooperadores(oid, idusu, fid) {
                    //alert(img);
                    var url1 = "../../Procesos/gCoops.html?ResponseType=Edit&oid=" + oid + "&idusu=" + idusu + "&fid=" + fid;
                    newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                function EstadoCuentaCoop(fid, idusu) {
                    //alert(img);
                    var url1 = "../../Procesos/EdoCtaFrente.html?ResponseType=Edit&fid=" + fid + "&idusu=" + idusu;
                    newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1500,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                function EstadoCuentaGeneral(fid, idusu) {
                    //alert(img);
                    var url1 = "../../Procesos/EdoCtaFteGral.html?ResponseType=Edit&fid=" + fid + "&idusu=" + idusu;
                    newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1500,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                function EstadoCtaConvenio(fid, idconv, idusu) {
                    //alert(img);
                    var url1 = "../../Procesos/EdoCtaConvenio.html?ResponseType=Edit&fid=" + fid + "&idconv=" + idconv + "&idusu=" + idusu;
                    newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1500,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                function ubicObra(oid) {
                    //alert(img);
                    var url1 = "../../Procesos/UbicObra.html?ResponseType=Edit&oid=" + oid;
                    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1105,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
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
                    if (conten.trim == "") {
                        alert(msj + ', no debe ser vacío');
                        return false;
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


                function ObtenerFiltro() {
                    var nomcalle = $('#txtnomcalle').val();
                    if (nomcalle.length <= 0 || nomcalle.length > 20) {
                        nomcalle = "";
                    }
                    var oid = $('#txtoid').val();
                    if (oid.length <= 0 || !$.isNumeric(oid)) {
                        oid = "0";
                    }
                    var filtro = oid + "," + nomcalle;
                    return filtro;
                }



                function obtener_obra_s() {
                    var obra = $('#obra_s').val();
                    return obra;
                }

                function RedibujarGrid() {
                    //    jQuery("#grid").jqGrid('setGridParam',
                    //        {
                    //          datatype: function () { ObtenerDatos(ObtenerFiltro()) }                
                    //        })
                    //.trigger("reloadGrid");
                    $("#grid").trigger("reloadGrid");
                }

                function ObtenerDatos(filtro, EstatusObra, obra_s, v) {
                    $.ajax(
                        {
                            url: "../../WebServices/WebServiceObras.asmx/GetObra_psql", //PageMethod
                            data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                "','pFiltro':'" + filtro +
                                "','pEstatusObra':'" + EstatusObra +
                                "','pV':'" + v +
                                "','pobra_s':'" + obra_s + "'}", //PageMethod Parametros de entrada
                            dataType: "json",
                            type: "post",
                            contentType: "application/json; charset=utf-8",
                            complete: function (jsondata, stat) {
                                if (stat == "success") {
                                    jQuery("#grid")[0].addJSONData(JSON.parse(jsondata.responseText).d);
                                }
                                else {
                                    alert(JSON.parse(jsondata.responseText).Message);
                                }
                            },
                            error: function (xhr) {
                                console.log(xhr.responseText);
                            }
                        });
                }







                //// FUNCION PRINCIPAL

                $(document).ready(function () {


                    /*$('#verdcto').click(function () {
                        var nom_archivo = $('#verdcto').val();
                        leerArchivo(nom_archivo);                
                    });*/
                    var oid, idusu, noobra, noobra2, noobra3, noobra4, estatusobra; /*Variables para enviar a la pagina de captura de cooperadores*/
                    var lastSel;
                    var band_grid2 = 0;
                    $("#grid").jqGrid(
                        {
                            datatype: function () { ObtenerDatos(ObtenerFiltro(), "2,3,4,5,8,11", obtener_obra_s(), 0) },
                            jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                            {
                                root: "Items",
                                page: "CurrentPage",
                                total: "PageCount",
                                records: "RecordCount",
                                repeatitems: true,
                                cell: "row",
                                id: "oid"
                            },
                            colModel: [
                                {
                                    index: 'oid', width: 200, align: 'Right',
                                    name: 'oid'
                                },
                                {
                                    index: 'noobra', width: 300, align: 'Center',
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
                                    index: 'noobra4', width: 300, align: 'center',
                                    name: 'noobra4'
                                },
                                {
                                    index: 'idsol', width: 100, align: 'Center',
                                    name: 'idsol', hidden: true
                                },
                                {
                                    index: 'idpoligono', width: 100, align: 'center',
                                    name: 'idpoligono', hidden: true
                                },
                                {
                                    index: 'ctacontable', width: 350, align: 'center',
                                    name: 'ctacontable'
                                },
                                {
                                    index: 'fecrec', width: 300, align: 'center',
                                    name: 'Fec_Rec'
                                },
                                {
                                    index: 'fecinipag', width: 300, align: 'center',
                                    name: 'Fec_Ini_Pag'
                                },
                                {
                                    index: 'fecproceso', width: 300, align: 'center',
                                    name: 'Fec_Proc'
                                },
                                {
                                    index: 'feccob', width: 300, align: 'center',
                                    name: 'Fec_Cob'
                                },
                                {
                                    index: 'fecpav', width: 300, align: 'center',
                                    name: 'Fec_Pav'
                                },
                                {
                                    index: 'evidenciaentobra', width: 400, align: 'center',
                                    name: 'Entrega_OBRA', editable: false, sortable: false, formatter: function (evidencia) {
                                        var archivo = evidencia;
                                        var url;
                                        if (archivo != '') {
                                            url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        }
                                        else {
                                            url = '';
                                        }
                                        return url;
                                    }
                                },
                                {
                                    index: 'fecpub1', width: 250, align: 'center',
                                    name: 'Fec_Pub_1'
                                },
                                {
                                    index: 'evidenciapub1', width: 400, align: 'center',
                                    name: 'Evi_Pub_1', editable: false, sortable: false, formatter: function (evidencia) {
                                        var archivo = evidencia;
                                        var url;
                                        if (archivo != '') {
                                            url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        }
                                        else {
                                            url = '';
                                        }
                                        return url;
                                    }
                                },
                                {
                                    index: 'fecpub2', width: 250, align: 'center',
                                    name: 'Fec_Pub_2'
                                },
                                {
                                    index: 'evidenciapub2', width: 400, align: 'center',
                                    name: 'Evi_Pub_2', editable: false, sortable: false, formatter: function (evidencia) {
                                        var archivo = evidencia;
                                        var archivo = evidencia;
                                        var url;
                                        if (archivo != '') {
                                            url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        }
                                        else {
                                            url = '';
                                        }
                                        return url;
                                    }
                                },
                                {
                                    index: 'fecavicong', width: 300, align: 'center',
                                    name: 'Fec_Avi_Cong'
                                },
                                {
                                    index: 'Evi_Cong', width: 300, align: 'center',
                                    name: 'Evid_Cong', editable: false, sortable: false, formatter: function (evidencia) {
                                        var archivo = evidencia;
                                        var url;
                                        if (archivo != '') {
                                            url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        }
                                        else {
                                            url = '';
                                        }
                                        return url;
                                    }
                                },
                                {
                                    index: 'Etatus_SIFIDOC', width: 250, align: 'center',
                                    name: 'status_SIFIDOC', hidden: true
                                },
                                {
                                    index: 'estatus_calidad', width: 250, align: 'center',
                                    name: 'estatus_calidad', hidden: true
                                },
                                {
                                    index: 'statusobra', width: 350, align: 'center',
                                    name: 'EstatusObraNum', hidden: true
                                },
                                {
                                    index: 'cestatus', width: 350, align: 'center',
                                    name: 'EstatusObra'
                                },
                                {
                                    index: 'sector', width: 80, align: 'center',
                                    name: 'SECTOR', hidden: true
                                },
                                {

                                    index: 'subsector', width: 80, align: 'center',
                                    name: 'SUBSECTOR', hidden: true
                                },
                                {

                                    index: 'cvecalle', width: 80, align: 'center',
                                    name: 'CVECALLE', hidden: true
                                },
                                {

                                    index: 'mtslong', width: 150, align: 'center',
                                    name: 'mtslong'
                                },
                                {

                                    index: 'calle', width: 1200, align: 'center',
                                    name: 'calle'
                                },
                                {
                                    index: 'tramo', width: 1200, align: 'center',
                                    name: 'Tramo'
                                },
                                {
                                    index: 'colonia', width: 1200, align: 'center',
                                    name: 'colonia'
                                },
                                {
                                    index: 'nopagos', width: 250, align: 'center',
                                    name: 'NoPagos'
                                },
                                {

                                    index: 'costo_total', width: 300, align: 'center',
                                    name: 'Costo_Obra'
                                },
                                {
                                    index: 'costo_total_municipio', width: 200, align: 'center',
                                    name: 'Costo_Munic', hidden: true
                                },
                                {
                                    index: 'costo_total_ciudadanos', width: 200, align: 'center',
                                    name: 'Costo_Ciud', hidden: true
                                },
                                {
                                    index: 'id_implan', width: 50, align: 'center',
                                    name: 'Id_IMPLAN', hidden: true
                                },
                                {
                                    index: 'usucre', width: 100, align: 'center',
                                    name: 'UsuCrea', hidden: true
                                },
                                {
                                    index: 'usrmod', width: 100, align: 'center',
                                    name: 'UsuMod', hidden: true
                                },
                                {
                                    index: 'fec_mod', width: 150, align: 'center',
                                    name: 'Fec_Mod', hidden: true
                                },

                            ],
                            pager: "#pager", //Pager.                 
                            loadtext: 'Cargando datos...',
                            recordtext: "{0} - {1} de {2} elementos",
                            emptyrecords: 'No hay resultados',
                            pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                            rowNum: "20", // PageSize.
                            rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                            viewrecords: true, //Show the RecordCount in the pager.
                            multiselect: false,
                            sortname: "oid", //Default SortColumn
                            sortorder: "asc", //Default SortOrder.
                            width: "3200",
                            height: "600",
                            caption: "OBRAS",
                            subGrid: true,
                            subGridBeforeExpand: function (subgrid_id, row_id) {
                                var myGrid = $('#grid');
                                var obra = myGrid.jqGrid('getRowData', row_id);



                                oid = obra.oid;
                                estatusobra = obra.EstatusObraNum;
                                var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                                var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                                idusu = arrusuario[2];
                            },
                            subGridRowExpanded: function (subgrid_id, row_id) {
                                var subgrid_table_id, pager_id;
                                subgrid_table_id = subgrid_id + "_t";
                                pager_id = "p_" + subgrid_table_id;
                                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                                var obra = jQuery('#grid').jqGrid('getRowData', row_id);
                                jQuery("#" + subgrid_table_id).jqGrid(
                                    {
                                        datatype: function () {
                                            var obra = jQuery('#grid').jqGrid('getRowData', row_id);
                                            var filtro = "1,2,5,6";
                                            $.ajax(
                                                {
                                                    url: "../../WebServices/WebServiceCoop.asmx/GetCoopsfpc", //PageMethod
                                                    data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                        "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                        "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                        "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                        "','pFiltro':'" + filtro +
                                                        "','oid':'" + parseInt(obra.oid) + "'}", //PageMethod Parametros de entrada
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
                                            id: "oid"
                                        },
                                        colModel: [{
                                            index: 'oid', width: 150, align: 'Center',
                                            name: 'oid'
                                        },
                                        {
                                            index: 'fid', width: 150, align: 'Center',
                                            name: 'fid'
                                        },
                                        {
                                            index: 'pid', width: 150, align: 'Center',
                                            name: 'pid'
                                        },
                                        {
                                            index: 'cid', width: 150, align: 'center',
                                            name: 'cid'
                                        },
                                        {
                                            index: 'cooperador', width: 300, align: 'center',
                                            name: 'coop_SIFIDOC'
                                        },
                                        {
                                            index: 'nomcoop', width: 500, align: 'center',
                                            name: 'NOMBRE COOP'
                                        },
                                        {
                                            index: 'mts', width: 150, align: 'center',
                                            name: 'Mts'
                                        },
                                        {
                                            index: 'prid', width: 100, align: 'center',
                                            name: 'prid', hidden: true
                                        },
                                        {
                                            index: 'costomtolineal', width: 150, align: 'center',
                                            name: 'CostoMto', hidden: true
                                        },
                                        {
                                            index: 'costo_total_obra', width: 200, align: 'center',
                                            name: 'CostoTotalObra', hidden: true
                                        },
                                        {
                                            index: 'nomprog', width: 300, align: 'center',
                                            name: 'Programa', hidden: true
                                        },
                                        {
                                            index: 'progmun', width: 100, align: 'center',
                                            name: 'ParteMunicip', hidden: true
                                        },
                                        {
                                            index: 'progcoop', width: 100, align: 'center',
                                            name: 'ParteCoop', hidden: true
                                        },
                                        {
                                            index: 'progdescrip', width: 500, align: 'center',
                                            name: 'DescripProg', hidden: true
                                        },
                                        {
                                            index: 'nooficial', width: 300, align: 'center',
                                            name: 'NoOficial'
                                        },
                                        {
                                            index: 'ctapredial', width: 300, align: 'center',
                                            name: 'CtaPredial'
                                        },
                                        {
                                            index: 'cup', width: 400, align: 'center',
                                            name: 'CUP', hidden: true
                                        },
                                        {
                                            index: 'ctaimuvi', width: 300, align: 'center',
                                            name: 'CtaIMUVI', hidden: true
                                        },
                                        {
                                            index: 'sapal', width: 300, align: 'center',
                                            name: 'CtaSAPAL', hidden: true
                                        },
                                        {
                                            index: 'tipopredionum', width: 100, align: 'center',
                                            name: 'TipoPredioNum', hidden: true
                                        },
                                        {
                                            index: 'tipopredio', width: 300, align: 'center',
                                            name: 'TipoPredio', hidden: true
                                        },
                                        {
                                            index: 'adeudo', width: 300, align: 'center',
                                            name: 'Adeudo', hidden: true
                                        },
                                        {
                                            index: 'sumpagos', width: 300, align: 'center',
                                            name: 'Pagos', hidden: true
                                        },
                                        {
                                            index: 'saldoact2', width: 300, align: 'center',
                                            name: 'saldoact2', hidden: true
                                        },
                                        {
                                            index: 'saldoparcial', width: 300, align: 'center',
                                            name: 'SaldoParcial', hidden: true
                                        },
                                        {
                                            index: 'fecpav', width: 200, align: 'center',
                                            name: 'FecEntrega', hidden: true
                                        },
                                        {
                                            index: 'factoract', width: 200, align: 'center',
                                            name: 'FacAct', hidden: true
                                        },
                                        {
                                            index: 'periodoact', width: 400, align: 'center',
                                            name: 'PeriodoAct', hidden: true
                                        },
                                        {
                                            index: 'saldopagar', width: 300, align: 'center',
                                            name: 'SaldoPagar'
                                        },
                                        {
                                            index: 'recargos', width: 200, align: 'center',
                                            name: 'Recargos', hidden: true
                                        },
                                        {
                                            index: 'estatusconv', width: 400, align: 'center', formatter: function (cellvalue) {
                                                var estatusconv = cellvalue;
                                                if (estatusconv == 0) {
                                                    estatusconvdescrip = 'SIN CONVENIO';
                                                }
                                                if (estatusconv == 1) {
                                                    estatusconvdescrip = 'CONVENIO VIGENTE';
                                                }
                                                if (estatusconv == 2) {
                                                    estatusconvdescrip = 'CONVENIO PAGADO';
                                                }
                                                if (estatusconv == 3) {
                                                    estatusconvdescrip = 'CONVENIO CANCELADO';
                                                }
                                                return estatusconvdescrip;
                                            },
                                            name: 'EstatusConv'
                                        },
                                        {
                                            index: 'estatusconv', width: 400, align: 'center',
                                            name: 'estatusconvenio'
                                        },
                                        {
                                            index: 'idconv', width: 180, align: 'center',
                                            name: 'IdConv'
                                        },
                                        {
                                            index: 'pagosconv', width: 180, align: 'center',
                                            name: 'PagosConv'
                                        },
                                        {
                                            index: 'usrcre', width: 50, align: 'center',
                                            name: 'Usuario crea', hidden: true
                                        },
                                        {
                                            index: 'feccre', width: 30, align: 'center', name: 'feccre', hidden: true, formatter: function (cellvalue) {
                                                var fecha = cellvalue;
                                                if (fecha == '01/01/1900') {
                                                    fecha = '';
                                                }
                                                return fecha;
                                            }, hidden: true
                                        },
                                        {
                                            index: 'usrmod', width: 50, align: 'center',
                                            name: 'Usuario mod', hidden: true
                                        },
                                        {
                                            index: 'fecmod', width: 30, align: 'center', name: 'fecmod', hidden: true, formatter: function (cellvalue) {
                                                var fecha = cellvalue;
                                                if (fecha == '01/01/1900') {
                                                    fecha = '';
                                                }
                                                return fecha;
                                            }, hidden: true
                                        }],
                                        pager: pager_id, //Pager.                 
                                        loadtext: 'Cargando datos...',
                                        recordtext: "{0} - {1} de {2} elementos",
                                        emptyrecords: 'No hay resultados',
                                        pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                                        rowNum: "12", // PageSize.
                                        rowList: [4, 6, 8], //Variable PageSize DropDownList. 
                                        viewrecords: true, //Show the RecordCount in the pager.
                                        ajaxGridOptions: row_id,
                                        multiselect: false,
                                        sortname: "oid", //Default SortColumn
                                        sortorder: "asc", //Default SortOrder.
                                        width: "1000",
                                        height: "100%",
                                        caption: "COOPERADORES"
                                    }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Gestion_Coops",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                var fid_foco = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                                var oid_foco = myGrid.jqGrid('getCell', selectedRowId, 'oid');

                                                if (fid_foco) {
                                                    GestionCooperadores(oid_foco, idusu, fid_foco);
                                                }
                                                else {
                                                    GestionCooperadores(oid_foco, idusu, 0);
                                                }
                                            },
                                            position: "last",
                                            title: "Cooperadores",
                                            cursor: "pointer"
                                        })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "EdoCtaCoop",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');

                                                var fid_foco = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                                var idconv = myGrid.jqGrid('getCell', selectedRowId, 'IdConv');


                                                if (fid) {
                                                    if (estatusobra == 5) {
                                                        if (idconv > 0) {
                                                            EstadoCtaConvenio(fid, idconv, idusu);
                                                        }
                                                        else {
                                                            EstadoCuentaCoop(fid, idusu);
                                                        }
                                                    }
                                                    else {
                                                        EstadoCuentaGeneral(fid, idusu);
                                                    }

                                                }
                                                else {
                                                    alert("No se ha seleccionado frente para mostrar estado de cuenta")
                                                }
                                            },
                                            position: "last",
                                            title: "Cooperadores",
                                            cursor: "pointer"
                                        })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Convenir",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                var fid_foco = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                                var pid_foco = myGrid.jqGrid('getCell', selectedRowId, 'pid');
                                                var oid_foco = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                                var nomcoop = myGrid.jqGrid('getCell', selectedRowId, 'NOMBRE COOP');
                                                var mts = myGrid.jqGrid('getCell', selectedRowId, 'Mts');
                                                var costomto = myGrid.jqGrid('getCell', selectedRowId, 'CostoMto');
                                                var nomprog = myGrid.jqGrid('getCell', selectedRowId, 'Programa');
                                                var nooficial = myGrid.jqGrid('getCell', selectedRowId, 'NoOficial');
                                                var ctapredial = myGrid.jqGrid('getCell', selectedRowId, 'CtaPredial');
                                                var calle = obra.calle;
                                                var tramo = obra.Tramo;
                                                var colonia = obra.colonia;
                                                var saldoact2 = myGrid.jqGrid('getCell', selectedRowId, 'saldoact2');
                                                var recargos = myGrid.jqGrid('getCell', selectedRowId, 'Recargos');
                                                var saldopagar = myGrid.jqGrid('getCell', selectedRowId, 'SaldoPagar');
                                                var factoract = myGrid.jqGrid('getCell', selectedRowId, 'FacAct');
                                                var estatusconv = myGrid.jqGrid('getCell', selectedRowId, 'estatusconvenio');
                                                if (estatusconv == 0) { //SIN CONVENIO
                                                    if (parseFloat(saldopagar) > 10) {
                                                        AltaRegistroConvenio(fid_foco, pid_foco, oid_foco, nomcoop, mts, costomto, nomprog, nooficial, ctapredial, calle, tramo, colonia, saldoact2, recargos, factoract);
                                                    }
                                                    else {
                                                        alert('Para convenir debe existir un saldo a pagar mayor a $10.00');
                                                    }
                                                }
                                                else {
                                                    if (estatusconv == 1) { //Convenio vigente
                                                        alert('Convenio vigente');
                                                    }
                                                    else {
                                                        if (estatusconv == 3) {
                                                            alert('El convenio se encuentra  cancelado.');
                                                        }
                                                        else {
                                                            alert('Convenio cumplido, no existe saldo por cobrar.');
                                                        }
                                                    }
                                                }
                                            },
                                            position: "last",
                                            title: "Convenios cooperadores",
                                            cursor: "pointer"
                                        })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Eliminar Convenio",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                var fid_foco = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                                var estatusconv = myGrid.jqGrid('getCell', selectedRowId, 'estatusconvenio');
                                                var pagosconv = myGrid.jqGrid('getCell', selectedRowId, 'PagosConv');
                                                var idconv = myGrid.jqGrid('getCell', selectedRowId, 'IdConv');

                                                $("#bodegadatos").data("fid", fid_foco);
                                                $("#bodegadatos").data("idconv", idconv);

                                                if (parseInt(estatusconv) == 0) { //SIN CONVENIO
                                                    alert('No hay convenio para ser cancelado');
                                                }
                                                else {
                                                    if (parseInt(estatusconv) == 1) { //Convenio vigente
                                                        if (parseFloat(pagosconv) > 0) {
                                                            alert('El convenio no puede ser cancelado, existen pagos aplicados.');
                                                        }
                                                        else {
                                                            GestionConvenio(1);
                                                        }
                                                    }
                                                    else {
                                                        alert('El convenio se ha cumplido, no puede ser cancelado.');
                                                    }
                                                }
                                            },
                                            position: "last",
                                            title: "Cooperadores",
                                            cursor: "pointer"
                                        });
                            }

                        }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                        .navButtonAdd('#pager',
                            {
                                caption: "Buscar Sol",
                                buttonicon: "ui-icon-search",
                                onClickButton: function () {
                                    RedibujarGrid();
                                },
                                position: "last",
                                title: "Buscar Sol",
                                cursor: "pointer"
                            })

                        .navButtonAdd('#pager',
                            {
                                caption: "Editar_Obra",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var estatussol;
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    noobra = myGrid.jqGrid('getCell', selectedRowId, 'noobra');
                                    noobra2 = myGrid.jqGrid('getCell', selectedRowId, 'noobra2');
                                    noobra3 = myGrid.jqGrid('getCell', selectedRowId, 'noobra3');
                                    cvecalle = myGrid.jqGrid('getCell', selectedRowId, 'CVECALLE');
                                    sector = myGrid.jqGrid('getCell', selectedRowId, 'SECTOR');
                                    subsector = myGrid.jqGrid('getCell', selectedRowId, 'SUBSECTOR');
                                    tramo = myGrid.jqGrid('getCell', selectedRowId, 'Tramo');
                                    ctacont = myGrid.jqGrid('getCell', selectedRowId, 'ctacontable');
                                    fecrec = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Rec');
                                    fecinipag = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Ini_Pag');
                                    fecproc = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Proc');
                                    feccob = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Cob');
                                    estatusobra = myGrid.jqGrid('getCell', selectedRowId, 'EstatusObraNum');
                                    nopagos = myGrid.jqGrid('getCell', selectedRowId, 'NoPagos');

                                    if (oid > 0) {
                                        AccionRegistroObra(0, 0, oid, noobra, noobra2, noobra3, cvecalle, sector, subsector, tramo, ctacont, fecrec, fecinipag, fecproc, feccob, estatusobra, nopagos);
                                    }
                                    else {
                                        alert("Selecciona un registro de obra.");
                                    }
                                },
                                position: "last",
                                title: "Alta_Obra",
                                cursor: "pointer"
                            })

                        .navButtonAdd('#pager',
                            {
                                caption: "Fec_Pub_1",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var estatussol;
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'status_obra');
                                    fecpub1 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_1');
                                    fecpub2 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_2');
                                    fecpav = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pav');
                                    fecproc = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Proc');
                                    fecavicong = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Avi_Cong');
                                    evidencia = myGrid.jqGrid('getCell', selectedRowId, 'Evi_Pub_1');
                                    evidencia = evidencia.substr(evidencia.indexOf('">') + 2);
                                    evidencia = evidencia.substr(0, evidencia.indexOf('<'));
                                    /*oid, status_obra, no. de publicacion*/
                                    if (cellValue) {
                                        AccionRegistroPub(cellValue, cellValue2, 1, fecpub1, fecpub2, fecpav, fecavicong, fecproc, evidencia);

                                    }
                                    else {
                                        alert("Selecciona un registro");
                                    }
                                },
                                position: "last",
                                title: "Fecha primera publicación.",
                                cursor: "pointer"
                            })

                        .navButtonAdd('#pager',
                            {
                                caption: "Fec_Pub_2",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var estatussol;
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'status_obra');
                                    fecpub1 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_1');
                                    fecpub2 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_2');
                                    fecpav = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pav');
                                    fecproc = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Proc');
                                    fecavicong = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Avi_Cong');
                                    evidencia = myGrid.jqGrid('getCell', selectedRowId, 'Evi_Pub_2');
                                    evidencia = evidencia.substr(evidencia.indexOf('">') + 2);
                                    evidencia = evidencia.substr(0, evidencia.indexOf('<'));
                                    if (cellValue) {
                                        /*if (fecpub1 == '01/01/1900') {
                                            alert("No se ha capturado la fecha de la 1ra. Publicación")
                                        }
                                        else {*/
                                        AccionRegistroPub(cellValue, cellValue2, 2, fecpub1, fecpub2, fecpav, fecavicong, fecproc, evidencia);
                                        // }
                                    }
                                    else {
                                        alert("Selecciona un registro");
                                    }
                                },
                                position: "last",
                                title: "Fecha segunda publicación.",
                                cursor: "pointer"
                            })
                        .navButtonAdd('#pager',
                            {
                                caption: "Fec_Avi_Cong",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var estatussol;
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'status_obra');
                                    fecpub1 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_1');
                                    fecpub2 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_2');
                                    fecpav = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pav');
                                    fecproc = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Proc');
                                    fecavicong = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Avi_Cong');
                                    evidencia = myGrid.jqGrid('getCell', selectedRowId, 'Evid_Cong');
                                    evidencia = evidencia.substr(evidencia.indexOf('">') + 2);
                                    evidencia = evidencia.substr(0, evidencia.indexOf('<'));
                                    if (cellValue) {
                                        /*  if (fecpub2 == '01/01/1900') {
                                              alert("No se ha capturado la fecha de la 2da. Publicación")
                                          }
                                          else {*/
                                        AccionRegistroPub(cellValue, cellValue2, 3, fecpub1, fecpub2, fecpav, fecavicong, fecproc, evidencia);
                                        //}
                                    }
                                    else {
                                        alert("Selecciona un registro");
                                    }
                                },
                                position: "last",
                                title: "Fecha de Aviso al Congreso",
                                cursor: "pointer"
                            })
                        .navButtonAdd('#pager',
                            {
                                caption: "Entrega_OBRA",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    var estatussol;
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'status_obra');
                                    fecpub1 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_1');
                                    fecpub2 = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pub_2');
                                    fecpav = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Pav');
                                    fecproc = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Proc');
                                    fecavicong = myGrid.jqGrid('getCell', selectedRowId, 'Fec_Avi_Cong');

                                    if (cellValue) {
                                        evidencia = myGrid.jqGrid('getCell', selectedRowId, 'Entrega_OBRA');
                                        evidencia = evidencia.substr(evidencia.indexOf('">') + 2);
                                        evidencia = evidencia.substr(0, evidencia.indexOf('<'));
                                        if (fecproc == '01/01/1900') {
                                            alert("No se ha capturado el inicio de proceso de obra")
                                        }
                                        else {
                                            AccionRegistroPub(cellValue, cellValue2, 0, fecpub1, fecpub2, fecpav, fecavicong, fecproc, evidencia);
                                        }
                                    }
                                    else {
                                        alert("Selecciona un registro");
                                    }
                                },
                                position: "last",
                                title: "Fecha de entrega del pavimento de la obra",
                                cursor: "pointer"
                            })
                        .navButtonAdd('#pager',
                            {
                                caption: "Alta_Presup",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    /*var costo_mto = */
                                    if (oid) {
                                        AccionRegistroCostoMto(oid, 6); /*(obra, accion) siempre la acción refiere a un nuevo presupuesto*/
                                    }
                                    else {
                                        alert("Selecciona el registro correspondiente a la obra");
                                    }
                                },
                                position: "last",
                                title: "Alta presupuesto",
                                cursor: "pointer"
                            })
                        .navButtonAdd('#pager',
                            {
                                caption: "Edit_Presup",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    /*var costo_mto = */
                                    if (oid) {
                                        AccionRegistroCostoMto(oid, 7); /*(obra, accion) siempre la acción refiere a un nuevo presupuesto*/
                                    }
                                    else {
                                        alert("Selecciona el registro correspondiente a la obra");
                                    }
                                },
                                position: "last",
                                title: "Editar presupuesto",
                                cursor: "pointer"
                            })
                        .navButtonAdd('#pager',
                            {
                                caption: "Eliminar_Presup",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                    /*var costo_mto = */
                                    if (oid) {
                                        AccionRegistroCostoMto(oid, 8); /*(obra, accion) siempre la acción refiere a un nuevo presupuesto*/
                                    }
                                    else {
                                        alert("Selecciona el registro correspondiente a la obra");
                                    }
                                },
                                position: "last",
                                title: "Cancelar presupuesto",
                                cursor: "pointer"
                            });;


                    $(".verarchivo").click(function (e) { //Ver documento                   
                        var archivo = $("#archivo2").text();
                        leerArchivo(archivo);
                    });

                    $(".verarchivo").click(function (e) { //Ver documento                   
                        var archivo = $("#archivopresup").text();
                        leerArchivo(archivo);
                    });

                    $(".geom_obra").click(function (e) { //Ver documento                   
                        ubicObra(parseInt($("#txtobra").val()));
                    });


                    $(".window .posicion_boton_cancelar_anu").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });

                    $(".window .posicion_boton_cancelar_presup").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });


                    $(".window .posicion_boton_cancelar_convenio").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });


                    $(".window .posicion_boton_cancelar_pub").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });

                    $(".window .posicion_boton_cancelar_obra").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });

                    $("#colonia").change(function () {
                        llenarCalles2($("#colonia").val(), 0);
                    });

                    $("#lstprogs").change(function () {
                        CargarPresupuestosObra($("#lstprogs").val())
                    });


                    $(".window .posicion_boton_cancelar_procobra").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });

                    $(".window .posicion_boton_cancelar_entregaobra").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });

                    $(".window .posicion_boton_cancelar_obra").click(function (e) {
                        //Cancel the link behavior
                        e.preventDefault();
                        $('#mask, .window').hide();
                    });


                    //if mask is clicked
                    $('#mask').click(function () {
                        $(this).hide();
                        $('.window').hide();
                    });


                    $(".posicion_boton_accion_obra").click(function (e) {
                        e.preventDefault();
                        var accionobra = 'infobra';
                        ValidarRegistroObra(0, accionobra);
                    });

                    $(".posicion_boton_accion_pub").click(function (e) {
                        e.preventDefault();
                        var oid = $("#lbloid").html();
                        var accionpub = parseInt($("#lblaccionpub").html());
                        ValidarRegistroPublicacion(oid, accionpub);
                    });

                    $(".posicion_boton_accion_convenio").click(function (e) {
                        e.preventDefault();
                        var accionconv = $("#accionconvenio").html();
                        GestionConvenio(parseInt(accionconv));
                    });

                    $(".posicion_boton_accion_procobra").click(function (e) {
                        e.preventDefault();
                        var oid = $("#lbloid").html();
                        var accionpub = parseInt($("#lblaccionpub2").html());
                        ValidarRegistroPublicacion(oid, accionpub);
                    });

                    $(".posicion_boton_accion_entregaobra").click(function (e) {
                        e.preventDefault();
                        var oid = $("#lbloid").html();
                        var accionpub = parseInt($("#lblaccionentregaobra").html());
                        ValidarRegistroPublicacion(oid, accionpub);
                    });


                    $(".posicion_boton_accion_presup").click(function (e) {
                        e.preventDefault();
                        var oid = $("#lbloidpresup").html();
                        var accionpresup = $("#lblaccionpresup").html();
                        var accionp;
                        if (accionpresup == 'altapresup') {
                            accionp = 6;
                        }
                        if (accionpresup == 'editpresup') {
                            accionp = 7;
                        }
                        if (accionpresup == 'elimpresup') {
                            accionp = 8;
                        }
                        ValidarRegistroPresupuesto(oid, accionp);

                    });


                }); /// FIN del document READY

                function ValidarRegistroObra(oid, accionobra) {
                    if (accionobra == 'infobra') {
                        oid = parseInt($("#txtobra").val());
                        ExistePoligonoObra(oid, accionobra)
                            .done(function (r) {
                                if (r.d != '<NewDataSet />') {
                                    if (ValidarDatosObraNueva(oid, accionobra)) {
                                        var oidy = parseInt(oid);
                                        var noobra = $("#txtnoobra").val();
                                        var idsol = 0;
                                        var fec_rec = ConvertirCadenaToFecha($("#txtfecrec").val());
                                        var fec_ini_pag = ConvertirCadenaToFecha($("#fecinipag").val());
                                        var fec_proceso = ConvertirCadenaToFecha($("#txtfecproc1").val());
                                        var fec_cob = ConvertirCadenaToFecha($("#txtfeccob").val());
                                        var tramo = $("#tramo").val();
                                        var noobra2 = $("#txtnoobra2").val();
                                        var noobra3 = $("#txtnoobra3").val();
                                        var noobra4 = $("#txtnoobra3").val();;
                                        var status_sifidoc = $("#estatusobra").val();
                                        var estatus_calidad = $("#estatusobra").val();
                                        var clavescolonia = $("#colonia").val();
                                        var arr = clavescolonia.split("*");
                                        var sector = parseInt(arr[0]);
                                        var subsector = parseInt(arr[1]);
                                        var clacno = parseInt($("#calle").val());
                                        var idpoligono = 0;
                                        var mtslong = 0;
                                        var costo_total = 0;
                                        var ctacontable = $("#txtctacontable").val();
                                        var calle = $.trim($("#calle option:selected").text());
                                        var colonia = $.trim($("#colonia option:selected").text());
                                        var nopagos;
                                        if ($("#txtnopagos").val() == '') {
                                            nopagos = 0
                                        } else {
                                            nopagos = parseInt($("#txtnopagos").val());
                                        }

                                        var status_obra = parseInt($("#estatusobra").val());
                                        var costo_total_municipio = 0;
                                        var costo_total_ciudadanos = 0;
                                        var bienvusuario = $("#lblUsuario").html();
                                        var arrusuario = bienvusuario.split(":");
                                        var usuario = parseInt(arrusuario[2]);
                                        var id_implan = 0;
                                        var date = new Date();
                                        var strDate = date.getDate() + '/' + (date.getMonth() + 1) + '/' + (date.getFullYear());
                                        var accionobraint;
                                        if (accionobra == 'infobra') {
                                            accionobraint = 0;
                                        }
                                        RegistrarObra(oidy,
                                            noobra,
                                            idsol,
                                            fec_rec,
                                            fec_ini_pag,
                                            fec_proceso,
                                            fec_cob,
                                            tramo,
                                            noobra2,
                                            noobra3,
                                            noobra4,
                                            status_sifidoc,
                                            estatus_calidad,
                                            sector,
                                            subsector,
                                            clacno,
                                            idpoligono,
                                            mtslong,
                                            costo_total,
                                            ctacontable,
                                            calle,
                                            colonia,
                                            nopagos,
                                            status_obra,
                                            costo_total_municipio,
                                            costo_total_ciudadanos,
                                            usuario,
                                            id_implan,
                                            usuario,
                                            date,
                                            accionobraint);

                                        $('#mask, .window').hide();
                                        alert("Obra registrada correctamente.");
                                        RedibujarGrid();
                                    }
                                    else {
                                        alert("Obra no dada de alta en SIG, por lo tanto no es posible registrar la obra..");
                                    }
                                }
                                else {
                                    alert("Obra no dada de alta en SIG, por lo tanto no es posible registrar la obra..");
                                }
                            })
                            .fail(function (x) {
                                alert("Obra no dada de alta en SIG, por lo tanto no es posible registrar la obra..");
                            });
                    } else {
                        alert("Evaluar el proceso para editar la obra.")
                    }
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
                    var lugarfechahora = d[hoy.getDay()] + " " + hoy.getDate() + " de " + m[hoy.getMonth()] + "  " + hoy.getFullYear() + "," + hrs + ":" + min + ' hrs';

                    return lugarfechahora;
                }

                /*
                  Funcion que convierte cualqueir fecha en formato super largo: Viernes 21 de enero del 2015 
                  
                  */

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



                function FormatoMoneda(parametro) {
                    if (!isNaN(parametro)) {
                        resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
                    } else {
                        resultado = 0;
                    }
                    return resultado
                }

                function calculafecvencconv(numpagos) {
                    var hoy = new Date;
                    var strfechoy = hoy.getDate() + "/" + hoy.getMonth() + "/" + hoy.getFullYear();

                    $("#bodegadatos").data("numpagos", numpagos);

                    var fec = ConvertirCadenaToFecha(strfechoy);
                    fec.setMonth(fec.getMonth() + parseInt(numpagos) + 1);
                    var strDate = fec.getDate() + "/" + (fec.getMonth() + 1) + "/" + fec.getFullYear();
                    $("#bodegadatos").data("fecvenc", strDate);
                    $("#lblfecvencconv").text('');
                    $("#lblfecvencconv").text(strDate);
                    calculamontopagomensual(numpagos);
                }




                function calculadesctorecargo(desctorec) {
                    var saldoact2 = $("#bodegadatos").data("saldoact2");
                    var recargos = $("#bodegadatos").data("recargos");
                    var montodesctorec = (desctorec * recargos) / 100;
                    $("#bodegadatos").data("desctorec", montodesctorec);
                    $("#lbldctorecargos").text(FormatoMoneda(montodesctorec));
                    CalcularSaldoPagar();
                }


                function calcularecargoconv(recargoconv) {
                    var saldoact2 = $("#bodegadatos").data("saldoact2");
                    var montorecargoconv = (recargoconv * saldoact2) / 100;
                    $("#bodegadatos").data("recargoconv", montorecargoconv);
                    $("#lblrecargoconv").text(FormatoMoneda(montorecargoconv));
                    CalcularSaldoPagar();
                }



                function CalcularSaldoPagar() {
                    var saldoact2 = $("#bodegadatos").data("saldoact2");
                    var recargos = $("#bodegadatos").data("recargos");
                    var montodesctorec = $("#bodegadatos").data("desctorec");
                    var montorecconv = $("#bodegadatos").data("recargoconv");
                    var saldopagar = parseFloat(saldoact2) + parseFloat(recargos) - montodesctorec - montorecconv;
                    $("#bodegadatos").data("saldopagar", saldopagar);
                    $("#lblsaldo").text(FormatoMoneda(saldopagar));
                    calculamontopagomensual(parseInt($("#txtnumpagosconv").val()));
                }

                function calculamontopagomensual(numpagos) {
                    var saldopagar = $("#bodegadatos").data("saldopagar");
                    var montopago;
                    if (isNaN(saldopagar)) {
                        montopago = 0;
                    }
                    else {
                        montopago = saldopagar / numpagos;

                    }
                    $("#pagomensual").text('  ' + FormatoMoneda(trunc(montopago, 2)) + '  Mensual');

                }


                function trunc(x, posiciones) {
                    var s = x.toString()
                    var l = s.length
                    var decimalLength = s.indexOf('.') + 1

                    if (l - decimalLength <= posiciones) {
                        return x
                    }
                    // Parte decimal del número
                    var isNeg = x < 0
                    var decimal = x % 1
                    var entera = isNeg ? Math.ceil(x) : Math.floor(x)
                    // Parte decimal como número entero
                    // Ejemplo: parte decimal = 0.77
                    // decimalFormated = 0.77 * (10^posiciones)
                    // si posiciones es 2 ==> 0.77 * 100
                    // si posiciones es 3 ==> 0.77 * 1000
                    var decimalFormated = Math.floor(
                        Math.abs(decimal) * Math.pow(10, posiciones)
                    )
                    // Sustraemos del número original la parte decimal
                    // y le sumamos la parte decimal que hemos formateado
                    var finalNum = entera +
                        ((decimalFormated / Math.pow(10, posiciones)) * (isNeg ? -1 : 1))

                    return finalNum
                }

                function AltaRegistroConvenio(fid_foco, pid_foco, oid_foco, nomcoop, mts, costomto, nomprog, nooficial, ctapredial, calle, tramo, colonia, saldoact2, recargos, factoract) {


                    $("#lblfidconv").text(fid_foco);
                    $("#lblpidconv").text(pid_foco);
                    $("#lbloidconv").text(oid_foco);
                    $("#lblnomcoopconv").text(nomcoop);
                    $("#lblnooficialconv").text(nooficial);
                    $("#lblcalleconv").text(calle);
                    $("#lblcolconv").text(colonia);
                    $("#lbltramoconv").text(tramo);
                    $("#lblprogconv").text(nomprog);
                    $("#lblmtsfteconv").text(mts);
                    $("#lblcostomto").text(FormatoMoneda(costomto));
                    $("#lblctapredialconv").text(ctapredial);
                    $("#accionconvenio").text('0');
                    $("#lblfecconv").text(FechaHora());
                    $("#factoractconv").text(trunc(factoract, 3));
                    $("#lblfecconv").text(FechaHora());

                    $("#bodegadatos").data("fid", fid_foco);
                    $("#bodegadatos").data("recargos", recargos);
                    $("#bodegadatos").data("saldoact2", saldoact2);
                    $("#bodegadatos").data("factoract", factoract);
                    $("#bodegadatos").data("desctorec", 0);
                    $("#bodegadatos").data("recargoconv", 0);
                    $("#lblsaldo").text('');


                    var hoy = new Date;
                    var strfechahoy = hoy.getDate() + "/" + hoy.getMonth() + "/" + hoy.getFullYear();
                    $("#bodegadatos").data("hoy", strfechahoy);



                    $("#lblsaldoantesrecargos").text(FormatoMoneda(saldoact2));
                    $("#lblrecargosconv").text(FormatoMoneda(recargos));
                    $("#lblrecargoconv").text('');
                    $("#lbldctorecargos").text('');
                    $("#lbldctorecargos").text('');
                    $("#txtrecargoconv").val('0');

                    $("#txtdesctorecargo").val('0');



                    CalcularSaldoPagar();

                    MostrarModalConv();

                }

                function RegistrarObra(oid, noobra, idsol, fec_rec, fec_ini_pag, fec_proceso, fec_cob, tramo, noobra2, noobra3, noobra4, status_sifidoc, estatus_calidad, sector, subsector, cvecalle, idpoligono, mtslong, costo_total, ctacontable, calle, colonia, nopagos, status_obra, costo_total_municipio, costo_total_ciudadanos, usuario, id_implan, usuario, strDate, accionobra) {

                    var enviarObj = {
                        "oid": oid,
                        "noobra": noobra,
                        "idsol": idsol,
                        "fecrec": fec_rec,
                        "fecinipag": fec_ini_pag,
                        "fecproceso": fec_proceso,
                        "feccob": fec_cob,
                        "tramo": tramo,
                        "noobra2": noobra2,
                        "noobra3": noobra3,
                        "noobra4": noobra4,
                        "statusSIFIDOC": status_sifidoc,
                        "estatusCALIDAD": estatus_calidad,
                        "sector": sector,
                        "subsector": subsector,
                        "cvecalle": cvecalle,
                        "idpoligono": idpoligono,
                        "mtslong": mtslong,
                        "costo_total": costo_total,
                        "ctacontable": ctacontable,
                        "calle": calle,
                        "colonia": colonia,
                        "nopagos": nopagos,
                        "statusobra": status_obra,
                        "costototalmunicipio": costo_total_municipio,
                        "costototalciudadanos": costo_total_ciudadanos,
                        "usrcre": usuario,
                        "idimplan": id_implan,
                        "usrmod": usuario,
                        "fecmod": strDate,
                        "accion": accionobra
                    }

                    var stringData = JSON.stringify(enviarObj);
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceObras.asmx/RegObra",
                        data: "{objObra:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };

                function ValidarDatosObraNueva(oid, accionobra) {

                    var valid = true;

                    if (accionobra == 'infobra') {


                        valid = valid && checkLength($("#txtnoobra").val().length, "Número de obra  SIFIDOC", 10, 10);
                        valid = valid && checkLength($("#txtnoobra2").val().length, "Número obra2  SIFIDOC", 0, 10);
                        valid = valid && checkLength($("#txtnoobra3").val().length, "Número obra3  SIFIDOC", 0, 10);
                        valid = valid && checkLength($("#tramo").val().length, "Tramo", 8, 200);
                        /*valid = valid && checkRegexp($("#tramo").val(), /^[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú()]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]*[ ]*[-]+[ ]*[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]*$/, "El tramo debe constar dos limites: límite1 - límite2");*/

                        /*   var fecinipag = ConvertirCadenaToFecha($("#fecinipag").val());
                           var fecrec = ConvertirCadenaToFecha($("#txtfecrec").val());
                           var fecproc = ConvertirCadenaToFecha($("#txtfecproc1").val());            
                           var feccob = ConvertirCadenaToFecha($("#txtfeccob").val());
               
                           if (fecinipag <= '01/01/1900' || fecrec <= '01/01/1900' || fecproc <= '01/01/1900'  && feccob <= '01/01/1900') {
                               valid = valid && false;
                               alert("Fechas capturadas inválidas");
                           }
                           else {
                               if (fecinipag < fecrec && fecinipag < fecproc && fecinipag < feccob) {
               
                                   if (fecrec < fecproc && fecrec < feccob) {
                                       if (fecproc < feccob) {
                                           valid = valid && true;
                                       }
                                       else {
                                           valid = valid && false;
                                           alert("Fecha de proceso inválida, debe ser menor de la fecha de cobranza");
                                       }
                                   }
                                   else {
                                       valid = valid && false;
                                       alert("Fecha de recaudación inválida, debe ser menor de la fecha de proceso, fecha de cobranza y fecha de entrega de obra ");
                                   }
                               }
                               else {
                                   valid = valid && false;
                                   alert("Fecha de inicio de pago inválida, debe ser menor de la fecha de recaudación,fecha de proceso y fecha de cobranza");
                               }
                           }*/


                        return valid;
                    }
                }

                function ExistePoligonoObra(oid, accionobra) {
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceObras.asmx/GetObra",
                        data: "{'oid':'" + oid + "',accion:'" + accionobra + "'}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            console.log('Se encontro obra');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });
                };



                function AccionRegistroCostoMto(oid, accion) {
                    $("#lbloidpresup").text(oid);
                    if (accion == 6) /*Alta de presepuesto*/ {
                        $("#lstprogs").prop("disabled", true);
                        $("#txtmtsseccion").val('');
                        $("#txtbanqueta").val('');
                        $("#txtmtsarroyo").val('');
                        $("#txtgtosadmvos").val('');
                        $("#txtfoliocalidad").val('');
                        $("#txtmts2arroyo").val('');
                        $("#txtmts2banqueta").val('');
                        $("#txtderramavecinos").val('');
                        $("#txtderramaeu").val('');
                        $("#txtcostomtolineal").val('');
                        $("#txtctoobratotal").val('');
                        $("#archivopresup").text('');
                        $("#filepresup").val("");
                        $("#lblaccionpresup").text('altapresup');
                        llenarPrograma(0, 0);
                        MostrarModalPresup();
                    }
                    if (accion == 7 || accion == 8) {
                        $("#lstprogs").prop("disabled", false);
                        if (accion == 7)
                            $("#lblaccionpresup").text('editpresup');
                        else
                            $("#lblaccionpresup").text('elimpresup');
                        ConsultaPresupprog(oid)
                            .done(function (r) {
                                var cadena = $.trim(r.d);
                                if (cadena != "<NewDataSet />") {
                                    $("#lstprogs").html('');
                                    var idprog;
                                    var prid;
                                    $(r.d).find("presupprog").each(function () {
                                        var option = $(document.createElement('option'));
                                        var prog = $(this).find("nomprog").text();
                                        idprog = $(this).find("idprog").text();
                                        var descripprog = $(this).find("progdescrip").text();
                                        var costomto = $(this).find("costo_mto_lineal").text();
                                        var costototalobra = $(this).find("costo_total_obra").text();
                                        prid = $(this).find("prid").text();
                                        option.html(prog + '||' + descripprog + '||' + '$' + costomto + '||' + '$' + costototalobra);
                                        option.val(prid);
                                        $("#lstprogs").append(option);
                                        $("#lstprogs").val(0);
                                    });
                                    CargarPresupuestosObra($("#lstprogs").val());
                                    llenarPrograma(0, 0);
                                    $("#lstprograma").val(idprog);
                                    MostrarModalPresup();

                                }
                                else {
                                    alert("No existe presupuesto para ser editado");
                                }
                            }).fail(function (result) {
                                alert("No existen programas asignados a la obra, por lo tanto no es posible dar de alta el frente");
                            });
                    }


                }

                function CargarPresupuestosObra(prid) {

                    var oid = $("#lbloidpresup").text();

                    ConsultaPresupObra(oid, prid)
                        .done(function (r) {
                            var cadena = $.trim(r.d);
                            var idprog, nomarchivo;
                            if (cadena != "<NewDataSet />") {
                                $(r.d).find("Presup").each(function () {
                                    $("#txtgtosadmvos").val($(this).find("gastos_admvos").text());
                                    idprog = $(this).find("idprog").text();
                                    $("#txtfoliocalidad").val($(this).find("folio_calidad").text());
                                    $("#txtmts2arroyo").val($(this).find("mts2_arroyo").text());
                                    $("#txtmts2banqueta").val($(this).find("mts2_banqueta").text());
                                    $("#txtderramavecinos").val($(this).find("gastos_admvos").text());
                                    $("#txtderramaeu").val($(this).find("derrama_eu").text());
                                    $("#txtmtsseccion").val($(this).find("mts_secc").text());
                                    $("#txtbanqueta").val($(this).find("mts_banqueta").text());
                                    $("#txtmtsarroyo").val($(this).find("mts_arroyo").text());
                                    $("#txtcostomtolineal").val($(this).find("costo_mto_lineal").text());
                                    $("#txtctoobratotal").val($(this).find("costo_total_obra").text());
                                    nomarchivo = $(this).find("dcto_presup").text();

                                });
                                $("#lstprograma").val(idprog);
                                $("#archivopresup").text(nomarchivo);
                                $("#filepresup").prop('disabled', false);
                            }
                        }).fail(function (result) {
                            alert("No se encontro presupuesto asignado a la Obra");
                        });
                }


                function GestionConvenio(accionconv) {

                    var fid = parseInt($("#bodegadatos").data("fid"));
                    var idconv = parseInt($("#bodegadatos").data("idconv"));

                    if (accionconv == 0) {  /*Alta de un Convenio nuevo*/
                        if (ValidarConvenio(accionconv)) {
                            /*Frente a asignar el convenio*/
                            var numpagos = parseInt($("#bodegadatos").data("numpagos"));        /*Número de pagos capturados*/
                            var saldoact2 = parseFloat($("#bodegadatos").data("saldoact2"));     /*Saldo original sin recargos*/
                            var recargosconv = parseFloat($("#bodegadatos").data("recargos")); /*Recargos originales a convenir*/
                            var recargos_cobrados = parseFloat($("#bodegadatos").data("recargoconv") - $("#bodegadatos").data("desctorec")); /* Recargos cobrados en el convenio */
                            var desctorecargos = parseFloat($("#bodegadatos").data("desctorec")); /*Descuento sobre recargos*/
                            var recargosporconv = parseFloat($("#bodegadatos").data("recargoconv"));  /*Recargo por convenio*/
                            var saldo_total_pagar_conv = parseFloat($("#bodegadatos").data("saldopagar"));  /*Saldo total a pagar en el convenio*/
                            var fecconv = ConvertirCadenaToFecha($("#bodegadatos").data("hoy"));
                            var fecvencconv = ConvertirCadenaToFecha($("#bodegadatos").data("fecvenc"));
                            var factoract = parseFloat($("#bodegadatos").data("factoract"));

                            var archivo = $("#fileconvenio").get(0).files;
                            var hoy = new Date();

                            var nomarchivo = fid + '_0' + '_conv';  /*Se arma el nombre del archivo para asignarlo al archivo en el server*/
                            nomarchivo = nomarchivo + ".pdf";
                            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                            var arrusuario = bienveusuario.split(":");
                            var usuario = arrusuario[1];
                            var usurec = parseInt(arrusuario[2]);
                            var hayarchivo = archivo.length;

                            /*fid: identificador de frente
                              fecconv: fecha de vencimiento
                              factoractconv: factor de actualizacion
                              recargosconv: recargos cobrados en el convenio
                              nomarchivo: nombre del archivo del convenio
                              desctorecargosconv: descuento hecho en el convenio
                              saldoact2: saldo actualizado antes de recargos contando los pagos despues de fecha de actualización
                              recargosconv: recargos originales 
                              fechavencconv: fecha de vencimiwento del convenio
                              numpagos: numero de pagos del convenio
                              saldoconv: saldo total convenido
                              pagosconv: paos que se han realizado al convenio
                              estatusconv: estatus del convenio
                              accion:  bandera para identificar el trabjo a hacer con el convenio*/

                            RegistrarConvenio(fid, fecconv, factoract, recargosconv, desctorecargos, saldoact2, recargosporconv, fecvencconv, numpagos, saldo_total_pagar_conv, 0, 1, nomarchivo, usurec, accionconv)
                                .done(function (r) {
                                    if (hayarchivo > 0) {  /*Si hay archivo capturado guardar el documento*/
                                        /*idsol: Id de Frente, 
                                          idref: Se inserta el idconv
                                          iddcto: id de Documento {0} (se asigna el prcediiento almacenado),
                                          folioDcto: 
                                          fecenvio: Fecha en que se envia el documento
                                          fecrecibo: Fecha en
                                          usurec: el usuario que guarda el documento 
                                          nomarchivo: es el nombre del archivo 
                                          tipodcto: 9 es el tipo de documento para el convenio
                                          usuario:el usuario que guarda el documento 
                                          hoy: la fecha del dia en que e tramita
                                          usuario: el usuario que guarda el documento 
                                          hoy: la fecha del dia en que e tramita
                                          archivo: es el archivo y su contenido 
                                          accion: es una accion para dar de alta un documento normal se deja 0 
                                          */
                                        var respWebServicePresup = r.d;
                                        var arridconv = respWebServicePresup.split(":");
                                        var idconvy = parseInt(arridconv[1]);
                                        if (idconvy > 0) { /*Si se guardo un convenio */
                                            nomarchivo = fid.toString() + '_' + idconvy.toString() + '_conv.pdf';
                                            InsertaRegDcto(fid, 0, idconvy, 'conv', hoy, hoy, usurec, nomarchivo, 9, usuario, hoy, usuario, hoy, archivo, accionconv)
                                        }
                                    }
                                    else {
                                        alert("No existe documento para guardar.")
                                    }
                                    $('#mask, .window').hide();
                                    alert("Accion ejecutada correctamente.");
                                    RedibujarGrid();
                                })
                                .fail(function (x) {
                                    alert("No es posible guardar el convenio...");
                                });
                        }
                    }
                    if (accionconv == 1) {  //* ELIMINACION DE CONVENIO**/
                        EliminarConvenio(fid, idconv, accionconv)
                            .done(function (r) {
                                $('#mask, .window').hide();
                                alert("Convenio cancelado correctamente")
                                RedibujarGrid();
                            })
                            .fail(function (x) {
                                alert("No es posible cancelar el convenio...");
                            });
                    }
                }

                function EliminarConvenio(fid, idconv, accion) {

                    var enviarObj = {
                        "fid": fid,
                        "idconv": idconv,
                        "accion": accion
                    }

                    var stringData = JSON.stringify(enviarObj);
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceConvenio.asmx/ActConvenio",
                        data: "{objConv:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };



                function RegistrarConvenio(fid, fecconv, factoractconv, recargosconv, desctorecargosconv, saldoact2, recargoporconvenio, fechavencconv, numpagos, saldoconv, pagosconv, estatusconv, archivoconv, usurec, accion) {

                    var enviarObj = {
                        "fid": fid,
                        "fecconv": fecconv,
                        "factoractconv": factoractconv,
                        "recargosconv": recargosconv,
                        "desctorecargosconv": desctorecargosconv,
                        "saldoact2": saldoact2,
                        "recargosporconvenio": recargoporconvenio,
                        "fechavencconv": fechavencconv,
                        "numpagos": numpagos,
                        "saldoconv": saldoconv,
                        "pagosconv": pagosconv,
                        "estatusconv": estatusconv,
                        "archivoconv": archivoconv,
                        "usucre": usurec,
                        "accion": accion
                    }



                    var stringData = JSON.stringify(enviarObj);
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceConvenio.asmx/ActConvenio",
                        data: "{objConv:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };


                function ValidarRegistroPublicacion(oid, accionpub) {

                    if (ValidarPub()) {

                        var fecpub = ConvertirCadenaToFecha($("#txtfecpub").val());
                        var archivo = $("#filepub").get(0).files;
                        var sufijo = '_pub';
                        if (accionpub == 4) {
                            fecpub = $("#txtfecproc").val();
                        }

                        if (accionpub == 0) {
                            fecpub = ConvertirCadenaToFecha($("#txtentregaobra").val());
                            archivo = $("#fileentobra").get(0).files;
                            sufijo = '_entrega_obra';
                        }


                        var hayarchivo = archivo.length;
                        var hoy = new Date();


                        var nomarchivo = oid + sufijo + accionpub.toString();  /*Se arma el nombre del archivo para asignarlo al archivo en el server*/
                        nomarchivo = nomarchivo + ".pdf";
                        var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                        var arrusuario = bienveusuario.split(":");
                        var usuario = arrusuario[1];
                        var usurec = arrusuario[2];


                        RegistrarPub(oid, fecpub, nomarchivo, accionpub, 4)
                            .done(function (r) {
                                if (hayarchivo > 0) {  /*Si hay archivo capturado guardar el documento*/
                                    InsertaRegDcto(oid, 0, 0, accionpub, hoy, hoy, usurec, nomarchivo, 10, usuario, hoy, usuario, hoy, archivo, 16)     /*El número 16 indica que se va a guardar un documento de publicacion y el accionpub (1ra publicacion, 2da publicacion y aviso al congreso) servira para referenciar el documento junto con el oid*/
                                }
                                else {
                                    alert("No existio documento para guardar.")
                                }
                                $('#mask, .window').hide();
                                alert("Accion ejecutada correctamente.");
                                RedibujarGrid();
                            })
                            .fail(function (x) {
                                alert("No es posible guardar la publicación...");
                            });
                    }
                }


                function RegistrarPub(oid, fecpub, nomarchivo, accionpub, accion) {

                    var enviarObj = {
                        "oid": oid,
                        "fecpub": fecpub,
                        "evidenciapub": nomarchivo,
                        "accionpub": accionpub,
                        "accion": accion
                    }


                    var stringData = JSON.stringify(enviarObj);
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceObras.asmx/RegObra",
                        data: "{objObra:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };



                function ValidarRegistroPresupuesto(oid, accion) {
                    /*var accion = parseInt($("#lblaccionpresup").html());*/
                    var idsol = 0;

                    if (validarpresup(accion)) {   /*Valida que los datos del documento sean correctos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                        /*Reunir parámetros para guardar el levantamiento capturado en el server*/

                        var hoy = new Date();
                        var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                        var arrusuario = bienveusuario.split(":");
                        var usuario = arrusuario[1];
                        var usurec = arrusuario[2];
                        var idprog = parseInt($("#lstprograma option:selected").val());
                        var prid = parseInt($("#lstprogs option:selected").val());
                        if (isNaN(prid)) {
                            prid = 0;
                        }
                        var costo_mto_lineal = $("#txtcostomtolineal").val();
                        var costo_total_obra = $("#txtctoobratotal").val();
                        var mts_secc = $("#txtmtsseccion").val();
                        var mts_banqueta = $("#txtbanqueta").val();;
                        var mts_arroyo = $("#txtmtsarroyo").val();;
                        var gastos = $("#txtgtosadmvos").val();;
                        var folio = 'presupObraV';
                        var mts2_banqueta = $("#txtmts2banqueta").val();;
                        var mts2_arroyo = $("#txtmts2arroyo").val();;
                        var derrama_vec = $("#txtderramavecinos").val();;
                        var derrama_eu = $("#txtderramaeu").val();;
                        var archivo = $("#filepresup").get(0).files;
                        var hayarchivo = archivo.length;

                        var estatus_presup;
                        if (accion == 8) {
                            estatus_presup = 5;
                        }
                        else {
                            estatus_presup = 1;
                        }

                        var nomarchivo = oid + "_PRESUP.pdf";


                        RegistrarPresupuestoBD(costo_mto_lineal,
                            costo_total_obra,
                            nomarchivo,
                            idprog,
                            mts_secc,
                            mts_banqueta,
                            mts_arroyo,
                            gastos,
                            folio,
                            mts2_banqueta,
                            mts2_arroyo,
                            derrama_vec,
                            derrama_eu,
                            estatus_presup,
                            oid,
                            idsol,
                            prid,
                            usuario,
                            hoy,
                            usuario,
                            hoy,
                            accion)
                            .done(function (r) {
                                if (hayarchivo > 0 && accion != 8) {  /*Si hay archivo capturado guardar el documento*/
                                    var respWebServicePresup = r.d;
                                    var arridpresup = respWebServicePresup.split(":");
                                    var idpresup = parseInt(arridpresup[1]);
                                    if (idpresup > 0) { /*Si se guardo un presupuesto para obrav */
                                        var nomarchivo = oid + '_' + idpresup + "_PRESUP.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                                        InsertaRegDcto(oid, 0, idpresup, folio, hoy, hoy, usurec, nomarchivo, 8, usuario, hoy, usuario, hoy, archivo, accion)
                                    }
                                    else {
                                        alert("No se guardo el documento capturado.");
                                    }
                                }
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            })
                            .fail(function (x) {
                                alert("No es posible guardar el presupuesto...");
                            });
                    }
                };



                function validarpresup(accion) {

                    var valid = true;

                    if (accion == 6 || accion == 7) { /*Si el usuario escogió dar de alta un nuevo levantamiento*/

                        if ($("#filepresup").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                            if (ValidarArchivo($("#filepresup")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                valid = valid && true;
                            }
                            else {
                                $("#filepresup").val("");
                                valid = valid && false;
                            }
                        }
                        else {
                            if (accion == 7) {
                                if ($("#archivopresup").text() != "") {
                                    valid = valid && true;
                                }
                                else {
                                    alert("No se ha capturado ningún archivo digital");
                                    valid = valid && false;
                                }
                            }
                            else {
                                alert("No se ha capturado ningún archivo digital");
                                valid = valid && false;
                            }
                        }

                        if (valid) {   /*Si es v[alido el archivo*/

                            valid = valid && checkLength($("#txtcostomtolineal").val().length, "Costo Metro Lineal", 1, 10);
                            valid = valid && checkLength($("#txtctoobratotal").val().length, "Costo total de obra", 1, 10);
                            valid = valid && checkVacio($("#txtcostomtolineal").val(), /\d+(.\d+)?/, "Captura correctamente el costo del metro lineal");
                            valid = valid && checkVacio($("#txtctoobratotal").val(), /\d+(.\d+)?/, "Captura correctamente el costo total de la obra");

                            valid = valid && checkVacio($("#txtgtosadmvos").val(), /\d+(.\d+)?/, "Captura correctamente los gastos administrativos");
                            valid = valid && checkVacio($("#txtmts2arroyo").val(), /\d+(.\d+)?/, "Captura correctamente area del arroyo");
                            valid = valid && checkVacio($("#txtmts2banqueta").val(), /\d+(.\d+)?/, "Captura correctamente el area de la banqueta");
                            valid = valid && checkVacio($("#txtderramavecinos").val(), /\d+(.\d+)?/, "Captura correctamente la derrama de vecinos");
                            valid = valid && checkVacio($("#txtmtsarroyo").val(), /\d+(.\d+)?/, "Captura correctamente los metros lineales del arroyo");
                            valid = valid && checkVacio($("#txtbanqueta").val(), /\d+(.\d+)?/, "Captura correctamente los metros lineales de la banqueta");
                            valid = valid && checkVacio($("#txtmtsseccion").val(), /\d+(.\d+)?/, "Captura correctamente los metros de la sección");
                        }
                    }

                    return valid;
                }

                function RegistrarPresupuestoBD(costo_mto_lineal, costo_total_obra, nomarchivo, idprog, mts_secc, mts_banqueta, mts_arroyo, gastos, folio, mts2_banqueta, mts2_arroyo, derrama_vec, derrama_eu, estatus_presup, oid, idsol, prid, usuario, hoy, usuario, hoy, accion) {

                    var enviarObj = {
                        "CostoMtoLineal": costo_mto_lineal,
                        "CostoTotalObra": costo_total_obra,
                        "Dcto": nomarchivo,
                        "ProgId": idprog,
                        "MtsSeccion": mts_secc,
                        "MtsBanqueta": mts_banqueta,
                        "MtsArroyo": mts_arroyo,
                        "GastosAdmvos": gastos,
                        "Folio": folio,
                        "Mts2Arroyo": mts2_banqueta,
                        "Mts2Banqueta": mts2_arroyo,
                        "DerramaVecinos": derrama_vec,
                        "DerramaEU": derrama_eu,
                        "EstatusPresup": estatus_presup,
                        "oid": oid,
                        "solid": idsol,
                        "IdPresup": prid,
                        "UsuCre": usuario,
                        "FecCre": hoy,
                        "UsuMod": usuario,
                        "FecMod": hoy,
                        "accion": accion,
                    }


                    var stringData = JSON.stringify(enviarObj);
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServicePresup.asmx/RegPresup",
                        data: "{objPresup:" + stringData + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                                /*$(data.d).find("Presup").each(function () {
                                    var noerror = $(this).find('noerror').text();
                                    if (parseInt(noerror)>0) {
                                        var description = $(this).find('descerror').text();                           
                                        alert(description);
                                    }
                                });  */
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };

                function leerArchivo(nom_archivo) {
                    var url = "../../temp/" + nom_archivo;
                    window.open(url, '_blank', 'toolbar=0');
                }



                function ConsultaSolicitud(idsolSelec) {
                    return $.ajax({
                        type: 'POST',
                        url: "../../WebServices/WebServiceSolic.asmx/GetSolicitud",
                        data: "{idSol:" + idsolSelec + "}",
                        contentType: 'application/json; utf-8',
                        dataType: 'json',
                        success: function (data) {
                            if (data.d != null) {
                                alert(data.d);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus + jqXHR + errorThrown);
                        }
                    });

                };

                function InsertaRegDcto(idsol, iddcto, idref, folioDcto, fecenvio, fecrecibo, usurec, nomarchivo, tipodcto, usuario, hoy, usuario, hoy, archivo, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


                    var enviarObj = {
                        "idsol": idsol,
                        "iddcto": iddcto,
                        "idref": idref,
                        "folio": 'pub' + folioDcto,
                        "FecSolic": fecenvio,
                        "FecRecib": fecrecibo,
                        "NumRecibe": usurec,
                        "NomArchivo": nomarchivo,
                        "TipoDcto": tipodcto,
                        "UsuCre": usuario,
                        "FecCre": hoy,
                        "UsuMod": usuario,
                        "FecMod": hoy,
                        "accion": accion
                    }
                    var stringData = JSON.stringify(enviarObj);

                    return $.ajax({
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



                function ConvertirCadenaToFecha(cadenafec) {
                    var fecha = new Date();
                    if (cadenafec != "") {
                        var from = cadenafec.split("/");
                        var fecha = new Date(from[2], from[1] - 1, from[0]);
                        if (!isDate(cadenafec)) {
                            fecha = '01/01/1900';
                        }
                    }
                    else {
                        /*var fecha = new Date('2200', '01', '01');*/
                        fecha = '01/01/1900';
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
                    return resp;
                }


                function ValidarConvenio(accionconv) {
                    /*Validamos que se haya capturado el archivo del convenio firmado*/
                    /*Validamos que se haya capturado el archivo del convenio firmado*/

                    var accionpub = parseInt($("#lblaccionpub").html());
                    var lblfecpub1 = ConvertirCadenaToFecha($("#lblfecpub1").html());
                    var lblfecpub2 = ConvertirCadenaToFecha($("#lblfecpub2").html());
                    var valid = true;

                    if (accionconv == 0) {   /*ALTA DE UN CONVENIO*/
                        if ($("#fileconvenio").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                            if (ValidarArchivo($("#fileconvenio")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                valid = valid && true;
                            }
                            else {
                                $("#fileconvenio").val("");
                                valid = valid && false;
                            }
                        } else {
                            alert('Debe ser capturado el archivo correspondiente al convenio firmado por el cooperador');
                            valid = valid && false;
                        }
                    }

                    return valid;
                }


                function ValidarPub() {
                    var accionpub = parseInt($("#lblaccionpub").html());
                    var lblfecpub1 = ConvertirCadenaToFecha($("#lblfecpub1").html());
                    var lblfecpub2 = ConvertirCadenaToFecha($("#lblfecpub2").html());
                    var valid = true;

                    if (accionpub == 1) {
                        var fecpub1 = ConvertirCadenaToFecha($("#txtfecpub").val());
                        if (fecpub1 <= '01/01/1900') {
                            valid = false;
                            alert("Es errónea la fecha capturada de la 1ra. Publicación");
                        }
                        else {
                            if (lblfecpub2 = ConvertirCadenaToFecha('01/01/1900')) {
                                var fecpav = ConvertirCadenaToFecha($("#lblfecpav").html());
                                var nohayfecha = new Date('01/01/1900');
                                if (fecpav = nohayfecha) {
                                    valid = true;
                                }
                                else {
                                    if (fecpub1 < fecpav) {
                                        valid = true;
                                    }
                                    else {
                                        valid = false;
                                        alert("Es errónea la fecha capturada de la 1ra. Publicación es mayor a la fecha de entrega del pavimento de la obra");
                                    }
                                }
                            }
                            else {
                                if (fecpub1 < lblfecpub2) {
                                    valid = true;
                                }
                                else {
                                    valid = false;
                                    alert("Es errónea la fecha capturada de la 1ra. Publicación es mayor a la fecha de la 2da. Publicación");
                                }
                            }
                        }

                    }
                    else {
                        if (accionpub == 2) {
                            if (lblfecpub1 == '01/01/1900') {
                                valid = false;
                                alert("No es posible capturar la fecha de 2da. Publicación si no existe 1ra. Publicación")
                                $("#txtfecpub").val('');
                            }
                            else {
                                var fecpub2 = ConvertirCadenaToFecha($("#txtfecpub").val());
                                if (fecpub2 > lblfecpub1) {
                                    valid = true;
                                }
                                else {
                                    if (fecpub2 == '01/01/1900') {
                                        alert("Fecha capturada de 2da. Publicación errónea")
                                    }
                                    else {
                                        alert("Fecha capturada de 2da. Publicación errónea es menor que la fecha de la 1ra. Publicación")
                                    }
                                    valid = false;
                                }
                            }
                        }
                        else {
                            if (accionpub == 3) {
                                var fecpub2 = ConvertirCadenaToFecha($("#lblfecpub2").html());
                                var fecavicong = ConvertirCadenaToFecha($("#txtfecpub").val());
                                if (fecavicong > fecpub2) {
                                    valid = true;
                                }
                                else {
                                    valid = false;
                                    alert("Fecha capturada de aviso del congreso es errónea.")
                                }
                            }
                            else {
                                accionpub = parseInt($("#lblaccionpub2").html());
                                if (accionpub == 4) {
                                    var fecpub2 = ConvertirCadenaToFecha($("#lblfecpub2").html());
                                    var fecproc = ConvertirCadenaToFecha($("#txtfecproc").val());
                                    if (fecproc > fecpub2) {
                                        valid = true;
                                    }
                                    else {
                                        valid = false;
                                        alert("El inicio de proceso de la obra debe ser mayor a la fecha de la 2da. publicación.");
                                    }
                                }
                                else {
                                    if (accionpub == 0) {
                                        var fecproc = ConvertirCadenaToFecha($("#lblfecpro2").html());
                                        var fecentobra = ConvertirCadenaToFecha($("#txtentregaobra").val());
                                        if (fecproc < fecentobra) {
                                            valid = true;
                                        }
                                        else {
                                            valid = false;
                                            alert("No se ha capturado el inicio de proceso de la obra.");
                                        }

                                    }
                                }

                            }
                        }
                    }

                    if (accionpub < 4) {
                        if (accionpub == 0) {
                            if ($("#fileentobra").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                                if (ValidarArchivo($("#fileentobra")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                    valid = valid && true;
                                }
                                else {
                                    $("#fileentobra").val("");
                                    valid = valid && false;
                                }
                            }
                            else {
                                var t = $("#archivo3").text();
                                if ($("#archivo3").text() == "Ningún archivo seleccionado") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                    valid = valid && false;
                                    alert("No se ha capturado ningún archivo digital");
                                }
                                else {
                                    valid = valid && true;
                                }
                            }

                        }
                        else {
                            if ($("#filepub").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                                if (ValidarArchivo($("#filepub")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                    valid = valid && true;
                                }
                                else {
                                    $("#filepub").val("");
                                    valid = valid && false;
                                }
                            }
                            else {
                                var t = $("#archivo2").text();
                                if ($("#archivo2").text() == "Ningún archivo seleccionado") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                    valid = valid && false;
                                    alert("No se ha capturado ningún archivo digital");
                                }
                                else {
                                    valid = valid && true;
                                }
                            }
                        }
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
                            default:
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

                function MostrarModalConv() {
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
                    $("#dialogoconv").css('top', winH / 2 - $("#dialogoconv").height() / 2);
                    $("#dialogoconv").css('left', winW / 2 - $("#dialogoconv").width() / 2);

                    //transition effect
                    $("#dialogoconv").fadeIn(2000);
                }


                function MostrarModalPresup() {
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
                    $("#dialogopresup").css('top', winH / 2 - $("#dialogopresup").height() / 2);
                    $("#dialogopresup").css('left', winW / 2 - $("#dialogopresup").width() / 2);

                    //transition effect
                    $("#dialogopresup").fadeIn(2000);
                }


                function MostrarModalObra() {
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
                    $("#dialogoObra").css('top', winH / 2 - $("#dialogoObra").height() / 2);
                    $("#dialogoObra").css('left', winW / 2 - $("#dialogoObra").width() / 2);

                    //transition effect
                    $("#dialogoObra").fadeIn(2000);
                }

                function MostrarModalPub() {
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
                    $("#dialogoPub").css('top', winH / 2 - $("#dialogoPub").height() / 2);
                    $("#dialogoPub").css('left', winW / 2 - $("#dialogoPub").width() / 2);

                    //transition effect
                    $("#dialogoPub").fadeIn(2000);
                }


                function MostrarModalFecProc() {
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
                    $("#dialogoprocobra").css('top', winH / 2 - $("#dialogoprocobra").height() / 2);
                    $("#dialogoprocobra").css('left', winW / 2 - $("#dialogoprocobra").width() / 2);

                    //transition effect
                    $("#dialogoprocobra").fadeIn(2000);
                }



                function MostrarModalFecEntObra() {
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
                    $("#dialogoentregaobra").css('top', winH / 2 - $("#dialogoentregaobra").height() / 2);
                    $("#dialogoentregaobra").css('left', winW / 2 - $("#dialogoentregaobra").width() / 2);

                    //transition effect
                    $("#dialogoentregaobra").fadeIn(2000);
                }

                function AccionRegistroObra(accion, estatusobra, oid, noobra, noobra2, noobra3, cvecalle, sector, subsector, tramo, ctacont, fecrec, fecinipag, fecproc, feccob, estatusobra, nopagos) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro        


                    if (accion == 0) {  //Si la accion es dar de alta una obra
                        var estatussol = "9";
                        if (oid > 0) {
                            $("#lblaccionobra").text(accion);
                            $("#lblestobra").text(estatusobra);
                            $("#txtobra").val(oid);
                            $("#txtnoobra").val(noobra);
                            $("#txtnoobra2").val(noobra2);
                            $("#txtnoobra3").val(noobra3);
                            $("#tramo").val(tramo);
                            $("#txtnopagos").val(nopagos);
                            $("#txtfecrec").val(fecrec);
                            $("#txtfecproc1").val(fecproc);
                            $("#txtfeccob").val(feccob);
                            $("#fecinipag").val(fecinipag);

                            var fec = ConvertirCadenaToFecha(fecinipag.toString());
                            fec.setMonth(fec.getMonth() + parseInt(nopagos));
                            var strDate = fec.getDate() + "/" + (fec.getMonth() + 1) + "/" + fec.getFullYear();
                            $("#lblfecvenc").text('');
                            $("#lblfecvenc").text("Fecha de Vencimiento:" + strDate);

                            llenarColonias2(sector, subsector, cvecalle);
                            llenarEstatusObra("infestatusobra", parseInt(estatusobra));
                        }
                        MostrarModalObra();
                    }
                }

                function AccionRegistroPub(oid, status_obra, accionpub, fecpub1, fecpub2, fecpav, fecavicong, fecproc, nomarchivo) {

                    $("#lbloid").text(oid);
                    $("#lblestatusobra").text(status_obra);
                    $("#lblpub").text(accionpub);
                    $("#lblfecpav").text(ConvertirCadenaToFecha(fecpav));
                    $("#lblfecpub1").text(fecpub1);
                    $("#lblfecpub2").text(fecpub2);
                    $("#archivo2").text(nomarchivo);


                    if (accionpub == 1) {
                        $("#lblpub").text('Captura de Fecha de 1ra. publicación');
                        $("#lblaccionpub").text('1')
                        $("#txtfecpub").val(fecpub1);
                        MostrarModalPub();
                    }
                    else {
                        if (accionpub == 2) {
                            $("#lblpub").text('Captura de Fecha de 2da. publicación');
                            $("#lblaccionpub").text('2');
                            $("#txtfecpub").val(fecpub2);
                            MostrarModalPub();
                        }
                        else {
                            if (accionpub == 3) {
                                $("#lblpub").text('Aviso al Congreso del Estado de Gto');
                                $("#fecavicong").text('Fecha de aviso al Congreso del Estado:');
                                $("#docpub").text('Acuse de recibo del Congreso del Estado:');
                                $("#lblaccionpub").text('3');
                                $("#txtfecpub").val(fecavicong);
                                MostrarModalPub();
                            }
                            else {
                                if (accionpub == 4) {
                                    $("#lblfec2dapub").text(fecpub2);
                                    $("#lbloidobra").text(oid);
                                    $("#lblaccionpub2").text('4');
                                    $("#lblestatusobra2").text(status_obra);
                                    MostrarModalFecProc();
                                }
                                else {
                                    if (accionpub == 0) {
                                        $("#lbloid3").text(oid);
                                        $("#lblaccionentregaobra").text('0');
                                        $("#lblestatusobra3").text(status_obra);
                                        $("#lblfecpro2").text(fecproc);
                                        $("#archivo3").text(nomarchivo);
                                        MostrarModalFecEntObra();

                                    }
                                }
                            }

                        }
                    }

                }


                function CargaSolicitudes(estatussol) {


                    return $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceSolic.asmx/ConsultaSolicitudes_psql",
                        data: "{'estatussol':'" + estatussol + "'}",
                        success: function (data) {
                            var cadena = $.trim(data.d);
                            if (cadena != "<NewDataSet />") {
                                var elementos = 0;
                                $("#lstsolicitudes").html('');
                                $(data.d).find("rSolicitud").each(function () {
                                    var option = $(document.createElement('option'));
                                    var idSol = parseInt($(this).find("msolid").text());
                                    var calle = $(this).find("msolCalle").text();
                                    var colonia = $(this).find("msolColonia").text();
                                    var tramo = $(this).find("msolTramo").text();
                                    var ubic = $(this).find("ubic").text();
                                    var contenido = idSol.toString() + " || " + $.trim(calle) + " || " + $.trim(colonia) + " || " + $.trim(tramo) + " || " + $.trim(ubic);
                                    option.html(contenido);
                                    option.val(idSol);
                                    //Nombre de combo a poblar
                                    $("#lstsolicitudes").append(option);
                                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                                });
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }


                function llenarUsuario(idusu) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioProm",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstUsuario").html('');
                            $(data.d).find("UsuarioProm").each(function () {
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
                }

                function llenarEstatusObra(accion, idestatusobra) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceEstatusObra.asmx/GetEstatusObra",
                        data: "{'accion':'" + accion + "',idestatusobra:'" + idestatusobra + "'}",
                        success: function (data) {
                            var elementos = 0;
                            $("#estatusobra").html('');
                            $(data.d).find("EstObra").each(function () {
                                var option = $(document.createElement('option'));
                                var idestatusobra = $(this).find("cidestatusobrar").text();
                                var descrip = $(this).find("cestatusr").text();
                                option.html(descrip);
                                option.val(idestatusobra);
                                //Nombre de combo a poblar
                                $("#estatusobra").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (accion == 'infestatusobra') {
                                $("#estatusobra").val(idestatusobra);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }


                /* function llenarTiposDctos(accion, idtipodcto) {
                     $.ajax({
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         url: "../../WebServices/WebServiceDcto.asmx/GetTipoDcto",
                         data: '{accion:' + accion + '}',
                         success: function (data) {
                             var elementos = 0;
                             $("#lsttipodoc").html('');
                             $(data.d).find("TipoDcto").each(function () {
                                 var option = $(document.createElement('option'));
                                 var idtipodoc = $(this).find("cidtipodoc").text();
                                 var nomtipodoc = $(this).find("cdescrip").text() + ":" + $(this).find("prefijo").text();;
                                 option.html(nomtipodoc);
                                 option.val(idtipodoc);
                                 $("#lsttipodoc").append(option);
                             });
                             if (idtipodcto != 0) { //Si la clave del tipo de dcto es diferente de 0, es decir si el registro es para editar
                                 $("#lsttipodoc").val(idtipodcto);
                             }
                         },
                         error: function (xhr) {
                             console.log(xhr.responseText);
                         }
                     });
                 }*/

                function llenarCalles(cvecolonia, cvecallesel) {
                    var arr = cvecolonia.split("*");
                    var colonia = arr[0] + arr[1];
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCalCol.asmx/GetCalles",
                        data: "{'parametro':'" + colonia + "'}",
                        success: function (data) {
                            $("#calle").html('');
                            // Data.d trae un string con el XML generado dentro del servicio web asmx
                            $(data.d).find("CallesDU").each(function () {
                                var option = $(document.createElement('option'));
                                var cvecalle = $(this).find("CveCalle").text();
                                var callenom = $(this).find("Calle").text();
                                option.html(callenom);
                                option.val(cvecalle);
                                $("#calle").append(option);
                            });
                            if (cvecallesel > 0) {
                                $("#calle").val(cvecallesel);
                            }
                        },
                        error: function (response) {
                            if (response.length != 0)
                                alert(response);
                        }
                    });
                }

                function llenarColonias2(sector, subsector, cvecalle) {
                    $.ajax({
                        type: "GET",
                        dataType: "json",
                        contentType: "application/json",
                        url: "http://192.1.1.7/ws_CatastroMultifinalitario/ws_colonias/consultasectores",
                        beforeSend: function (xhr) {
                            /* Authorization header */
                            xhr.setRequestHeader("Authorization", "K2XJFZY3mZAoGce8olN27Q==");
                        },
                        data: "",
                        success: function (data) {

                            var data_asc = [];
                            var elementos = data.Colonias.length;

                            for (var i = 0; i < elementos; i++) {
                                data_asc.push({ "clave": (data.Colonias[i].Sector + '*' + data.Colonias[i].SubSector), "colonia": data.Colonias[i].Colonia });
                            }
                            var a = data_asc.sort(function (a, b) {
                                if (a.colonia > b.colonia) {
                                    return 1;
                                }
                                if (a.colonia < b.colonia) {
                                    return -1;
                                }
                                // a must be equal to b
                                return 0;
                            });

                            $.each(a, function (index, value) {
                                // como ahora es un array de objetos, accede a cada propiedad adecuadamente
                                $('#colonia').append("<option value='" + value.clave + "'>" + value.colonia + "</option>");
                            });
                            if (sector != 0) { //Si la clave de sector es diferente de 0, es decir si el registro es para editar
                                $("#colonia").val(sector + "*" + subsector);
                            }
                            llenarCalles2($("#colonia").val(), cvecalle);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR.responseText);
                        }
                    });
                }


                function llenarCalles2(sectorsubsector, cvecalle) {
                    var arr = sectorsubsector.split("*");
                    var sector = arr[0];
                    var subsector = arr[1];
                    $.ajax({
                        type: "GET",
                        dataType: "json",
                        contentType: "application/json",
                        url: "http://192.1.1.7/ws_CatastroMultifinalitario/ws_colonias/consultasectorsubsectorcalles",
                        beforeSend: function (xhr) {
                            /* Authorization header */
                            xhr.setRequestHeader("Authorization", "K2XJFZY3mZAoGce8olN27Q==");
                        },
                        headers: { 'sector': sector, 'subsector': subsector },
                        success: function (data) {
                            var data_asc = [];
                            var elementos = data.Calles.length;
                            $("#calle").html('');
                            for (var i = 0; i < elementos; i++) {
                                data_asc.push({ "clvcalle": data.Calles[i].ClaveCalle, "calle": data.Calles[i].Calle });
                            }
                            var a = data_asc.sort(function (a, b) {
                                if (a.calle > b.calle) {
                                    return 1;
                                }
                                if (a.calle < b.calles) {
                                    return -1;
                                }
                                // a must be equal to b
                                return 0;
                            });
                            $.each(a, function (index, value) {
                                // como ahora es un array de objetos, accede a cada propiedad adecuadamente
                                $("#calle").append("<option value='" + value.clvcalle + "'>" + value.calle + "</option>");
                            });
                            if (cvecalle != 0) { //Si la clave de sector es diferente de 0, es decir si el registro es para editar
                                $("#calle").val(cvecalle);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR.responseText);
                        }
                    });
                }

                function ConsultaPresupprog(xid) {
                    return $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServicePresup.asmx/GetPresupprog",
                        data: "{'oid':'" + xid + "'}"
                    });
                }

                function ConsultaPresupObra(oid, prid) {
                    return $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServicePresup.asmx/GetPresupObra",
                        data: "{'oid':'" + oid + "','prid':'" + prid + "'}",
                    });
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

                function llenarCalles(cvecolonia, cvecallesel) {
                    var arr = cvecolonia.split("*");
                    var colonia = arr[0] + arr[1];
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCalCol.asmx/GetCalles",
                        data: "{'parametro':'" + colonia + "'}",
                        success: function (data) {
                            $("#calle").html('');
                            // Data.d trae un string con el XML generado dentro del servicio web asmx
                            $(data.d).find("CallesDU").each(function () {
                                var option = $(document.createElement('option'));
                                var cvecalle = $(this).find("CveCalle").text();
                                var callenom = $(this).find("Calle").text();
                                option.html(callenom);
                                option.val(cvecalle);
                                $("#calle").append(option);
                            });
                            if (cvecallesel > 0) {
                                $("#calle").val(cvecallesel);
                            }
                        },
                        error: function (response) {
                            if (response.length != 0)
                                alert(response);
                        }
                    });
                }

            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


            <b>Nombre de Calle:<input type="text" name="Calle" id="txtnomcalle" style="width:250px" />&nbsp &nbsp No.
                Obra:</><input type="text" name="oid" id="txtoid" style="width:50px" /> &nbsp &nbsp Obra_SIFIDOC:</>
                <input type="text" name="obra_s" maxlength="10" id="obra_s" style="width:100px" /></b><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp

            <div id="boxes">
                <div id="dialogoObra" class="window">
                    <div id="tituloAnu" style="text-align:right">
                        <p style="text-align:center">GESTION DE OBRAS</p>
                        No. de Obra: <label for="oid" id="lblobra"></label><br />
                        Estatus Obra: <label for="id" id="lblestobra"></label><br />
                        Acción:<label for="accion" id="lblaccionobra"></label><br />
                    </div>
                    <div class="datos" id="bodyObra">
                        <br /><br />
                        &nbsp&nbsp&nbsp<label for="name">*Obra:</label><input type="text" name="txtobra" id="txtobra"
                            size="10" />&nbsp&nbsp&nbsp&nbsp<a href="#" class="geom_obra">Ver obras >>></a><br /><br />
                        <label for="name">*NoObra:</label><input type="text" name="noobra" id="txtnoobra" size="10"
                            maxlength="10" /><br />
                        <label for="name">NoObra2:</label><input type="text" name="noobra2" id="txtnoobra2" size="10"
                            maxlength="10" /><br />
                        <label for="name">NoObra3:</label><input type="text" name="noobra3" id="txtnoobra3" size="10"
                            maxlength="10" /> <br /><br />
                        <label for="name">*COLONIA:</label><select name="colonia" id="colonia"></select><br /><br />
                        <label for="name">*CALLE A PAVIMENTAR:</label><select name="calle"
                            id="calle"></select><br /><br />
                        <label for="name">*TRAMO:</label><input type="text" name="tramo" id="tramo"
                            size="120" /><br /><br />
                        <label for="name">*Estatus Obra:</label><select name="estatusobra"
                            id="estatusobra"></select>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name">Cuenta
                            contable:</label><input type="text" name="ctacontable" id="txtctacontable" size="25"
                            maxlength="25" /><br /><br /><br />
                        <label for="name">*Fec_Inic_Pago (dd/mm/aaaa):</label><input type="text" name="fecinipag"
                            id="fecinipag" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" />&nbsp&nbsp&nbsp
                        <label for="name">*No.Pagos:</label><input type="text" name="nopagos" id="txtnopagos" size="10"
                            maxlength="10" />&nbsp&nbsp&nbsp<label id="lblfecvenc" for="name">*Fecha Venc.
                            (dd/mm/aaaa):</label><br /><br />
                        <label for="name">*Fecha_Recaudación (dd/mm/aaaa):</label><input type="text" name="fecrec"
                            id="txtfecrec" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                        <label for="name">*Fecha_Proceso (dd/mm/aaaa):</label><input type="text" name="fecproc"
                            id="txtfecproc1" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                        <label for="name">*Fecha_Cobranza (dd/mm/aaaa):</label><input type="text" name="feccob"
                            id="txtfeccob" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                    </div>
                    <div class="botonesA" id="botonesA">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_obra">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_obra">Cancelar</a></p>
                    </div>
                </div>
                <div id="dialogoPub" class="window">
                    <div id="tituloPub" style="text-align:right">
                        <p style="text-align:center">PUBLICACIONES DE OBRA</p>
                        <label for="publicacion" id="lblpub"></label><br /><br />
                        No. de Obra: <label for="oid" id="lbloid"></label><br />
                        Estatus Obra: <label for="id" id="lblestatusobra"></label><br />
                        Fecha de Entrega de Pavimento: <label for="id" id="lblfecpav"></label><br />
                        Fecha 1ra. Publicación: <label for="id" id="lblfecpub1"></label><br />
                        Fecha 2da. Publicación: <label for="id" id="lblfecpub2"></label><br />
                        Accion: <label for="id" id="lblaccionpub"></label><br /><br />
                    </div>
                    <div class="datos" id="bodyPub">
                        <label for="name" id="fec">Fecha de Publicación:</label>&nbsp&nbsp<input type="text" name="pub"
                            id="txtfecpub" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                        <label for="name" id="docpub">Documento Publicación:</label>&nbsp&nbsp<input type="file"
                            id="filepub" name="file" /> <a href="#" id="archivo2" class="verarchivo"></a>
                    </div>
                    <div class="botonesA" id="botonesB">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_pub">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_pub">Cancelar</a></p>
                    </div>
                </div>
                <div id="dialogoprocobra" class="window">
                    <div id="tituloprocobra" style="text-align:right">
                        <p style="text-align:center">INICIO DE PROCESO DE OBRA</p><br />
                        <p style="text-align:center">(RECAUDACION ---> PROCESO)</p><br /><br />
                        No. de Obra: <label for="oid" id="lbloidobra"></label><br />
                        Estatus Obra: <label for="id" id="lblestatusobra2"></label><br />
                        Fecha 2da. Publicación: <label for="id" id="lblfec2dapub"></label><br />
                        Accion: <label for="id" id="lblaccionpub2"></label><br /><br />
                    </div>
                    <div class="datos" id="bodyestatusproc">
                        <label for="name" id="lblfecproc">Fecha inicio de proceso la obra:</label>&nbsp&nbsp<input
                            type="text" name="pub" id="txtfecproc" size="10" maxlength="10"
                            onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                    </div>
                    <div class="botonesA" id="botonesprocesoobra">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_procobra">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_procobra">Cancelar</a></p>
                    </div>
                </div>
                <div id="dialogoentregaobra" class="window">
                    <div id="tituloentregaobra" style="text-align:right">
                        <p style="text-align:center">ENTREGA DE OBRA PAVIMENTADA </p><br />
                        <p style="text-align:center">(PROCESO ---> COBRANZA)</p><br />
                        No. de Obra: <label for="oid" id="lbloid3"></label><br />
                        Estatus Obra: <label for="id" id="lblestatusobra3"></label><br />
                        Inicio de proceso de obra: <label for="id" id="lblfecpro2"></label><br />
                        Accion: <label for="id" id="lblaccionentregaobra"></label><br /><br />
                    </div>
                    <div class="datos" id="bodyentregaobra">
                        <label for="name" id="lblfecpav2">Fecha entrega de pavimentación de la
                            obra:</label>&nbsp&nbsp<input type="text" name="entregaobra" id="txtentregaobra" size="10"
                            maxlength="10" onkeyup="this.value=formateafecha(this.value);" /><br /><br />
                        <label for="name" id="lbldocentobra">Documento Entrega Obra:</label>&nbsp&nbsp<input type="file"
                            id="fileentobra" name="file" /> <a href="#" id="archivo3" class="verarchivo" />
                    </div>
                    <div class="botonesB" id="botonesentregaobra">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_entregaobra">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_entregaobra">Cancelar</a></p>
                    </div>
                </div>
                <div id="dialogopresup" class="window">
                    <div id="titulopresup">
                        <p style="text-align:center">GESTION DE PRESUPUESTO</p>
                        No. de obra: <label for="idsol" id="lbloidpresup"></label><br />
                        Acción:<label for="accion" id="lblaccionpresup"></label><br />
                    </div>
                    <div class="datos" id="bodypresup">
                        <label for="name"> Programa || Descripción || Costo_Mto._Lineal || Costo_Total_Obra
                        </label><br />
                        <select name="programa" id="lstprogs"></select><br /><br />
                        <label for="name">Gastos_Admvos:</label><input type="text" name="gastosadmvos"
                            id="txtgtosadmvos" size="10" /><br /><br />
                        <label for="name">Folio_Calidad:</label><input type="text" name="foliocalidad"
                            id="txtfoliocalidad" size="10" /><br /><br />
                        <label for="name">mts2_arroyo:</label><input type="text" name="mts2arroyo" id="txtmts2arroyo"
                            size="10" /><br /><br />
                        <label for="name">mts2_banqueta:</label><input type="text" name="mts2banqueta"
                            id="txtmts2banqueta" size="10" /><br /><br />
                        <label for="name">Derrama_Vecinos:</label><input type="text" name="derramavecinos"
                            id="txtderramavecinos" size="10" /><br /><br />
                        <label for="name">Derrama_EU:</label><input type="text" name="derramaeu" id="txtderramaeu"
                            size="10" /><br /><br />
                        <label for="name">Metros_Arroyo:</label><input type="text" name="mtsarroyo" id="txtmtsarroyo"
                            size="10" /><br /><br />
                        <label for="name">Metros_Banqueta:</label><input type="text" name="mtsbanqueta" id="txtbanqueta"
                            size="10" /><br /><br />
                        <label for="name">Metros_Sección:</label><input type="text" name="mtsseccion" id="txtmtsseccion"
                            size="10" /><br /><br />
                        <label for="name">*Costo metro lineal.:</label><input type="text" name="costomtolineal"
                            id="txtcostomtolineal" size="10" /><br /><br />
                        <label for="name">*Costo de Obra Total:</label><input type="text" name="costoobratotal"
                            id="txtctoobratotal" size="15" /><br /><br />
                        <label for="name">*Programa:</label><select name="programa"
                            id="lstprograma"></select><br /><br />
                        <label for="name">*Documento:</label><input type="file" id="filepresup" name="file" /> <a
                            href="#" id="archivopresup" class="verarchivo" />
                    </div>
                    <div class="botonesA" id="botonesC">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_presup">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_presup">Cancelar</a></p>
                    </div>
                </div>
                <div id="dialogoconv" class="window">
                    <div id="tituloconv">
                        <p style="text-align:center">GESTION DE CONVENIO</p>
                        fid: <label for="fid" id="lblfidconv"></label><br />
                        pid: <label for="pid" id="lblpidconv"></label><br />
                        oid: <label for="oid" id="lbloidconv"></label><br /><br />
                        Nombre Cooperador:<label for="idconv" id="lblnomcoopconv"></label><br /><br />
                        Calle:<label for="calle" id="lblcalleconv"></label>&nbsp&nbsp<label for="nooficial"
                            id="lblnooficialconv"></label><br />
                        Colonia:<label for="colonia" id="lblcolconv"></label><br />
                        Tramo:<label for="tramo" id="lbltramoconv"></label><br /><br />
                        Cta_Predial:<label for="tramo" id="lblctapredialconv"></label><br />
                        Programa:<label for="progconv" id="lblprogconv"></label><br />
                        Mts_Frente:<label for="mtsfte" id="lblmtsfteconv"></label><br />
                        Costo del Mto:<label for="costomto" id="lblcostomto"></label><br />
                        Factor Act:<label for="factoractconv" id="factoractconv"></label><br />
                        Acción:<label for="accion" id="accionconvenio"></label><br />

                    </div>
                    <div class="datos" id="bodyconvenio">
                        <label for="name">Convenio celebrado el día:</label><label id="lblfecconv"></label><br /><br />
                        <label for="name">*Número de pagos:</label><input type="number" id="txtnumpagosconv" min="1"
                            max="18"
                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value > 18) this.value = 18; calculafecvencconv(this.value) "
                            maxLength="2" /><label id="pagomensual"></label><br /><br />
                        <label for="name">*Fecha de vencimiento:</label><label id="lblfecvencconv"></label><br /><br />
                        <label for="name">*Convenio firmado:</label><input type="file" id="fileconvenio" name="file" />
                        <a href="#" id="aconvenio" class="verconvenio" /><br />
                        <table>
                            <tr>
                                <th></th>
                                <th></th>
                                <th>MONTOS</th>
                                <th></th>
                            </tr>
                            <tr>
                                <td class="auto-style100">Saldo antes de recargos:</td>
                                <td class="auto-style102"><label id="lblsaldoantesrecargos"></label></td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"></td>
                            </tr>
                            <tr>
                                <td class="auto-style100">Recargos:</td>
                                <td class="auto-style102"><label id="lblrecargosconv"></label></td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"></td>
                            </tr>
                            <tr>
                                <td class="auto-style100">Descuento sobre recargos:</td>
                                <td class="auto-style100"></td>
                                <td class="auto-style101"><label id="lbldctorecargos"></label></td>
                                <td class="auto-style100"><input type="number" id="txtdesctorecargo" min="1" max="50"
                                        oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value > 50) this.value = 50; calculadesctorecargo(this.value) "
                                        maxLength="2" />&nbsp&nbsp%</td>
                            </tr>
                            <tr>
                                <td class="auto-style100">Recargo por convenio:</td>
                                <td class="auto-style102"><label id="lblrecargoconv"></label></td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"><input type="number" id="txtrecargoconv" min="1" max="5"
                                        oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value > 5) this.value = 1.13; calcularecargoconv(this.value) "
                                        maxLength="4" />&nbsp&nbsp%</td>
                            </tr>
                            <tr>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"></td>
                            </tr>
                            <tr>
                                <td class="auto-style100">Saldo:</td>
                                <td class="auto-style100"></td>
                                <td class="auto-style100"><label id="lblsaldo"></label></td>
                                <td class="auto-style100"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="botonesA" id="botonesconv">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_convenio">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_convenio">Cancelar</a></p>
                    </div>
                </div>

                <div id="mask"></div>
                <div id="bodegadatos"></div>
            </div>
        </asp:Content>