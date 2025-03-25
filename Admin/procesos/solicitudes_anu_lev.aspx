<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="solicitudes_anu_lev.aspx.vb" Inherits="Admin_procesos_solicitudes_anu_lev" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
<script type="text/javascript" language="JavaScript">


  function CapturarCoops(idsol, idfact, idusu, idanu) {
        //alert(img);
        var url1 = "../../Procesos/coopsCalidad.html?ResponseType=Edit&gid=" + idfact + "&idsol=" + idsol + "&idusu=" + idusu + "&idanu=" + idanu;
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
             url: "../../WebServices/WebServiceSolic.asmx/GetSolicitudesAnuLev", //PageMethod
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
              pgtext: 'Pág: {0} de {1}', //Paging input control text format.
              rowNum: "12", // PageSize.
              rowList: [4, 8, 12], //Variable PageSize DropDownList. 
              viewrecords: true, //Show the RecordCount in the pager.
              multiselect: false,
              sortname: "c.mSolId", //login SortColumn
              sortorder: "asc", //login SortOrder.
              width: "1900",
              height: "600",
              caption: "SOLICITUDES DE PAVIMENTACION DE CALLES (ANUENCIAS-LEVANTAMIENTOS)",
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
                                      url: "../../WebServices/WebServiceLevant.asmx/GetLevs", //PageMethod
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
                                   index: 'mIdLevanta', width: 15, align: 'Center',
                                   name: 'IdLev'
                               },                               
                               {
                                   index: 'mFechaSolicitud', width: 30, align: 'center', name: 'FechaSolicitud', formatter: function (cellvalue) {
                                       var fecha = cellvalue;
                                       if (fecha == '01/01/1900') {
                                           fecha = '';
                                       }
                                       return fecha;
                                   }
                               },
                               {
                                   index: 'mFechaEntrega', width: 30, align: 'center', name: 'FecEntrega', formatter: function (cellvalue) {
                                       var fecha = cellvalue;
                                       if (fecha == '01/01/1900') {
                                           fecha = '';
                                       }
                                       return fecha;
                                   }
                               },
                               {
                                   index: 'mEjecutor', width: 80, align: 'center',
                                   name: 'Dibujante'
                               },
                               {
                                   index: 'mObserva', width: 80, align: 'center',
                                   name: 'Observaciones'
                               },
                               {
                                   name: 'Archivo', index: 'mImagen', width: 60, align: 'center', editable: false, sortable: false, formatter: function (cellvalue) {
                                       var archivo = cellvalue;
                                       if (archivo == '0') {
                                           archivo = '';
                                       }
                                       var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                       return url;
                                   }
                               },
                               {
                                   index: 'mMapa', width: 40, align: 'center',
                                   name: 'Mapa'
                               },
                               {
                                   index: 'UsrCre', width: 40, align: 'center',
                                   name: 'UsrCre'
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
                            caption: "LEVANTAMIENTOS"
                        }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })

                          .navButtonAdd("#" + pager_id,
                              {
                                  caption: "Editar levantamiento...",
                                  buttonicon: "ui-icon-document",
                                  onClickButton: function () {
                                      var myGrid = $("#" + subgrid_table_id);
                                      selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                      cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                      cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'IdLev');
                                      idlev = myGrid.jqGrid('getCell', selectedRowId, 'IdLev');
                                      if (cellValue) {
                                          RevisaEstatusAnuencia(idlev)
                                          .done(function (r) {
                                              var cadena = $.trim(r.d);
                                              if (cadena != "<NewDataSet />") {  // Si no se encontro el estatus de la anuencia.
                                                  $(r.d).find("EstatusAnu").each(function () {
                                                      var estanu = $(this).find("cEstDesc").text();
                                                      if (estanu == "LEVANTAMIENTO") {
                                                          CapturarCoops(idsolicitud, idfact, idusu, idanu);
                                                      }
                                                      else {
                                                          alert("La anuencia se encuentra en: " + estanu + " no es posible analizar el Levantamiento");
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
                                          alert("No existen registros ó selecciona un registro para modificar...");
                                      }
                                  },
                                  position: "last",
                                  title: "Revisar anuencia",
                                  cursor: "pointer"
                              })

                          .navButtonAdd("#" + pager_id,
                              {
                                 caption: "Eliminar levantamiento",
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
                         caption: "Alta Lev",
                         buttonicon: "ui-icon-document",
                         onClickButton: function () {
                             var myGrid = $('#grid');                       
                             selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                             cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                             if (cellValue) {                                 
                                AccionRegistroLev(cellValue, 0, 0);
                             }
                             else {
                                 alert("Selecciona una solicitud...");
                             }
                         },
                         position: "last",
                         title: "Alta de Levantamiento",
                         cursor: "pointer"
                     });


        
        $(".posicion_boton_accion_lev").click(function (e) { //Actualizar datos en el registro            
            e.preventlogin();
            var accion = $("#lblaccionlev").html();
            var idsol = $("#lblidsol").html();


            if (validarlev(accion)) {   /*Valida que los datos del documento sean coreectos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                /*Reunir parámetros para guardar el levantamiento capturado en el server*/
                
                
                var fecsolic = ConvertirCadenaToFecha($("#txtfecsolic").val());
                var fecentrega = ConvertirCadenaToFecha($("#txtfecentrega").val());                
                var observ = $("#txtobserv").val();
                
                var hoy = new Date();
                var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienvusuario.split(":");    
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
                    var dibujante = parseInt($("#lstUsuario option:selected").val());
                    var idlev = $("#lblidlev").html();
                    //var nomarchivo = idsol + '_' + idlev + "_LEV.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                    var archivo = $("#filelev").get(0).files;
                    var hayarchivo = archivo.length;
                    
                    InsertarRegLev(idsol, fecsolic, fecentrega, dibujante, usuario, hoy, usuario, hoy, accion)
                         .done(function (r) {
                             alert("Archivo guardado correctamente");
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         })
                         .fail(function (x) {
                             alert("No es posible guardar el levantamiento...");
                         });
                }

            }
        });

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

    function AccionRegistroLev(idsol, idlev, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
        $("#lblaccionlev").text(accion);        
        
        if (accion == 0) {  //Si la accion es crear un nuevo levantamiento 

            $("#lblidsol").text(idsol);
            //if (idlev == 0) {                
                $("#lblidlev").text(idlev);
            //}

            $("#txtfecsolic").val('');
            $("#txtfecentrega").val('');
            $("#lstUsuario").prop('disabled', false);
            llenarUsuario(0);
            $("#txtobserv").val('');
            $("#filelev").val("");
            $("#archivo").text("");
            $("#filelev").prop('disabled', false);

            //$("#txtFolioAnu").prop('disabled', false);
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
                    if (accion == 2) {
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
                    }
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
        MostrarModalLev();

    }




    function SolicitarPresupuesto(idsol) {
        MostrarModalSolicPresup();
    };



   
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




    function validarlev(accion) {

        if (accion == 0 || accion == 1) { /*Si el usuario escogió dar de alta un nuevo levantamiento*/

            if ($("#filelev").val().length > 0) {              /*Valida si existe archivo capturado en el control input file*/
                if (ValidarArchivo($("#filelev")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                    valid = valid && true;
                }
                else {
                    $("#filelev").val("");
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

            if (accion == 0) {
                var valid = checkLength($("#txtobserv").val().length, "Observaciones", 20, 120);
                valid = valid && isDate($("#txtfecentrega").val());
                var fecsolic = ConvertirCadenaToFecha($("#txtfecsolic").val());
                if (fecsolic == '01/01/1900') {
                    alert("La fecha de solicitud es incorrecta.");
                    valid = valid && false;
                }
                var fecentrega = ConvertirCadenaToFecha($("#txtfecentrega").val());
                if (fecentrega == '01/01/1900') {
                    alert("La fecha de entrega es incorrecta.");
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

    function MostrarModalSolicPresup() {
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

    function MostrarModalLev() {
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
        $("#dialogolev").css('top', winH / 2 - $("#dialogolev").height() / 2);
        $("#dialogolev").css('left', winW / 2 - $("#dialogolev").width() / 2);

        //transition effect
        $("#dialogolev").fadeIn(2000);
    }




    function llenarUsuario(idusu) {
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
    <div id="dialogolev" class="window"> 
       <div id="titulolev" style="text-align:right"> 
         <p style="text-align:center">GESTIONAR LEVANTAMIENTO</p>
         No. de solicitud: <label for="idsol" id="lblidsol"></label><br/>                           
         No. de Levantamiento: <label for="idlev" id="lblidlev"></label><br/>
         Acción:<label for="accion" id="lblaccionlev"></label><br/> 
       </div>
       <div class="datos" id="bodylev">        
          <label for="name">*Fecha solicitud Lev.:</label><input type="text" name="fecsolic" id="txtfecsolic" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/> dd/mm/aaaa<br/><br/>
          <label for="name">*Fecha entrega Lev.:</label><input type="text" name="fecentrega" id="txtfecentrega" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/> dd/mm/aaaa<br/><br/>          
          <label for="name">Dibujante:</label><select name="Usuario" id="lstUsuario"></select><br/><br/> 
          <label for="name">Observaciones:</label><input type="text" name="observ" id="txtobserv" size="200"/><br/><br/>
          <label for="name">Levantamiento:</label><input type="file" id="filelev" name="file"/><a href="#" id="A2" class="verarchivo"/>          
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_lev">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_lev">Cancelar</a></p>                
       </div>
    </div> 
     <div id="dialogopresup" class="window"> 
       <div id="titulopresup" style="text-align:right"> 
         <p style="text-align:center">SOLICITUD DE PRESUPUESTO</p>
         No. de solicitud: <label for="idsol" id="lblidsolpresup"></label><br/>                           
         Acción:<label for="accion" id="lblaccionpresup"></label><br/> 
       </div>
       <div class="datos" id="bodysolicpresup">        
          <label for="name">Fecha solicitud presupuesto:</label><input type="text" name="fecsolicpresup" id="lblfecpresup" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/> dd/mm/aaaa<br/><br/>
          <label for="name">Solicitud Presupuesto (dcto):</label><input type="file" id="filesolicpresup" name="file"/><a href="#" id="solicpresup" class="verarchivo"/>
       </div>                  
       <div class="botonesA" id="botonesB">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_presup">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_presup">Cancelar</a></p>                
       </div>
    </div> 
    <div id="mask"></div>
 </div>
</asp:Content>


