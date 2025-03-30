<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_act_costo_obra.aspx.vb" Inherits="Admin_procesos_consultar_act_costo_obra" %>
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

            function CompletaCerosIzq(cadena, longitud) {

                cadena.length > longitud
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



            function MostrarAct_costo_obra(idusu, filtro) {


                /*   var date = new Date();
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
                                  url: "../../WebServices/WebServiceAct_costo_obra.asmx/GetAct_costo_obra_Grid", //PageMethod
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
                            id: "idAct_costo_obra"
                        },
                        colModel: [
                                        {
                                            index: 'idAct_costo_obra', width: 50, align: 'Center', name: 'idAct_costo_obra'
                                        },
                                        {
                                            index: 'lugar', width: 300, align: 'Center', name: 'Lugar'
                                        },
                                        {
                                            index: 'idpromotor', width: 300, align: 'Center', name: 'idPromotor', hidden: true
                                        },
                                        {
                                            index: 'nom_promotor', width: 200, align: 'Center', name: 'NombrePromotor'
                                        },
                                        {
                                            index: 'idtAct_costo_obra', width: 50, align: 'Center', name: 'idTipoAct_costo_obra', hidden: true
                                        },
                                        {
                                            index: 'nom_tAct_costo_obra', width: 250, align: 'Center', name: 'NombreTipoAsmablea'
                                        },
                                        {
                                            index: 'fecha_Act_costo_obra', width: 80, align: 'Center', name: 'FechaAct_costo_obra'
                                        },
                                        {
                                            index: 'num_asistentes', width: 50, align: 'Center', name: 'NumAsistentes'
                                        },
                                        {
                                            index: 'fecha_programa', width: 80, align: 'Center', name: 'FechaPrograma'
                                        },
                                        {
                                            index: 'docto_evidencia', width: 80, align: 'Center', name: 'DctoAct_costo_obra'
                                        },
                                        {
                                            index: 'oid', width: 50, align: 'Center', name: 'oid'
                                        },
                                        {
                                            index: 'estatus_Act_costo_obra', width: 50, align: 'Center', name: 'idEstatusAct_costo_obra', hidden: true
                                        },
                                        {
                                            index: 'cestatus', width:80, align: 'Center', name: 'EstatusAct_costo_obra'
                                        },
                                        {
                                            index: 'usu_cre', width: 50, align: 'Center', name: 'UsuCre', hidden: true
                                        },
                                        {
                                            index: 'usu_mod', width: 50, align: 'Center', name: 'UsuMod', hidden: true
                                        },
                                        {
                                            index: 'fec_cre', width: 50, align: 'Center', name: 'FecCre',hidden: true
                                        },
                                        {
                                            index: 'fec_mod', width: 50, align: 'Center', name: 'FecMod', hidden: true
                                        },                                 
                                        {
                                            index: 'calle', width: 200, align: 'Center', name: 'Calle_Obra'
                                        },
                                        {
                                            index: 'colonia', width: 200, align: 'Center', name: 'Colonia_Obra'
                                        },
                                        {
                                            index: 'tramo', width: 200, align: 'Center', name: 'Tramo'
                                        }],
                        pager: "#pager", //Pager.                 
                        loadtext: 'Cargando datos...',
                        recordtext: "{0} - {1} de {2} elementos",
                        emptyrecords: 'No hay resultados',
                        pgtext: 'Pág:{0} de {1}', //Paging input contAccion text format.
                        rowNum: "20", // PageSize.
                        rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                        viewrecords: true, //Show the RecordCount in the pager.
                        multiselect: false,
                        sortname: "idAct_costo_obra", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1800",
                        height: "800",
                        caption: "GESTION DE Act_costo_obraS"
       
                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                      .navButtonAdd('#pager',
                               {
                                   caption: "AltaAct_costo_obra",
                                   id: "alta_Act_costo_obra",
                                   buttonicon: "ui-icon-document",
                                   onClickButton: function () {
                                       var myGrid = $('#grid');
                                       var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                       var objAct_costo_obra = myGrid.jqGrid('getRowData', selectedRowId);
       
                                       GestionAct_costo_obra(objAct_costo_obra, 0);
       
                                   },
                                   position: "last",
                                   title: "AltaAsamb",
                                   cursor: "pointer"
                               })
       
                        .navButtonAdd('#pager',
                               {
                                   caption: "EditAct_costo_obra",
                                   id: "edit_usuario",
                                   buttonicon: "ui-icon-document",
                                   onClickButton: function () {
                                       var myGrid = $('#grid');
                                       var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                       var objAct_costo_obra = myGrid.jqGrid('getRowData', selectedRowId);
       
                                       if (objAct_costo_obra.idAct_costo_obra) {
                                           GestionAct_costo_obra(objAct_costo_obra, 1);
                                       }
                                       else {
                                           alert("Selecciona una Act_costo_obra...");
                                       }
                                   },
                                   position: "last",
                                   title: "DctoDet",
                                   cursor: "pointer"
                               });
       
                   /*.navButtonAdd('#pager',
                          {
                              caption: "DesactivarTipoAct_costo_obra",
                              id: "desactivar_Accion",
                              buttonicon: "ui-icon-document",
                              onClickButton: function () {
       
                                  var myGrid = $('#grid');
                                  var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                  var objTipoAct_costo_obra = myGrid.jqGrid('getRowData', selectedRowId);
       
                                  if (objTipoAct_costo_obra.idTipoAsamb) {
                                      if (objTipoAct_costo_obra.Estatus == 1) {
                                          GestionTipoAct_costo_obra(objTipoAct_costo_obra, 2);
                                      }
                                      else {
                                          alert('El Tipo de Act_costo_obra esta desactivado');
                                      }
                                  }
                                  else {
                                      alert("Selecciona un Tipo de Act_costo_obra...");
                                  }
                              },
                              position: "last",
                              title: "DctoDet",
                              cursor: "pointer"
                          })
       
              .navButtonAdd('#pager',
                          {
                              caption: "ActivarTipoAct_costo_obra",
                              id: "activar_Accion",
                              buttonicon: "ui-icon-document",
                              onClickButton: function () {
       
                                  var myGrid = $('#grid');
                                  var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                  var objTipoAct_costo_obra = myGrid.jqGrid('getRowData', selectedRowId);
       
                                  if (objTipoAct_costo_obra.idTipoAsamb) {
                                      if (objTipoAct_costo_obra.Estatus == 0) {
                                          GestionTipoAct_costo_obra(objTipoAct_costo_obra, 3);
                                      }
                                      else {
                                          alert('El Tipo de Act_costo_obra esta activado');
                                      }
       
                                  }
                                  else {
                                      alert("Selecciona un Tipo de Act_costo_obra...");
                                  }
       
       
                              },
                              position: "last",
                              title: "DctoDet",
                              cursor: "pointer"
                          });*/

            }



            function ObtenerFiltro() {


                var calle_Act_costo_obra = $.trim($('#txtcalle_Act_costo_obra_q').val());
                var colonia_Act_costo_obra = $.trim($('#txtcolonia_Act_costo_obra_q').val());
                var promotor = $.trim($('#txtpromotor_Act_costo_obra_q').val());
                if (calle_Act_costo_obra.length <= 0 || calle_Act_costo_obra.length > 100) {
                    calle_Act_costo_obra = "NULL";
                }
                if (colonia_Act_costo_obra.length <= 0 || colonia_Act_costo_obra.length > 100) {
                    colonia_Act_costo_obra = "NULL";
                }
                if (promotor.length <= 0 || promotor.length > 100) {
                    promotor = "NULL";
                }

                var filtro = calle_Act_costo_obra.toString() + ',' + colonia_Act_costo_obra.toString() + ',' + promotor.toString() + ',';
                return filtro;
            }


            function Buscar_Act_costo_obra(idusu) {
                MostrarAct_costo_obra(idusu, ObtenerFiltro());
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

                $("#bodegadatos").data("idusu", idusu);



                $(".buscar_act_costo_obra").click(function () {
                    Buscar_Act_costo_obra(idusu);
                });

                $(".alta_actualizacion").click(function () {
                    GestionAct_costo_obra(0, 0);
                });



                $(".posicion_boton_cancelar_act_costo_obra").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_act_costo_obra").click(function (e) {
                    EjecutarAccionAct_costo_obra();
                });




                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });





            function ConsultaReglasUsuario(idusu, accion) {

                return $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; utf-8',
                    url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetUsuAccionTarea",
                    data: "{'idusu':'" + idusu + "','accion':'" + accion + "'}",
                });
            }

            function RegistrarAct_costo_obraBD(objAct_costo_obra) {

                var stringData = JSON.stringify(objAct_costo_obra);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceAct_costo_obra.asmx/GuardarAct_costo_obra",
                    data: "{objAct_costo_obra:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionAct_costo_obra() {

                var idusu = $("#bodegadatos").data("idusu");

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

                var accion = parseInt($("#lblaccion_Act_costo_obra").html());
                var idAct_costo_obra = parseInt($("#lblidAct_costo_obra").html());
                var lugar = $("#txtdescrip_lugar").val();
                var idpromotor = $("#lstpromotor").val();
                var idtAct_costo_obra = $("#lsttipo_Act_costo_obra").val();
                var fecha_programa = $("#txtfec_programa").val();
                var num_asistentes = parseInt($("#txtnum_asistentes").val());
                var fecha_Act_costo_obra = $("#txtfec_Act_costo_obra").val();
                var docto_evidencia = 'Act_costo_obra_' + $("#lblidAct_costo_obra").html() + '.pdf';
                var oid = parseInt($("#lbloid").html());
                var estatus_Act_costo_obra = $("#lstestatus_Act_costo_obra").val();

                var objAct_costo_obra = {
                    "idAct_costo_obra": 0,
                    "lugar": '',
                    "idtAct_costo_obra": 0,
                    "fecha_Act_costo_obra": '01/01/1900',
                    "num_asistentes": 0,
                    "fecha_programa": '01/01/1900',
                    "docto_evidencia": '',
                    "oid": 0,
                    "usu_cre": idusu,
                    "usu_mod": idusu,
                    "fec_cre": hoy,
                    "fec_mod": hoy,
                    "estatus_Act_costo_obra": 0,
                    "idpromotor": 0,
                    "accion": accion
                }


                if (accion == 0) { /*Registrar Accion*/
                    if (ValidarDatosAct_costo_obra()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objAct_costo_obra.idAct_costo_obra = 0;
                        objAct_costo_obra.lugar = lugar;
                        objAct_costo_obra.idpromotor = parseInt(idpromotor);
                        objAct_costo_obra.idtAct_costo_obra = parseInt(idtAct_costo_obra);
                        objAct_costo_obra.num_asistentes = num_asistentes;
                        objAct_costo_obra.estatus_Act_costo_obra = parseInt(estatus_Act_costo_obra);
                        objAct_costo_obra.fecha_programa = ConvertirCadenaToFecha(fecha_programa);
                        objAct_costo_obra.fecha_Act_costo_obra = ConvertirCadenaToFecha(fecha_Act_costo_obra);
                        objAct_costo_obra.docto_evidencia = docto_evidencia;
                        objAct_costo_obra.oid = oid;


                        RegistrarAct_costo_obraBD(objAct_costo_obra)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = arr[1];
                                    if (error == '0') {
                                        ValidacionGuardadoArchivo($("#file_asam").get(0).files, objAct_costo_obra.docto_evidencia);
                                        alert('La Act_costo_obra ' + arr[3] + ' ha sido creado satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);

                                alert("No fue posible guardar la Act_costo_obra creada");
                            })
                    }
                }


                if (accion == 1) {
                    if (ValidarDatosAct_costo_obra()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                        objAct_costo_obra.idAct_costo_obra = idAct_costo_obra;
                        objAct_costo_obra.lugar = lugar;
                        objAct_costo_obra.idpromotor = parseInt(idpromotor);
                        objAct_costo_obra.idtAct_costo_obra = parseInt(idtAct_costo_obra);
                        objAct_costo_obra.num_asistentes = num_asistentes;
                        objAct_costo_obra.estatus_Act_costo_obra = parseInt(estatus_Act_costo_obra);
                        objAct_costo_obra.fecha_programa = ConvertirCadenaToFecha(fecha_programa);
                        objAct_costo_obra.fecha_Act_costo_obra = ConvertirCadenaToFecha(fecha_Act_costo_obra);
                        objAct_costo_obra.docto_evidencia = docto_evidencia;
                        objAct_costo_obra.oid = oid;

                        var oid_inicial = $("#bodegadatos").data("oid_inicial");

                        if (objAct_costo_obra.oid != oid_inicial) {
                            objAct_costo_obra.accion = 4; /*Asigna el valor de la accion para que directamente actualice el OID de la Act_costo_obra y evitar que se repita la Act_costo_obra del tipo "ACTUALIZACION DE COSTO" */
                        }


                        RegistrarAct_costo_obraBD(objAct_costo_obra)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = arr[1];
                                    if (error == '0') {
                                        ValidacionGuardadoArchivo($("#file_asam").get(0).files, objAct_costo_obra.docto_evidencia);
                                        alert('La Act_costo_obra ' + arr[3] + ' ha sido editada satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible guardar la Act_costo_obra creada");
                            })
                    }

                }

                /*  if (accion == 2) {
                      objTipoAct_costo_obra.cactivo = 0;
                      objTipoAct_costo_obra.idtipoAct_costo_obra = parseInt($("#lbl_idtipoAct_costo_obra").html());
                      var resp = confirm('¿Desea desactivar el Tipo de Act_costo_obra: ' + objTipoAct_costo_obra.Etiqueta + '?');
                      if (resp) {
                          RegistrarTipoAct_costo_obraBD(objTipoAct_costo_obra)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   alert('El Tipo de Act_costo_obra con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                   $('#mask, .window').hide();
                                   RedibujarGrid();
                               }
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fue posible desactivar el Tipo de Act_costo_obra solicitada");
                           })
                      }
      
                  }
      
                  if (accion == 3) {
                      objTipoAct_costo_obra.cactivo = 1;
                      objTipoAct_costo_obra.idtipoAct_costo_obra = parseInt($("#lbl_idtipoAct_costo_obra").html());
                      var resp = confirm('¿Desea activar el Tipo de Act_costo_obra: ' + objTipoAct_costo_obra.Etiqueta + '?');
                      if (resp) {
                          RegistrarTipoAct_costo_obraBD(objTipoAct_costo_obra)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   alert('El Tipo de Act_costo_obra con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                                   $('#mask, .window').hide();
                                   RedibujarGrid();
                               }
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fue posible activar el Tipo de Act_costo_obra solicitada");
                           })
                      }
      
                  }*/

            }

            function ValidarDatosAct_costo_obra() {

                var valid;

                fecha_programa = ConvertirCadenaToFecha($("#txtfec_programa").val());
                fecha_Act_costo_obra = ConvertirCadenaToFecha($("#txtfec_Act_costo_obra").val());

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());


                if (parseInt($("#txtnum_asistentes").val()) > 0) {
                    valid = true;
                    if (fecha_programa > fecha_Act_costo_obra) {
                        valid = false;
                        alert('ERROR: La fecha de programación es mayor a la fecha de Act_costo_obra');
                    }
                    if (fecha_Act_costo_obra > hoy) {
                        valid = false;
                        alert('ERROR: La fecha de la Act_costo_obra es mayor a hoy');
                    }
                } else {
                    valid = false;
                    alert('El número de asistentes es erróneo')
                }

                if (valid) {
                    if ($("#file_asam").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                        if (ValidarArchivo($("#file_asam")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                            valid = true;
                        }
                        else {
                            $("#file_asam").val("");
                            valid = false;
                        }
                    }
                    else {
                        if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                            valid = true;
                        }
                        else {
                            alert("No se capturado el documento de la Act_costo_obra");
                            valid = false;
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

            function GestionAct_costo_obra(objAct_costo_obra, accion) {

                var reglas_usu = [];
                var idusu = $("#bodegadatos").data("idusu");

                MostrarModalAct_costo_obra();

                /*    if (accion == 0) {  /*Alta de Act_costo_obra            
                        ConsultaReglasUsuario(idusu, 0)
                           .done(function (r) {
                               var regla = $.trim(r.d);
                               if (regla != "<NewDataSet />") {  // Si encontró reglas para el usuario, preparar las propiedades correspondientes
        
                                   $(r.d).find("regla").each(function () {
        
                                       var objReglaUsu = {
                                           "idrol": 0,
                                           "crolnombre": '',
                                           "croldescripcion": 0,
                                           "idaccion": 0,
                                           "etiqueta_accion": 0,
                                           "idtarea": 0,
                                           "etiqueta_tarea": '',
                                           "fec_cre": '01/01/1900',
                                           "musuid": 0,
                                           "musunombre": '',
                                           "musucuenta": 0
                                       }
        
                                       objReglaUsu.idrol = parseInt($(this).find("idrol_r").text());
                                       objReglaUsu.crolnombre = $(this).find("crolnombre_r").text();
                                       objReglaUsu.croldescripcion = $(this).find("croldescripcion_r").text();
                                       objReglaUsu.idaccion = parseInt($(this).find("idaccion_r").text());
                                       objReglaUsu.etiqueta_accion = $(this).find("etiqueta_accion_r").text();
                                       objReglaUsu.idtarea = parseInt($(this).find("idtarea_r").text());
                                       objReglaUsu.etiqueta_tarea = $(this).find("etiqueta_tarea_r").text();
                                       objReglaUsu.fec_cre = $(this).find("fec_cre_r").text();
                                       objReglaUsu.musuid = parseInt($(this).find("musuid_r").text());
                                       objReglaUsu.musunombre = $(this).find("musunombre_r").text();
                                       objReglaUsu.musucuenta = parseInt($(this).find("musucuenta_r").text());
                                       reglas_usu.push(objReglaUsu);
                                   });
        
                                   /*Tarea 153: Admitir alta de Act_costo_obras
                                   var puede_registrar_Act_costo_obras = reglas_usu.find(tarea => (tarea.idtarea == 153 && tarea.idaccion==3));
        
                                   if (puede_registrar_Act_costo_obras==null)
                                   {
                                       alert ('El usuario no tiene permiso para registrar Act_costo_obras.');
                                   }
                                   else {                       
                                       $("#lblidAct_costo_obra").html('0');
                                       $("#lblaccion_Act_costo_obra").html(accion);
                                       $("#txtdescrip_lugar").val('');
                                       $("#txtfec_programa").val('');
                                       $("#txtfec_Act_costo_obra").val('');
                                       $("#txtnum_asistentes").val('');
                                       $("#archivo").text('')
                                       $("#file_asam").val('');
                                       llenarObrasSGP(5,0);                
                                       llenarPromotores(0, 'listar_promotores');
                                       llenarEstatusAct_costo_obra(0);
                                       llenarTipoAct_costo_obra(0);      
                                       MostrarModalAct_costo_obra();
                                   };
                               }
                               else {
                                   alert("El usuario no tiene permiso para registrar Act_costo_obras.");
                               }
        
                           }).fail(function (r) {
                               alert("No fué posible consultar las reglas del usuario.");
                           });                        
                    }
                    else {
                        if (accion == 1) 
                            var estatus_Act_costo_obra = parseInt(objAct_costo_obra.idEstatusAct_costo_obra);
                        if (estatus_Act_costo_obra!=3) {
                            ConsultaReglasUsuario(idusu, 0)
                            .done(function (r) {
                                var regla = $.trim(r.d);
                                if (regla != "<NewDataSet />") {  // Si encontró reglas para el usuario, preparar las propiedades correspondientes
        
                                    $(r.d).find("regla").each(function () {
                                        var objReglaUsu = {
                                            "idrol": 0,
                                            "crolnombre": '',
                                            "croldescripcion": 0,
                                            "idaccion": 0,
                                            "etiqueta_accion": 0,
                                            "idtarea": 0,
                                            "etiqueta_tarea": '',
                                            "fec_cre": '01/01/1900',
                                            "musuid": 0,
                                            "musunombre": '',
                                            "musucuenta": 0
                                        }
        
                                        objReglaUsu.idrol = parseInt($(this).find("idrol_r").text());
                                        objReglaUsu.crolnombre = $(this).find("crolnombre_r").text();
                                        objReglaUsu.croldescripcion = $(this).find("croldescripcion_r").text();
                                        objReglaUsu.idaccion = parseInt($(this).find("idaccion_r").text());
                                        objReglaUsu.etiqueta_accion = $(this).find("etiqueta_accion_r").text();
                                        objReglaUsu.idtarea = parseInt($(this).find("idtarea_r").text());
                                        objReglaUsu.etiqueta_tarea = $(this).find("etiqueta_tarea_r").text();
                                        objReglaUsu.fec_cre = $(this).find("fec_cre_r").text();
                                        objReglaUsu.musuid = parseInt($(this).find("musuid_r").text());
                                        objReglaUsu.musunombre = $(this).find("musunombre_r").text();
                                        objReglaUsu.musucuenta = parseInt($(this).find("musucuenta_r").text());
                                        reglas_usu.push(objReglaUsu);
                                    });
        
                                    /*Tarea 154: Admitir edicion de Act_costo_obras
                                    var puede_editar_Act_costo_obras = reglas_usu.find(tarea => (tarea.idtarea == 154 && tarea.idaccion==3));
        
                                    if (puede_editar_Act_costo_obras==null)
                                    {
                                        alert ('El usuario no tiene permiso para editar Act_costo_obras.');
                                    }
                                    else {                       
                                        $("#lblidAct_costo_obra").html(objAct_costo_obra.idAct_costo_obra);
                                        $("#lblaccion_Act_costo_obra").html(accion);
                                        $("#txtdescrip_lugar").val(objAct_costo_obra.Lugar);
                                        $("#txtfec_programa").val(objAct_costo_obra.FechaPrograma);
                                        $("#txtfec_Act_costo_obra").val(objAct_costo_obra.FechaAct_costo_obra);
                                        $("#txtnum_asistentes").val(objAct_costo_obra.NumAsistentes); 
                                        $("#archivo").text(objAct_costo_obra.DctoAct_costo_obra)
                                        $("#file_asam").val('');
                                        llenarObrasSGP(5,objAct_costo_obra.oid);                
                                        llenarPromotores(objAct_costo_obra.idPromotor, 'listar_promotores');
                                        llenarEstatusAct_costo_obra(objAct_costo_obra.idEstatusAct_costo_obra);
                                        llenarTipoAct_costo_obra(objAct_costo_obra.idTipoAct_costo_obra);      
                                        MostrarModalAct_costo_obra();
                                    };
                                }
                                else {
                                    alert("El usuario no tiene permiso para editar Act_costo_obras.");
                                }
        
                            }).fail(function (r) {
                                alert("No fué posible consultar las reglas del usuario.");
                            });    
                        } else {
                            alert('Esta Act_costo_obra no es posible modificarla debido a que ya mantiene otros procesos referenciados');
                        }
                    }*/

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


            function MostrarModalAct_costo_obra() {
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
                $("#dialogo_act_costo_obra").css('top', winH / 2 - $("#dialogo_act_costo_obra").height() / 2);
                $("#dialogo_act_costo_obra").css('left', winW / 2 - $("#dialogo_act_costo_obra").width() / 2);

                //transition effect
                $("#dialogo_act_costo_obra").fadeIn(2000);
            };


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
                    url: "../../WebServices/WebServiceFileUpload.asmx/GuardarArchivo",
                    contentType: false,
                    processData: false,
                    data: formdata
                });
            }

            function llenarObrasSGP(accion, oid) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                    data: "{'accion':'" + accion + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lst_obra_s").html('');
                        $(data.d).find("ObrasSGP").each(function () {
                            var option = $(document.createElement('option'));
                            var obr_clv = $(this).find("obra_s").text();
                            var obr_clv_int = $(this).find("obr_clv_int_r").text();
                            var obr_call = $(this).find("calle_r").text();
                            var obr_colonia = $(this).find("colonia_r").text();
                            var obr_tramo = $(this).find("tramo_r").text();
                            var oid = $(this).find("oid_r").text();
                            option.html(obr_clv + ' || ' + obr_call + ' || ' + obr_colonia + ' || ' + obr_tramo + ' || ' + obr_clv_int + ' || ' + oid);
                            option.val(oid);
                            $("#lst_obra_s").append(option);
                        });

                        if (parseInt(oid) > 0) {
                            $("#lst_obra_s").val(oid);
                            $("#bodegadatos").data("oid_inicial", parseInt(oid));
                        }

                        LlenaLabelObra($("#lst_obra_s option:selected").text());

                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }


            function LlenaLabelObra(cadena_activa) {
                if ($.trim(cadena_activa.length) > 0) {
                    datos_obra = cadena_activa.split(' || ');
                    var calle = datos_obra[1];
                    var colonia = datos_obra[2];
                    var tramo = datos_obra[3];
                    var obr_clv_int = datos_obra[4];
                    var oid = datos_obra[5];
                    var obra = datos_obra[0];

                    $("#lblcalle").html(calle);
                    $("#lblcolonia").html(colonia);
                    $("#lbltramo").html(tramo);
                    $("#lblobra_s").html(obra);
                    $("#lblobr_clv_int").html(obr_clv_int);
                    $("#lbloid").html(oid);
                }
            }

            function llenarPromotores(idpromotor, accion) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceUsuario.asmx/GetUsuarioMinistros",
                    data: "{'accion':'" + accion + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lstpromotor").html('');
                        $(data.d).find("UsuarioMinistros").each(function () {
                            var option = $(document.createElement('option'));
                            var idusu = $(this).find("musuidr").text();
                            var nom_promotor = $(this).find("musunombrer").text();
                            option.html(nom_promotor);
                            option.val(idusu);
                            $("#lstpromotor").append(option);
                        });
                        if (idpromotor > 0) { //
                            $("#lstpromotor").val(idpromotor);
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }



            function llenarEstatusAct_costo_obra(idest_asam) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceEstatusAct_costo_obra.asmx/GetEstatusAct_costo_obra",
                    data: "{'idest_asam':'" + idest_asam + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lstestatus_Act_costo_obra").html('');
                        $(data.d).find("estatus_Act_costo_obra").each(function () {
                            var option = $(document.createElement('option'));
                            var idestatus_Act_costo_obra = $(this).find("idestatus_Act_costo_obrar").text();
                            var etiqueta_Act_costo_obra = $(this).find("etiqueta_estatus_Act_costo_obrar").text();
                            var estatus_estatus_Act_costo_obra = $(this).find("cactivor").text();
                            var usu_cre = $(this).find("usu_crer").text();
                            option.html(etiqueta_Act_costo_obra);
                            option.val(idestatus_Act_costo_obra);
                            $("#lstestatus_Act_costo_obra").append(option);
                        });
                        if (idest_asam > 0) { //
                            $("#lstestatus_Act_costo_obra").val(idest_asam);
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }


            function llenarTipoAct_costo_obra(idtipo_asam) {

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceTipoAct_costo_obra.asmx/GetTipoAct_costo_obra",
                    data: "{'idtipoAct_costo_obra':'" + '0' + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lsttipo_Act_costo_obra").html('');
                        $(data.d).find("tipo_Act_costo_obra").each(function () {
                            var option = $(document.createElement('option'));
                            var idtipo_Act_costo_obra = $(this).find("idtipoAct_costo_obra_r").text();
                            var etiqueta_tipo_Act_costo_obra = $(this).find("etiqueta_r").text();
                            var descrip_tipo_Act_costo_obra = $(this).find("descrip_tipo_r").text();
                            var usu_cre_Act_costo_obra = $(this).find("usu_cre_r").text();
                            var estatus_tipo_Act_costo_obra = $(this).find("cactivo_r").text();
                            var feccre_tipo_Act_costo_obra = $(this).find("fec_cre_r").text();
                            option.html(etiqueta_tipo_Act_costo_obra);
                            option.val(idtipo_Act_costo_obra);
                            $("#lsttipo_Act_costo_obra").append(option);
                        });
                        if (idtipo_asam > 0) { //
                            $("#lsttipo_Act_costo_obra").val(idtipo_asam);
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Calle Act_costo_obra:</label><input type="text" name="calle_act_costo_obra"
            id="txtcalle_act_costo_obra_q" style="width:250px" maxlength="120" /><br /><br />
        <label>Colonia:</label><input type="text" name="colonia_act_costo_obra" id="txtcolonia_act_costo_obra_q"
            style="width:250px" maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
            class="buscar_actualizacion">
            <== Buscar Actualización de Costo Obra==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_actualizacion">
            <== Alta Actualización de Costo de Obra==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>


        <div id="boxes">
            <div id="dialogo_act_costo_obra" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="6" class="titulo_modulo">GESTION DE ACTUALIZACION DE COSTO DE OBRA</td>
                        </tr>
                        <tr>
                            <td class="f">Folio:</td>
                            <td class="e"><input type="text" name="folio_act_costo_obra" id="txtfolio_act_costo_obra"
                                    size="10" maxlength="10" /></td>
                            <td class="f">Fecha:</td>
                            <td><input type="text" name="fec_act_costo_obra" id="txtFecCostoObra" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                            <td class="f">Asamblea:</td>
                            <td class="e"><select name="obras_s" id="Select1"
                                    onchange="LlenaLabelObra(this.options[this.selectedIndex].text);"></select></td>
                        </tr>
                        <tr>
                            <td class="f">Calle:</td>
                            <td class="e" colspan="3"><label id="lblcalle" /></td>
                        </tr>
                        <tr>
                            <td class="f">Colonia:</td>
                            <td class="e" colspan="3"><label id="lblcolonia" /></td>
                        </tr>
                        <tr>
                            <td class="f">Tramo:</td>
                            <td class="e" colspan="3"><label id="lbltramo" /></td>
                        </tr>
                        <tr>
                            <td class="f">Obra_s:</td>
                            <td class="e"><label id="lblobra_s" /></td>
                            <td class="f">IdObra:</td>
                            <td class="e"><label id="lblobr_clv_int" /></td>
                            <td class="f">Programa:</td>
                            <td class="e"><label id="lblprograma" /></td>
                        </tr>
                        <tr>
                            <td class="f">Sesión de Comité Técnico:</td>
                            <td class="e"><select name="obras_s" id="lstcomite"
                                    onchange="LlenaLabelObra(this.options[this.selectedIndex].text);"></select></td>
                            <td class="f">Tipo de Sesión:</td>
                            <td class="e"><label id="lbltipo_sesion" /></td>
                            <td class="f">Fecha Sesión:</td>
                            <td class="e"><label id="lblfec_sesion" /></td>

                        </tr>
                        <tr>
                            <td class="f">No. Acuerdo:</td>
                            <td class="e"><input type="text" name="fec_programa" id="txtfec_programa" size="10"
                                    maxlength="10" onkeyup="this.value=formateafecha(this.value);" /></td>
                            <td class="f">Descripción de Acuerdo:</td>
                            <td class="e" colspan="3"><label id="lbldescrip_acuerdo" /></td>
                        </tr>
                        <tr>
                            <td class="f">Costo Metro Lineal ACTUAL:</td>
                            <td class="e"><label id="lblcosto_mto_actual" /></td>
                            <td class="f">Costo Metro Lineal NUEVO</td>
                            <td class="e"><label id="lblcosto_mto_nuevo" /></td>
                            <td class="f">Porcentaje Incremento</td>
                            <td class="e"><label id="lblporcoentaje_incremento" /></td>
                        </tr>
                        <tr>
                            <td colspan="6" class="titulo_modulo2">COOPERADORES SIN CUBRIR CAPITAL</td>
                        </tr>
                        <tr>
                            <td id="grid_coops_con_saldo">
                                <div id="pager2"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="f">idact_costo_obra:</td>
                            <td class="e"><label id="lblidact_costo_obra" /></td>
                            <td class="f">idUsuario:</td>
                            <td class="e"><label id="lblidusu_act_costo_obra" /></td>
                            <td class="f">accion:</td>
                            <td class="e"><label id="lblaccion_act_costo_obra" /></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="boton_dialog"><a href="#"
                                    class="posicion_boton_accion_act_costo_obra">ACEPTAR</a></td>
                            <td colspan="3" class="boton_dialog"><a href="#"
                                    class="posicion_boton_cancelar_act_costo_obra">CANCELAR</a></td>
                        </tr>

                    </tbody>
                </table>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>