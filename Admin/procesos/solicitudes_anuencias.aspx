<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="solicitudes_anuencias.aspx.vb" Inherits="Admin_procesos_solicitudes_anuencias" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
<script type="text/javascript" language="JavaScript">

   
    function CapturarCoops(idsol,idfact,idusu,idanu) {
        //alert(img);
        var url1 = "../../Procesos/coops.html?ResponseType=Edit&gid=" + idfact + "&idsol=" + idsol + "&idusu=" + idusu + "&idanu=" + idanu;
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
             url: "../../WebServices/WebServiceSolic.asmx/GetSolicitudes", //PageMethod
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
        var idsolicitud, idfact,idusu,idanu; /*Variables para enviar a la pagina de captura de cooperadores*/
        var lastSel;
        var band_grid2 = 0;
        $("#grid").jqGrid(
          {
              datatype: function () { ObtenerDatos(ObtenerFiltro(),"2,3","1,3","1,2,3,5,6") },
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
                   index: 'idsol', width: 50, align: 'right',
                   name: 'idsol'
               },
               {
                   index: 'mSolFecha', width: 110, align: 'center',
                   name: 'FechaSolicitud'
               },
               {
                   index: 'mSolNombre', width: 300, align: 'center',
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
                   name: 'ubic'
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
               }
              ],
              pager: "#pager", //Pager.                 
              loadtext: 'Cargando datos...',
              recordtext: "{0} - {1} de {2} elementos",
              emptyrecords: 'No hay resultados',
              pgtext: 'Pág: {0} de {1}', //Paging input control text format.
              rowNum: "12", // PageSize.
              rowList: [4, 8, 12], //Variable PageSize DropDownList. 
              viewrecords: true, //Show the RecordCount in the pager.
              multiselect: false,
              sortname: "idsol", //login SortColumn
              sortorder: "asc", //login SortOrder.
              width: "1900",
              height: "600",
              caption: "SOLICITUDES DE PAVIMENTACION DE CALLES (ANUENCIAS)",
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
                                var filtro = "1,2,5,6";
                                $.ajax(
                                  {
                                      url: "../../WebServices/WebServiceAnuencia.asmx/GetAnuencias", //PageMethod
                                      data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                            "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                            "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                            "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                            "','pFiltro':'" + filtro +
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
                                   index: 'mAnuId', width: 15, align: 'Center',
                                   name: 'IdAnu'
                               },
                               {
                                   index: 'mAnuNFolio', width: 15, align: 'Center',
                                   name: 'Folio'
                               },
                               {
                                   index: 'mUsuNombre', width: 80, align: 'center',
                                   name: 'Nom Prom FIDOC'
                               },
                               {
                                   index: 'mFechaEnvio', width: 30, align: 'center', name: 'FechaEnvio', formatter: function (cellvalue) {
                                       var fecha = cellvalue;
                                       if (fecha == '01/01/1900') {
                                           fecha = '';
                                       }
                                       return fecha;
                                   }
                               },
                               {
                                   index: 'mFechaRecibe', width: 30, align: 'center', name: 'FechaRecibe', formatter: function (cellvalue) {
                                       var fecha = cellvalue;
                                       if (fecha == '01/01/1900') {
                                           fecha = '';
                                       }
                                       return fecha;
                                   }
                               },                               
                               {
                                   index: 'mAnuRecibe', width: 80, align: 'center',
                                   name: 'Nom Prom Calle'
                               },                               
                               {
                                   index: 'mAnuDomicilio', width: 80, align: 'center',
                                   name: 'Domicilio'
                               },
                               {
                                   index: 'mAnuTel', width: 40, align: 'center',
                                   name: 'Tel'
                               },
                               {
                                   index: 'UsrCre', width: 40, align: 'center',
                                   name: 'UsuCre'
                               },
                               {
                                   index: 'FecCre', width: 30, align: 'center',
                                   name: 'Fec_Crea'
                               },
                               {
                                   index: 'UsrMod', width: 40, align: 'center',
                                   name: 'Usu_Mod'
                               },
                               {
                                   index: 'FecMod', width: 30, align: 'center',
                                   name: 'Fec_Mod'
                               },
                               {
                                   index: 'cEstDesc', width: 30, align: 'center',
                                   name: 'Est_Anuencia'
                               },
                               {
                                   name: 'Documento', index: 'mNomArchivo', width: 60, align: 'center', editable: false, sortable: false, formatter: function (cellvalue) {
                                       var archivo = cellvalue;
                                       if (archivo == '0') {
                                           archivo = '';
                                       }
                                       var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                       return url;
                                   }
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
                            sortname: "idsol", //login SortColumn
                            sortorder: "asc", //login SortOrder.
                            width: "1800",
                            height: "100%",
                            caption: "ANUENCIAS"
                        }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })

                          .navButtonAdd("#" + pager_id,
                              {
                                  caption: "Editar Anuencia",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                      var myGrid = $("#" + subgrid_table_id);
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdAnu');
                                      cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est_Anuencia');


                                      if (cellValue) {
                                          if (cellValue3 != 'CANCELADA') {
                                              if (cellValue3 == 'CALIDAD') {
                                                  alert("La ANUENCIA está autorizada, no puede ser editada");                                                                                                                  
                                              }
                                              else {
                                                  if (cellValue3 == 'LEVANTAMIENTO') {
                                                     alert("La ANUENCIA se encuentra en análisis, no puede ser editada");                                                                    
                                                  }
                                                  else {
                                                      AccionRegistroAnu(cellValue, cellValue2, 1);
                                                  }
                                              }
                                          }
                                          else {
                                              alert("La anuencia se encuentra CANCELADA, no puede ser editada.");                                                                    
                                          }
                                      }
                                      else {
                                          alert("No existen registros ó selecciona un registro para modificar...");
                                      }
                                  },
                                  position: "last",
                                  title: "Editar_Anuecia",
                                  cursor: "pointer"
                              })
                          .navButtonAdd("#" + pager_id,
                              {
                                  caption: "Recibir Anuencia",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                      var myGrid = $("#" + subgrid_table_id);
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdAnu');
                                      cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est_Anuencia');

                                      if (cellValue) {
                                          if (cellValue3 != 'CANCELADA') {
                                              if (cellValue3 == 'PRESUPUESTO') {
                                                  alert("La ANUENCIA ha sido recibida y se encuentra en análisis.");
                                              }
                                              else {
                                                  if (cellValue3 == 'PROMOCION') {
                                                      alert("La ANUENCIA ha sido recibida");
                                                  }
                                                  else {
                                                      if (cellValue3 == 'CALIDAD') {
                                                          alert("La ANUENCIA ha sido recibida y se encuentra autorizada para iniciar recaudación");
                                                      }
                                                      else {
                                                         AccionRegistroAnu(cellValue, cellValue2, 2); //------ Envío valor de idsol   y "accion = 1" para editar registro
                                                      }
                                                  }
                                              }
                                          }
                                          else {
                                                alert("La anuencia se encuentra CANCELADA.");                                                              
                                          }
                                      }
                                      else {
                                          alert("No existen registros ó selecciona un registro para cancelar...")
                                      }
                                  },
                                  position: "last",
                                  title: "Recibir_Anuencia",
                                  cursor: "pointer"
                              })
                          .navButtonAdd("#" + pager_id,
                              {
                                  caption: "Eliminar Anuencia",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                      var myGrid = $("#" + subgrid_table_id);
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdAnu');
                                      cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est_Anuencia');

                                      if (cellValue) {
                                          if (cellValue3 != 'CANCELADA') {
                                              if (cellValue3 == 'PRESUPUESTO' || cellValue3 == 'CALIDAD') {
                                                  alert("Las anuencias en estatus de LEVANTAMIENTO o ya autorizadas por el área de CALIDAD no pueden ser canceladas...");
                                              }
                                              else {
                                                  AccionRegistroAnu(cellValue, cellValue2, -1); //------ Envío valor de idsol   y "accion = 1" para editar registro
                                              }
                                          }
                                          else {
                                              alert("La ANUENCIA ya se encuentra CANCELADA...");
                                          }
                                      }
                                      else {
                                          alert("No existen registros ó selecciona un registro para cancelar...");
                                      }
                                  },
                                  position: "last",
                                  title: "Eliminar_Dcto",
                                  cursor: "pointer"
                              })

                          .navButtonAdd("#" + pager_id,
                              {
                                  caption: "Capturar cooperadores",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                      var idfacti;
                                      var myGrid = $("#" + subgrid_table_id);
                                      var myGridPadre = $('#grid');
                                      var column = myGridPadre.jqGrid('getRowData');
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est_Anuencia');
                                      idanu = myGrid.jqGrid('getCell', selectedRowId, 'IdAnu');
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est_Anuencia');
                                      idanu = myGrid.jqGrid('getCell', selectedRowId, 'IdAnu');
                                      
                                      if (cellValue) {
                                          for (i = 0; i <= column.length; i++) {      ///Comprueba que exista una ubicación (polígono de factibilidad) asignado
                                              if (column[i].idsol == cellValue) {
                                                  idfacti = column[i].ubic;
                                                  break;
                                              }
                                          }
                                          if (parseInt(idfact)>0) {
                                              RevisaEstatusAnuencia(idanu)
                                              .done(function (r) {
                                                  var cadena = $.trim(r.d);
                                                  if (cadena != "<NewDataSet />") {  // Si no se encontro el estatus de la anuencia.
                                                      $(r.d).find("EstatusAnu").each(function () {
                                                          var estanu = $(this).find("cEstDesc").text();
                                                          if (estanu != 'CANCELADA') {
                                                              if (estanu == 'PROMOCION') {
                                                                  CapturarCoops(idsolicitud, idfact, idusu, idanu);
                                                              }
                                                              else {
                                                                  if (estanu == 'COOPERADOR') {
                                                                      alert("La ANUENCIA se encuentra con el COOPERADOR no se ha recibido.");
                                                                  }
                                                                  else {
                                                                      if (estanu == 'PRESUPUESTO') {
                                                                          alert("La ANUENCIA se encuentra en análisis de PRESUPUESTO.");
                                                                      }
                                                                      else {
                                                                          alert("La ANUENCIA ha sido autorizada para iniciar obra en recaudación, por lo tanto, para capturar cooperadores remitase al modulo de OBRAS.");
                                                                      }
                                                                  }
                                                              }
                                                          }
                                                          else {
                                                              alert("La ANUENCIA se encuentra CANCELADA y no es posible capturar cooperadores");
                                                          }
                                                      })
                                                  }
                                                  else {
                                                      alert("La anuencia no tiene estatus asignado ");
                                                  }
                                              }).fail(function (r) {
                                                  alert("No fue posible consultar el estatus de la anuencia");
                                              });
                                          }
                                          else {
                                              alert("No es posible capturar cooperadores, asignar primeramente un polígono de factibilidad");
                                          }
                                      }
                                      else {
                                           alert("No existe anuencia seleccionada...");
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
                    caption: "Alta Anuencia",
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

             
        $(".posicion_boton_accion_anu").click(function (e) { //Actualizar datos en el registro            
            e.preventlogin();
            var accion = $("#lblaccionanu").html();
            var idsol = parseInt($("#lblsolicitud").html());
            

            if (validaranu(accion)) {   /*Valida que los datos del documento sean coreectos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                /*Reunir parámetros para guardar el registro del archivo y el archivo capturado en el server*/
                var folioanu = $("#txtFolioAnu").val();      /*Recupera folio del documento capturado*/
                var idanu = parseInt($("#lblidanu").html());
                if (isNaN(idanu)) {
                    idanu = 0;
                }
                var estanu = parseInt($("#lblestanu").html());
                if (isNaN(estanu)) {
                    estanu = 1;
                }
                var fecenvio = ConvertirCadenaToFecha($("#txtfecentrega").val());
                var fecrecibo = ConvertirCadenaToFecha($("#txtfecrecep").val());
                var nomprom = $("#txtNomProm").val();
                var domprom = $("#txtDomProm").val();
                var telprom = $("#txtTelProm").val();
                var usurec = parseInt($("#lstUsuario").val());
                var hoy = new Date();
                var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                var usuario = arrusuario[1];

                if (accion == -1) {
                    estanu = 5;
                    InsertarRegAnuencia(idsol, idanu, folioanu, fecenvio, fecrecibo, nomprom, domprom, telprom, promfidoc, estanu, usuario, hoy, usuario, hoy, accion, nomarchivo)
                    .done(function (r) {
                        alert("Anuencia cancelada");
                        $('#mask, .window').hide();
                        RedibujarGrid();
                    })
                    .fail(function (x) {
                        alert("No es posible cancelar la anuencia...");
                    });
                }
                else { /*accion in (0,1,2)*/
                    var promfidoc = parseInt($("#lstUsuario option:selected").val());
                    var iddcto = parseInt($("#lbliddcto").html());
                    if (isNaN(iddcto)) {
                        iddcto = 0;
                    }
                    var nomarchivo = idsol + '_' + idanu + "_ANU.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                    var archivo = $("#file1").get(0).files;
                    var hayarchivo = archivo.length;
                    if (accion == 2) {
                        estanu = 2;
                    }

                    InsertarRegAnuencia(idsol, idanu, folioanu, fecenvio, fecrecibo, nomprom, domprom, telprom, promfidoc, estanu, usuario, hoy, usuario, hoy, accion, nomarchivo)
                         .done(function (r) {
                             if (hayarchivo > 0) {  /*Si hay archivo capturado guardar el documento*/
                                 InsertaRegDcto(idsol, iddcto, idanu, folioanu, fecenvio, fecrecibo, usurec, nomarchivo, 4, usuario, hoy, usuario, hoy, archivo, accion)
                                        .done(function (r) { /*Si se tiene éxito al guardar la factibilidad*/
                                            alert("Archivo guardado correctamente")
                                        })
                                        .fail(function (x) {
                                            alert("No es posible guardar el documento...");
                                        });
                             }

                             $('#mask, .window').hide();
                             RedibujarGrid();
                         })
                         .fail(function (x) {
                             alert("No es posible guardar la anuencia...");
                         });
                }
                
            }
        });


        $(".verarchivo").click(function (e) { //Ver documento                   
            var archivo = $("#archivo").text();
            leerArchivo(archivo);
        });



        
        $(".window .posicion_boton_cancelar_anu").click(function (e) {
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



    function InsertarRegAnuencia(idsol, idanu, folioanu, fecentrega, fecrecibo, nomprom, domprom, telprom, promfidoc, estanu, usucre, feccre, usumod, fecmod, accion,nomarchivo) {
         
        var enviarObj = {
            "idsol": idsol,
            "idanu": idanu,
            "folio": folioanu,
            "fecentrega": fecentrega,
            "fecrecibo": fecrecibo,
            "NomPromCalle": nomprom,
            "DomicProm": domprom,
            "TelProm": telprom,
            "PromFidoc": promfidoc,
            "EstatusAnuencia": estanu,
            "usucre": usucre,
            "feccre": feccre,
            "usumod": usumod,
            "fecmod": fecmod,             
            "accion": accion,
            "docdig": nomarchivo
        }    
        
       
        var stringData = JSON.stringify(enviarObj);
         return $.ajax({
             type: 'POST',
             url: "../../WebServices/WebServiceAnuencia.asmx/ActAnuencia",
             data: "{objAnu:" + stringData + "}",
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
                "folio": folioDcto,
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

        if (accion == 0 || (accion==1 && estanu==1)) { /*Si el usuario escogió dar de alta una anuencia*/
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


        if (accion == 1 && estanu==2) {            
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


    function MostrarModalAnu() {
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
        $("#dialogoAnu").css('top', winH / 2 - $("#dialogoAnu").height() / 2);
        $("#dialogoAnu").css('left', winW / 2 - $("#dialogoAnu").width() / 2);

        //transition effect
        $("#dialogoAnu").fadeIn(2000);
    }

    function AccionRegistroAnu(idsol, idanu, accion) { // accion=0 --->nuevo anuencia; accion = 1 ---> editar anuencia, accion = -1 ----> cancelar anuencia
        $("#lblaccionanu").text(accion);

        if (accion == 0) {  //Si la accion es crear una anuencia y entregarsela al cooperador

            $("#lblsolicitud").text(idsol);

            $("#lblidanu").text('');
            $("#lbliddcto").text('');            
            $("#lblestanu").text('');
            $("#txtfecentrega").val('');
            $("#txtfecrecep").val('');           
            
            $("#txtFolioAnu").val('');
            $("#txtNomProm").val('');
            $("#txtDomProm").val('');
            $("#txtTelProm").val('');
            $("#file1").val("");
            $("#archivo").text("");
            
            $("#txtFolioAnu").prop('disabled', false);
            $("#txtfecentrega").prop('disabled', false);
            $("#txtNomProm").prop('disabled', false);
            $("#txtDomProm").prop('disabled', false);
            $("#txtTelProm").prop('disabled', false);
            $("#txtfecrecep").prop('disabled', true);
            $("#lstUsuario").prop('disabled', true);                        
            $("#file1").prop('disabled', true);                        
            llenarUsuario(0);                  
        }
        else {
              $.ajax({
                  type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceAnuencia.asmx/GetAnu",
                    data: '{idsol:' + idsol + ',idanu:' + idanu + '}',
                    success: function (data) {
                        var estanu;
                        var folioanu;
                        var fecenvio;
                        var fecrecibe;
                        var nomprom;
                        var domprom
                        var telprom;

                        var iddcto;
                        var numusuario;
                        var nom_archivo;
                        var cadena = $.trim(data.d);
                        if (cadena == "<NewDataSet />") {
                            alert("La anuencia está cancelado, por lo tanto no es posible realizar la acción solicitada.");
                        }
                        else {
                            // Data.d trae un string con el XML generado dentro del servicio web asmx
                                $(data.d).find("Anuencia").each(function () {
                                folioanu = $(this).find("mAnuNfolio").text();
                                estanu = $(this).find("mAnuEstatus").text();
                                fecenvio = $(this).find("mFechaEnvio").text();
                                fecrecibe = $(this).find("mFechaRecibe").text();
                                nomprom = $(this).find("mAnuRecibe").text();
                                domprom = $(this).find("mAnuDomicilio").text();
                                telprom = $(this).find("mAnuTel").text();
                                numusuario = parseInt($(this).find("mAnuPromotor").text());
                                iddcto = $(this).find("midDcto").text();
                                nom_archivo = $(this).find("mNomArchivo").text();
                                $("#lblidanu").text(idanu);
                                $("#txtfecentrega").val(fecenvio);
                                if ($.trim(fecrecibe) == '01/01/1900') {
                                    fecrecibe = '';
                                }
                                $("#txtfecrecep").val(fecrecibe);
                                $("#txtNomProm").val(nomprom);
                                $("#txtDomProm").val(domprom);
                                $("#txtTelProm").val(telprom);
                                $("#lblsolicitud").text(idsol);
                                if (isNaN(parseInt(iddcto))) {
                                    iddcto = 0
                                }
                                $("#lbliddcto").text(iddcto);
                                $("#lblestanu").text(estanu);
                                $("#txtFolioAnu").val(folioanu);
                                $("#archivo").text(nom_archivo);
                            });
                        }
                        if (accion == 2 ) {
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
                            if (estanu==1) {
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
                        }
                        if (accion==-1) {
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
        MostrarModalAnu();

    }
                
    


    function RevisaAnuencias(idSol) {
        return $.ajax({
            url: "../../WebServices/WebServiceSolic.asmx/RevisaAnuencias",
            data: "{'idsol':'" + idSol + "'}",
            type: "POST",
            dataType: "json",
            contentType: "application/json",
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

    function llenarEstatusAnu(accion) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceAnuencia.asmx/GetEstAnu",
            data: '{accion:' + accion + '}',            
            success: function (data) {
                var elementos = 0;
                $("#lstEstAnu").html('');
                $(data.d).find("EstatusAnu").each(function () {
                    var option = $(document.createElement('option'));
                    var idestanuencia = $(this).find("cEstId").text();
                    var descrip = $(this).find("cEstDesc").text();
                    option.html(descrip);
                    option.val(idestanuencia);
                    //Nombre de combo a poblar
                    $("#lstEstAnu").append(option);
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

    /*function llenarCalles(cvecolonia, cvecallesel) {
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
    }*/

</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
     

<b>Nombre de Calle:<input type="text" name="Calle" id="txtnomcalle" style="width:250px"/>&nbsp &nbsp No. Solicitud:</><input type="text" name="idsol" id="txtidsol" style="width:50px" /></b><br/><br/>        
  
 <table id="grid"></table>
 <div id="pager"></div>&nbsp       
 
 <div id="boxes">    
    <div id="dialogoAnu" class="window"> 
       <div id="tituloAnu"> 
         <p style="text-align:center">GESTION  DE  ANUENCIAS</p>
         No. de solicitud: <label for="idsol" id="lblsolicitud"></label><br/>
         No. de Anuencia: <label for="idanu" id="lblidanu"></label><br/>
         Estatus Anuencia: <label for="idanu" id="lblestanu"></label><br/>
         Id.Dcto: <label for="accion" id="lbliddcto"></label><br/>          
         Acción:<label for="accion" id="lblaccionanu"></label><br/> 
       </div>
       <div class="datos" id="bodyAnu">        
          <label for="name">Folio de anuencia:</label><input type="text" name="txtFolioAnu" id="txtFolioAnu" size="20"/><br/><br/>
          <label for="name">Fecha entrega:</label><input type="text" name="fecenvio" id="txtfecentrega" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/> dd/mm/aaaa<br/><br/>
          <label for="name">Fecha recepción:</label><input type="text" name="fecrecep" id="txtfecrecep" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/> dd/mm/aaaa<br/><br/>
          <label for="name">Promotor de calle:</label><input type="text" name="txtNomProm" id="txtNomProm" size="40"/><br/><br/>
          <label for="name">Domicilio promotor de calle:</label>   <input type="text" name="txtDomProm" id="txtDomProm" size="60"/><br/><br/>
          <label for="name">Teléfono de promotor de calle:</label> <input type="text" name="txtTelProm" id="txtTelProm" size="10"/><br/><br/>
          <label for="name">Promotor FIDOC:</label> <select name="Usuario" id="lstUsuario"></select><br/><br/>          
          <label for="name">Dcto. de Anuencia:</label><input type="file" id="file1" name="file"/>      <a href="#" id="archivo" class="verarchivo"/>  
       </div>                  
       <div class="botonesA" id="botonesA">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_anu">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_anu">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>


