<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="consultar_tanexo_contrato.aspx.vb" Inherits="Admin_procesos_consultar_tanexo_contrato" Culture="Auto" UICulture="Auto"%>



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



        function MostrarTipoAnexoContrato(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceTipoAnexoContrato.asmx/GetTipoAnexoContrato_Grid", //PageMethod
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
                     id: "idtipo_anexo_cont"
                 },
                 colModel: [
                                 {
                                     index: 'idtipo_anexo_cont', width: 50, align: 'Center', name: 'idTipoAnexoContrato'
                                 },
                                 {
                                     index: 'etiqueta_anexo', width: 200, align: 'Center', name: 'EtiquetaAnexo'
                                 },
                                 {
                                     index: 'observaciones', width: 300, align: 'Center', name: 'Observaciones'
                                 },
                                 {
                                     index: 'usu_cre', width: 80, align: 'Center', name: 'UsuCre'
                                 },
                                 {
                                     index: 'usu_mod', width: 80, align: 'Center', name: 'UsuMod'
                                 },
                                 {
                                     index: 'fec_cre', width: 80, align: 'Center', name: 'FecCre'
                                 },
                                 {
                                     index: 'fec_mod', width: 80, align: 'Center', name: 'FecMod'
                                 },
                                 {
                                     index: 'cactivo', width: 50, align: 'Center', name: 'Estatus'
                                 }],
                 pager: "#pager", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input conttarea text format.
                 rowNum: "20", // PageSize.
                 rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "idtipo_anexo_cont", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1500",
                 height: "800",
                 caption: "CATALOGO DE ANEXOS DE CONTRATO"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaTipAnexCont",
                            id: "alta_anexo_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAnexoCont = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionTipoAnexoContrato(objTipoAnexoCont, 0);

                            },
                            position: "last",
                            title: "AltaTipAnexCont",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "ModTipAnexCont",
                            id: "edit_tipo_anexo_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAnexoCont = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAnexoCont.idTipoAnexoContrato) {
                                    GestionTipoAnexoContrato(objTipoAnexoCont, 1);

                                }
                                else {
                                    alert("Selecciona un Tipo de Anexo de Contrato...");
                                }
                            },
                            position: "last",
                            title: "EditaTipoAnexoContrato",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "DesactTipAnexCont",
                            id: "desactivar_tipo_anexo_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAnexoCont = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAnexoCont.idTipoAnexoContrato) {
                                    if (objTipoAnexoCont.Estatus == 1) {
                                        GestionTipoAnexoContrato(objTipoAnexoCont, 2);
                                    }
                                    else {
                                        alert('El tipo de anexo de contrato se encuentra desactivada');
                                    }

                                }
                                else {
                                    alert("Selecciona una Tipo de Anexo de Contrato...");
                                }


                            },
                            position: "last",
                            title: "DesactTipoAnexoContrato",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "ActTipAnexCont",
                            id: "activar_tipo_anexo_contrato",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoAnexoCont = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objTipoAnexoCont.idTipoAnexoContrato) {
                                    if (objTipoAnexoCont.Estatus == 0) {
                                        GestionTipoAnexoContrato(objTipoAnexoCont, 3);
                                    }
                                    else {
                                        alert('El Tipo de Anexo de Contrato se encuentra activada.');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Anexo de Contrato...");
                                }


                            },
                            position: "last",
                            title: "ActivarTipoAnexoContrato",
                            cursor: "pointer"
                        });


        }



        function ObtenerFiltro() {


            var nom_tipo_anexo_contrato = $('#txttipo_anexo_tarea_q').val();
            if (nom_tipo_anexo_contrato.length <= 0 || nom_tipo_anexo_contrato.length > 30) {
                nom_tipo_anexo_contrato = "NULL";
            }

            var filtro = nom_tipo_anexo_contrato.toString();
            return filtro;
        }


        function Buscar_TipoAnexoContrato(idusu) {
            MostrarTipoAnexoContrato(idusu, ObtenerFiltro());
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




            $(".buscar_tipo_anexo_contrato").click(function () {
                Buscar_TipoAnexoContrato(idusu);
            });

            $(".alta_tipo_anexo_contrato").click(function () {
                GestionTipoAnexoContrato(0, 0);
            });



            $("#bodegadatos").data("idusu", idusu);





            $(".posicion_boton_cancelar_tanexo_cont").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_tanexo_cont").click(function (e) {
                EjecutarAccionTipoAnexoContrato();
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function RegistrarTipoAnexoContratoBD(objTipoAnexoContrato) {

            var stringData = JSON.stringify(objTipoAnexoContrato);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceTipoAnexoContrato.asmx/GuardarTipoAnexoContrato",
                data: "{objTipoAnexoContrato:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function EjecutarAccionTipoAnexoContrato() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

            var observ_tipo_anexo_contrato = $("#txtobserv_tipo_anexo_contrato").val();
            var etiqueta_tipo_anexo_contrato = $("#txtetiqueta_tipo_anexo_contrato").val();

            
            var idtipo_anexo_contrato = $("#lblidtipo_anexo_contrato").html();
            
            var estatus_tipo_anexo_contrato=1;

            var accion = parseInt($("#lblaccion_tipo_anexo_contrato").html());

            var objTipoAnexoContrato = {
                "idtipo_anexo_cont": parseInt(idtipo_anexo_contrato),
                "etiqueta_anexo": etiqueta_tipo_anexo_contrato,
                "observaciones": observ_tipo_anexo_contrato,
                "usu_cre": idusu,
                "usu_mod": idusu,
                "fec_cre": hoy,
                "fec_mod": hoy,
                "cactivo": estatus_tipo_anexo_contrato,
                "accion": accion
            }


            if (accion == 0) { /*Registrar tarea*/              
                RegistrarTipoAnexoContratoBD(objTipoAnexoContrato)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de anexo de contrato:' + arr[1] + ' ha sido modificada satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);

                     alert("No fue posible guardar los datos del tipo de anexo de contrato");
                 })
            }
            if (accion == 1) {
               
                RegistrarTipoAnexoContratoBD(objTipoAnexoContrato)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de anexo de contrato:' + arr[1] + ' ha sido modificada satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible editar los cambios en el tipo de anexo de contrato");
                 })

            }

            if (accion == 2) {
                objTipoAnexoContrato.cactivo = 0;

                var resp = confirm('¿Desea desactivar el Tipo de Anexo de Contrato: ' + objTipoAnexoContrato.etiqueta_anexo + '?');
                if (resp) {
                    RegistrarTipoAnexoContratoBD(objTipoAnexoContrato)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El tipo de anexo de contrato:' + arr[1] + ' ha sido modificada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible editar los cambios en el tipo de anexo de contrato");
                     })
                }

            }

            if (accion == 3) {
               
                var resp = confirm('¿Desea desactivar el Tipo de Anexo de Contrato: ' + objTipoAnexoContrato.etiqueta_anexo + '?');
                if (resp) {
                    RegistrarTipoAnexoContratoBD(objTipoAnexoContrato)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El tipo de anexo de contrato:' + arr[1] + ' ha sido modificada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible editar los cambios en el tipo de anexo de contrato");
                     })
                }

            }




        }

        function GestionTipoAnexoContrato(objTipoAnexoContrato, accion) {

            if (accion == 0) {  /*Alta de tarea*/
                $("#txtetiqueta_tipo_anexo_contrato").val('');
                $("#txtobserv_tipo_anexo_contrato").val('');           
                $("#lblidtipo_anexo_contrato").html('0');
                $("#lblaccion_tipo_anexo_contrato").html(accion);
            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    var idtipo_anexo_contrato = parseInt(objTipoAnexoContrato.idTipoAnexoContrato);
                    ConsultaDatosTipoAnexoContrato(idtipo_anexo_contrato)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            $(cadena).find("tipo_anexo_contrato").each(function () {
                                $("#lblidtipo_anexo_contrato").html($(this).find("idtipo_anexo_contrato_r").text());
                                $("#lblaccion_tipo_anexo_contrato").html(accion);
                                $("#txtetiqueta_tipo_anexo_contrato").val($(this).find("etiqueta_anexo_r").text());
                                $("#txtobserv_tipo_anexo_contrato").val($(this).find("observaciones_r").text());
                               
                            });
                        }
                        if (accion == 2 || accion == 3) {
                            $("#txtetiqueta_tipo_anexo_contrato").prop('disabled', true);
                            $("#txtobserv_tipo_anexo_contrato").prop('disabled', true);
                           
                        }
                        else {
                            $("#txtetiqueta_tipo_anexo_contrato").prop('disabled', false);;
                            $("#txtobserv_tipo_anexo_contrato").prop('disabled', false);
                           
                        }
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fue posible consultar los dato del Tipo de Anexo de Contrato solicitado");
                    });
                }
            }

            MostrarModalTipoAnexoContrato();

        }

        function ConsultaDatosTipoAnexoContrato(idtipo_anexo_contrato) {
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceTipoAnexoContrato.asmx/GetTipoAnexoContrato",
                data: "{idTipoAnexoContrato:" + idtipo_anexo_contrato + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }


        function MostrarModalTipoAnexoContrato() {
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
            $("#dialogo_tipo_anexo_contrato").css('top', winH / 2 - $("#dialogo_tipo_anexo_contrato").height() / 2);
            $("#dialogo_tipo_anexo_contrato").css('left', winW / 2 - $("#dialogo_tipo_anexo_contrato").width() / 2);

            //transition effect
            $("#dialogo_tipo_anexo_contrato").fadeIn(2000);
        };



