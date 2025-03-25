<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="solicitudes.aspx.vb" Inherits="Admin_procesos_solicitudes" Culture="Auto" UICulture="Auto"%>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
<script type="text/javascript" language="JavaScript">

    

        function abrirVisorFactis() {
            //alert(img);
            var url1 = "../../Procesos/MostrarMapa.html";
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1105,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }

        function ubicFactis(id) {
            //alert(img);
            var url1 = "../../Procesos/UbicFact.html?ResponseType=Edit&gid=" + id;
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


             

        function checkVacio(conten,regexp,msj) {
            if (conten == "" || conten == " ") {
                return true;
            }
            else {
                return checkRegexp(conten,regexp,msj);                
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
            if (nomcalle.length <= 0 || nomcalle.length>20) {
                nomcalle = "";
            }
            var idsol = $('#txtidsol').val();
            if (idsol.length <= 0 || !$.isNumeric(idsol) ){
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
                     url: "../../WebServices/WebServiceSolic.asmx/GetSolicitudes_psql", //PageMethod
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

        


        
        
            //// INICIO DE SCRIPT

        $(document).ready(function () {


            /*$('#verdcto').click(function () {
                var nom_archivo = $('#verdcto').val();
                leerArchivo(nom_archivo);                
            });*/

            var lastSel;
            var band_grid2=0;            
            $("#grid").jqGrid(
              {
                  datatype: function () { ObtenerDatos(ObtenerFiltro(),"1,2","1,2,3,4","0") },
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
                       index: 'idsol', width: 50, align: 'Center',
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
                       name: 'Ubic.'
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
                  viewrecords: true, //Show  the RecordCount in the pager.
                  multiselect: false,
                  sortname: "idsol", //login SortColumn
                  sortorder: "asc", //login SortOrder.
                  width: "1900",
                  height: "600",
                  caption: "SOLICITUDES DE PAVIMENTACION DE CALLES (FACTIBILIDAD)",
                  subGrid: true,
                  subGridRowExpanded: function (subgrid_id, row_id) {                     
                      var subgrid_table_id, pager_id;
                      subgrid_table_id = subgrid_id + "_t";
                      pager_id = "p_" + subgrid_table_id;
                      $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                      /*var solicitud = jQuery('#grid').jqGrid('getRowData', row_id);*/
                      jQuery("#" + subgrid_table_id).jqGrid(
                            {
                                datatype: function () {
                                    var solicitud = jQuery('#grid').jqGrid('getRowData', row_id);
                                    $.ajax(
                                      {
                                          url: "../../WebServices/WebServiceFact.asmx/GetFactibilidades", //PageMethod
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
                                    index: 'midsol', width: 30, align: 'Center',
                                    name: 'IdSol'
                                   },
                                   {
                                       index: 'mnumfact', width: 30, align: 'Center',
                                       name: 'No_Fact'
                                   },
                                   {
                                       index: 'mopc1', width: 40, align: 'Center',
                                       name: 'Col_Reg'
                                   },
                                   {
                                       index: 'mopc2', width: 40, align: 'center',
                                       name: 'Agua'
                                   },
                                   {
                                       index: 'mopc3', width: 40, align: 'center',
                                       name: 'Elec'
                                   },
                                   {
                                       index: 'mopc4', width: 40, align: 'center',
                                       name: 'Dren'
                                   },
                                   {
                                       index: 'mopc5', width: 50, align: 'center',
                                       name: 'Pav.Colin.'
                                   },
                                   {
                                       index: 'mopc6', width: 40, align: 'center',
                                       name: 'Afect.'
                                   },
                                   {
                                       index: 'mopc7', width: 40, align: 'center',
                                       name: 'Sec<13'
                                   },
                                   {
                                       index: 'mopc8', width: 40, align: 'center',
                                       name: 'Cost_Ext'
                                   },
                                   {
                                       index: 'mopc9', width: 40, align: 'center',
                                       name: 'A.Dona'
                                   },
                                   {
                                       index: 'mopc10', width: 40, align: 'center',
                                       name: 'Consolid.'
                                   },
                                   {
                                       index: 'mUsuNombre', width: 180, align: 'center',
                                       name: 'Usu_Fact.'
                                   },
                                   {
                                       index: 'mUsuCre', width: 100, align: 'center',
                                       name: 'Usu_Cre'
                                   },
                                   {
                                       index: 'mFecCre', width: 60, align: 'center',
                                       name: 'Fec_Cre'
                                   },
                                   {
                                       index: 'mUsuModif', width: 100, align: 'center',
                                       name: 'Usu_Modif'
                                   },
                                   {
                                       index: 'mFecModif', width: 60, align: 'center',
                                       name: 'Fec_Modif'
                                   },
                                   {
                                       index: 'cEstDescripcion', width: 100, align: 'center',
                                       name: 'Est.Fact.'
                                   },
                                   {
                                       index: 'mobserv_tec', width: 200, align: 'center',
                                       name: 'Observ.Tec.'
                                   },
                                   {
                                       index: 'mobserv_gral', width: 200, align: 'center',
                                       name: 'Obser.Gral.'
                                   },
                                   {
                                       index: 'mfolio', width: 40, align: 'center',
                                       name: 'FolioDcto.'
                                   },
                                   {  
                                       name: 'Documento', index: 'mNomArchivo', width: 150, align: 'center', editable: false, sortable: false, formatter: function (cellvalue) {
                                           var archivo = cellvalue;
                                           var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                                           return url;
                                       }
                                   }],
                                pager: pager_id, //Pager.                 
                                loadtext: 'Cargando datos...',
                                recordtext: "{0} - {1} de {2} elementos",
                                emptyrecords: 'No hay resultados',
                                pgtext: 'Pág: {0} de {1}', //Paging input control text format.
                                rowNum: "5", // PageSize.
                                rowList: [1, 3, 5], //Variable PageSize DropDownList. 
                                viewrecords: true, //Show the RecordCount in the pager.
                                ajaxGridOptions: row_id,
                                multiselect: false,
                                sortname: "idsol", //login SortColumn
                                sortorder: "asc", //login SortOrder.
                                width: "1800",
                                height: "100%",
                                caption: "FACTIBILIDADES"
                            }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                              .navButtonAdd("#" + pager_id,
                                  {
                                      caption: "Editar Fact",
                                      buttonicon: "ui-icon-document",
                                      onClickButton: function () {
                                          var myGrid = $("#" + subgrid_table_id);
                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                          cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                          cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'No_Fact');
                                          if (cellValue) {
                                              AccionRegistroFacti(cellValue, cellValue2, 1); //------ Envío valor de idsol   y "accion = 1" para editar registro                        
                                          }
                                          else {
                                              alert("Selecciona un registro...");
                                          }
                                      },
                                      position: "last",
                                      title: "Editar_Fact",
                                      cursor: "pointer"
                                  })
                              .navButtonAdd("#" + pager_id,
                                  {
                                      caption: "Eliminar Fact",
                                      buttonicon: "ui-icon-document",
                                      onClickButton: function () {
                                          var myGrid = $("#" + subgrid_table_id);
                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                          cellValue = myGrid.jqGrid('getCell', selectedRowId, 'IdSol');
                                          cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'No_Fact');
                                          cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Est.Fact.');
                                          if (cellValue) {
                                              if (cellValue3 != 'CANCELADO') {
                                                  AccionRegistroFacti(cellValue, cellValue2, -1); //------ Envío valor de idsol   y "accion = 1" para editar registro                        
                                              }
                                              else {
                                                  alert("La factibilidad se encuentra cancelada.");
                                              }
                                          }
                                          else {
                                              alert("Selecciona un registro...");
                                          }
                                      },
                                      position: "last",
                                      title: "Eliminar_Fact",
                                      cursor: "pointer"
                                  });

                      
                  }

            }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                 //Crear botón de editar
              .navButtonAdd('#pager',
                     {
                      caption: "Alta Sol",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                        AccionRegistroSolicitud(0, 0); //----- No envío valor de idsol porque es nuevo registro y "accion=0" como nuevo registro                
                      },
                      position: "last",
                      title: "Alta Sol",
                      cursor: "pointer"
                     })
              .navButtonAdd('#pager',
                     {
                     caption: "Editar Sol",
                     buttonicon: "ui-icon-pencil",
                     onClickButton: function () {
                     var myGrid = $('#grid');
                     selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                     cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                      if (cellValue) {
                        AccionRegistroSolicitud(cellValue, 1); //------ Envío valor de idsol   y "accion = 1" para editar registro                        
                        }
                      else {
                        alert("Selecciona un registro...");
                      }
                     },
                        position: "last",
                        title: "Editar Sol",
                        cursor: "pointer"
                     })
              .navButtonAdd('#pager',
                     {
                      caption: "Cancelar Sol",
                      buttonicon: "ui-icon-closethick",
                      onClickButton: function () {
                        var myGrid = $('#grid');
                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                        if (cellValue) {
                            AccionRegistroSolicitud(cellValue, -1); //----- Envío valor de idsol y "accion=-1" para cancelar registro
                        }
                        else {
                            alert("Selecciona un registro...");
                        }
                     },
                        position: "last",
                        title: "Cancelar Sol",
                        cursor: "pointer"
                     })
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
                     caption: "Ubicación Tramo",
                     buttonicon: "ui-icon-image",
                     onClickButton: function () {
                     var myGrid = $('#grid');
                     selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                     cellValue = myGrid.jqGrid('getCell', selectedRowId, 'Ubic.');
                     if (cellValue) {
                       if (cellValue > 0) {
                                ubicFactis(cellValue);
                            }
                            else {
                               alert("Solicitud sin UBICACION asignada");
                                 }
                        }
                        else {
                               alert("Selecciona un registro...");
                             }
                         },
                     position: "last",
                     title: "Ubicar tramo",
                     cursor: "pointer"
                    })
              .navButtonAdd('#pager',
                    {
                     caption: "Alta Fact",
                     buttonicon: "ui-icon-document",
                     onClickButton: function () {
                     var myGrid = $('#grid');
                     selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                     cellValue = myGrid.jqGrid('getCell', selectedRowId, 'idsol');
                     if (cellValue) {
                         AccionRegistroFacti(cellValue, 0, 0);
                     }
                     else {
                         alert("Selecciona un registro...");                         
                     }
                    },
                     position: "last",
                     title: "Alta_Fact",
                     cursor: "pointer"
                    });
              
               

             

                //// Procedimiento para capturar el click en las imagenes que se presenten 

                // $("img").click(function () {  //Caza el CLICK DE TODAS LAS IMAGENES
                //     var nombre = $(this);     //Cacha el  objeto imagen donde se hizo click                
                //     var bandera = nombre.attr("src"); // Asigna el texto de la ruta de la propiedad src
                //     if (bandera.indexOf("buscar") !== -1) {  //  Encontro la imagen que en su path tiene la cadena "Buscar"                                         
                //         RedibujarGrid();
                //     }
                // });

                // $("#btnAgregar").click(function () {
                //     AbrirModal(0, 0);
                // });

                $(".posicion_boton_accion_sol").click(function (e) { //Actualizar datos en el registro            
                    e.preventlogin();
                    var accion = $('#lblaccion').html();
                    ejecutarAccion(accion);                   
                });

                $(".posicion_boton_accion_fact").click(function (e) { //Actualizar datos en el registro            
                    e.preventlogin();
                    var accion = $("#lblaccionfact").html();
                    var idsol = parseInt($("#lblsolfact").html());
                    if (validarFactibilidad(accion)) {   /*Valida que los datos de la factibilidad incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                        GuardarFactBD(accion)            /*Se ordena guardar registro de factibilidad*/
                           .done(function (r) { /*Si se tiene éxito al guardar la factibilidad*/
                               if (accion>=0) {
                                   /*Reunir parámetros para guardar el registro del archivo y el archivo capturado en el server*/
                                  var folioDcto = $("#txtFolioDcto").val();      /*Recupera folio del documento capturado*/
                                  var hoy = new Date();                          /*recupera la fecha del dia de la alta del registro*/
                                  var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                                  var iddcto = parseInt($("#lbliddcto").html());
                                  if (isNaN(iddcto)) {
                                     iddcto = 0;                                  
                                  }
                                  var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                                  var idusuario = parseInt(arrusuario[2]);
                                  var nomusuario = arrusuario[1];
                                  var respWebServiceFact = r.d;
                                  var arridfact = respWebServiceFact.split(":");
                                  var idfact = parseInt(arridfact[1]);
                                  var nomarchivo = idsol + "_" + idfact + "_SFACT.pdf"; /*Se arma el nombre del archivo para asignarselo al archivo en el server*/
                                  var archivo = $("#file1").get(0).files;                              
                                  InsertaRegDcto(idsol,iddcto,idfact, folioDcto, hoy, hoy, idusuario, nomarchivo, 1, nomusuario, hoy, nomusuario, hoy, archivo,accion);                               
                               }
                               $('#mask, .window').hide();
                               RedibujarGrid();
                           })
                           .fail(function (x) {
                               alert("No es posible guardar la FACTIBILIDAD");
                           });
                    }
                });

               $(".verarchivo").click(function (e) { //Ver documento                   
                    var archivo = $("#archivo").text();
                    leerArchivo(archivo);
                });
               

                $(".posicion_boton_accion_sapal").click(function (e) { //Actualizar datos en el registro            
                    e.preventlogin();
                    var accion = $('#lblaccionS').html();                    
                });

                $(".posicion_boton_accion_DU").click(function (e) { //Actualizar datos en el registro            
                    e.preventlogin();
                    var accion = $('#lblaccionDU').html();
                });


                $(".posicionar_solicitud").click(function (e) { //Actualizar datos en el registro            
                    e.preventlogin();
                    abrirVisorFactis();
                });

                $(".window .posicion_boton_cancelar_sol").click(function (e) {
                    //Cancel the link behavior
                    e.preventlogin();
                    $('#mask, .window').hide();
                });

                $(".window .posicion_boton_cancelar_fact").click(function (e) {
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

                /* var map = new ol.Map({
                     layers: [
                       new ol.layer.Tile({
                           source: new ol.source.OSM()
                       })
                     ],
                     target: 'map',
                     controls: ol.control.defaults({
                         attributionOptions: /** @type {olx.control.AttributionOptions}  ({*/
                /*            collapsible: false
                        })
                    }),
                    view: new ol.View({
                        center: [1, -19],
                        zoom: 10
                    })
                })
    
                document.getElementById('zoom-out').onclick = function () {
                    var view = map.getView();
                    var zoom = view.getZoom();
                    view.setZoom(zoom - 1);
                };
    
                document.getElementById('zoom-in').onclick = function () {
                    var view = map.getView();
                    var zoom = view.getZoom();
                    view.setZoom(zoom + 1);
                };*/

            });

        function leerArchivo(nom_archivo) {
            var url = "../../temp/" + nom_archivo;
            window.open(url, '_blank', 'toolbar=0');
        }
          
            
            function enviardatosBD(accion) {
                var claves = $("#colonia").val();
                var arr = claves.split("*");
                var sector = parseInt(arr[0]);
                var subsector = parseInt(arr[1]);            
                var bienvusuario =  $("#lblUsuario").html();
                var arrusuario = bienvusuario.split(":");
                var usuario = arrusuario[1];

                var date = new Date();
                var strDate=date.getDate() + '/' + (date.getMonth() + 1)  + '/' + (date.getFullYear());            
            
                var enviarObj = {
                    "IdSol": parseInt($("#lblidsol").text()),
                    "IdEstatus":1,                                        
                    "IdOrigen": parseInt($("#origsol").val()),
                    "Fecha":date, 
                    "Fecha1":date,
                    "Fecha2":date,
                    "Nombre": $("#nomsol").val().toUpperCase(),
                    "Direccion": $("#domsol").val().toUpperCase(),
                    "Telefono": $("#telsol").val(),
                    "Correo": $("#emailsol").val(),
                    "SECFNO": sector,
                    "SSCFNO": subsector,
                    "CLACNO": $("#calle").val(),
                    "Tramo": $("#tramo").val().toUpperCase(),                
                    "Distancia":"0",
                    "Observaciones": $("#observ").val().toUpperCase(),                
                    "Accion":accion,
                    "Busqueda":"Buscar",
                    "listado":"listado",
                    "UsuCre": usuario,
                    "FecCre":date,
                    "UsuMod":usuario,
                    "FecMod": date,
                    "Atencion":"noatencion",
                    "TramoO": $("#tramo").val().toUpperCase(),
                    "Ordena":"ordena",
                    "Inicio":0,
                    "Fin":0,                
                    "Calle": $("#calle option:selected").text(),
                    "Col": $("#colonia option:selected").text(),
                    "ubic": parseInt($("#ubic").val()),
                    "Autorizar":0,
                    "Mensaje":"mensaje"                
                }
                var stringData = JSON.stringify(enviarObj);
                $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceSolic.asmx/ActSolicitud",
                    data: "{objSol:" + stringData + "}",                 
                    contentType: 'application/json; utf-8',
                    dataType: 'json',
                    success: function (data) {
                        if (data.d != null) {
                            alert(data.d);
                        }
                        RedibujarGrid();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            
            };
            
            function GuardarFactBD(accion) {
                var bienvusuario = $("#lblUsuario").html();
                var arrusuario = bienvusuario.split(":");
                var usuario = arrusuario[1];
                var date = new Date();
                var strDate = date.getDate() + '/' + (date.getMonth() + 1) + '/' + (date.getFullYear());
                var idsol = parseInt($("#lblsolfact").text());
                var opciones = [];
                var usuario_facti = parseInt($("#lstUsuario").val());
                
                $("input:checkbox").each(
                  function () {
                      if ($(this).attr('checked')) {
                          opciones.push(1);
                      }
                      else {
                          opciones.push(0);
                      }
                  });
                var idfact;
                if ($("#lblfact").text().length > 0) {
                    idfact= parseInt($("#lblfact").text())
                }
                else {
                    idfact = 0;
                }


                var enviarObj = {
                    "idSol": parseInt($("#lblsolfact").text()),
                    "idfact": idfact,
                    "usufact": $("#lstUsuario").val(),
                    "opc1": opciones[0],
                    "opc2": opciones[1],
                    "opc3": opciones[2],
                    "opc4": opciones[3],
                    "opc5": opciones[4],
                    "opc6": opciones[5],
                    "opc7": opciones[6],
                    "opc8": opciones[7],
                    "opc9": opciones[8],
                    "opc10": opciones[9],            
                    "opc11": 0,            /*Se deshabilita porque solo se estan utilizando 10 opciones*/
                    "opc12": 0,            /*Se deshabilita porque solo se estan utilizando 10 opciones*/
                    "factfile": "ocupado",
                    "estatusfact": $("#lstEstFact").val(),
                    "UsuCre": usuario,
                    "FecCre": date,                    
                    "UsuMod": usuario,                    
                    "FecMod": date,
                    "observtec": $("#txtobservtec").val().toUpperCase(),
                    "observgral": $("#txtobservgral").val().toUpperCase(),
                    "accion": accion                
                }
                var stringData = JSON.stringify(enviarObj);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceFact.asmx/ActFactibilidad",
                    data: "{objFact:" + stringData + "}",
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

            function InsertaRegDcto(idsol,iddcto,idfact,folioDcto,hoy,hoy,idusuario,nomarchivo,tipodcto,nomusuario,hoy,nomusuario,hoy,archivo,accion)   { /*Inserta los registros de los documentos en la tabla de mDocumento*/
                          

                var enviarObj = {
                    "idsol": idsol,
                    "iddcto":iddcto,
                    "idref":idfact,
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
                    "accion":accion
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

            
            function checkUbicSolicitud(idpolig) {
                return $.ajax({
                    url: "../../WebServices/WebServiceMap.asmx/GetPolygonoFact",
                    data: "{'idpoligono':'" + idpolig + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                });
            }

            function ejecutarAccion(accion) {

                /*IMPORTANTE*/
                /*EXPRESIONES REGULARES SE MANEJAN DE ACUERDO A LA DEFINICION: /^ significa que la cadena coincide con cualquier cosa que no esté en la expresión regular  */
                
                    var valid = checkLength($("#nomsol").val().length, "Nombre solicitante", 10, 200);
                    valid = valid && checkLength($("#domsol").val().length, "Domicilio solicitante", 1, 200);
                    valid = valid && checkLength($("#tramo").val().length, "Tramo", 8, 200);
                    valid = valid && checkRegexp($("#nomsol").val(), /^[a-zA-Z.]+( *[a-zA-Z.]*)*[a-zA-Z.]+$/, "El nombre solo acepta letras");
                    valid = valid && checkVacio($("#emailsol").val(), /^[\w-+]+(\.[\w-]{1,62}){0,126}@[\w-]{1,63}(\.[\w-]{1,62})+[\w-]+$/, "Introduce dirección email correctamente ejem.: micorreo@dominio.com");
                    valid = valid && checkVacio($("#telsol").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
                    valid = valid && checkRegexp($("#domsol").val(), /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+/, "El domicilio acepta letras, números y carcatéres especiales.");
                    valid = valid && checkRegexp($("#tramo").val(), /^[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú()]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]*[ ]*[-]+[ ]*[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú]+[a-zA-Z0-9üÜÑñÁÉÍÓÚáéíóú .#]*$/, "El tramo debe constar dos limites: límite1 - límite2");
                    valid = valid && checkRegexp($("#ubic").val(), /^[0-9]*$/, "La ubicación debe ser numero entero");
                    if (valid) {
                        checkUbicSolicitud(parseInt($("#ubic").val()))
                            .done(function (r) {
                                if (r.d == "<NewDataSet />") {
                                    $("#ubic").val("");
                                    alert("No existe ubicación registrada, favor capturar una ubicación válida");
                                }
                                else {
                                    $(r.d).find("PolygonoFact").each(function () {
                                        var idpolig = $(this).find("gid").text();
                                        enviardatosBD(accion);
                                        $('#mask, .window').hide();
                                    })
                                }
                            })
                           .fail(function (x) {
                               alert("No fue posible leer la ubicación");
                           });
                    }
                
            }


            function validarFactibilidad(accion) {
                if (accion >= 0) {
                    var valid = checkLength($("#txtobservtec").val().length, "Observaciones Técnicas", 10, 800);            /*Valida que exista algo capturado en las Observaciones Técnicas*/
                    valid = valid && checkLength($("#txtobservgral").val().length, "Observaciones Generales", 10, 800);     /*Valida que existan observaciones generales*/
                    valid = valid && checkLength($("#txtFolioDcto").val().length, "Folio del Documento", 1, 20);            /*Valida la longitud del Folio del documento*/
                    if (valid) {
                        if ($("#file1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                            if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                                return true;
                            }
                            else {
                                $("#file1").val("");
                                return false;
                            }
                        }
                        else {
                            if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                                return true;
                            }
                            else {
                                alert("No se capturado ningún archivo digital");
                                return false;
                            }
                        }
                    }
                }
                else {                    
                    return true;
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


            function ValidacionGuardadoArchivo(archivo,nomarchivo) {                  
                    GuardarArchivo(archivo,nomarchivo)
                    .done(function (result) {
                        console.log("El archivo fue guardado correctamente")
                    }).fail(function (jqXHR,  textStatus, errorThrown) {
                        alert("No fue posible guardar el archivo:" + jqXHR.responseText + "," + textStatus + "," + errorThrown);
                    });                
            }
            
        
            function GuardarArchivo(archivo,nomarchivo) {

                var formdata = new FormData();

                formdata.append("UploadedImage", archivo[0]);
                var objParametro = "{'nomarchivo':'" + nomarchivo + "'}";
                
                formdata.append("objParametros", objParametro);

                  return $.ajax({
                        type: "POST",
                        url: "../../WebServices/WebServiceFileUpload.asmx/GuardarArchivo",                        
                        contentType: false,
                        processData: false,
                        data:formdata
                    });
            }


                function MostrarModal() {
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
                    $("#dialog").css('top', winH / 2 - $("#dialog").height() / 2);
                    $("#dialog").css('left', winW / 2 - $("#dialog").width() / 2);

                    //transition effect
                    $("#dialog").fadeIn(2000);
                }

                function MostrarModalFact() {
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
                    $("#dialogf").css('top', winH / 2 - $("#dialogf").height() / 2);
                    $("#dialogf").css('left', winW / 2 - $("#dialogf").width() / 2);

                    //transition effect
                    $("#dialogf").fadeIn(2000);
                }

                function AccionRegistroFacti(idsol,idfact, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro
                    $("#lblaccionfact").text(accion);

                    if (accion == 0) {  //Si la accion es crear un nuevo registro

                        $("#lstUsuario").prop('disabled', false);
                        $("#txtFolioDcto").prop('disabled', false);
                        $("#txtcolreg:checkbox").prop('disabled', false);
                        $("#txtservaguapot:checkbox").prop('disabled', false);
                        $("#txtservelect:checkbox").prop('disabled', false);
                        $("#txtservdre:checkbox").prop('disabled', false);
                        $("#txtpavcol:checkbox").prop('disabled', false);
                        $("#txtsec13:checkbox").prop('disabled', false);
                        $("#txtafect:checkbox").prop('disabled', false);
                        $("#txtcostext:checkbox").prop('disabled', false);
                        $("#txtareadon:checkbox").prop('disabled', false);
                        $("#txtconsolida:checkbox").prop('disabled', false);
                        $("#txtobservtec").prop('disabled', false);
                        $("#txtobservgral").prop('disabled', false);
                        $("#lstEstFact").prop('disabled', false);
                        $("#file1").prop('disabled', false);

                        $("#lblsolfact").text(idsol);
                        $("#lblfact").text('');                        
                        $('input[type=checkbox]').prop('checked', false);
                        $("#txtobservtec").val("");
                        $("#txtobservgral").val("");
                        $("#txtFolioDcto").val("");
                        $("#file1").val("");
                        $("#archivo").text("");
                        llenarUsuario(0);
                        llenarEstatusFact(0);
                        MostrarModalFact();
                    }
                    else {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../../WebServices/WebServiceFact.asmx/GetFactibilidad",
                            data: '{idsol:' + idsol + ',idfact:'+ idfact + '}',
                            success: function (data) {
                                var usufact;
                                var estatusfact;                                
                                var cadena = $.trim(data.d);
                                if (cadena == "<NewDataSet />") {
                                    alert("La factibilidad está cancelada, por lo tanto no es posible realizar la acción solicitada.");
                                }
                                else {                                                                       
                                    
                                    // Data.d trae un string con el XML generado dentro del servicio web asmx
                                    $(data.d).find("Factibilidad").each(function () {
                                        usufact = parseInt($(this).find("mUsuFact").text());
                                        var idfact = $(this).find("mnumfact").text();
                                        var foliofact = $(this).find("mfolio").text();
                                        var iddcto = $(this).find("midDcto").text();
                                        var opc1 = parseInt($(this).find("mopc1").text());
                                        var opc2 = parseInt($(this).find("mopc2").text());
                                        var opc3 = parseInt($(this).find("mopc3").text());
                                        var opc4 = parseInt($(this).find("mopc4").text());
                                        var opc5 = parseInt($(this).find("mopc5").text());
                                        var opc6 = parseInt($(this).find("mopc6").text());
                                        var opc7 = parseInt($(this).find("mopc7").text());
                                        var opc8 = parseInt($(this).find("mopc8").text());
                                        var opc9 = parseInt($(this).find("mopc9").text());
                                        var opc10 = parseInt($(this).find("mopc10").text());
                                        var opc11 = parseInt($(this).find("mopc11").text());
                                        var opc12 = parseInt($(this).find("mopc12").text());
                                        var observtec = $(this).find("mobserv_tec").text();
                                        var observgral =$(this).find("mobserv_gral").text();
                                        estatusfact = parseInt($(this).find("mEstatusFact").text());
                                        var nom_archivo = $(this).find("mNomArchivo").text();
                                        $("#lblsolfact").text(idsol);
                                        $("#lblfact").text(idfact);
                                        $("#lbliddcto").text(iddcto);
                                        $("#lstUsuario").val(usufact);
                                        $("#txtFolioDcto").val(foliofact);
                                        $("#txtcolreg:checkbox").attr('checked',!!opc1);
                                        $("#txtservaguapot:checkbox").attr('checked', !!opc2);
                                        $("#txtservelect:checkbox").attr('checked', !!opc3);
                                        $("#txtservdre:checkbox").attr('checked', !!opc4);
                                        $("#txtpavcol:checkbox").attr('checked', !!opc5);
                                        $("#txtafect:checkbox").attr('checked', !!opc6);
                                        $("#txtsec13:checkbox").attr('checked', !!opc7);
                                        $("#txtcostext:checkbox").attr('checked', !!opc8);
                                        $("#txtareadon:checkbox").attr('checked', !!opc9);
                                        $("#txtconsolida:checkbox").attr('checked', !!opc10);                                                                                
                                        $("#txtobservtec").val(observtec);
                                        $("#txtobservgral").val(observgral);                                        
                                        $("#lstEstFact").val(estatusfact);
                                        $("#file1").val('');
                                        $("#archivo").text(nom_archivo);   /*Asignamos al hipervinculo el nombre del archivo guardado*/

                                       /* var url = "../../temp/"+nom_archivo;  /*completamos la ruta especifica del archivo*/ 
                                       /* $("#archivo").attr("href", url);   /*Asignamos la referencia al hipervinculo del archivo para poderse ver*/
                                        /*$("#verdcto").prop("value",nom_archivo);*/
                                    });
                                    llenarUsuario(usufact);
                                    llenarEstatusFact(estatusfact);
                                    if (accion < 0) {
                                        $("#lstUsuario").prop('disabled', true);
                                        $("#txtFolioDcto").prop('disabled', true);
                                        $("#txtcolreg:checkbox").prop('disabled', true);
                                        $("#txtservaguapot:checkbox").prop('disabled', true);
                                        $("#txtservelect:checkbox").prop('disabled', true);
                                        $("#txtservdre:checkbox").prop('disabled', true);
                                        $("#txtpavcol:checkbox").prop('disabled', true);
                                        $("#txtsec13:checkbox").prop('disabled', true);
                                        $("#txtafect:checkbox").prop('disabled', true);
                                        $("#txtcostext:checkbox").prop('disabled', true);
                                        $("#txtareadon:checkbox").prop('disabled', true);
                                        $("#txtconsolida:checkbox").prop('disabled', true);
                                        $("#txtobservtec").prop('disabled', true);
                                        $("#txtobservgral").prop('disabled', true);
                                        $("#lstEstFact").prop('disabled', true);
                                        $("#file1").prop('disabled', true);
                                        alert("ATENCION: seleccionó cancelar la factibilidad...");
                                    }
                                    else {
                                        $("#lstUsuario").prop('disabled', false);
                                        $("#txtFolioDcto").prop('disabled', false);
                                        $("#txtcolreg:checkbox").prop('disabled', false);
                                        $("#txtservaguapot:checkbox").prop('disabled', false);
                                        $("#txtservelect:checkbox").prop('disabled', false);
                                        $("#txtservdre:checkbox").prop('disabled', false);
                                        $("#txtpavcol:checkbox").prop('disabled', false);
                                        $("#txtsec13:checkbox").prop('disabled', false);
                                        $("#txtafect:checkbox").prop('disabled', false);
                                        $("#txtcostext:checkbox").prop('disabled', false);
                                        $("#txtareadon:checkbox").prop('disabled', false);
                                        $("#txtconsolida:checkbox").prop('disabled', false);
                                        $("#txtobservtec").prop('disabled', false);
                                        $("#txtobservgral").prop('disabled', false);
                                        $("#lstEstFact").prop('disabled', false);
                                        $("#file1").prop('disabled', false);                                       
                                    }
                                    MostrarModalFact();
                                }
                    
                            },
                            error: function (xhr) {
                                console.log(xhr.responseText);
                            }                    
                        });

                    }
                    
                }

                function AccionRegistroSolicitud(idsol, accion) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro

                    if (accion == 0) {  //Si la accion es crear un nuevo registro
                        $("#lblidsol").text('');
                        //Formatear fecha de solicitud                   
                        $("#nomsol").val('');
                        $("#telsol").val('');
                        $("#emailsol").val('');
                        $("#domsol").val('');
                        $("#callepav").val('');
                        $("#colonia").val('');
                        $("#tramo").val('');
                        $("#observ").val('');
                        $("#ubic").val('');
                        llenarOrigenSolicitud(0);
                        llenarColonias(0, 0, 0);
                        MostrarModal();
                    }
                    else { // si la acción indica editar o cancelar un registro
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../../WebServices/WebServiceSolic.asmx/GetSolicitud",
                            data: '{idsol:' + idsol + '}',
                            success: function (data) {
                                var cadena = $.trim(data.d);
                                if (cadena == "<NewDataSet />") {
                                    alert("La solicitud está cancelada, por lo tanto no es posible realizar la acción solicitada.");
                                }
                                else {
                                    var idorigsol;
                                    var idsolvalid = 0;
                                    var cvesector;
                                    var cvesubsector;
                                    var cvecalle;
                                    // Data.d trae un string con el XML generado dentro del servicio web asmx
                                    $(data.d).find("Solicitud").each(function () {
                                        var fecsol = $(this).find("msolfecha").text();
                                        idsolvalid = parseInt($(this).find("mSolId").text());
                                        var nomsol = $(this).find("mSolNombre").text();
                                        var telsol = $(this).find("mSoltel").text();
                                        var emailsol = $(this).find("mSolcorreo").text();
                                        idorigsol = $(this).find("cOrigId").text();
                                        var domsol = $(this).find("msoldireccion").text();
                                        var callepav = $(this).find("mSolcalle").text();
                                        var colonia = $(this).find("mSolcolonia").text();
                                        var tramo = $(this).find("mSoltramo").text();
                                        var observ = $(this).find("mSolObserva").text();
                                        var ubic = parseInt($(this).find("ubic").text());
                                        cvesector = $(this).find("mSolSECFNO").text();
                                        cvesubsector = $(this).find("mSolSSCFNO").text();
                                        cvecalle = $(this).find("mSolCLACNO").text();
                                        $("#lblidsol").text(idsolvalid); 
                                        //Formatear fecha de solicitud
                                        var date = new Date(fecsol);
                                        $("#lblfecsol").text((date.getDate() + '/' + date.getMonth() + 1) + '/' + date.getFullYear());
                                        $("#nomsol").val(nomsol);
                                        $("#telsol").val(telsol);
                                        $("#emailsol").val(emailsol);
                                        $("#domsol").val(domsol);
                                        $("#callepav").val(callepav);
                                        $("#colonia").val(colonia);
                                        $("#tramo").val(tramo);
                                        $("#observ").val(observ);
                                        $("#ubic").val(ubic);
                                    });
                                    llenarOrigenSolicitud(idorigsol);
                                    llenarColonias(cvesector, cvesubsector, cvecalle);
                                    if (accion < 0) {
                                        $("#nomsol").prop('disabled', true);
                                        $("#telsol").prop('disabled', true);
                                        $("#emailsol").prop('disabled', true);
                                        $("#origsol").prop('disabled', true);
                                        $("#domsol").prop('disabled', true);
                                        $("#colonia").prop('disabled', true);
                                        $("#tramo").prop('disabled', true);
                                        $("#calle").prop('disabled', true);
                                        $("#observ").prop('disabled', true);
                                        $("#ubic").prop('disabled', true);
                                    }
                                    else {
                                        $("#nomsol").prop('disabled', false);
                                        $("#telsol").prop('disabled', false);
                                        $("#emailsol").prop('disabled', false);
                                        $("#origsol").prop('disabled', false);
                                        $("#domsol").prop('disabled', false);
                                        $("#colonia").prop('disabled', false);
                                        $("#tramo").prop('disabled', false);
                                        $("#calle").prop('disabled', false);
                                        $("#observ").prop('disabled', false);
                                        $("#ubic").prop('disabled', false);
                                    }
                                    MostrarModal();
                                }
                    
                            },
                            error: function (xhr) {
                                console.log(xhr.responseText);
                            }                    
                        });               
                    }
                    $("#lblaccion").text(accion);
                }

       
                function llenarOrigenSolicitud(idOrigSol) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceSolic.asmx/GetOrigenSolicitud",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#origsol").html('');
                            $(data.d).find("OrigSolicitud").each(function () {
                                var option = $(document.createElement('option'));
                                var origsol = $(this).find("cOrigId").text();
                                var orignom = $(this).find("cOrigNombre").text();
                                option.html(orignom);
                                option.val(origsol);
                                //Nombre de combo a poblar
                                $("#origsol").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (idOrigSol!=0) {
                                $("#origsol").val(idOrigSol);
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
                        url: "../../WebServices/WebServiceUsuario.asmx/GetUsuario",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstUsuario").html('');
                            $(data.d).find("Usuario").each(function () {
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

                function llenarEstatusFact(idestfact) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceFact.asmx/GetEstFact",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#lstEstFact").html('');
                            $(data.d).find("EstatusFact").each(function () {
                                var option = $(document.createElement('option'));
                                var idestfact = $(this).find("cEstId").text();
                                var descrip = $(this).find("cEstDescripcion").text();
                                option.html(descrip);
                                option.val(idestfact);
                                //Nombre de combo a poblar
                                $("#lstEstFact").append(option);
                                elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                            });
                            if (idestfact != 0) {
                                $("#lstEstFact").val(idestfact);
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }
                 

                function llenarColonias(cvesector,cvesubsector,cvecalle) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../../WebServices/WebServiceCalCol.asmx/GetColonias",
                        data: "",
                        success: function (data) {
                            var elementos = 0;
                            $("#colonia").html('');
                            $(data.d).find("ColoniasDU").each(function () {                                              
                                var option = $(document.createElement('option'));
                                var sector = $(this).find("CveSector").text();
                                var subsector = $(this).find("CveSubsector").text();
                                var colnom = $(this).find("Colonia").text();
                                option.html(colnom);
                                option.val(sector + "*" + subsector);
                                $("#colonia").append(option);
                            });
                            if (cvesector != 0) { //Si la clave de sector es diferente de 0, es decir si el registro es para editar
                                $("#colonia").val(cvesector + "*" + cvesubsector);
                            }
                            //llenarCalles((cvesector + "*" + cvesubsector), cvecalle);                        
                            llenarCalles($("#colonia").val(), cvecalle);
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
     

<b>Nombre de Calle:<input type="text" name="Calle" id="txtnomcalle" style="width:250px"/>&nbsp &nbsp No. Solicitud:</><input type="text" name="idsol" id="txtidsol" style="width:50px" /></b><br/><br/>        
     
       
       <table id="grid"></table>
       <div id="pager"></div>&nbsp
       
 
  <div id="boxes">
    <div id="dialog"  class="window">         
      <div id="titulo"> 
        <p style="text-align:center">GESTION  DE  SOLICITUD  DE  PAVIMENTO</p>
        No. de solicitud:<label for="idsol" id="lblidsol"></label><br/>
        Fecha de Solicitud:<label for="fecsol"  id="lblfecsol"></label><br/>
        <label for="accion" id="lblaccion"></label><br/> 
      </div>
      <div class="datos" id="bodymodaldatos">                      
        <label for="name">*NOMBRE DEL SOLICITANTE:</label><br/>
        <input type="text" name="name" id="nomsol" size="80"/><br/><br/>
        <label for="name">TELEFONO:</label><br />
        <input type="text" name="telsol" id="telsol" size="10"/><br/><br/>
        <label for="name">CORREO ELECTRÓNICO:</label><br />
        <input type="text" name="emailsol" id="emailsol" size="80"/><br/><br/>
        <label for="name">ORIGEN DE LA SOLICITUD:</label><br />
        <select name="origsol" id="origsol"></select><br/><br/>   
        <label for="name">*DOMICILIO DEL SOLICITANTE:</label><br />       
        <textarea cols="82" rows="5" name="domsol" id="domsol" class="text"></textarea><br/><br/>               
        <label for="name">COLONIA:</label><br/>
        <select name="colonia" id="colonia">                
        </select><br/><br/>                 
        <label for="name">CALLE A PAVIMENTAR:</label><br />
        <select name="calle" id="calle">                
        </select><br/><br/> 
        <label for="name">*TRAMO:</label><br />
        <input type="text" name="tramo" id="tramo" size="80"/><br/><br/>
        <label for="name">OBSERVACIONES:</label><br />
        <textarea cols="82" rows="5" class="text" id="observ"></textarea><br/><br/>
        <label for="name">Ubicación:</label>
        <input type="text" name="ubic" id="ubic" size="10"/><a href="#" class ="posicionar_solicitud">UBICAR</a>        
      </div>            
      <div class="botonessol">
        <p style="text-align:right"><a href="#" class ="posicion_boton_accion_sol">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_sol">Cancelar</a></p>                
      </div> 
    </div>
    <div id="dialogf"  class="window">         
      <div id="titulofact"> 
        <p style="text-align:center">GESTION  DE  FACTIBILIDAD</p>
        No. de solicitud: <label for="idsol" id="lblsolfact"></label><br/>
        No. de FACTIBILIDAD: <label for="idfact" id="lblfact"></label><br/>                  
        No. de Documento: <label for="iddcto" id="lbliddcto"></label><br/> 
        <label for="accion" id="lblaccionfact"></label><br/> 
      </div>
      <div class="datos" id="bodyfact">
        <label for="name">Usuario que realizó FACTIBILIDAD:</label>        
        <select name="Usuario" id="lstUsuario"></select><br/><br/> 
        <label for="name">Folio de FACTIBILIDAD: </label><input type="text" name="txtFolioDcto" id="txtFolioDcto" size="20"/><br/>
        <label for="name">1.- Colonia regular:</label>  <input type="checkbox"name="colreg"id="txtcolreg" size="80"/><br/>
        <label for="name">2.- Servicio agua potable:</label> <input type="checkbox" name="servaguapot" id="txtservaguapot" size="10"/><br/>
        <label for="name">3.- Servicio de Electricidad:</label> <input type="checkbox" name="servelect" id="txtservelect" size="80"/><br/>
        <label for="name">4.- Servicio de drenaje y alcantarillado:</label> <input type="checkbox" name="servdre" id="txtservdre" size="80"/><br/>
        <label for="name">5.- Pavimento colindante:</label> <input type="checkbox" name="pavcol" id="txtpavcol" size="80"/><br/>
        <label for="name">6.- Afectación:</label> <input type="checkbox" name="afect" id="txtafect" size="80"/><br/>  
        <label for="name">7.- Sección menor a 13 mts:</label> <input type="checkbox" name="sec13" id="txtsec13" size="80"/><br/>
        <label for="name">8.- Costos extras:</label> <input type="checkbox" name="costext" id="txtcostext" size="80"/><br/>  
        <label for="name">9.- Area de donación:</label>  <input type="checkbox" name="areadon" id="txtareadon" size="80"/><br/>          
        <label for="name">10.-Consolidación:</label>  <input type="checkbox" name="ubic" id="txtconsolida" size="10"/><br/><br/>
        <label for="name">Observaciones técnicas:</label><br/> <textarea cols="82" rows="5" name="observtec" id="txtobservtec" class="text"></textarea><br/><br/>           
        <label for="name">Observaciones generales:</label><br/> <textarea cols="82" rows="5" name="observgral" id="txtobservgral" class="text"></textarea><br/><br/>
        <label for="name">*ESTATUS FACTIBILIDAD:</label> <select name="EstFact" id="lstEstFact"></select><br/><br/>  
        <label for="name">Factibilidad:</label><input type="file" id="file1" name="file"/>     <a href="#" id="archivo" class="verarchivo"/>
        <!--  <input type="button" id="verdcto" value="Ver Documento"/></><br/><br/>                         -->
      </div>            
      <div class="botonesf">
        <p style="text-align:right"><a href="#" class ="posicion_boton_accion_fact">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_fact">Cancelar</a></p>                
      </div>
    </div>        
    <div id="mask"></div>
</div>
 </asp:Content>

