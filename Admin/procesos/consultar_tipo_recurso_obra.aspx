<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_tipo_recurso_obra.aspx.vb" Inherits="Admin_procesos_consultar_tipo_recurso_obra" %>
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



        function MostrarTipoRecursoObra(idusu, filtro) {


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
                           url: "../../WebServices/WebServiceTipoRecursoObra.asmx/GetTipoRecursoObra_Grid", //PageMethod
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
                     id: "IdTipoRecurso"
                 },
                 colModel: [
                                 {
                                     index: 'idtipo_recurso', width: 50, align: 'Center', name: 'idTipoRecurso'
                                 },
                                 {
                                     index: 'descrip', width: 100, align: 'Center', name: 'Descripcion'
                                 },
                                 {
                                     index: 'observ', width: 300, align: 'Center', name: 'Observaciones'
                                 },
                                 {
                                     index: 'usu_cre', width: 50, align: 'Center', name: 'Usu_Cre'
                                 },
                                 {
                                     index: 'usu_mod', width: 50, align: 'Center', name: 'Usu_Mod'
                                 },
                                 {
                                     index: 'fec_cre', width: 50, align: 'Center', name: 'Fec_Cre'
                                 },
                                 {
                                     index: 'fec_mod', width: 50, align: 'Center', name: 'Fec_Mod'
                                 },
                                 {
                                     index: 'cestatus', width: 50, align: 'Center', name: 'Estatus'
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
                 sortname: "idtipo_recurso", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1800",
                 height: "800",
                 caption: "CATALOGO DE TIPO DE RECURSOS PARA OBRA"

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
               .navButtonAdd('#pager',
                        {
                            caption: "AltaTipoRecurso",
                            id: "alta_tipo_recurso",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoRecurso = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionTipoRecurso(objTipoRecurso, 0);

                            },
                            position: "last",
                            title: "AltaUsu",
                            cursor: "pointer"
                        })

                 .navButtonAdd('#pager',
                        {
                            caption: "EditTipoRecurso",
                            id: "edit_usuario",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoRecurso = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoRecurso.idTipoRecurso)) {
                                    GestionTipoRecurso(objTipoRecurso, 1);
                                }
                                else {
                                    alert("Selecciona un Tipo de Recurso...");
                                }
                            },
                            position: "last",
                            title: "EditTipoRec",
                            cursor: "pointer"
                        })

                   .navButtonAdd('#pager',
                        {
                            caption: "DesactivarTipoRecurso",
                            id: "desactivar_tipo_recurso",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoRecurso = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoRecurso.idTipoRecurso)) {
                                    if (parseInt(objTipoRecurso.Estatus) == 1) {
                                        GestionTipoRecurso(objTipoRecurso, 2);
                                    }
                                    else {
                                        alert('El Tipo de Recurso esta desactivado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Recurso...");
                                }


                            },
                            position: "last",
                            title: "DescactTipoRecurso",
                            cursor: "pointer"
                        })

            .navButtonAdd('#pager',
                        {
                            caption: "ActivarTipoRecurso",
                            id: "activar_trecurso",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objTipoRecurso = myGrid.jqGrid('getRowData', selectedRowId);

                                if (parseInt(objTipoRecurso.idTipoRecurso)) {
                                    if (parseInt(objTipoRecurso.Estatus) == 0) {
                                        GestionTipoRecurso(objTipoRecurso, 3);
                                    }
                                    else {
                                        alert('El Tipo de Recurso esta activado');
                                    }

                                }
                                else {
                                    alert("Selecciona un Tipo de Recurso...");
                                }


                            },
                            position: "last",
                            title: "ActTipoRec",
                            cursor: "pointer"
                        });

        }



        function ObtenerFiltro() {


            var nom_tipo_recurso = $.trim($('#txttipo_recurso_q').val());
            if (nom_tipo_recurso.length <= 0 || nom_tipo_recurso.length > 60) {
                nom_tipo_recurso = "NULL";
            }

            var filtro = nom_tipo_recurso.toString();
            return filtro;
        }


        function Buscar_TipoRecurso(idusu) {
            MostrarTipoRecursoObra(idusu, ObtenerFiltro());
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




            $(".buscar_tipo_recurso").click(function () {
                Buscar_TipoRecurso(idusu);
            });

            $(".alta_tipo_recurso").click(function () {
                GestionTipoRecurso(0, 0);
            });

            $("#bodegadatos").data("idusu", idusu);

            $(".posicion_boton_cancelar_tipo_recurso").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_tipo_recurso").click(function (e) {
                EjecutarAccionTipoRecurso();
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function RegistrarTipoRecursoBD(objTipoRecurso) {

            var stringData = JSON.stringify(objTipoRecurso);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceTipoRecursoObra.asmx/GuardarTipoRecursoObra",
                data: "{objTipoRecursoObra:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };

        function EjecutarAccionTipoRecurso() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



            var usu_cre_tipo_recurso = parseInt(idusu);

            var accion = parseInt($("#lblaccion_tiporecurso").html());
            var objTipoRecurso = {
                "idtipo_recurso": 0,                
                "descrip": '',
                "observ": '',
                "usu_cre": idusu,
                "usu_mod": idusu,
                "fec_cre": hoy,                
                "fec_mod": hoy,
                "cestatus": 0,
                "accion": accion
            }


            if (accion == 0) { /*Registrar Accion*/
                objTipoRecurso.cestatus = 1;                
                objTipoRecurso.descrip = $("#txtdescripcion_tipo_recurso").val();
                objTipoRecurso.observ = $("#txtobserv_tipo_recurso").val();
                

                RegistrarTipoRecursoBD(objTipoRecurso)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de recurso ' + arr[1] + ' ha sido creado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);

                     alert("No fue posible guardar el tipo de recurso capturado");
                 })
            }

            if (accion == 1) {
                objTipoRecurso.cestatus = 1;
                objTipoRecurso.idtipo_recurso = parseInt($("#lbl_idtiporecurso").html());
                objTipoRecurso.descrip = $("#txtdescripcion_tipo_recurso").val();
                objTipoRecurso.observ = $("#txtobserv_tipo_recurso").val();


                RegistrarTipoRecursoBD(objTipoRecurso)
                 .done(function (r) {
                     var cadena = r.d;
                     if (cadena != '<NewDataSet />') {
                         var arr = cadena.split(':');
                         alert('El tipo de recurso con IdTipoRecurso:' + arr[1] + ' ha sido modificado satisfactoriamente');
                         $('#mask, .window').hide();
                         RedibujarGrid();
                     }
                 })
                 .fail(function (xhr) {
                     console.log(xhr.responseText);
                     alert("No fue posible editar los cambios el Tipo de Recurso");
                 })

            }

            if (accion == 2) {
                objTipoRecurso.cestatus = 0;
                objTipoRecurso.idtipo_recurso = parseInt($("#lbl_idtiporecurso").html());
                objTipoRecurso.descrip = $("#txtdescripcion_tipo_recurso").val();
                objTipoRecurso.observ = $("#txtobserv_tipo_recurso").val();
                var resp = confirm('¿Desea desactivar el Tipo de Recurso: ' + objTipoRecurso.descrip + '?');
                if (resp) {
                    RegistrarTipoRecursoBD(objTipoRecurso)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Recurso con id: ' + arr[1] + ' ha sido desactivada satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible desactivar el Tipo de Recurso solicitada");
                     })
                }

            }

            if (accion == 3) {
                objTipoRecurso.cestatus = 1;
                objTipoRecurso.idtipo_recurso = parseInt($("#lbl_idtiporecurso").html());
                objTipoRecurso.descrip = $("#txtdescripcion_tipo_recurso").val();
                objTipoRecurso.observ = $("#txtobserv_tipo_recurso").val();
                var resp = confirm('¿Desea activar el Tipo de Recurso: ' + objTipoRecurso.descrip + '?');
                if (resp) {
                    RegistrarTipoRecursoBD(objTipoRecurso)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Tipo de Recurso con id: ' + arr[1] + ' ha sido activado satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el Tipo de Recurso solicitado");
                     })
                }

            }




        }

        function GestionTipoRecurso(objTipoRecurso, accion) {

            if (accion == 0) {  /*Alta de Accion*/
                $("#lbl_idtiporecurso").html('0');
                $("#lblaccion_tiporecurso").html(accion);                
                $("#txtobserv_tipo_recurso").val('');
                $("#txtdescripcion_tipo_recurso").val('');
            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    $("#lbl_idtiporecurso").html(objTipoRecurso.idTipoRecurso);
                    $("#lblaccion_tiporecurso").html(accion);                   
                    $("#txtdescripcion_tipo_recurso").val(objTipoRecurso.Descripcion);
                    $("#txtobserv_tipo_recurso").val(objTipoRecurso.Observaciones);

                    if (accion == 2 || accion == 3) {

                        $("#txtdescripcion_tipo_recurso").prop('disabled', true);
                        $("#txtobserv_tipo_recurso").prop('disabled', true);
                    }
                    else {                    
                        $("#txtdescripcion_tipo_recurso").prop('disabled', false);
                        $("#txtobserv_tipo_recurso").prop('disabled', false);
                    }

                }
            }
            MostrarModalTipoRecurso();
        }



        function MostrarModalTipoRecurso() {
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
            $("#dialogo_trecurso").css('top', winH / 2 - $("#dialogo_trecurso").height() / 2);
            $("#dialogo_trecurso").css('left', winW / 2 - $("#dialogo_trecurso").width() / 2);

            //transition effect
            $("#dialogo_trecurso").fadeIn(2000);
        };



