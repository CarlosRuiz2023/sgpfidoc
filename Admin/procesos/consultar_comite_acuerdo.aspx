<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_comite_acuerdo.aspx.vb" Inherits="Admin_procesos_consultar_comite_acuerdo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">




        function AbreVisorDocto(nombre_docto) {
            //alert(img);
            /*var url1 = "../Procesos/visor_docto.html?ResponseType=Edit&nombre_docto=" + nombre_docto;*/

            var url1 = "../../js/powerful_pdf_viewer/viewer_pdf.html?ResponseType=Edit&nombre_docto=" + nombre_docto;
            newWindow = window.open(url1, "_blank", "top=200,left=900,menubar=no,toolbar=no,location=no,height=720,width=880,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
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

        function ValidarArchivo(archivo) {              /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/

            var fn = archivo.name;
            var fs = archivo.size;
            var ext = fn.split(".").pop();
            if (fs > 7000000) {
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

        function formatea_num_sesion(texto) {
            var long = texto.length;

            if (texto.match(/[^0-9 ]/g)) {
                texto = texto.replace(/[^0-9 ]/g, '');
            }

            return texto;
        }

        function actualiza_tipo_sesion(tipo_sesion) {
            $('#lblnum_sesion_romano').html('');
            var r = $('#txtnum_sesion').val();
            var num_sesion = 0;
            var formato_comite = $('#txt_sesion').val();
            if ($.trim(r) != '') {
                num_sesion = parseInt(r);
            }

            var value_formato_comite = $('#lstformato_comite').val();
            var formato_comite = $('#lstformato_comite > option[value=' + value_formato_comite + ']').text();

            if (formato_comite.toUpperCase() != 'VIRTUAL') {
                formato_comite = '';
            }

            $('#lblnum_sesion_romano').html('Sesión ' + formato_comite + ' de Comité Técnico ' + '  ' + NumerosOrdinalesALetras(num_sesion, 0) + ' ' + tipo_sesion);
        }

        function actualiza_formato_comite(formato_comite) {
            $('#lblnum_sesion_romano').html('');
            var r = $('#txtnum_sesion').val();
            var num_sesion = 0;
            if ($.trim(r) != '') {
                num_sesion = parseInt(r);
            }

            var value_tipo_sesion = $('#lsttipo_sesion').val();
            var tipo_sesion = $('#lsttipo_sesion > option[value=' + value_tipo_sesion + ']').text();

            if (formato_comite.toUpperCase() != 'VIRTUAL') {
                formato_comite = '';
            }

            $('#lblnum_sesion_romano').html('Sesión ' + formato_comite + ' de Comité Técnico ' + '  ' + NumerosOrdinalesALetras(num_sesion, 0) + ' ' + tipo_sesion);
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



        function MostrarComiteAcuerdos(idusu, filtro) {


            var date = new Date();
            var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
            var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            var filtro2;
            var objComite;

            if ($("#grid")[0].grid) {
                $.jgrid.gridUnload("#grid");
                //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
            }


            $("#grid").jqGrid(
               {
                   datatype: function () {
                       $.ajax(
                         {
                             url: "../../WebServices/WebServiceAcuerdo.asmx/GetComiteAcuerdos_Grid", //PageMethod
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
                       id: "idcomite"
                   },
                   colModel: [
                 {
                     index: 'Idcomite', width: 120, align: 'center',
                     name: 'idComite', hidden: true
                 },
                 {
                     index: 'acta_comite', width: 100, align: 'center',
                     name: 'ActaComite', hidden: true
                 },
                 {
                     index: 'num_sesion', width: 80, align: 'center',
                     name: 'NumSesion'
                 },
                 {
                     index: 'fec_comite', width: 120, align: 'center',
                     name: 'FecComite'
                 },
                 {
                     index: 'leyenda_comite', width: 650, align: 'Center',
                     name: 'DescripComite'
                 },
                 {
                     index: 'idacuerdo', width: 80, align: 'center',
                     name: 'IdAcuerdo', hidden: true
                 },
                 {
                     index: 'num_acuerdo', width: 80, align: 'center',
                     name: 'NumAcuerdo', hidden: true
                 },
                 {
                     index: 'folio_acuerdo', width: 200, align: 'center',
                     name: 'FolioAcuerdo'
                 },
                 {
                     index: 'leyenda_acuerdo', width: 1000, align: 'center',
                     name: 'DescripAcuerdo'
                 },
                 {
                     index: 'estatus_acuerdo', width: 200, align: 'center',
                     name: 'EstatusAcuerdo'
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
                   sortname: "idcomite", //login SortColumn
                   sortorder: "asc", //login SortOrder.
                   width: "1600",
                   height: "800",
                   caption: "ACUERDOS POR COMITE"
                   
               }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
              
              
             .navButtonAdd('#pager',
                       {
                           caption: "VerActa",
                           id: "ver_acta_comite",
                           buttonicon: "ui-icon-document",
                           onClickButton: function () {
                               var myGrid = $('#grid');
                               var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                               var objComiteAcuerdo = myGrid.jqGrid('getRowData', selectedRowId);


                               if (objComiteAcuerdo.idComite) {
                                   AbreVisorDocto(objComiteAcuerdo.ActaComite);
                               } else {

                                   alert("Selecciona el Comité a consultar...");
                               }

                           },
                           position: "last",
                           title: "EditarComite",
                           cursor: "pointer"
                       });

        }


        function ObtenerFiltro() {


            var num_comite = $('#txtnum_sesion_q').val();

            if (num_comite.length <= 0 || num_comite.length > 8) {
                num_comite = "NULL";
            }


            var acuerdos_terminados = $('#chkacuerdos_terminados').is(":checked");

            if (acuerdos_terminados) {
                mostrar_acuerdos_terminados = '1';
            } else {
                mostrar_acuerdos_terminados = '0';
            }


            var acuerdos_no_terminados = $('#chkacuerdos_no_terminados').is(":checked");

            if (acuerdos_no_terminados) {
                mostrar_acuerdos_no_terminados = '1';
            } else {
                mostrar_acuerdos_no_terminados = '0';
            }

            var descrip_acuerdo = $('#txtdescrip_acuerdo_q').val();

            if (descrip_acuerdo.length <= 0 || descrip_acuerdo.length > 30) {
                descrip_acuerdo = "NULL";
            }

            var filtro = num_comite.toString() + ',' + mostrar_acuerdos_terminados + ',' + mostrar_acuerdos_no_terminados + ',' + descrip_acuerdo + ',';

            return filtro;
        }


        function Buscar_Comite(idusu) {
            MostrarComiteAcuerdos(idusu, ObtenerFiltro());
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



            $(".buscar_comite").click(function () {
                Buscar_Comite(idusu);
            });

            $(".checkboxAcuerdosTerminados").change(function () {
                var valor_actual = this.checked ? "0" : "1";
                if (valor_actual == '1') {
                    var acuerdos_no_terminados = $('#chkacuerdos_no_terminados').is(":checked");
                    if (!acuerdos_no_terminados) {
                        $("#chkacuerdos_no_terminados").prop("checked", true);
                    }
                }
            });


            $(".checkboxAcuerdosNoTerminados").change(function () {
                var valor_actual = this.checked ? "0" : "1";
                if (valor_actual == '1') {
                    var acuerdos_terminados = $('#chkacuerdos_terminados').is(":checked");
                    if (!acuerdos_terminados) {
                        $("#chkacuerdos_terminados").prop("checked", true);
                    }
                }
            });


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

     



      


</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
    
    <label>No. Sesión Comité:</label><input type="text" name="num_sesion" id="txtnum_sesion_q" style="width:250px" maxlength ="6" onkeyup = "this.value=formatea_num_sesion(this.value);"/><br/><br/> 
    <input type="checkbox" name="acuerdos_terminados" id="chkacuerdos_terminados" class="checkboxAcuerdosTerminados" checked/><label>Acuerdos Terminados</label><br/><br/> 
    <input type="checkbox" name="acuerdos_no_terminados" id="chkacuerdos_no_terminados" class="checkboxAcuerdosNoTerminados" checked/><label>Acuerdos No Terminados</label><br/><br/> 
    <label>Descripcion Acuerdo:</label><input type="text" name="descrip_acuerdo" id="txtdescrip_acuerdo_q" size="30" maxlength="30"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_comite"><== Buscar COMITE TECNICO ==></a><br/><br/>         

<table id="grid"></table>
<div id="pager"></div>&nbsp       
<div id="bodegadatos"></div>

 
<div id="boxes">        
   <div id="dialogo_comite" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">GESTION DE COMITÉS TÉCNICOS</td>
              </tr>   
              <tr>
                  <td class="f">Tipo de Sesión:</td>
                  <td class="e"><select name="tipo_sesion" id="lsttipo_sesion" onchange="actualiza_tipo_sesion(this.options[this.selectedIndex].text);"></select></td>               
                  <td class="f">Fecha Comité Técnico:</td>
                  <td class="dato_captura"><input type="text" name="fec_comite" id="txtfec_comite" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/></td>               
              </tr>
              <tr>
                  <td class="f">Formato de Comité:</td>
                  <td class="e"><select name="formato_comite" id="lstformato_comite" onchange="actualiza_formato_comite(this.options[this.selectedIndex].text);"></select></td>               
                  <td class="f">No. Sesión:</td>
                  <td class="e"><input type="text" name="num_sesion" id="txtnum_sesion" size="3" maxlength="3" onkeyup = "this.value=formatea_num_sesion(this.value);"/> </td>                  
              </tr>             
              <tr>                  
                  <td class="e" colspan="4"><label id="lblnum_sesion_romano"/></td>                  
              </tr>
              <tr>
                  <td class="f">Acta de Comité:</td>
                  <td class="e" colspan="3"><input type="file" id="file_acta" name="file"/>&nbsp&nbsp<a href="#" id="archivo" class="verarchivo"></a></td>                  
              </tr>                  
              <tr class="renglon_sistema">
                  <td>idComite:</td>
                  <td class="columna_sistema"><label id="lblidcomite"/></td>
                  <td>accion:</td>
                  <td class="columna_sistema"><label id="lblaccion"/></td>
              </tr>                  
              <tr>                        
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_comite">ACEPTAR</a></td>                  
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_comite">CANCELAR</a></td>
                  
              </tr>
          </tbody>
       </table>
    </div>     
      <div id="dialogo_acuerdo" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">GESTION DE ACUERDOS DE COMITÉ</td>
              </tr>   
              <tr>
                  <td class="f">Folio Acuerdo:</td>
                  <td class="e"><label id="lblfolio_acuerdo"/></td>               
                  <td class="f">Número Acuerdo:</td>
                  <td class="e"><input type="text" name="num_acuerdo" id="txtnum_acuerdo" size="3" maxlength="3" onkeyup = "CreaFolioAcuerdo(this.value);"/></td>                                          
              </tr>
              <tr>
                  <td class="f">Número Acuerdo Romano:</td>
                  <td class="e"><label id="lblnum_acuerdo_romano"/></td>                        
                  <td class="e" colspan="2"><input type="checkbox" id="check_acuerdo" /><label for="check1" id="lblacuerdo_terminado"></label></td>                  
              </tr>
              <tr>
                  <td class="f">Encabezado de Acuerdo:</td>
                  <td class="e" colspan="3" ><textarea name="encabezado_acuerdo" id="txtdescrip_acuerdo" cols="80" rows="20"></textarea></td>                       
              </tr>                            
              <tr class="renglon_sistema">
                  <td>idAcuerdo:</td>
                  <td class="columna_sistema"><label id="lblidacuerdo"/></td>
                  <td>idComite:</td>
                  <td class="columna_sistema"><label id="lblidcomite2"/></td>                  
              </tr>               
              <tr class="renglon_sistema">   
                  <td colspan="2">accion:</td>
                  <td colspan="2" class="columna_sistema"><label id="lblaccion_acuerdo"/></td>
              </tr>
              <tr>                        
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_accion_acuerdo">ACEPTAR</a></td>                  
                  <td  colspan="2" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_acuerdo">CANCELAR</a></td>
                  
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>



