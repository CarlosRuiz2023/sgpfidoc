<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_calle_du.aspx.vb" Inherits="Admin_procesos_consultar_calle_du" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script type="text/javascript" language="JavaScript">

                function UbicacionCalleDU(clavecalle) {
                    //alert(img);
                    var url1 = "./UbicCalleDU.html?ResponseType=Edit&clavecalle=" + clavecalle;
                    newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
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
                    var fecvenc = ConvertirCadenaToFecha($("#txtfecinipag").val());
                    if (fecvenc > ConvertirCadenaToFecha('01/01/1900')) {
                        fecvenc.setMonth(fecvenc.getMonth() + parseInt(obr_npago));
                        obr_fecvenp = CompletaCerosIzq(fecvenc.getDate(), 2) + "/" + CompletaCerosIzq(fecvenc.getMonth(), 2) + "/" + CompletaCerosIzq(fecvenc.getFullYear());  //Fecha de vencimiento de pagos
                    }
                    else {
                        obr_fecvenp = '01/01/1900';  //Fecha de vencimiento de pagos
                    }
                    $("#lblfecvenc").html(obr_fecvenp);
                    $("#lblfecvenc").css("background", "white");
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



                function RedibujarGrid() {
                    //    jQuery("#grid").jqGrid('setGridParam',
                    //        {
                    //          datatype: function () { ObtenerDatos(ObtenerFiltro()) }                
                    //        })
                    //.trigger("reloadGrid");
                    $("#grid").trigger("reloadGrid");
                }




                function ObtenerFiltro() {
                    var nomcalle = $.trim($('#txtnomcalle').val());
                    if (nomcalle.length <= 0 || nomcalle.length > 30) {
                        nomcalle = '';
                    }

                    var nomcalle_ant = $.trim($('#txtnomcalle_ant').val());
                    if (nomcalle_ant.length <= 0 || nomcalle_ant.length > 30) {
                        nomcalle_ant = '';
                    }

                    var nomcolonia = $.trim($('#txtnom_colonia').val());
                    if (nomcolonia.length <= 0 || nomcolonia.length > 30) {
                        nomcolonia = '';
                    }

                    var filtro = nomcalle + "," + nomcalle_ant + "," + nomcolonia + ",";
                    return filtro;
                }



                function Buscar_calle(filtro) {


                    if ($("#grid")[0].grid) {
                        $.jgrid.gridUnload("#grid");
                        //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
                    }

                    $("#grid").jqGrid(
                        {
                            datatype: function () {
                                $.ajax(
                                    {
                                        url: "../../WebServices/WebServiceCalleDU.asmx/GetCalleDU_Grid", //PageMethod
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
                                id: "id"
                            },
                            colModel: [
                                {
                                    index: 'id', width: 100, align: 'center',
                                    name: 'id', hidden: true
                                },
                                {
                                    index: 'objectid', width: 200, align: 'center',
                                    name: 'Objectid', hidden: true
                                },
                                {
                                    index: 'clavecalle', width: 200, align: 'center',
                                    name: 'ClaveCalle'
                                },
                                {
                                    index: 'nomactual', width: 800, align: 'Center',
                                    name: 'NombreActual'
                                },
                                {
                                    index: 'nomanterior', width: 800, align: 'center',
                                    name: 'NombreAnterior'
                                },
                                {
                                    index: 'tipo', width: 220, align: 'center',
                                    name: 'TipoCalle', hidden: true
                                },
                                {
                                    index: 'clasificac', width: 220, align: 'center',
                                    name: 'Clasificacion'
                                },
                                {
                                    index: 'sector', width: 220, align: 'center',
                                    name: 'Sector', hidden: true
                                },
                                {
                                    index: 'subsector', width: 220, align: 'center',
                                    name: 'SubSector', hidden: true
                                },
                                {
                                    index: 'sectorsub', width: 220, align: 'center',
                                    name: 'SectorSub', hidden: true
                                },
                                {
                                    index: 'colonia', width: 800, align: 'center',
                                    name: 'Colonia'
                                },
                                {
                                    index: 'colindacon', width: 220, align: 'center',
                                    name: 'ColindanciaCalle', hidden: true
                                },
                                {
                                    index: 'sectorsubc', width: 220, align: 'center',
                                    name: 'SectorSubC', hidden: true
                                },
                                {
                                    index: 'jerarquia', width: 220, align: 'center',
                                    name: 'Jerarquia', hidden: true
                                },
                                {
                                    index: 'inicia_jer', width: 220, align: 'center',
                                    name: 'Jerarquia Inicial', hidden: true
                                },
                                {
                                    index: 'termina_je', width: 220, align: 'center',
                                    name: 'Jerarquia Final', hidden: true
                                },
                                {
                                    index: 'corredor', width: 220, align: 'center',
                                    name: 'Corredor', hidden: true
                                },
                                {
                                    index: 'actualizac', width: 220, align: 'center',
                                    name: 'Actualización', hidden: true
                                },
                                {
                                    index: 'observacio', width: 600, align: 'center',
                                    name: 'Observaciones'
                                },
                                {
                                    index: 'shape_leng', width: 220, align: 'center',
                                    name: 'Shape_Leng', hidden: true
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
                            sortname: "id", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1900",
                            height: "800",
                            caption: "CATALAGO DE CALLES DU"
                        }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

                        .navButtonAdd('#pager',
                            {
                                caption: "Ubic",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var clavecalle = myGrid.jqGrid('getCell', selectedRowId, 'ClaveCalle');

                                    if (clavecalle) {

                                        UbicacionCalleDU(clavecalle);
                                    } else {

                                        alert('Selecciona una calle del catálogo...')
                                    }


                                },
                                position: "last",
                                title: "Alta de Obra",
                                cursor: "pointer"
                            })

                }







                //// FUNCION PRINCIPAL

                $(document).ready(function () {

                    var usuario = $("#lblUsuario").html();
                    $("#bodegadatos").data("idusu", usuario.split(":")[1] + ":" + usuario.split(":")[2]);



                    $(".buscar_calle").click(function () {
                        Buscar_calle(ObtenerFiltro());
                    });


                });


            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="bodegadatos"></div>

            <label>Nombre de Calle:</label><input type="text" name="nom_calle" id="txtnomcalle" style="width:250px"
                maxlength="30" /><br /><br />
            <label>Nombre Anterior de Calle:</label><input type="text" name="nom_calle_anterior" id="txtnomcalle_ant"
                style="width:250px" maxlength="30" /><br /><br />
            <label>Nombre Colonia:</label><input type="text" name="nom_colonia" id="txtnom_colonia" style="width:250px"
                maxlength="30" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_calle">
                <== Buscar Nombre(s)==>
            </a><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp

            <div id="boxes">
                <div id="mask"></div>
            </div>
        </asp:Content>