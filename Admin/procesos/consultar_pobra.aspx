<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_pobra.aspx.vb" Inherits="Admin_procesos_consultar_pobra" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" language="JavaScript">

    function UbicacionOID(oid) {
        //alert(img);
        var url1 = "./UbicObra.html?ResponseType=Edit&oid=" + oid;
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
        var oid = $.trim($("#txtoid").val());
        var nomcalle=$.trim($("#txtnomcalle").val());
        var nomcolonia=$.trim($("#txtcolonia").val());
        var nomtramo = $.trim($("#txttramo").val());

        if (oid.length <= 0 || oid.length > 10 || !$.isNumeric(oid)) {
            oid = '0';
        }              
        if (nomcalle.length <= 0 || nomcalle.length > 50) {
            nomcalle = '';
        }        
        if (nomcolonia.length <= 0 || nomcolonia.length > 50) {
            nomcolonia = '';
        }
        if (nomtramo.length <= 0 || nomtramo.lenght > 50) {
            nomtramo='';
        }

        var filtro = oid + "," + nomcalle + "," + nomcolonia + "," + nomtramo + ',';
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



    function Buscar_pobra() {



        var filtro = ObtenerFiltro();
        var filtro2;

        if ($("#grid")[0].grid) {
            $.jgrid.gridUnload("#grid");
            //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
        }

        $("#grid").jqGrid(
         {
             datatype: function () {
                 $.ajax(
                   {
                       url: "../../WebServices/WebServicePobra.asmx/GetPobra_psql", //PageMethod
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
                 id: "oid"
             },
             colModel: [
              {
                  index: 'oid', width: 120, align: 'center',
                  name: 'oid'
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
                  index: 'limite1', width: 220, align: 'center',
                  name: 'LIMITE1'
              },
              {
                  index: 'limite2', width: 220, align: 'center',
                  name: 'LIMITE2'
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
             sortname: "oid", //login SortColumn
             sortorder: "asc", //login SortOrder.
             width: "1900",
             height: "800",
             caption: "POLIGONOS DE OBRA",
             subGrid: true,
             subGridBeforeExpand: function (subgrid_id, row_id) {
                 var myGrid = $('#grid');
                 obra = myGrid.jqGrid('getRowData', row_id);                                  
                 filtro2= '0,,' + obra.oid.toString() + ',';
                 var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                 var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                 idusu = arrusuario[2];
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
                                     url: "../../WebServices/WebServiceObras.asmx/GetObra_psql", //PageMethod
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
                                id: "oid"
                            },
                           colModel: [                               
                                     {
                                        index: 'obr_clv_int', width: 200, align: 'center',
                                        name: 'ClvObra_SGPFIDOC'
                                     },
                                     {
                                        index: 'obr_clv2', width: 250, align: 'center',
                                        name: 'Obra_SIFIDOC'
                                     },
                                     {
                                        index: 'calle', width: 300, align: 'center',
                                        name: 'Calle', hidden: true
                                     },
                                     {
                                        index: 'colonia', width: 300, align: 'center',
                                        name: 'Colonia', hidden: true
                                     },
                                     {
                                        index: 'tramo', width: 500, align: 'Center',
                                        name: 'Tramo', hidden: true
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
                                        name: 'EvidPub1_aux', hidden: true
                                     },
                                     {
                                        index: 'evid_pub1', width: 200, align: 'center',
                                        name: 'EvidPub1', formatter: function (cellvalue) {
                                            var archivo = cellvalue;
                                            var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                            return url;
                                        }
                                     },
                                     {
                                        index: 'obr_fec_pub2', width: 160, align: 'center',
                                        name: 'FecPub2'
                                     },
                                     {
                                        index: 'evid_pub2', width: 200, align: 'center',
                                        name: 'EvidPub2_aux', hidden: true
                                     },
                                     {
                                        index: 'evid_pub2', width: 200, align: 'center',
                                        name: 'EvidPub2', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                        }
                                     },
                                     {
                                        index: 'obr_fecinip', width: 160, align: 'center',
                                        name: 'FecIniPag', hidden: true
                                     },
                                     {
                                        index: 'obr_fecvenp', width: 160, align: 'center',
                                        name: 'FecVenP', hidden: true
                                     },
                                     {
                                        index: 'obr_npago', width: 80, align: 'center',
                                        name: 'NumPagos', hidden: true
                                     },
                                     {
                                         ndex: 'obr_fec_ini_proc', width: 160, align: 'center',
                                         name: 'FecIniProc', hidden: true
                                     },
                                     {
                                         index: 'evid_obra_proc', width: 200, align: 'center',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                         name: 'EvidObrProc_aux', hidden: true
                                     },
                                     {
                                        index: 'evid_obra_proc', width: 200, align: 'center',
                                        name: 'EvidObrProc', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                        return url;
                                        }
                                     },
                                     {
                                        index: 'obr_fec_ini_cob', width: 160, align: 'center',
                                        name: 'FecIniCob', hidden: true
                                     },
                                     {
                                        index: 'evid_termino_obra', width: 200, align: 'center',
                                        name: 'EvidTermObr_aux', hidden: true
                                     },
                                     {
                                        index: 'evid_termino_obra', width: 200, align: 'center',
                                        name: 'EvidTermObr', formatter: function (cellvalue) {
                                        var archivo = cellvalue;
                                        var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                                return url;
                                            }
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
                                        index: 'gastos_admvos', width: 300, align: 'center',
                                        name: 'GastosAdmvos', hidden: true
                                     },
                                     {
                                        index: 'oid', width: 80, align: 'Center',
                                        name: 'oid', hidden: true
                                     },
                                     {
                                        index: 'geom', width:   300, align: 'Center',
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
                           caption: "OBRAS"
                       }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                       
                         /*  .navButtonAdd("#" + pager_id,
                                  {
                                      caption: "ActPagos",
                                      buttonicon: "ui-icon-document",
                                      onClickButton: function () {
                                          var myGrid = $("#" + subgrid_table_id);
                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                          var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                          var coo_clv = myGrid.jqGrid('getCell', selectedRowId, 'coopid');
                                          var obr_clv_txt = obra.obr_clv;

                                          if (fid) {

                                              ActualizacionPagosCoop(fid, obra.ClvObra, obr_clv_txt, coo_clv, idusu);
                                          }
                                          else {
                                              alert('Es necesario que selecciones un cooperador')
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
                        caption: "Ubic",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            var myGrid = $('#grid');
                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');

                            UbicacionOID(oid);
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
       


        $(".buscar_pobra").click(function () {           
            Buscar_pobra();
        });


    });

 
</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
    <div id="bodegadatos"></div>
         
<label>Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px" maxlength ="120"/><br/><br/>
<label>Colonia:</label><input type="text" name="calle" id="txtcolonia" style="width:250px" maxlength ="120"/><br/><br/>
<label>Tramo:</label><input type="text" name="calle" id="txttramo" style="width:250px" maxlength ="120"/><br/><br/>
<label>OID_Obra:</label><input type="text" name="obra" id="txtoid" style="width:250px" maxlength="10"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_pobra"><== Buscar Polígono de Obra ==></a><br/><br/>
 
<table id="grid"></table>
<div id="pager"></div>&nbsp       
 
<div id="boxes">
    <div id="mask"></div>
 </div>
</asp:Content>




