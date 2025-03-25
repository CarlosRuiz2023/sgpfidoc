<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consulta_inpc.aspx.vb" Inherits="Admin_procesos_consulta_inpc" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


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



    function ObtenerFiltro() {
        var nomcalle = $('#txtnomcalle').val();
        if (nomcalle.length <= 0 || nomcalle.length > 20) {
            nomcalle = "NULL";
        }
        var num_obra = $('#txtnumobra').val();
        if (num_obra.length <= 0 || !$.isNumeric(num_obra)) {
            num_obra = "0";
        }
        var filtro = num_obra + "," + nomcalle + ",";
        return filtro;
    }




    function Mostrar_inpc() {

        var aux = $("#bodegadatos").data("menu_se leccionado");


        if ($("#grid")[0].grid) {
            $.jgrid.gridUnload("#grid");
            //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
        }

        
        $("#grid").jqGrid(
             {
                 datatype: function () {
                     $.ajax(
                       {
                           url: "../../WebServices/WebServiceINPC.asmx/Get_INPC", //PageMethod
                           data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                           "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                           "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                           "','pSortOrder':'" + $('#grid').getGridParam("sortorder")  + "'}", //PageMethod Parametros de entrada
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
                 },
                 jsonReader: //Set the jsonReader to the JQGridJSonResponse squema to bind the data.
                 {
                     root: "Items",
                     page: "CurrentPage",
                     total: "PageCount",
                     records: "RecordCount",
                     repeatitems: true,
                     cell: "row",
                     id: "yearmes"
                 },
                 colModel: [
                  {
                      index: 'mes', width: 100, align: 'Center',
                      name: 'MES'
                  },
                  {
                      index: 'year', width: 100, align: 'Center',
                      name: 'AÑO'
                  },
                  {
                      index: 'year_mes', width: 100, align: 'Center',
                      name: 'CLAVE'
                  },
                  {
                      index: 'valor_inpc', width: 100, align: 'Center',
                      name: 'VALOR_INPC'
                  }],
                 pager: "#pager", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                 rowNum: "30", // PageSize.
                 rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "year_mes", //login SortColumn
                 sortorder: "desc", //login SortOrder.
                 width: "1700",
                 height: "800",
                 caption: "Indice Nacional Precios al Consumidor",
                 

             }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

               .navButtonAdd('#pager',
                        {
                            caption: "Alta INPC",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                                                
                                AccionCapturaINPC(0);
                                
                            },
                            position: "last",
                            title: "Alta de INPC",
                            cursor: "pointer"
                        })

               .navButtonAdd('#pager',
                      {
                          caption: "Elim. INPC",
                          buttonicon: "ui-icon-document",
                          onClickButton: function () {
                              var myGrid = $('#grid');
                              selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                              yearmes = myGrid.jqGrid('getCell', selectedRowId, 'CLAVE');

                              var hoy = new Date();
                              var mes = lpad("0", 2, hoy.getMonth());
                              yearmes_act = hoy.getFullYear().toString() + '/' + mes;

                              if (yearmes != '') {
                                  if (yearmes == yearmes_act) {
                                      AccionRegistroINPC(-1, yearmes);
                                  }
                                  else {
                                      alert("Sólo es permitido eliminar el INPC actual");
                                  }

                              }
                              else {
                                  alert("Es necesario seleccionar un registro ");
                              }
                          },
                          position: "last",
                          title: "Eliminar de INPC",
                          cursor: "pointer"
                      });
    }
     
    


 

    //// FUNCION PRINCIPAL

    $(document).ready(function () {
       
              
        
      

        var opcion_selected;
        $("#Menu2 ul li").on('click', function (e) {
            opcion_selected = this.innerText;
            if (opcion_selected == 'INPC') {
                $("#bodegadatos").data("menu_se leccionado", 1);
                $("#lblOpc").html(':Det1');
                opcion_selected = 0;
               
            }
            else {
                if (opcion_selected == 'Determinantes generados sin entregar') {
                    $("#bodegadatos").data("menu_seleccionado", 1);
                    $("#lblOpc").html('Det2');
                    opcion_selected = 1;
                }
                else {
                    if (opcion_selected == 'Determinantes sin notificar') {
                        $("#bodegadatos").data("menu_seleccionado", 2);
                        $("#lblOpc").html('Det3');
                        opcion_selected = 2;
                    }
                    else {
                        if (opcion_selected == 'Determinantes notificados') {
                            $("#bodegadatos").data("menu_seleccionado", 3);
                            $("#lblOpc").html('Det4');
                            opcion_selected = 3;
                        }
                        /* else {
                             $("#bodegadatos").data("menu_seleccionado", -1);
                         }*/
                    }
                }
            }

        });
        var aux = opcion_selected;
        Mostrar_inpc();
           



        //if mask is clicked
        $('#mask').click(function () {
            $(this).hide();
            $('.window').hide();
        });


        $(".posicion_boton_cancelar_inpc").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
            $('#mask, .window').hide();
        });        


        $(".posicion_boton_accion_inpc").click(function (e) {            
            var accion = $("#lblaccioninpc").html();
            AccionRegistroINPC(accion);
        });
       
    });

    function leerArchivo(nom_archivo) {
        var url = "../../temp/" + nom_archivo;
        window.open(url, '_blank', 'toolbar=0');
    }

    function AccionCapturaINPC(accion) { // accion=0 --->nuevo registro;  accion = -1 ----> cancelar registro

        $("#txtmesinpc").val('');
        $("#txtyearinpc").val('');
        $("#lblyearmes").text('');
        
        if (accion == 0) {  //Si la accion es crear un nuevo levantamiento 

            //Preparación de interfaz para dar de alta la obra.  accion ==0
            $("#txtcalle").val('');
            $("#txttramolim1").val('');
            $("#txttramolim2").val('');
            $("#lblaccioninpc").html('0');


        }   
        MostrarModalINPC();
    }

    


    function AccionRegistroINPC(accion,yearmes) { // accion=0 --->nuevo registro;  accion = -1 ----> cancelar registro
        
        if (accion == 0) {  //Si la accion es crear un nuevo levantamiento 

            var mes = $("#txtmesinpc").val();
            var year = $("#txtyearinpc").val();
            var yearmes = $("#lblyearmes").html();
            var valor_inpc = $("#txtinpc").val();
            
            InsertaRegINPC(mes, year, yearmes, valor_inpc, accion);
           
        }

        if (accion == -1) {
            EliminaRegINPC(accion,yearmes);
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

    function EliminaRegINPC(accion, yearmes) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


        var enviarObj = {
            "mes": 0,
            "year": 0,
            "yearmes": yearmes,
            "valor_inpc": 0,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceINPC.asmx/ActINPC",
            data: "{objinpc:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    alert(data.d);
                    $('#mask, .window').hide();
                    RedibujarGrid();

                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }


    function InsertaRegINPC(mes, year, yearmes, valor_inpc, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


        var enviarObj = {
            "mes": mes,
            "year": year,
            "yearmes": yearmes,
            "valor_inpc":valor_inpc,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceINPC.asmx/ActINPC",
            data: "{objinpc:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    alert(data.d);
                    $('#mask, .window').hide();
                    RedibujarGrid();

                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }


    function RedibujarGrid() {
        
        $("#grid").trigger("reloadGrid");
    }




    function MostrarModalINPC() {
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
        $("#dialogoinpc").css('top', winH / 2 - $("#dialogoinpc").height() / 2);
        $("#dialogoinpc").css('left', winW / 2 - $("#dialogooinpc").width() / 2);

        //transition effect
        $("#dialogoinpc").fadeIn(2000);
    }

    function year(year_cap) {

        var year = year_cap;        
        var yearmes = year.toString() + '/' + lpad("0", 2, $("#txtmesinpc").val());

        $("#lblyearmes").text(yearmes);        
    }

    function mes(mes_cap) {
        var mes = lpad("0", 2,mes_cap);
        var yearmes = $("#txtyearinpc").val() + '/' + mes.toString();

        $("#lblyearmes").text(yearmes);
    }
    
    function lpad(padString, length,mes) {
        var str = mes.toString();
        while (str.length < length)
            str = padString + str;
        return str;
    }

  
</script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">     
 
<table id="grid"></table>
<div id="pager"></div>&nbsp       
 
<div id="boxes">        
    <div id="dialogoinpc" class="window"> 
       <div id="tituloinpc"> 
         <p style="text-align:center">GESTION DE INPC</p>                 
         Acción:<label for="accion" id="lblaccioninpc"></label><br/> 
       </div>
       <div class="datos" id="bodyinpc">                  
          <label for="name" id="lblmes">*MES:</label><input type="number" id="txtmesinpc" min="1" max="12"  oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxlength); const hoy = new Date(); if (this.value > 12) this.value = 12; if (this.value < (hoy.getMonth())) this.value=hoy.getMonth();mes(this.value);" maxlength="2"/>&nbsp&nbsp&nbsp&nbsp&nbsp
          <label for="name" id="lblyear">*AÑO:</label><input type="number" id="txtyearinpc" min="2022" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxlength);const hoy = new Date(); if (this.value > hoy.getFullYear() && hoy.getMonth()==0) { this.value = hoy.getFullYear()-1 } else { this.value = hoy.getFullYear() }; year(this.value);" maxlength="4"/>  &nbsp&nbsp&nbsp&nbsp&nbsp
          <label for="name" id="lblyearmes">*AÑO/MES:</label><label for="name" id="lblyearmes"></label><br/><br/>
          <label for="name" id="lblvalorinpc">*Valor del Indice Nacional del Consumidor:</label><input type="number" min="1" max="500"  oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value > 200) this.value = 120;" maxLength="7" name="inpc" id="txtinpc" size="10"/><br/><br/>          
       </div>                  
       <div class="botonesA" id="botonesinpc">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_inpc">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_inpc">Cancelar</a></p>                
       </div>
    </div>     
    <div id="mask"></div>
 </div>
</asp:Content>



