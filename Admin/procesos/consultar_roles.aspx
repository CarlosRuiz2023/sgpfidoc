<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="consultar_roles.aspx.vb" Inherits="Admin_procesos_consultar_roles" Culture="Auto" UICulture="Auto"%>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">



        function ConsultaEdoCtaCoop(idusu, coo_clv2) {
            //alert(img);
            var url1 = "../../Procesos/EdoCtaFteGral_S.html?ResponseType=Edit&idusu=" + idusu + "&coo_clv2=" + coo_clv2;
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1600,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
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



        function MostrarRoles(idusu,filtro) {


            var date = new Date();
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
                           url: "../../WebServices/WebServiceRolesUsuario.asmx/GetRoles_Grid", //PageMethod
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
                     id: "crolid"
                 },
                 colModel: [
                                 {
                                     index: 'crolid', width: 50, align: 'Center', name: 'idrol'
                                 },
                                 {
                                     index: 'croldescripcion', width: 100, align: 'Center', name: 'Descripcion_Rol'
                                 },
                                 {
                                     index: 'crolnombre', width: 100, align: 'Center', name: 'Rol'
                                 },
                                 {
                                     index: 'crolestatus', width: 50, align: 'Center', name: 'Estatus'
                                 },
                                 {
                                     index: 'usrcre', width: 200, align: 'Center', name: 'UsrCre', hidden: true
                                 },
                                 {
                                     index: 'feccre', width: 200, align: 'Center', name: 'FecCre', hidden: true
                                 },
                                 {
                                     index: 'usumod', width: 200, align: 'Center', name: 'UsuMod', hidden: true
                                 },
                                 {
                                     index: 'fecmod', width: 100, align: 'Center', name: 'FecMod', hidden: true
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
                 sortname: "crolid", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1500",
                 height: "800",
                 caption: "CATALOGO DE ROLES",
                 subGrid: true,
                 subGridBeforeExpand: function (subgrid_id, row_id) {
                 var myGrid = $('#grid');
                 obra = myGrid.jqGrid('getRowData', row_id);
                 idrol_principal = parseInt(obra.idrol);                
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
                                    url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetRolAccionTarea_Grid", //PageMethod
                                    data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                          "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                          "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                          "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                          "','idrol':'" + idrol_principal + "'}", //PageMethod Parametros de entrada                                   
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
                               id: "idrol"
                           },
                          colModel: [
                                {
                                    index: 'idrol', width: 50, align: 'Center', name: 'idrol' , hidden: true
                                },
                                {
                                    index: 'idaccion', width: 50, align: 'Center', name: 'idaccion' 
                                },
                                {
                                    index: 'idtarea', width: 50, align: 'Center', name: 'idtarea'
                                },
                                {
                                    index: 'fec_cre', width: 100, align: 'Center', name: 'Fec_Crea_Rol', hidden: true
                                },
                                {
                                    index: 'fec_alta_accion', width: 100, align: 'Center', name: 'Fec_Cre_Accion', hidden: true
                                },
                                {
                                    index: 'etiqueta_accion', width: 200, align: 'Center', name: 'Etiq_accion'
                                },
                                {
                                    index: 'sp', width: 200, align: 'Center', name: 'sp'
                                },
                                {
                                    index: 'descrip_tarea', width: 200, align: 'Center', name: 'Descrip_tarea'
                                },
                                {
                                    index: 'etiqueta_tarea', width: 200, align: 'Center', name: 'Etiq_tarea'
                                },
                                {
                                    index: 'limite_autorizacion', width: 50, align: 'Center', name: 'Lim_Autorizacion'
                                },
                                {
                                    index: 'fec_cre_tarea', width: 100, align: 'Center', name: 'fec_cre_tarea', hidden: true
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
                          sortname: "idrol", //login SortColumn
                          sortorder: "asc", //login SortOrder.
                          width: "1200",
                          height: "100%",
                          caption: "Rol-Accion-Tarea"
                      }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                      .navButtonAdd("#" + pager_id,
                            {
                                caption: "Eliminar Tarea...",
                                buttonicon: "ui-icon-document",
                                onClickButton: function () {
                                    var myGrid = $("#" + subgrid_table_id);
                                    selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                    var idrol = myGrid.jqGrid('getCell', selectedRowId, 'idrol');
                                    var idaccion = myGrid.jqGrid('getCell', selectedRowId, 'idaccion');
                                    var idtarea = myGrid.jqGrid('getCell', selectedRowId, 'idtarea');

                                    if (idrol) {

                                        var objRolAccionTarea = {
                                            "idrol": parseInt(idrol),
                                            "idaccion": parseInt(idaccion),
                                            "idtarea": parseInt(idtarea),
                                            "fec_cre": ConvertirCadenaToFecha('01/01/1900'),
                                            "accion": 2  /*Eliminar un ROL-ACCION-TAREA*/
                                        }

                                        EliminarRolAccionTareaBD(objRolAccionTarea)
                                         .done(function (r) {
                                             var cadena = r.d;
                                             if (cadena != '<NewDataSet />') {
                                                 var num_error = 0;
                                                 var descrip_error = '';

                                                 $(cadena).find("rol").each(function () {
                                                     num_error = $(this).find("noerror").text();
                                                     descrip_error = $(this).find("descerror").text();
                                                 });
                                                 if (parseInt(num_error) > 0) {
                                                     alert('Num. error: ' + num_error + ' ' + descrip_error);
                                                 } else {
                                                     alert('ACCION - TAREA eliminada correctamente');
                                                     RedibujarGrid();
                                                 }


                                             }
                                         })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fue posible consultar los dato del ROL solicitado");
                    });
                                    }
                                    else {
                                        alert("Selecciona una ACCION-TAREA para eliminar...");
                                    }
                                },
                                position: "last",
                                title: "Eliminar ACCION-TAREA",
                                cursor: "pointer"
                            })


            }

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaRol",
                            id: "alta_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objRol = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionRol(objRol,0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditRol",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objRol = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objRol.idrol) {
                                    GestionRol(objRol, 1);
                                   
                                }
                                else {
                                    alert("Selecciona un usuario...");
                                }
                            },
                            position: "last",
                            title: "EditarRol",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "DesactivarRol",
                            id: "desactivar_rol",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objRol = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objRol.idrol) {
                                    if (objRol.Estatus == 1) {
                                        GestionRol(objRol, 2);
                                    }
                                    else {
                                        alert('El ROL esta desactivado');
                                    }

                                }
                                else {
                                    alert("Selecciona un ROL...");
                                }


                            },
                            position: "last",
                            title: "DesactRol",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "ActivarRol",
                            id: "activar_rol",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objRol = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objRol.idrol) {
                                    if (objRol.Estatus == 0) {
                                        GestionRol(objRol, 3);
                                    }
                                    else {
                                        alert('El ROL se encuentra activado.');
                                    }

                                }
                                else {
                                    alert("Selecciona un ROL...");
                                }


                            },
                            position: "last",
                            title: "ActivaRol",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "AsigTarea",
                            id: "asignar_tarea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objRol = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objRol.idrol) {
                                    if (objRol.Estatus == 1) {
                                        GestionRol(objRol,4);
                                    }
                                    else {
                                        alert('No es posible asignar TAREAS a ROLES desactivados');
                                    }

                                }
                                else {
                                    alert("Selecciona un ROL...");
                                }


                            },
                            position: "last",
                            title: "AsignarTareas",
                            cursor: "pointer"
                        });

   
        }



        function ObtenerFiltro() {


            var nom_rol = $('#txtnomrol_q').val();
            if (nom_rol.length <= 0 || nom_rol.length > 30) {
                nom_rol = "NULL";
            }           

            var filtro = nom_rol.toString();
            return filtro;
        }


        function Buscar_Roles(idusu) {
            MostrarRoles(idusu, ObtenerFiltro());
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


            

            $(".buscar_rol").click(function () {
                Buscar_Roles(idusu);
            });

            $(".alta_rol").click(function () {
                GestionRol(0, 0);
            });

            

            $("#bodegadatos").data("idusu", idusu);


           


            $(".posicion_boton_cancelar_rol").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_rol").click(function (e) {                             
                EjecutarAccionRol();
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });


            $(".accion_aceptar_asignar_tarea").click(function (e) {
                
                var hoy = moment();

                var objRolAccionTarea = {
                        "idrol": parseInt($("#bodegadatos").data("idrol")),
                        "idaccion": $("#lstaccion_asig").val(),
                        "idtarea": $("#lsttarea_asig").val(),
                        "fec_cre": hoy,                        
                        "accion":1  /*Alta de un ROL-ACCION-TAREA*/
                    }

                RegistrarRolAccionTareaBD(objRolAccionTarea)
                .done(function (r) {
                    var cadena = r.d;
                    if (cadena != '<NewDataSet />') {
                        var num_error = 0;
                        var descrip_error = '';

                        $(cadena).find("rol").each(function () {
                            num_error = $(this).find("noerror").text();
                            descrip_error = $(this).find("descerror").text();
                        });
                        if (parseInt(num_error) > 0) {
                            alert('Num. error: ' + num_error + ' ' + descrip_error);
                        } else {
                            alert('ACCION - TAREA asignada correctamente');
                        }


                    }
                })
                .fail(function (xhr) {
                    console.log(xhr.responseText);
                    alert("No fué posible asignar la ACCION y TAREA");
                })
               
            });

            $(".accion_cancelar_asignar_tarea").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });

        });

        function EliminarRolAccionTareaBD(objRolAccionTarea) {

            var stringData = JSON.stringify(objRolAccionTarea);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetRolAccionTarea",
                data: "{objRolAccionTarea:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function RegistrarRolBD(objRol) {

            var stringData = JSON.stringify(objRol);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceRolesUsuario.asmx/GuardarRol",
                data: "{objRol:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'                
            });

        };


        function RegistrarRolAccionTareaBD(objRolAccionTarea) {

            var stringData = JSON.stringify(objRolAccionTarea);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetRolAccionTarea",
                data: "{objRolAccionTarea:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function EjecutarAccionRol() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];
            
            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

            var descrip_rol = $("#txtroldescrip").val();
            var nom_rol = $("#txtrolnombre").val();
            var idrol=$("#lblidrol").html();     
            var estatus_rol;
            var accion = parseInt($("#lblaccionrol").html());
         
            var objRol = {
                "crolid": idrol,
                "croldescripcion": descrip_rol,
                "crolestatus": estatus_rol,
                "crolnombre": nom_rol,
                "usrcre": idusu,
                "feccre": hoy,
                "usumod": idusu,
                "fecmod": hoy,
                "accion":accion
            }


            if (accion==0) { /*Registrar rol*/
                objRol.crolestatus = 1;
                RegistrarRolBD(objRol)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');                         
                         alert('El ROL ' + arr[1] + ' ha sido creado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();                         
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);

                     alert("No fue posible guardar el ROL creado");
                 })
            }
            if (accion==1) {
                objRol.crolestatus = 1;              
                RegistrarRolBD(objRol)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El Rol con IdRol:' + arr[1] + ' ha sido modificado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible editar los cambios en ROL");
                 })
                
            }

            if (accion == 2) {
                objRol.crolestatus = 0;

                var resp = confirm('¿Desea desactivar el ROL: ' + objRol.crolnombre + '?');
                if (resp) {
                    RegistrarRolBD(objRol)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Rol con IdRol:' + arr[1] + ' ha sido desactivado satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible desactivar el ROL solicitado");
                     })
                } 

            }

            if (accion == 3) {
                objRol.crolestatus = 1;
                var resp = confirm('¿Desea activar el ROL: ' + objRol.crolnombre + '?');
                if (resp) {
                    RegistrarRolBD(objRol)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Rol con IdRol:' + arr[1] + ' ha sido activado satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el ROL solicitado");
                     })
                }

            }


           

        }

        function GestionRol(objRol, accion) {

            if (accion == 0) {  /*Alta de Rol*/             
                $("#txtrolnombre").val('');
                $("#txtroldescrip").val('');
                $("#lblidrol").html('0');
                $("#lblaccionrol").html(accion);
                MostrarModalRol();
            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    var idrol = parseInt(objRol.idrol);
                    ConsultaDatosRol(idrol)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            $(cadena).find("rol").each(function () {
                                $("#lblidrol").html($(this).find("crolidr").text());
                                $("#lblaccionrol").html(accion);
                                $("#txtrolnombre").val($(this).find("crolnombrer").text());
                                $("#txtroldescrip").val($(this).find("croldescripcionr").text());
                            });
                        }
                        if (accion == 2 || accion == 3) {
                            $("#txtrolnombre").prop('disabled', true);
                            $("#txtroldescrip").prop('disabled', true);;
                        }
                        else {
                            $("#txtrolnombre").prop('disabled', false);;
                            $("#txtroldescrip").prop('disabled', false);;
                        }
                        MostrarModalRol();
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fue posible consultar los dato del ROL solicitado");
                    });
                }

                if (accion == 4) {
                    $("#lblrol_asig").html(objRol.Rol);
                    $("#bodegadatos").data("idrol",objRol.idrol);
                    LlenarListAccion(0);
                    LlenarListTareas(0);
                    MostrarModalAsigRol();

                }
            }          

        }


        function LlenarListAccion(idAccion) {

            $.ajax({
                url: "../../WebServices/WebServiceAccion.asmx/GetAccion",
                data: "{'idAccion':'" + idAccion + "'}",
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#lstaccion_asig").html('');
                        $(data.d).find("accion").each(function () {
                            var idaccion = $(this).find("idaccionr").text();
                            var nom_accion = $(this).find("etiqueta_accionr").text();
                            var option = $(document.createElement('option'));

                            option.html(nom_accion);
                            option.val(idaccion);
                            $("#lstaccion_asig").append(option);
                        });                    
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }


        function LlenarListTareas(idTarea) {

            $.ajax({
                url: "../../WebServices/WebServiceTarea.asmx/GetTarea",
                data: "{'idTarea':'" + idTarea + "'}",
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    $("#lsttarea_asig").html('');
                    $(data.d).find("tarea").each(function () {
                        var idtarea = $(this).find("idtarear").text();              
                        var nom_tarea = $(this).find("etiqueta_tarear").text();
                        var option = $(document.createElement('option'));
                        option.html(nom_tarea);
                        option.val(idtarea);
                        $("#lsttarea_asig").append(option);
                    });
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }

        function ConsultaDatosRol(idrol) {            
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceRolesUsuario.asmx/GetRol",
                data: "{idrol:" + idrol + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }


        function MostrarModalRol() {
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
            $("#dialogorol").css('top', winH / 2 - $("#dialogorol").height() / 2);
            $("#dialogorol").css('left', winW / 2 - $("#dialogorol").width() / 2);

            //transition effect
            $("#dialogorol").fadeIn(2000);
        };


        function MostrarModalAsigRol() {
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
            $("#asig_tarea").css('top', winH / 2 - $("#asig_tarea").height() / 2);
            $("#asig_tarea").css('left', winW / 2 - $("#asig_tarea").width() / 2);

            //transition effect
            $("#asig_tarea").fadeIn(2000);
        };


</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <label>Nombre del Rol:</label><input type="text" name="nomrol_q" id="txtnomrol_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_rol"><== Buscar Rol ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_rol"><== Alta Rol ==></a><br/><br/>        
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
    <div id="dialogorol" class="window"> 
       <div id="titulorol"> 
         <p style="text-align:center">GESTION DE ROLES</p>
         idRol: <label for="idrol" id="lblidrol"></label><br/>         
         Acción:<label for="accion" id="lblaccionrol"></label><br/>
       </div>
       <div class="datos" id="bodyrol">                  
          <label for="name" id="lblrolnombre">*Nombre de Rol:</label><input type="text" name="rolnombre" id="txtrolnombre" size="80"/><br/><br/>
          <label for="name" id="lblroldescrip">*Descripción del Rol::</label><input type="text" name="descriprol" id="txtroldescrip" size="80"/><br/><br/>          
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_rol">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_rol">Cancelar</a></p>                
       </div>
    </div>
    <div id="asig_tarea" class="window">
          <table class="t_modulo">
              <tbody> 
                  <tr>
                      <td class="titulo_modulo" colspan="2">ASIGNACION DE TAREAS</td>
                  </tr>   
                  <tr>
                      <td class="c" colspan="2"><label id="lblrol_asig"></label></td>
                  </tr>
                  <tr>
                      <td class="d">ACCION: </td><td class="e"><select name="accion" id="lstaccion_asig"></select></td>
                  </tr>                                                     
                  <tr>
                      <td class="d">TAREA: </td><td class="e"><select name="tarea" id="lsttarea_asig"></select></td>
                  </tr>                                                     
                  <tr>
                      <td class="boton_dialog"><a href="#" class="accion_aceptar_asignar_tarea">ASIGNAR</a></td><td class="boton_dialog"><a href="#" class="accion_cancelar_asignar_tarea">CANCELAR</a></td>
                  </tr>                  
              </tbody>
          </table>
      </div>              
    <div id="mask"></div>
 </div>
</asp:Content>


