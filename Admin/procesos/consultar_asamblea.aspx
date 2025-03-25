<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_asamblea.aspx.vb" Inherits="Admin_procesos_consultar_asamblea" %>
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


        
        function AbreVisorDocto(nombre_docto) {
            //alert(img);
            /*var url1 = "../Procesos/visor_docto.html?ResponseType=Edit&nombre_docto=" + nombre_docto;*/
            
            var url1 = "../../js/powerful_pdf_viewer/viewer_pdf.html?ResponseType=Edit&nombre_docto=" + nombre_docto;
            newWindow = window.open(url1, "_blank", "top=200,left=900,menubar=no,toolbar=no,location=no,height=720,width=880,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
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


        function MostrarAsamblea(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceAsamblea.asmx/GetAsamblea_Grid", //PageMethod
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
                     id: "idasamblea"
                 },
                 colModel: [
                                 {
                                     index: 'idasamblea', width: 50, align: 'Center', name: 'idAsamblea'
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
                                     index: 'idtasamblea', width: 50, align: 'Center', name: 'idTipoAsamblea', hidden: true
                                 },
                                 {
                                     index: 'nom_tasamblea', width: 250, align: 'Center', name: 'NombreTipoAsmablea'
                                 },
                                 {
                                     index: 'fecha_asamblea', width: 80, align: 'Center', name: 'FechaAsamblea'
                                 },
                                 {
                                     index: 'num_asistentes', width: 50, align: 'Center', name: 'NumAsistentes'
                                 },
                                 {
                                     index: 'num_asistentes_m', width: 50, align: 'Center', name: 'NumAMujeres', hidden: true
                                 },
                                 {
                                     index: 'fecha_programa', width: 80, align: 'Center', name: 'FechaPrograma', hidden: true
                                 },
                                 {
                                     index: 'docto_evidencia', width: 80, align: 'Center', name: 'DctoAsamblea', hidden: true
                                 },
                                 {
                                     index: 'oid', width: 50, align: 'Center', name: 'oid', hidden: true
                                 },
                                 {
                                     index: 'estatus_asamblea', width: 50, align: 'Center', name: 'idEstatusAsamblea', hidden: true
                                 },
                                 {
                                     index: 'cestatus', width:80, align: 'Center', name: 'EstatusAsamblea'
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
                 sortname: "idasamblea", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1800",
                 height: "800",
                 caption: "GESTION DE ASAMBLEAS"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaAsamblea",
                            id: "alta_asamblea",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                 GestionAsambleaBase(0);
                                
                            },
                            position: "last",
                            title: "AltaAsamb",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditAsamblea",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objAsamblea.idAsamblea) {
                                    $("#bodegadatos").data("oid_inicial",objAsamblea.oid);
                                    $("#lbloid_obr_clv_int").html(objAsamblea.oid);

                                    GestionAsamblea(objAsamblea, 1);
                                }
                                else {
                                    alert("Selecciona una Asamblea...");
                                }
                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                   {
                       caption: "VerDocto",
                       id: "VerDocto",
                       buttonicon: "ui-icon-document",
                       onClickButton: function () {

                           var myGrid = $('#grid');
                           var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                           var objAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                           if (objAsamblea.DctoAsamblea) {                               
                               AbreVisorDocto(objAsamblea.DctoAsamblea);
                               
                           }
                           else {
                               alert("Selecciona una Asamblea...");
                           }
                       },
                       position: "last",
                       title: "DctoDet",
                       cursor: "pointer"
                   });

            /*.navButtonAdd('#pager',
                        {
                            caption: "ActivarTipoAsamblea",
                            id: "activar_Accion",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAsamblea = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAsamblea.idTipoAsamb) {
                                    if (objTipoAsamblea.Estatus == 0) {
                                        GestionTipoAsamblea(objTipoAsamblea, 3);
                                    }
                                    else {
                                        alert('El Tipo de Asamblea esta activado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Asamblea...");
                                }


                            },
                            position: "last",
                            title: "DctoDet",
                            cursor: "pointer"
                        });*/

        }



        function ObtenerFiltro() {


            var calle_asamblea = $.trim($('#txtcalle_asamblea_q').val());
            var colonia_asamblea = $.trim($('#txtcolonia_asamblea_q').val());
            var promotor = $.trim($('#txtpromotor_asamblea_q').val());
            if (calle_asamblea.length <= 0 || calle_asamblea.length > 100) {
                calle_asamblea = "NULL";
            }
            if (colonia_asamblea.length <= 0 || colonia_asamblea.length > 100) {
                colonia_asamblea = "NULL";
            }
            if (promotor.length <= 0 || promotor.length > 100) {
                promotor = "NULL";
            }

            var filtro = calle_asamblea.toString() + ',' + colonia_asamblea.toString() + ',' + promotor.toString() + ',';
            return filtro;
        }


        function Buscar_Asamblea(idusu) {
            MostrarAsamblea(idusu, ObtenerFiltro());
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

            $(".verarchivo").click(function () {
                var nom_docto= $("#archivo").text();
                AbreVisorDocto(nom_docto);
            });
            

            $(".buscar_asamblea").click(function () {
                Buscar_Asamblea(idusu);
            });

            $(".alta_asamblea").click(function () {
                GestionAsambleaBase(0, 0);
            });


         /*   $("lstobras_sgp_base").change(function () {
                var obr_clv_int_sel = $("#lstobras_sgp_base").val();  
                ConsultaObra(4, obr_clv_int_sel);
            });*/
            


            $('#lstobras_sgp_base').on('change', function() {
                
                var obra_seleccionada = $("#lstobras_sgp_base option:selected" ).text();
                
                var cadena = obra_seleccionada.split('||');
                
                $("#lblcalle_obra").html(cadena[0]);
                $("#lblcolonia_obra").html(cadena[1]);
                $("#lbltramo_obra").html(cadena[2]);                
                $("#lbloid_obr_clv_int_2").html(cadena[3]);    
                
            });



            $(".posicion_boton_cancelar_asamblea,.posicion_boton_cancelar_base_asamblea").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_asamblea").click(function (e) {          
                              
                EjecutarAccionAsamblea();
                RedibujarGrid();
                $('#mask, .window').hide();
            
            });


            $(".posicion_boton_accion_base_asamblea").click(function (e) {                
                
                $('#mask, .window').hide();                
                var tipo_asamblea =  $("#lsttipo_asamblea_base").val();    
                var oid = parseInt($("#lbloid_obr_clv_int_2").html());
                

                if (tipo_asamblea == '15') {                    
                    RevisarAsambleasCosto_X_OID(oid,0)
                            .done(function (r2) {
                                   var resultado = r2.d;
                                   var r = resultado.split(':');
                                   var error =  parseInt(r[0]);
                                   var msj = r[1];
                                   if (error) {
                                       alert(msj);                                      
                                   } else {
                                       $("#lblcalle").html($("#lblcalle_obra").html());
                                       $("#lblcolonia").html($("#lblcolonia_obra").html());
                                       $("#lbltramo").html($("#lbltramo_obra").html());                  
                                       $("#lblobra_s").html($("#lblobra_s_base").html());                      
                                       $("#lbloid_obr_clv_int").html($("#lbloid_obr_clv_int_2").html());
                                       llenarTipoAsamblea($("#lsttipo_asamblea_base").val());                                
                                       GestionAsamblea(0, 0);   

                                   }

                             })
                            .fail(function (xhr) {
                                     console.log(xhr.responseText);
                                     alert("No fue posible revisar las asamblea de costo del OID");
                             })   
                } else {
                    if (tipo_asamblea == '18') {                    
                        RevisarAsambleasCosto_X_OID(oid,1)
                            .done(function (r2) {
                                var resultado = r2.d;
                                var r = resultado.split(':');
                                var error =  parseInt(r[0]);
                                var msj = r[1];
                                if (error) {
                                    alert(msj);                                    
                                } else {
                                    $("#lblcalle").html($("#lblcalle_obra").html());
                                    $("#lblcolonia").html($("#lblcolonia_obra").html());
                                    $("#lbltramo").html($("#lbltramo_obra").html());                  
                                    $("#lblobra_s").html($("#lblobra_s_base").html());                      
                                    $("#lbloid_obr_clv_int").html($("#lbloid_obr_clv_int_2").html());
                                    llenarTipoAsamblea($("#lsttipo_asamblea_base").val());                                
                                    GestionAsamblea(0, 0);   
                                }

                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible revisar las asamblea de actualización de costo del OID capturado");
                            })   
                    } else {
                        $("#lblcalle").html($("#lblcalle_obra").html());
                        $("#lblcolonia").html($("#lblcolonia_obra").html());
                        $("#lbltramo").html($("#lbltramo_obra").html());                  
                        $("#lblobra_s").html($("#lblobra_s_base").html());                      
                        $("#lbloid_obr_clv_int").html($("#lbloid_obr_clv_int_2").html());
                        llenarTipoAsamblea($("#lsttipo_asamblea_base").val());                                
                        GestionAsamblea(0, 0);   
                    }
                }
            });
            
            
            $('.numbersOnly').keyup(function () {

                var preg = /^([0-9]+\.?[0-9]{0,2})$/;
                if (preg.test(this.value) === false) {
                    this.value = '';
                }
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

        function RevisarAsambleasCosto_X_OID(oid,accion) {
            return $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; utf-8',
                url: "../../WebServices/WebServiceAsamblea.asmx/GetRevisionAsambleas_X_oid",
                data: "{'oid':'" + oid + "','accion':'" + accion + "'}",
            });
        }

        function ConsultaObra(accion,obr_clv_int) {

            return $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; utf-8',
                url: "../../WebServices/WebServiceObras.asmx/GetObra_obr_clv_int",
                data: "{'accion':'" + accion + "','obr_clv_int':'" + obr_clv_int + "'}",
            });
        }

        function ConsultaPermisoEjecutarTarea(idusu, idtarea, idaccion) {
            return $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; utf-8',
                url: "../../WebServices/WebServiceTarea.asmx/ConsultaPermisoTarea",
                data: "{'idusu':'" + idusu + "','idtarea':'" + idtarea + "','idaccion':'" + idaccion + "'}"
            });
        }

        function RegistrarAsambleaBD(objAsamblea) {

            var stringData = JSON.stringify(objAsamblea);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceAsamblea.asmx/GuardarAsamblea",
                data: "{objAsamblea:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function ConsultaActCostoObra(oid) {            
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/GetActCostoObra",
                data: "{'oid':'" + oid + "'}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };
        

        function EjecutarAccionAsamblea() {

            var idusu = $("#bodegadatos").data("idusu");

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
            
            var accion = parseInt($("#lblaccion_asamblea").html());
            var idasamblea = parseInt($("#lblidasamblea").html());
            var lugar = $("#txtdescrip_lugar").val();
            var idpromotor = $("#lstpromotor").val();
            var idtasamblea = $("#lsttipo_asamblea").val();
            var fecha_programa = '01/01/1900';
            var num_asistentes = parseInt($("#txtnum_asistentes").val());
            var num_asistentes_m = parseInt($("#txtnum_asistentes_m").val());
            var idpresup = 0;
            var fecha_asamblea = $("#txtfec_asamblea").val();
            
                        
            var oid = parseInt($("#lbloid_obr_clv_int").html());

            var estatus_asamblea = '2'
            
            var objAsamblea = {
                "idasamblea": 0,
                "lugar": '',
                "idtasamblea": 0,
                "fecha_asamblea": '01/01/1900',
                "num_asistentes": 0,
                "num_asistentes_m": 0,
                "fecha_programa": '01/01/1900',
                "docto_evidencia": '',                
                "oid": 0,                
                "usu_cre": idusu,
                "usu_mod": idusu,
                "fec_cre": hoy,
                "fec_mod": hoy,
                "estatus_asamblea": 0,
                "idpromotor": 0,
                "idpresup": 0,
                "accion": accion
            }


            if (accion == 0) { /*Registrar Accion*/
                if (ValidarDatosAsamblea()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 1 mb su tamaño*/
                    objAsamblea.idasamblea = 0;
                    objAsamblea.lugar = lugar;
                    objAsamblea.idpromotor = parseInt(idpromotor);
                    objAsamblea.idpresup = idpresup;
                    objAsamblea.idtasamblea = parseInt(idtasamblea);
                    objAsamblea.num_asistentes = num_asistentes;
                    objAsamblea.num_asistentes_m = num_asistentes_m;
                    objAsamblea.estatus_asamblea = parseInt(estatus_asamblea);
                    objAsamblea.fecha_programa = ConvertirCadenaToFecha(fecha_programa);
                    objAsamblea.fecha_asamblea = ConvertirCadenaToFecha(fecha_asamblea);
                    objAsamblea.docto_evidencia= 'Asamblea_';
                    objAsamblea.oid = oid;

                    if (objAsamblea.idtasamblea==18) {
                        ConsultaActCostoObra(objAsamblea.oid)
                        .done(function(r1) { 
                            var cadena = r1.d;
                            var num_error = 0;
                            var descrip_error = '';

                            if (cadena != '<NewDataSet />') {
                                $(cadena).find("act_costo_obra").each(function () {
                                    num_error = $(this).find("noerror").text();
                                    descrip_error = $(this).find("descerror").text();                                   
                                });          

                                if (num_error == '0') {
                                    var opcion = confirm("Desea aplicar los incrementos a los cooperadores por la actualización de obra encontrada");
                                    if (opcion == true) {
                                        RegistrarAsambleaBD(objAsamblea)
                                        .done(function (r2) {
                                            var cadena = r2.d;
                                            if (cadena != '<NewDataSet />') {
                                                var arr = cadena.split(':');
                                                var error = arr[1];
                                                var nombre_archivo = objAsamblea.docto_evidencia + $.trim(arr[3]) + '.pdf';
                                                if (error == '0') {
                                                    ValidacionGuardadoArchivo($("#file_asam").get(0).files, nombre_archivo);
                                                    alert('La Asamblea ' + arr[3] + ' ha sido creado satisfactoriamente');
                                                    $('#mask, .window').hide();
                                                    $('#grid').trigger('reloadGrid');
                                                } else {
                                                    alert(cadena);
                                                }
                                            } else {
                                                alert('El objeto (Errores de Asamblea) cadena XMl regresó vacío.'); 
                                            }
                                        })
                                        .fail(function (xhr) {
                                            console.log(xhr.responseText);
                                            alert("No fue posible guardar la asamblea creada");
                                        })   
                                    } else {
                                        console.log('Al ser negativa la respuesta para aplicar la actualización, la asamblea capturada no se registrará');
                                    }
                                } else {
                                    alert(descrip_error);
                                }
                            }  else {
                                alert('El objeto (ActCostoObra) cadena XMl regresó vacío.');
                            }
                            
                        })
                        .fail (function (xhr) {
                            console.log(xhr.responseText);
                            alert("No fue posible revisar la Actualización de Costo de Obra");
                        })
                    } else {
                        RegistrarAsambleaBD(objAsamblea)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   var error = arr[1];
                                   var nombre_archivo = objAsamblea.docto_evidencia + $.trim(arr[3]) + '.pdf';
                                   if (error == '0') {
                                       ValidacionGuardadoArchivo($("#file_asam").get(0).files, nombre_archivo);
                                       alert('La Asamblea ' + arr[3] + ' ha sido creado satisfactoriamente');
                                       $('#mask, .window').hide();
                                       $('#grid').trigger('reloadGrid');
                                   } else {
                                       alert(cadena);
                                   }
                               }
                            
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fue posible guardar la asamblea creada");
                           })
                    }
                }
            }


            if (accion == 1) {
                if (ValidarDatosAsamblea()) {  /*Valida que se haya capturado numero de contrato y el archivo del documento sea pdf y sea menos de 3 mb su tamaño*/
                    objAsamblea.idasamblea = idasamblea;
                    objAsamblea.lugar = lugar;
                    objAsamblea.idpromotor = parseInt(idpromotor);
                    objAsamblea.idpresup = parseInt(idpresup);
                    objAsamblea.idtasamblea = parseInt(idtasamblea);
                    objAsamblea.num_asistentes = num_asistentes;
                    objAsamblea.num_asistentes_m = num_asistentes_m;
                    objAsamblea.estatus_asamblea = parseInt(estatus_asamblea);
                    objAsamblea.fecha_programa = ConvertirCadenaToFecha(fecha_programa);
                    objAsamblea.fecha_asamblea = ConvertirCadenaToFecha(fecha_asamblea);
                    objAsamblea.docto_evidencia='Asamblea_' + $("#lblidasamblea").html() + '.pdf';
                    objAsamblea.oid =parseInt($("#lbloid_obr_clv_int").html());

                    var oid_inicial = $("#bodegadatos").data("oid_inicial");

                    if (objAsamblea.oid!=oid_inicial) {
                        objAsamblea.accion = 4; /*Asigna el valor de la accion para que directamente actualice el OID de la asamblea y evitar que se repita la asamblea del tipo "ACTUALIZACION DE COSTO" */
                    }

                    
                    RegistrarAsambleaBD(objAsamblea)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            var arr = cadena.split(':');
                            var error = arr[1];
                            if (error == '0') {
                                ValidacionGuardadoArchivo($("#file_asam").get(0).files, objAsamblea.docto_evidencia);
                                alert('La Asamblea ' + arr[3] + ' ha sido editada satisfactoriamente');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            } else {
                                alert(cadena);
                            }
                        }
                    })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible guardar la asamblea creada");
                     })
                }

            }

          /*  if (accion == 2) {
                objTipoAsamblea.cactivo = 0;
                objTipoAsamblea.idtipoasamblea = parseInt($("#lbl_idtipoasamblea").html());
                var resp = confirm('¿Desea desactivar el Tipo de Asamblea: ' + objTipoAsamblea.Etiqueta + '?');
                if (resp) {
                    RegistrarTipoAsambleaBD(objTipoAsamblea)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Asamblea con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible desactivar el Tipo de Asamblea solicitada");
                     })
                }

            }

            if (accion == 3) {
                objTipoAsamblea.cactivo = 1;
                objTipoAsamblea.idtipoasamblea = parseInt($("#lbl_idtipoasamblea").html());
                var resp = confirm('¿Desea activar el Tipo de Asamblea: ' + objTipoAsamblea.Etiqueta + '?');
                if (resp) {
                    RegistrarTipoAsambleaBD(objTipoAsamblea)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Asamblea con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el Tipo de Asamblea solicitada");
                     })
                }

            }*/

        }

        function ValidarDatosAsamblea() {

            var valid;
            
            fecha_asamblea=ConvertirCadenaToFecha($("#txtfec_asamblea").val());

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
            

            if (parseInt($("#txtnum_asistentes").val())> 0) {
                valid = true;                
                if (fecha_asamblea>hoy) {
                    valid= false;
                    alert('ERROR: La fecha de la asamblea es mayor a hoy');
                } else {
                    if (parseInt($("#txtnum_asistentes").val())>= 0) {
                        valid= true;
                    } 
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
                        alert("No se capturado el documento de la asamblea");
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
            if (fs > 4000000) {
                alert("El tamaño del archivo: " + fn + " debe ser menor que 3 MB");
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

        function GestionAsamblea(objAsamblea, accion) {
            
            var reglas_usu = [];               
            var idusu = $("#bodegadatos").data("idusu");

            if (accion == 0) {  /*Alta de Asamblea*/       
                
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

                           /*Tarea 153: Admitir alta de asambleas*/
                           var puede_registrar_asambleas = reglas_usu.find(tarea => (tarea.idtarea == 153 && tarea.idaccion==3));

                           if (puede_registrar_asambleas==null)
                           {
                               alert ('El usuario no tiene permiso para registrar asambleas.');
                           }
                           else {                       
                               $("#lblidasamblea").html('0');
                               $("#lblaccion_asamblea").html(accion);
                               $("#txtdescrip_lugar").val('');
                               $("#txtfec_programa").val('');
                               $("#txtfec_asamblea").val('');
                               $("#txtnum_asistentes").val('');
                               $("#txtnum_asistentes_m").val('');
                               var opcion_tipo_asamblea = $("#lsttipo_asamblea").val();
                               $("#lsttipo_asamblea option:selected").text();    
                               $("#lbltitulo_tipo_asamblea").html('ALTA DE ' + $("#lsttipo_asamblea option:selected").text());                               
                               $('#lsttipo_asamblea').prop('disabled', true);
                               $("#archivo").text('')
                               $("#file_asam").val('');
                               
                               llenarPromotores(0, 'listar_promotores');                               
                             
                               MostrarModalAsamblea();
                           };
                       }
                       else {
                           alert("El usuario no tiene permiso para registrar asambleas.");
                       }

                   }).fail(function (r) {
                       alert("No fué posible consultar las reglas del usuario.");
                   });                        
            }
            else {
                if (accion == 1) 
                    var estatus_asamblea = parseInt(objAsamblea.idEstatusAsamblea);
                    if (estatus_asamblea!=3) {
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

                                /*Tarea 154: Admitir edicion de asambleas*/
                                var puede_editar_asambleas = reglas_usu.find(tarea => (tarea.idtarea == 154 && tarea.idaccion==3));

                                if (puede_editar_asambleas==null)
                                {
                                    alert ('El usuario no tiene permiso para editar asambleas.');
                                }
                                else {                       
                                    $("#lblidasamblea").html(objAsamblea.idAsamblea);
                                    $("#lblaccion_asamblea").html(accion);
                                    $("#txtdescrip_lugar").val(objAsamblea.Lugar);
                                    $("#txtfec_programa").val(objAsamblea.FechaPrograma);
                                    $("#txtfec_asamblea").val(objAsamblea.FechaAsamblea);
                                    $("#txtnum_asistentes").val(objAsamblea.NumAsistentes); 
                                    $("#txtnum_asistentes_m").val(objAsamblea.NumAMujeres);
                                    
                                    $("#archivo").text(objAsamblea.DctoAsamblea)
                                    $("#lblcalle").text(objAsamblea.Calle_Obra)
                                    $("#lblcolonia").text(objAsamblea.Colonia_Obra)
                                    $("#lbltramo").text(objAsamblea.Tramo)
                                    $("#lbltitulo_tipo_asamblea").html('EDICION DE ASAMBLEA');
                                    $("#file_asam").val('');                                    
                                    llenarPromotores(objAsamblea.idPromotor, 'listar_promotores');
                                    llenarEstatusAsamblea(objAsamblea.idEstatusAsamblea);
                                    llenarTipoAsamblea(objAsamblea.idTipoAsamblea);      
                                    $('#lsttipo_asamblea').prop('disabled', true);
                                    MostrarModalAsamblea();
                                };
                            }
                            else {
                                alert("El usuario no tiene permiso para editar asambleas.");
                            }

                        }).fail(function (r) {
                            alert("No fué posible consultar las reglas del usuario.");
                        });    
                    } else {
                        alert('Esta asamblea no es posible modificarla debido a que ya mantiene otros procesos referenciados');
                    }
            }
            
        }

        function GestionAsambleaBase(accion) {
            
            var reglas_usu = [];               
            var idusu = $("#bodegadatos").data("idusu");

            if (accion == 0) {  /*Alta de Asamblea*/               
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

                           /*Tarea 153: Admitir alta de asambleas*/
                           var puede_registrar_asambleas = reglas_usu.find(tarea => (tarea.idtarea == 153 && tarea.idaccion==3));

                           if (puede_registrar_asambleas==null)
                           {
                               alert ('El usuario no tiene permiso para registrar asambleas.');
                           }
                           else {                                                     
                               llenarObrasBaseSGP(6,0);
                               llenarTipoAsamblea_base(0);
                               MostrarModalAsambleaBase();
                               
                           };
                       }
                       else {
                           alert("El usuario no tiene permiso para registrar asambleas.");
                       }

                   }).fail(function (r) {
                       alert("No fué posible consultar las reglas del usuario.");
                   });                        
            }            
            
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


        function MostrarModalAsamblea() {
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
            $("#dialogo_asamblea").css('top', winH / 2 - $("#dialogo_asamblea").height() / 2);
            $("#dialogo_asamblea").css('left', winW / 2 - $("#dialogo_asamblea").width() / 2);

            //transition effect
            $("#dialogo_asamblea").fadeIn(2000);
        };

        function MostrarModalAsambleaBase() {
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
            $("#dialogo_asamblea_base").css('top', winH / 2 - $("#dialogo_asamblea_base").height() / 2);
            $("#dialogo_asamblea_base").css('left', winW / 2 - $("#dialogo_asamblea_base").width() / 2);

            //transition effect
            $("#dialogo_asamblea_base").fadeIn(2000);
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

        function llenarObrasSGP(accion,oid) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                data: "{'accion':'" + accion + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lst_obra_s").html('');
                    $(data.d).find("ObrasSGP").each(function (e) {
                        var aux = e;
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
                    
                    if (parseInt(oid)>0) {                        
                        $("#lst_obra_s").val(oid);                        
                        $("#bodegadatos").data("oid_inicial", parseInt(oid));
                    }

                    LlenaLabelObra($( "#lst_obra_s option:selected" ).text());
                    
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }
      

        function llenarObrasBaseSGP(accion,oid) {

            var obra_s = '';
            var calle_inicial='';
            var colonia_inicial='';
            var tramo_inicial='';

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceObras.asmx/GetObrasSGP",
                data: "{'accion':'" + accion + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lstobras_sgp_base").html('');                    
                    $(data.d).find("ObrasSGP").each(function (index) {
                        if (index == 0) {                            
                            calle_inicial = $(this).find("calle_r").text();
                            colonia_inicial = $(this).find("colonia_r").text();
                            tramo_inicial = $(this).find("tramo_r").text();
                            oid_inicial = $(this).find("oid_r").text();                            
                        }
                        var option = $(document.createElement('option'));                                                
                        var obr_call = $(this).find("calle_r").text();
                        var obr_colonia = $(this).find("colonia_r").text();
                        var obr_tramo = $(this).find("tramo_r").text();
                        var oid = $(this).find("oid_r").text();
                        option.html($.trim(obr_call) + ' || ' + $.trim(obr_colonia) + ' || ' + $.trim(obr_tramo) + ' || ' + $.trim(oid));
                        option.val(oid);
                        $("#lstobras_sgp_base").append(option);                         
                    });
                    
                    if (parseInt(oid)>0) {                        
                        $("#lstobras_sgp_base").val(oid);                                                
                        $("#bodegadatos").data("oid", parseInt(oid));  
                    }

                   
                    $("#lblcalle_obra").html(calle_inicial);
                    $("#lblcolonia_obra").html(colonia_inicial);
                    $("#lbltramo_obra").html(tramo_inicial);                
                    $("#lbloid_obr_clv_int_2").html(oid_inicial);    

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
                var oid = datos_obra[5];                

                $("#lblcalle").html(calle);
                $("#lblcolonia").html(colonia);
                $("#lbltramo").html(tramo);                
                $("#lbloid").html(oid);
            }
        }

        function llenarPromotores(idpromotor,accion) {
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

        

        function llenarEstatusAsamblea(idest_asam) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceEstatusAsamblea.asmx/GetEstatusAsamblea",
                data: "{'idest_asam':'" + idest_asam + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lstestatus_asamblea").html('');
                    $(data.d).find("estatus_asamblea").each(function () {
                        var option = $(document.createElement('option'));
                        var idestatus_asamblea = $(this).find("idestatus_asamblear").text();
                        var etiqueta_asamblea = $(this).find("etiqueta_estatus_asamblear").text();
                        var estatus_estatus_asamblea = $(this).find("cactivor").text();
                        var usu_cre = $(this).find("usu_crer").text();
                        option.html(etiqueta_asamblea);
                        option.val(idestatus_asamblea);
                        $("#lstestatus_asamblea").append(option);
                    });
                    if (idest_asam > 0) { //
                        $("#lstestatus_asamblea").val(idest_asam);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }


        function llenarTipoAsamblea_base(idtipo_asam) {
            
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceTipoAsamblea.asmx/GetTipoAsamblea",
                data: "{'idtipoasamblea':'" + '0' + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lsttipo_asamblea_base").html('');
                    $(data.d).find("tipo_asamblea").each(function () {
                        var option = $(document.createElement('option'));
                        var idtipo_asamblea = $(this).find("idtipoasamblea_r").text();
                        var etiqueta_tipo_asamblea = $(this).find("etiqueta_r").text();
                        var descrip_tipo_asamblea = $(this).find("descrip_tipo_r").text();
                        var usu_cre_asamblea = $(this).find("usu_cre_r").text();
                        var estatus_tipo_asamblea = $(this).find("cactivo_r").text();
                        var feccre_tipo_asamblea = $(this).find("fec_cre_r").text();                                                                      
                        option.html(etiqueta_tipo_asamblea);
                        option.val(idtipo_asamblea);
                        $("#lsttipo_asamblea_base").append(option);
                    });
                    if (idtipo_asam > 0) { //
                        $("#lsttipo_asamblea_base").val(idtipo_asam);
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        }

        function llenarTipoAsamblea(idtipo_asam) {
            
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                url: "../../WebServices/WebServiceTipoAsamblea.asmx/GetTipoAsamblea",
                data: "{'idtipoasamblea':'" + '0' + "'}",
                success: function (data) {
                    var elementos = 0;
                    $("#lsttipo_asamblea").html('');
                    $(data.d).find("tipo_asamblea").each(function () {
                        var option = $(document.createElement('option'));
                        var idtipo_asamblea = $(this).find("idtipoasamblea_r").text();
                        var etiqueta_tipo_asamblea = $(this).find("etiqueta_r").text();
                        var descrip_tipo_asamblea = $(this).find("descrip_tipo_r").text();
                        var usu_cre_asamblea = $(this).find("usu_cre_r").text();
                        var estatus_tipo_asamblea = $(this).find("cactivo_r").text();
                        var feccre_tipo_asamblea = $(this).find("fec_cre_r").text();                                                                      
                        option.html(etiqueta_tipo_asamblea);
                        option.val(idtipo_asamblea);
                        $("#lsttipo_asamblea").append(option);
                    });
                    if (idtipo_asam > 0) { //
                        $("#lsttipo_asamblea").val(idtipo_asam);
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

    <label>Calle Asamblea:</label><input type="text" name="calle_asamblea" id="txtcalle_asamblea_q" style="width:250px" maxlength ="120"/><br/><br/>        
    <label>Colonia Aamblea:</label><input type="text" name="colonia_asamblea" id="txtcolonia_asamblea_q" style="width:250px" maxlength ="120"/><br/><br/> 
    <label>Promotor:</label><input type="text" name="promotor_asamblea" id="txtpromotor_asamblea_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_asamblea"><== Buscar Asamblea ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_asamblea"><== Alta Asamblea ==></a><br/><br/>
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
    <div id="dialogo_asamblea" class="window">        
       <table class="t_modulo">
          <tbody>               
              <tr>
                  <td colspan="4" class="titulo_modulo"><label id="lbltitulo_tipo_asamblea"></label></td>
              </tr>   
              <tr>                  
                  <td class="f">CALLE:</td><td class="ee" colspan="3"><label id="lblcalle"></label></td>               
              </tr>                                                                                                                                                                                                                                                                                                                                                                       
              <tr>
                  <td class="f">COLONIA:</td><td class="ee" colspan="3"><label id="lblcolonia" /></td>                  
              </tr>             
              <tr>                  
                  <td class="f">TRAMO:</td><td class="ee" colspan="3"><label id="lbltramo" /></td>                  
              </tr>              
              <tr class="renglon_sistema">                                    
                  <td colspan="2">oid:</td>
                  <td colspan="2" class="columna_sistema"><label id="lbloid_obr_clv_int"/></td>                                    
              </tr>
              <tr>
                  <td class="f">Asistentes:</td>
                  <td class="e"><input type="text" class="numbersOnly" name="num_asistentes_m" id="txtnum_asistentes" size="4" maxlength="4"/></td>                  
                  <td class="f">Asistentes Mujeres:</td>
                  <td class="e"><input type="text" class="numbersOnly" name="num_asistentes_m" id="txtnum_asistentes_m" size="4" maxlength="4"/></td>                                    
              </tr>                           
              <tr>
                  <td class="f">Fecha Asamblea:</td>
                  <td class="e"><input type="text" name="fec_asambles" id="txtfec_asamblea" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/></td>                  
                  <td class="f">Promotor Asamblea:</td>
                  <td class="e"><select class="select_captura" name="promotores" id="lstpromotor"></select></td>                                    
              </tr>              
              <tr>
                  <td class="f">Documento de Asamblea:</td>
                  <td class="e"><input type="file" id="file_asam" name="file"/>&nbsp&nbsp<a href="#" id="archivo" class="verarchivo"></a></td>
                  <td class="f">Tipo Asamblea:</td>
                  <td class="e"><select class="select_captura" name="tipo_asamblea_" id="lsttipo_asamblea"></select></td>
              </tr>
               <tr>
                  <td class="f">Observaciones/Notas Importantes:</td>
                  <td class="e" colspan="3" ><textarea name="descrip_lugar" id="txtdescrip_lugar" cols="112" rows="4"></textarea></td>    
              </tr>
              <tr class="renglon_sistema">                  
                  <td>idAsamblea:</td>
                  <td class="columna_sistema"><label id="lblidasamblea"/></td>
                  <td >Accion:</td>
                  <td class="columna_sistema"><label id="lblaccion_asamblea"/></td>                        
              </tr>                   
              <tr>
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_asamblea">ACEPTAR</a></td>                  
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_asamblea">CANCELAR</a></td>                  
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="dialogo_asamblea_base" class="window">        
       <table class="t_modulo">
          <tbody> 
               <tr>
                  <td colspan="2" class="titulo_modulo">GESTION DE ASAMBLEAS</td>
              </tr>   
              <tr>
                 <td class="f">Obra:</td>   
                 <td class="e"><select  class="select_captura" name="obras_s" id="lstobras_sgp_base"></select></td>               
              </tr>
              <tr>
                 <td class="f">Calle:</td>   
                 <td class="ee"><label id="lblcalle_obra"></label></td>               
              </tr>
              <tr>
                 <td class="f">Colonia:</td>   
                 <td class="ee"><label id="lblcolonia_obra"></label></td>               
              </tr>
              <tr>
                 <td class="f">Tramo:</td>   
                 <td class="ee"><label id="lbltramo_obra"></label></td>               
              </tr>
              <tr>
                 <td class="f">Tipo de Asamblea:</td>
                 <td class="e"><select class="select_captura" name="tipo_asamblea" id="lsttipo_asamblea_base"></select></td> 
              </tr>                          
              <tr class="renglon_sistema">
                  <td>oid:</td>
                  <td class="columna_sistema"><label id="lbloid_obr_clv_int_2"/></td>                                    
              </tr>
              <tr>
                  <td  class="boton_dialog"><a href="#" class ="posicion_boton_accion_base_asamblea">ACEPTAR</a></td>                  
                  <td  class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_base_asamblea">CANCELAR</a></td>                  
              </tr>
          </tbody>
       </table>
    </div>    
    <div id="mask"></div>
 </div>
</asp:Content>