</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <label>Tipo de Recurso: </label><input type="text" name="tipo_recurso" id="txttipo_recurso_q" style="width:250px" maxlength ="120"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_tipo_recurso"><== Buscar Tipo de Recurso ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_tipo_recurso"><== Alta Tipo Recurso==></a><br/><br/>        
         
<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>
 
<div id="boxes">        
    <div id="dialogo_trecurso" class="window"> 
       <div id="titulo_trecurso"> 
         <p style="text-align:center">GESTION DE TIPO DE RECURSO</p>
         idTipoRecurso: <label for="id_tipo_recurso" id="lbl_idtiporecurso"></label><br/>         
         accion:<label for="accion_tiporecurso" id="lblaccion_tiporecurso"></label><br/>
       </div>
       <div class="datos" id="bodyAccion">                            
          <label for="name" id="lbldescripcion_trecurso">*Etiqueta del Tipo de Recurso:</label><input type="text" name="Etiqueta del Tipo de Recurso:" id="txtdescripcion_tipo_recurso" size="60"/><br/><br/>          
           <label for="name" id="Label1">*Observación del Tipo de Recurso:</label><input type="text" name="Observación del Tipo de Recurso:" id="txtobserv_tipo_recurso" size="120"/><br/><br/>          
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_tipo_recurso">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_tipo_recurso">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>