</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

<label>Nombre del Tipo de Anexo de Contrato:</label><input type="text" name="nom_tipo_anexo_tarea_q" id="txttipo_anexo_tarea_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_tipo_anexo_contrato"><== Buscar Tipo Anexo del Contrato ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_tipo_anexo_contrato"><== Alta Tipo de anexo de Contrato ==></a><br/><br/>        
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
    <div id="dialogo_tipo_anexo_contrato" class="window"> 
       <div id="titulo_tipo_anexo_contrato"> 
         <p style="text-align:center">GESTION DE TIPO ANEXO DE CONTRATO</p>
         idTipoAnexoContrato: <label for="idtarea" id="lblidtipo_anexo_contrato"></label><br/>         
         Acción:<label for="accion" id="lblaccion_tipo_anexo_contrato"></label><br/>
       </div>
       <div class="datos" id="bodytarea">                  
          <label for="name" id="lbltareanombre">*Etiqueta del Tipo de Anexo del Contrato:</label><input type="text" name="tipo_anexo_contrato" id="txtetiqueta_tipo_anexo_contrato" size="80"/><br/><br/>
          <label for="name" id="lbltareadescrip">*Descripción del Tipo de Anexo del Contrato:</label><input type="text" name="descrip_tipo_anexo_contrato" id="txtobserv_tipo_anexo_contrato" size="80"/><br/><br/>                    
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_tanexo_cont">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_tanexo_cont">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>


