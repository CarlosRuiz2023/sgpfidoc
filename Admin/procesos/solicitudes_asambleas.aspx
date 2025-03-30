<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="solicitudes_asambleas.aspx.vb" Inherits="Admin_procesos_solicitudes_asambleas" %>
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


                function ObtenerFiltro() {
                    var nomcalle = $('#txtnomcalle').val();
                    if (nomcalle.length <= 0 || nomcalle.length > 20) {
                        nomcalle = "";
                    }
                    var idsol = $('#txtidsol').val();
                    if (idsol.length <= 0 || !$.isNumeric(idsol)) {
                        idsol = "0";
                    }
                    var filtro = idsol + "," + nomcalle;
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



                function ObtenerDatos(filtro, EstatusSolicitud, EstatusFactib, EstatusAnuencia) {
                    $.ajax(
                        {
                            url: "../../WebServices/WebServiceSolic.asmx/GetSolicitudesAnuPresup", //PageMethod
                            data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                                "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                                "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                                "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                                "','pFiltro':'" + filtro +
                                "','pEstatusSolicitud':'" + EstatusSolicitud +
                                "','pEstatusFactib':'" + EstatusFactib +
                                "','pEstatusAnuencia':'" + EstatusAnuencia + "'}", //PageMethod Parametros de entrada
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






                //// FUNCION PRINCIPAL

                $(document).ready(function () {


                    /*$('#verdcto').click(function () {
                        var nom_archivo = $('#verdcto').val();
                        leerArchivo(nom_archivo);                
                    });*/
                    var idsolicitud, idfact, idusu, idanu; /*Variables para enviar a la pagina de captura de cooperadores*/
                    var lastSel;
                    var band_grid2 = 0;
                    $("#grid").jqGrid(
                        {
                            datatype: function () { ObtenerDatos(ObtenerFiltro(), "3", "1,3", "6") },
                            jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                            {
                                root: "Items",
                                page: "CurrentPage",
                                total: "PageCount",
                                records: "RecordCount",
                                repeatitems: true,
                                cell: "row",
                                id: "idsol"
                            },
                            colModel: [
                                {
                                    index: 'idsol', width: 50, align: 'Right',
                                    name: 'idsol'
                                },
                                {
                                    index: 'mSolFecha', width: 110, align: 'Center',
                                    name: 'FechaSolicitud'
                                },
                                {
                                    index: 'mSolNombre', width: 300, align: 'Center',
                                    name: 'Nom. Solicitante'
                                },
                                {
                                    index: 'mSolCalle', width: 350, align: 'center',
                                    name: 'Calle'
                                },
                                {
                                    index: 'mSolColonia', width: 300, align: 'center',
                                    name: 'Colonia'
                                },
                                {
                                    index: 'mSolTramo', width: 380, align: 'center',
                                    name: 'Tramo'
                                },
                                {
                                    index: 'cEstDescripcion', width: 100, align: 'center',
                                    name: 'Est.Solicitud'
                                },
                                {
                                    index: 'ubic', width: 50, align: 'center',
                                    name: 'Ubic'
                                },
                                {
                                    //index: 'mSolSECFNO', width: 70, align: 'center',
                                    //name: 'CveSector'
                                    index: 'UsuCre', width: 220, align: 'center',
                                    name: 'Usu_Crea'
                                },
                                {
                                    //index: 'mSolSSCFNO', width: 70, align: 'center',
                                    //name: 'CveSubSector'
                                    index: 'FechaCre', width: 135, align: 'center',
                                    name: 'Fec_Crea'
                                },
                                {
                                    //index: 'mSolCLACNO', width: 70, align: 'center',
                                    //name: 'CveCalle'
                                    index: 'UsuModif', width: 220, align: 'center',
                                    name: 'Usu_Modif'
                                },
                                {
                                    //index: 'Calle', width: 440, align: 'center',
                                    //name: 'Calle'
                                    index: 'FechaMod', width: 135, align: 'center',
                                    name: 'Fec_Modif'
                                },
                                {

                                    index: 'MetrosLong', width: 80, align: 'center',
                                    name: 'Metros Capt.'
                                },
                                {
                                    index: 'PorcentajeCapt', width: 220, align: 'center',
                                    name: '% MetrosCapt.'
                                },
                                {
                                    //index: 'Calle', width: 440, align: 'center',
                                    //name: 'Calle'
                                    index: 'NumDocs', width: 135, align: 'center',
                                    name: 'No. Levs.'
                                }
                            ],
                            pager: "#pager", //Pager.                 
                            loadtext: 'Cargando datos...',
                            recordtext: "{0} - {1} de {2} elementos",
                            emptyrecords: 'No hay resultados',
                            pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                            rowNum: "12", // PageSize.
                            rowList: [4, 8, 12], //Variable PageSize DropDownList. 
                            viewrecords: true, //Show the RecordCount in the pager.
                            multiselect: false,
                            sortname: "c.msolid", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1900",
                            height: "600",
                            caption: "SOLICITUDES DE PAVIMENTACION DE CALLES (ANUENCIAS-PRESUPUESTOS)",
                            subGrid: true,
                            subGridBeforeExpand: function (subgrid_id, row_id) {
                                var myGrid = $('#grid');
                                var solicitud = myGrid.jqGrid('getRowData', row_id);;
                                idsolicitud = solicitud.idsol;
                                idfact = solicitud.ubic;
                                var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                                var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                                idusu = arrusuario[2];
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
                                                    url: "../../WebServices/WebServicePresup.asmx/GetPresupuestos", //PageMethod
                                                    data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                                        "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                                        "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                                        "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                                        "','idsol':'" + parseInt(solicitud.idsol) + "'}", //PageMethod Parametros de entrada
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
                                            id: "idsol"
                                        },
                                        colModel: [{
                                            index: 'idsol', width: 15, align: 'Center',
                                            name: 'IdSol'
                                        },
                                        {
                                            index: 'idpresupr', width: 15, align: 'Center',
                                            name: 'prid'
                                        },
                                        {
                                            index: 'progidr', width: 15, align: 'Center',
                                            name: 'Programa', formatter: function (cellvalue) {
                                                var idprograma;
                                                if (cellvalue == 11) {
                                                    idprograma = '60-40';
                                                }
                                                if (cellvalue == 12) {
                                                    idprograma = '20-80';
                                                }
                                                if (cellvalue == 13) {
                                                    idprograma = '80-20';
                                                }
                                                if (cellvalue == 14) {
                                                    idprograma = '70-30';
                                                }
                                                return idprograma;
                                            }
                                        },
                                        {
                                            name: 'Archivo', index: 'dctor', width: 80, align: 'center', editable: false, sortable: false, formatter: function (cellvalue) {
                                                var archivo = cellvalue;
                                                if (archivo == '0') {
                                                    archivo = '';
                                                }
                                                var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                                return url;
                                            }
                                        },
                                        {
                                            index: 'costomtolinealr', width: 40, align: 'center',
                                            name: 'CostoMtoLin'
                                        },
                                        {
                                            index: 'mtsseccionr', width: 40, align: 'center',
                                            name: 'Mts.Sección'
                                        },
                                        {
                                            index: 'mtsbanquetar', width: 40, align: 'center',
                                            name: 'Mts.Banqueta'
                                        },
                                        {
                                            index: 'mts2banquetar', width: 40, align: 'center',
                                            name: 'Mts2Banqueta'
                                        },
                                        {
                                            index: 'mtsarroyor', width: 40, align: 'center',
                                            name: 'Mts.Arroyo'
                                        },
                                        {
                                            index: 'mts2arroyor', width: 40, align: 'center',
                                            name: 'Mts2Arroyo'
                                        },
                                        {
                                            index: 'gastosadmvosr', width: 40, align: 'center',
                                            name: 'GastosAdmvos'
                                        },
                                        {
                                            index: 'derramavecinosr', width: 40, align: 'center',
                                            name: 'DerramaVec.'
                                        },
                                        {
                                            index: 'derramaeur', width: 40, align: 'center',
                                            name: 'DerramaEU'
                                        },
                                        {
                                            index: 'estatuspresupr', width: 40, align: 'center', formatter: function (cellvalue) {
                                                var estatuspresup;
                                                if (cellvalue == 1) {
                                                    estatuspresup = 'CREADO';
                                                }
                                                if (cellvalue == 2) {
                                                    estatuspresup = 'PROPUESTO';
                                                }
                                                if (cellvalue == 3) {
                                                    estatuspresup = 'ACEPTADO';
                                                }
                                                if (cellvalue == 4) {
                                                    estatuspresup = 'RECHAZADO';
                                                }
                                                if (cellvalue == 5) {
                                                    estatuspresup = 'ELIMINADO';
                                                }
                                                return estatuspresup;
                                            },
                                            name: 'EstPresup'
                                        },
                                        {
                                            index: 'folior', width: 40, align: 'center',
                                            name: 'Folio'
                                        },
                                        {
                                            index: 'usucrer', width: 40, align: 'center',
                                            name: 'UsuCre'
                                        },
                                        {
                                            index: 'feccrer', width: 30, align: 'center', name: 'Fecha Registro', formatter: function (cellvalue) {
                                                var fecha = cellvalue;
                                                if (fecha == '01/01/1900') {
                                                    fecha = '';
                                                }
                                                return fecha;
                                            }
                                        },
                                        {
                                            index: 'UsrMod', width: 40, align: 'center',
                                            name: 'Usu_Mod'
                                        },
                                        {
                                            index: 'fecmodr', width: 30, align: 'center', name: 'Fecha Modif.', formatter: function (cellvalue) {
                                                var fecha = cellvalue;
                                                if (fecha == '01/01/1900') {
                                                    fecha = '';
                                                }
                                                return fecha;
                                            }
                                        },
                                        {
                                            index: 'oid', width: 40, align: 'center',
                                            name: 'oid'
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
                                        sortname: "idsol", //login SortColumn
                                        sortorder: "asc", //login SortOrder.
                                        width: "1800",
                                        height: "100%",
                                        caption: "PRESUPUESTOS"
                                    }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Editar presupuesto...",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                var idsol_sel = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                                var estatus_presup_sel = myGrid.jqGrid('getCell', selectedRowId, 'EstPresup');
                                                var idpresup_sel = myGrid.jqGrid('getCell', selectedRowId, 'prid');
                                                if (idsol_sel) {
                                                    if (estatus_presup_sel == 'CREADO') {
                                                        AccionRegistroPresup(idsol_sel, idpresup_sel, 1)
                                                    }
                                                    else {
                                                        alert("El presupuesto se encuentra en un estatus que no puede ser editado.")
                                                    }
                                                }
                                                else {
                                                    alert("No existen presupuestos capturados o selecciona un registro para modificar...");
                                                }
                                            },
                                            position: "last",
                                            title: "Revisar presupuesto",
                                            cursor: "pointer"
                                        })

                                    .navButtonAdd("#" + pager_id,
                                        {
                                            caption: "Eliminar presupuesto",
                                            buttonicon: "ui-icon-document",
                                            onClickButton: function () {
                                                var myGrid = $("#" + subgrid_table_id);
                                                selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                                cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                                if (cellValue) {
                                                    SolicitarPresupuesto(cellValue);
                                                }
                                                else {
                                                    alert("Selecciona un registro de anuencia...");
                                                }
                                            },
                                            position: "last",
                                            title: "Solicitar presupuesto",
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
                                caption: "Alta Presup",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $('#grid');
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                                    if (cellValue) {
                                        AccionRegistroPresup(cellValue, 0, 0);
                                    }
                                    else {
                                        alert("Selecciona una solicitud...");
                                    }
                                },
                                position: "last",
                                title: "Alta de Presupuesto",
                                cursor: "pointer"
                            });



                    $(".posicion_boton_accion_presup").click(function (e) { //Actualizar datos en el registro            
                        e.preventlogin();

                        var idsol = $("#lblidsol").html();
                        var idpresup = $("#lblidpresup").html();
                        var accion = parseInt($("#lblaccionpresup").html());

                        ValidarRegistroPresupuesto(idsol, idpresup, accion)

                    });
                    /*         if (accion == -1) {
                                 estanu = 5;
                                 InsertarRegPresup(idsol, idanu, folioanu, fecenvio, fecrecibo, nomprom, domprom, telprom, promfidoc, estanu, usuario, hoy, usuario, hoy, accion, nomarchivo)
                                 .done(function (r) {
                                     alert("Presupuesto cancelado");
                                     $('#mask, .window').hide();
                                     RedibujarGrid();
                                 })
                                 .fail(function (x) {
                                     alert("No es posible cancelar el presupuesto...");
                                 });
                             }
                             else { /*accion in (0,1,2)*/
                    /*                    var idprog = parseInt($("#lstprograma option:selected").val());
                                        var idpresup = $("#lblidpresup").html();
                                        var costo_mto_lineal = $("#txtcostomtolineal").val();
                                        var mts_secc = $("#txtmtsseccion").val();
                                        var mts_banqueta = $("#txtmtsbanqueta").val();
                                        var mts_arroyo = $("#txtmtsarroyo").val();
                                        var gastos = $("#txtgastosadmvos").val();
                                        var folio = $("#txtfolio").val();
                                        var mts2_banqueta = $("#txtmts2banqueta").val();
                                        var mts2_arroyo = $("#txtmts2arroyo").val();
                                        var derrama_vec = $("#txtderramavecinos").val();
                                        var derrama_eu = $("#txtderramaeu").val();
                                        
                                        var archivo = $("#filepresup").get(0).files;
                                        var hayarchivo = archivo.length;
                                        /*(costo_mto_lineal,dcto_presup,idprog,mts_secc,mts_banqueta,mts_arroyo,gastos_admmvos,folio_calidad,mts2_banqueta,mts2_arroyo,derrama_vecinos,derrama_eu,estatus_presup,solid,prid,usucre,fec_cre,usumod,fec_mod,oid)*/
                    /*                  InsertarRegPresup(costo_mto_lineal,"", idprog, mts_secc, mts_banqueta, mts_arroyo, gastos, folio, mts2_banqueta, mts2_arroyo, derrama_vec, derrama_eu, 0, idsol, usuario, hoy, usuario, hoy, 0,accion)
                                           .done(function (r) {
                                               if (hayarchivo > 0) {  /*Si hay archivo capturado guardar el documento*/
                    /*                               var respWebServicePresup = r.d;
                                                   var arridpresup = respWebServicePresup.split(":");
                                                   var idpresup = parseInt(arridpresup[1]);  
                                                   var nomarchivo = idsol + '_' + idpresup + "_PRESUP.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                    /*                               InsertaRegDcto(idsol, 0, idpresup, folio, hoy, hoy, usurec, nomarchivo, 8, usuario, hoy, usuario, hoy, archivo, accion)                                        
                                               }                             
                                               $('#mask, .window').hide();
                                               RedibujarGrid();
                                           })
                                           .fail(function (x) {
                                               alert("No es posible guardar el presupuesto...");
                                           });
                                  }
                  
                              }
                          });*/

                    function ValidarRegistroPresupuesto(idsol, idpresup, accion) {
                        /*var accion = parseInt($("#lblaccionpresup").html());*/
                        /*var idsol = $("#lblidsol").html();*/

                        if (validarpresup(accion)) {   /*Valida que los datos del documento sean correctos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                            /*Reunir parámetros para guardar el levantamiento capturado en el server*/

                            var hoy = new Date();
                            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                            var arrusuario = bienveusuario.split(":");
                            var usuario = arrusuario[1];
                            var usurec = arrusuario[2];
                            var idprog = parseInt($("#lstprograma option:selected").val());
                            var costo_mto_lineal = $("#txtcostomtolineal").val();
                            var mts_secc = $("#txtmtsseccion").val();
                            var mts_banqueta = $("#txtmtsbanqueta").val();
                            var mts_arroyo = $("#txtmtsarroyo").val();
                            var gastos = $("#txtgastosadmvos").val();
                            var folio = $("#txtfolio").val();
                            var mts2_banqueta = $("#txtmts2banqueta").val();
                            var mts2_arroyo = $("#txtmts2arroyo").val();
                            var derrama_vec = $("#txtderramavecinos").val();
                            var derrama_eu = $("#txtderramaeu").val();
                            var archivo = $("#filepresup").get(0).files;
                            var hayarchivo = archivo.length;

                            if (accion == 0) { /*Si la accion corresponde a dar de alta un presupuesto*/
                                var estatus_presup = 1;
                                var nomarchivo = idsol + '_' + idpresup + "_PRESUP.pdf";
                            };

                            RegistrarPresupuestoBD(costo_mto_lineal,
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
                                idsol,
                                idpresup,
                                usuario,
                                hoy,
                                usuario,
                                hoy,
                                accion)
                                .done(function (r) {
                                    if (hayarchivo > 0) {  /*Si hay archivo capturado guardar el documento*/
                                        var respWebServicePresup = r.d;
                                        var arridpresup = respWebServicePresup.split(":");
                                        var idpresup = parseInt(arridpresup[1]);
                                        if (idpresup > 0) { /*Si se guardo un */
                                            var nomarchivo = idsol + '_' + idpresup + "_PRESUP.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                                            InsertaRegDcto(idsol, 0, idpresup, folio, hoy, hoy, usurec, nomarchivo, 8, usuario, hoy, usuario, hoy, archivo, accion)
                                            $('#mask, .window').hide();
                                            RedibujarGrid();
                                        }
                                        else {
                                            alert("No se guardo el documento capturado.");
                                        }
                                    }

                                })
                                .fail(function (x) {
                                    alert("No es posible guardar el presupuesto...");
                                });
                        }
                    };

                    function RegistrarPresupuestoBD(costo_mto_lineal, nomarchivo, idprog, mts_secc, mts_banqueta, mts_arroyo, gastos, folio, mts2_banqueta, mts2_arroyo, derrama_vec, derrama_eu, estatus_presup, idsol, idpresup, usuario, hoy, usuario, hoy, accion) {

                        var enviarObj = {
                            "CostoMtoLineal": costo_mto_lineal,
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
                            "solid": idsol,
                            "UsuCre": usuario,
                            "FecCre": hoy,
                            "UsuMod": usuario,
                            "FecMod": hoy,
                            "solid": idsol,
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
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(textStatus + jqXHR + errorThrown);
                            }
                        });

                    };

                    $(".verarchivo").click(function (e) { //Ver documento                   
                        var archivo = $("#archivo").text();
                        leerArchivo(archivo);
                    });


                    $(".window .posicion_boton_cancelar_lev").click(function (e) {
                        //Cancel the link behavior
                        e.preventlogin();
                        $('#mask, .window').hide();
                    });

                    $(".window .posicion_boton_cancelar_presup").click(function (e) {
                        //Cancel the link behavior
                        e.preventlogin();
                        $('#mask, .window').hide();
                    });

                    //if mask is clicked
                    $('#mask').click(function () {
                        $(this).hide();
                        $('.window').hide();
                    });

                    $("#colonia").change(function () {
                        llenarCalles($("#colonia").val(), 0);
                    });
                });

                function leerArchivo(nom_archivo) {
                    var url = "../../temp/" + nom_archivo;
                    window.open(url, '_blank', 'toolbar=0');
                }

                function AccionRegistroPresup(idsol, idpresup, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
                    $("#lblaccionpresup").text(accion);

                    if (accion == 0) {  //Si la accion es crear un nuevo levantamiento 

                        $("#lblidsol").text(idsol);
                        //if (idlev == 0) {                
                        $("#lblidpresup").text(idpresup);

                        //}
                        //Limpieza de inputs de la interfaz
                        $("#txtfolio").val('');
                        $("#txtmtsseccion").val('');
                        $("#txtmtsbanqueta").val('');
                        $("#txtmtsarroyo").val('');
                        $("#txtgastosadmvos").val('');
                        $("#txtmts2arroyo").val('');
                        $("#txt2mtsbanqueta").val('');
                        $("#txtderramavecinos").val('');
                        $("#txtderramaeu").val('');
                        $("#txtderramavecinos").val('');
                        $("#txtestatuspresup").val('1');
                        $("#txtestatuspresup").prop('disabled', true);

                        $("#lstprograma").prop('disabled', false);
                        $("#filepresup").val("");
                        $("#archivo").text("");
                        $("#filepresup").prop('disabled', false);
                        llenarPrograma(accion, 0);

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
                                        mts2_arroyo = $(this).find("mts2_arroyo").text();
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
                                if (accion == -1) {
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
                        });
                    }
                    MostrarModalPresup();

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




                function validarpresup(accion) {

                    var valid = true;

                    if (accion == 0 || accion == 1) { /*Si el usuario escogió dar de alta un nuevo levantamiento*/

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
                            if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                valid = valid && true;
                            }
                            else {
                                alert("No se ha capturado ningún archivo digital");
                                valid = valid && false;
                            }
                        }

                        if (valid) {   /*Si es v[alido el archivo*/
                            if (accion == 0) {
                                valid = checkLength($("#txtfolio").val().length, "Folio", 1, 10);
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
                                valid = checkLength($("#txtFolioAnu").val().length, "Folio de la Anuencia", 1, 20);            /*Valida la longitud del Folio del documento*/
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
                            }
                        }
                    }

                    if (accion == -1) {
                        alert("Has seleccionado cancelar el presupuesto.");
                        valid = true;
                    }

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




                /*  function llenarUsuario(idusu) {
                      $.ajax({
                          type: "POST",
                          dataType: "json",
                          contentType: "application/json",
                          url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioCalidad",
                          data: "",
                          success: function (data) {
                              var elementos = 0;
                              $("#lstUsuario").html('');
                              $(data.d).find("UsuarioCal").each(function () {
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
                  }*/

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


            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


            <b>Nombre de Calle:<input type="text" name="Calle" id="txtnomcalle" style="width:250px" />&nbsp &nbsp No.
                Solicitud:</><input type="text" name="idsol" id="txtidsol" style="width:50px" /></b><br /><br />

            <table id="grid"></table>
            <div id="pager"></div>&nbsp

            <div id="boxes">
                <div id="dialogopresup" class="window">
                    <div id="titulopresup">
                        <p style="text-align:center">GESTIONAR PRESUPUESTO</p>
                        No. de solicitud: <label for="idsol" id="lblidsol"></label><br />
                        No. de Presupuesto: <label for="idpresup" id="lblidpresup"></label><br />
                        Acción:<label for="accion" id="lblaccionpresup"></label><br />
                    </div>
                    <div class="datos" id="bodypresup">
                        <label for="name">*Costo metro lineal.:</label><input type="text" name="costomtolineal"
                            id="txtcostomtolineal" size="10" /><br /><br />
                        <label for="name">*Programa:</label><select name="programa"
                            id="lstprograma"></select><br /><br />
                        <label for="name">*Folio:</label><input type="text" name="folio" id="txtfolio"
                            size="10" /><br /><br />
                        <label for="name">Mts_Sección:</label><input type="text" name="mtsseccion" id="txtmtsseccion"
                            size="10" /><br /><br />
                        <label for="name">Mts_Banqueta:</label><input type="text" name="mtsbanqueta" id="txtmtsbanqueta"
                            size="10" /><br /><br />
                        <label for="name">Mts_Arroyo:</label><input type="text" name="mtsarroyo" id="txtmtsarroyo"
                            size="10" /><br /><br />
                        <label for="name">Gastos Admvos.:</label><input type="text" name="gastosadmvos"
                            id="txtgastosadmvos" size="10" /><br /><br />
                        <label for="name">Mts2_Arroyo:</label><input type="text" name="mts2arroyo" id="txtmts2arroyo"
                            size="10" /><br /><br />
                        <label for="name">Mts2_Banqueta:</label><input type="text" name="mts2banqueta"
                            id="txtmts2banqueta" size="10" /><br /><br />
                        <label for="name">*Derrama_Vecinos:</label><input type="text" name="derramavecinos"
                            id="txtderramavecinos" size="10" /><br /><br />
                        <label for="name">*Derrama_EU:</label><input type="text" name="derramaeu" id="txtderramaeu"
                            size="10" /><br /><br />
                        <label for="name">Estatus presup.:</label><input type="text" name="estatuspresup"
                            id="txtestatuspresup" size="2" /><br /><br />
                        <label for="name">*Documento:</label><input type="file" id="filepresup" name="file" /> <a
                            href="#" id="archivo" class="verarchivo" />
                    </div>
                    <div class="botonesA" id="botonesC">
                        <p style="text-align:right"><a href="#"
                                class="posicion_boton_accion_presup">Aceptar</a>&nbsp&nbsp&nbsp<a href="#"
                                class="posicion_boton_cancelar_presup">Cancelar</a></p>
                    </div>
                </div>
                <div id="mask"></div>
            </div>
        </asp:Content>