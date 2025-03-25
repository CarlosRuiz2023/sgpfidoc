<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_comite.aspx.vb" Inherits="Admin_procesos_consultar_comite" %>

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
            if (fs > 30000000) {
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

            if (long >= 1) {
                $('#lblnum_sesion_romano').html(CreaLeyendaSesion(texto,$('#lsttipo_sesion').text()));
            }
            else {
                $('#lblnum_sesion_romano').html('');
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


       

        function CreaLeyendaSesion(numero) {
            if (numero > 0) {

                var value_tipo_sesion = $('#lsttipo_sesion').val();
                var tipo_sesion = $('#lsttipo_sesion > option[value=' + value_tipo_sesion + ']').text();

                var value_formato_comite = $('#lstformato_comite').val();
                var formato_comite = $('#lstformato_comite > option[value=' + value_formato_comite + ']').text();

                if (formato_comite.toUpperCase() != 'VIRTUAL') {
                    formato_comite = '';
                }

                $('#lblnum_sesion_romano').html('Sesión ' + formato_comite + ' de Comité Técnico ' + NumerosOrdinalesALetras(numero, 0) + ' ' + tipo_sesion);
            } 
        }

        function romanos(number) {
            var romanos = {
                           M: 1000,
                          CM: 900,
                           D: 500,
                          CD: 400,
                           C: 100,
                          XC: 90,
                           L: 50,
                          XL: 40,
                           X: 10,
                          IX: 9,
                           V: 5,
                          IV: 4,
                           I: 1,
                          }

            var resultado = ""
            for (var r in romanos) {
                //repeat es parte del iterador y lo que hace es que
                // repite r las veces que sean necesarias. ( dependiendo la division)
              resultado += r.repeat(Math.floor( number / romanos[r]))
              number = number % romanos[r]
            }
        return resultado
        }

        function Unidades(num) {

            switch (num) {
                case 1: return "Primera";
                case 2: return "Segunda";
                case 3: return "Tercera";
                case 4: return "Cuarta";
                case 5: return "Quinta";
                case 6: return "Sexta";
                case 7: return "Séptima";
                case 8: return "Octava";
                case 9: return "Novena";
            }

            return "";
        }

        function Decenas(num) {

            decena = Math.floor(num / 10);
            unidad = num - (decena * 10);

            switch (decena) {
                case 1:
                    switch (unidad) {
                        case 0: return "Décima ";                       
                        default: return "Décima " + Unidades(unidad);
                    }
                case 2:
                    switch (unidad) {
                        case 0: return "Vigésima ";
                        default: return "Vigésima " + Unidades(unidad);
                    }
                case 3: return DecenasY("Trigésima",unidad);
                case 4: return DecenasY("Cuadragésima ", unidad);
                case 5: return DecenasY("Quincuagésima ", unidad);
                case 6: return DecenasY("Sextoagésima ", unidad);
                case 7: return DecenasY("Heptagésima ", unidad);
                case 8: return DecenasY("Octagésima ", unidad);
                case 9: return DecenasY("Nonagésima ", unidad);
                case 0: return Unidades(unidad);
            }
        }//Unidades()

        function DecenasY(strSin, numUnidades) {
            if (numUnidades > 0)
                return strSin + "  " + Unidades(numUnidades)

            return strSin;
        }//DecenasY()

        function Centenas(num) {

            centenas = Math.floor(num / 100);
            decenas = num - (centenas * 100);

            switch (centenas) {
                case 1:
                    if (decenas > 0)
                        return "Centésima " + Decenas(decenas);
                    return "Centésima ";
                case 2: return "Ducentésima " + Decenas(decenas);
                case 3: return "Tricentésima " + Decenas(decenas);
                case 4: return "Cuadrigentésima " + Decenas(decenas);
                case 5: return "Quincuagésima " + Decenas(decenas);
                case 6: return "Sexagentésima " + Decenas(decenas);
                case 7: return "Heptagentésima " + Decenas(decenas);
                case 8: return "Octigentésima " + Decenas(decenas);
                case 9: return "Nonigentésima " + Decenas(decenas);
            }

            return Decenas(decenas);
        }//Centenas()

        function Seccion(num, divisor, strSingular, strPlural) {
            cientos = Math.floor(num / divisor)
            resto = num - (cientos * divisor)

            letras = "";

            if (cientos > 0)
                if (cientos > 1)
                    letras = Centenas(cientos) + " " + strPlural;
                else
                    letras = strSingular;

            if (resto > 0)
                letras += "";

            return letras;
        }//Seccion()

        function Miles(num) {
            divisor = 1000;
            cientos = Math.floor(num / divisor)
            resto = num - (cientos * divisor)

            strMiles = Seccion(num, divisor, "Milésima", "Milésimas");
            strCentenas = Centenas(resto);

            if (strMiles == "")
                return strCentenas;

            return strMiles + " " + strCentenas;

            //return Seccion(num, divisor, "UN MIL", "MIL") + " " + Centenas(resto);
        }//Miles()

        function Millones(num) {
            divisor = 1000000;
            cientos = Math.floor(num / divisor)
            resto = num - (cientos * divisor)

            strMillones = Seccion(num, divisor, "Millonésima", "Millonésimas");
            strMiles = Miles(resto);

            if (strMillones == "")
                return strMiles;

            return strMillones + " " + strMiles;

            //return Seccion(num, divisor, "UN MILLON", "MILLONES") + " " + Miles(resto);
        }//Millones()

        function NumerosOrdinalesALetras(num, centavos) {
            var data = {
                numero: num,
                enteros: Math.floor(num),
                centavos: (((Math.round(num * 100)) - (Math.floor(num) * 100))),
                letrasCentavos: "",
            };
            if (centavos == undefined || centavos == false) {
                data.letrasMonedaPlural = "";
                data.letrasMonedaSingular = "";
            } else {
                data.letrasMonedaPlural = "";
                data.letrasMonedaSingular = "";
            }

           /*if (data.centavos > 0)
                data.letrasCentavos = "CON " + NumeroALetras(data.centavos, true);*/

            if (data.enteros == 0)
                return " " + data.letrasMonedaPlural + " " + data.letrasCentavos;
            if (data.enteros == 1)
                return Millones(data.enteros) + " " + data.letrasMonedaSingular + " " + data.letrasCentavos;
            else
                return Millones(data.enteros) + " " + data.letrasMonedaPlural + " " + data.letrasCentavos;
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



        function MostrarComite(idusu, filtro) {


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
                             url: "../../WebServices/WebServiceComite.asmx/GetComite_Grid", //PageMethod
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
                     index: 'idcomite', width: 120, align: 'center',
                     name: 'idComite', hidden: true
                 },
                 {
                     index: 'num_sesion', width: 100, align: 'center',
                     name: 'No_Sesion'
                 },
                 {
                     index: 'num_sesion_romano', width: 100, align: 'center',
                     name: 'NumSesionRomano', hidden: true
                 },
                 {
                     index: 'leyenda', width: 500, align: 'center',
                     name: 'Etiqueta'
                 },
                 {
                     index: 'acta_comite', width: 300, align: 'Center',
                     name: 'Dcto_ActaComite', hidden: true
                 },
                 {
                     index: 'tipo_sesion', width: 80, align: 'center',
                     name: 'Num_Tipo_Sesion', hidden: true
                 },
                 {
                     index: 'tipo_sesion_etiqueta', width: 200, align: 'center',
                     name: 'Tipo_Sesion'
                 },
                 {
                     index: 'formato_comite', width: 80, align: 'center',
                     name: 'Num_Formato_Comite', hidden: true
                 },
                 {
                     index: 'formato_comite_etiqueta', width: 200, align: 'center',
                     name: 'Formato_Comite'
                 },
                 {
                     index: 'fec_comite', width: 200, align: 'center',
                     name: 'Fecha_Comite'
                 },
                 {
                     index: 'usu_cre', width: 300, align: 'center',
                     name: 'UsuCre', hidden: true
                 },
                 {
                     index: 'usu_mod', width: 160, align: 'center',
                     name: 'UsuMod', hidden: true
                 },
                 {
                     index: 'fec_cre', width: 200, align: 'center',
                     name: 'FecCre', hidden: true
                 },
                 {
                     index: 'fec_mod', width: 160, align: 'center',
                     name: 'FecMod', hidden: true
                 },
                 {
                     index: 'cestatus', width: 200, align: 'center',
                     name: 'Estatus', hidden: true
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
                   width: "1300",
                   height: "800",
                   caption: "GESTION DE COMITES TECNCOS",
                   subGrid: true,
                   subGridBeforeExpand: function (subgrid_id, row_id) {
                       var myGrid = $('#grid');
                       objComite = myGrid.jqGrid('getRowData', row_id);
                       filtro2 = objComite.idComite + ',';
                   },
                   subGridRowExpanded: function (subgrid_id, row_id) {
                       var subgrid_table_id, pager_id;
                       subgrid_table_id = subgrid_id + "_t";
                       pager_id = "p_" + subgrid_table_id;
                       $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");
                       var comite = jQuery('#grid').jqGrid('getRowData', row_id);

                       jQuery("#" + subgrid_table_id).jqGrid({
                           datatype: function () {

                               $.ajax(
                                 {
                                     url: "../../WebServices/WebServiceAcuerdo.asmx/GetAcuerdo_Grid", //PageMethod
                                     data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                           "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                           "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                           "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                           "','filtro':'" + filtro2 + "'}", //PageMethod Parametros de entrada                                   
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
                               id: "idacuerdo"
                           },
                           colModel: [
                                 {
                                     index: 'idacuerdo', width: 80, align: 'Center', name: 'idAcuerdo', hidden: true
                                 },
                                 {
                                     index: 'idcomite', width: 100, align: 'Center', name: 'idComite', hidden: true
                                 },
                                 {
                                     index: 'num_acuerdo', width: 50, align: 'Center', name: 'Num_Acuerdo'
                                 },
                                 {
                                     index: 'folio_acuerdo', width: 80, align: 'Center', name: 'Folio_Acuerdo'
                                 },
                                 {
                                     index: 'num_acuerdo_romano', width: 80, align: 'Center', name: 'Num_Acuerdo_Romano'
                                 },
                                 {
                                     index: 'descrip_acuerdo', width: 200, align: 'Center', name: 'Descripcion'
                                 },
                                 {
                                      index: 'acuerdo_terminado_txt', width: 100, align: 'Center', name: 'ATerminado'
                                 },
                                 {
                                     index: 'fec_cre', width: 100, align: 'Center', name: 'Fec_Cre', hidden: true
                                 },
                                 {
                                     index: 'fec_mod', width: 80, align: 'Center', name: 'Fec_Mod', hidden: true
                                 },
                                 {
                                     index: 'usr_cre', width: 100, align: 'Center', name: 'Usr_Cre', hidden: true
                                 },
                                 {
                                     index: 'usr_mod', width: 100, align: 'Center', name: 'Usr_Mod', hidden: true
                                 },
                                 {
                                     index: 'cestatus', width: 100, align: 'Center', name: 'Estatus', hidden: true
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
                           sortname: "num_acuerdo", //login SortColumn
                           sortorder: "asc", //login SortOrder.
                           width: "1200",
                           height: "100%",
                           caption: "ACUERDOS"
                       }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })


                        .navButtonAdd("#" + pager_id,
                                {
                                    caption: "AltaAcuerdo...",
                                    buttonicon: "ui-icon-document",
                                    onClickButton: function () {
                                        var myGrid = $("#" + subgrid_table_id);
                                        var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                        var objAcuerdo = myGrid.jqGrid('getRowData', selectedRowId);

                                        GestionAcuerdo(objAcuerdo, objComite, 0);
                                    },
                                    position: "last",
                                    title: "AltaAcuerdo",
                                    cursor: "pointer"
                                })

                        .navButtonAdd("#" + pager_id,
                                {
                                    caption: "EditarAcuerdo",
                                    buttonicon: "ui-icon-document",
                                    onClickButton: function () {
                                        var myGrid = $("#" + subgrid_table_id);
                                        var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                        var objAcuerdo = myGrid.jqGrid('getRowData', selectedRowId);

                                        if (objAcuerdo.idAcuerdo) {
                                            GestionAcuerdo(objAcuerdo, objComite, 1);
                                        }
                                        else {
                                            alert("Selecciona el acuerdo a consultar...");
                                        }
                                    },
                                    position: "last",
                                    title: "EditarAcuerdo",
                                    cursor: "pointer"
                                })


                       .navButtonAdd("#" + pager_id,
                                {
                                    caption: "EliminarAcuerdo",
                                    buttonicon: "ui-icon-document",
                                    onClickButton: function () {
                                        var myGrid = $("#" + subgrid_table_id);
                                        var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                        var objAcuerdo = myGrid.jqGrid('getRowData', selectedRowId);

                                        if (objAcuerdo.idAcuerdo) {
                                            GestionAcuerdo(objAcuerdo, objComite, 2);
                                        }
                                        else {
                                            alert("Selecciona el acuerdo a consultar...");
                                        }
                                    },
                                    position: "last",
                                    title: "EditarAcuerdo",
                                    cursor: "pointer"
                                })


                   }


               }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
              .navButtonAdd('#pager',
                       {
                           caption: "AltaComite",
                           id: "alta_comite",
                           buttonicon: "ui-icon-document",
                           onClickButton: function () {
                               var myGrid = $('#grid');
                               var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                               var objComite = myGrid.jqGrid('getRowData', selectedRowId);

                               if (objComite.idComite) {
                                   GestionComite(objComite, 0);
                               } else {
                                   alert("Selecciona el Comité a consultar...");
                               }


                           },
                           position: "last",
                           title: "AltaComite",
                           cursor: "pointer"
                       })

              .navButtonAdd('#pager',
                       {
                           caption: "EditarComite",
                           id: "editar_comite",
                           buttonicon: "ui-icon-document",
                           onClickButton: function () {
                               var myGrid = $('#grid');
                               var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                               var objComite = myGrid.jqGrid('getRowData', selectedRowId);
                               
                               if (objComite.idComite) {
                                   GestionComite(objComite, 1);
                               } else {

                                   alert("Selecciona el Comité a consultar...");
                               }

                           },
                           position: "last",
                           title: "EditarComite",
                           cursor: "pointer"
                       })

             .navButtonAdd('#pager',
                       {
                           caption: "VerActa",
                           id: "ver_acta_comite",
                           buttonicon: "ui-icon-document",
                           onClickButton: function () {
                               var myGrid = $('#grid');
                               var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                               var objComite = myGrid.jqGrid('getRowData', selectedRowId);

                               
                               if (objComite.idComite) {
                                   AbreVisorDocto(objComite.Dcto_ActaComite);
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

            if (num_comite.length <= 0 || num_comite.length > 30) {
                num_comite = "NULL";
            }


            var fec_comite = $('#txtfec_comite_q').val();
            if (fec_comite.length <= 0 || fec_comite.length > 10) {
                fec_comite = "NULL";
            }

            var filtro = num_comite.toString() + ',' + fec_comite.toString() + ',';
            return filtro;
        }


        function Buscar_Comite(idusu) {
            MostrarComite(idusu, ObtenerFiltro());
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

            $(".alta_comite").click(function () {
                GestionComite(0, 0);
            });            
           

            $(".posicion_boton_cancelar_comite,.posicion_boton_cancelar_acuerdo").click(function (e) {
                //Cancel the link behavior
                //e.preventlogin();
                $('#mask, .window').hide();
            });


            $(".posicion_boton_accion_comite").click(function (e) {
                EjecutarAccionComite();
            });

            $(".posicion_boton_accion_acuerdo").click(function (e) {
                EjecutarAccionAcuerdo();
            });

            $(".verarchivo").click(function (e) {
                var nom_archivo = $("#archivo").text();
                AbreVisorDocto(nom_archivo);
            });

            

            


            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });

        });

        function RegistrarComiteBD(objComite) {

            var stringData = JSON.stringify(objComite);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceComite.asmx/GuardarComite",
                data: "{objComite:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };


        function RegistrarAcuerdoBD(objAcuerdo) {

            var stringData = JSON.stringify(objAcuerdo);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceAcuerdo.asmx/GuardarAcuerdo",
                data: "{objAcuerdo:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });

        };
     

        function EjecutarAccionComite() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



            var usu_cre_comite = idusu;
            var accion = parseInt($("#lblaccion").html());


            var objComite = {
                "idcomite": 0,
                "num_sesion": '',
                "tipo_sesion": '',                
                "formato_comite": '',
                "acta_comite": '',
                "num_sesion_romano": '',
                "leyenda": '',
                "fec_comite": '01/01/1900',
                "usu_cre": idusu,
                "usu_mod": idusu,
                "fec_cre": hoy,
                "fec_mod": hoy,
                "cestatus": 0,
                "accion": accion,
            }

         
            if (accion == 0) { /*Registrar Accion*/
                objComite.idcomite = 1;
                
                objComite.cestatus = 1;
                objComite.num_sesion = $("#txtnum_sesion").val();
                objComite.tipo_sesion = $("#lsttipo_sesion").val();
                objComite.formato_comite = $("#lstformato_comite").val();
                objComite.acta_comite = 'ActaComite_';
                objComite.num_sesion_romano = 'disponible'
                objComite.leyenda = $("#lblnum_sesion_romano").html();
                objComite.fec_comite = $("#txtfec_comite").val();
                
                var valido = ValidarValores(objComite);
                if (valido) {
                    objComite.fec_comite = ConvertirCadenaToFecha($("#txtfec_comite").val());
                    RegistrarComiteBD(objComite)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   var error = arr[1];
                                   var nom_archivo = arr[4];
                                   if (error == '0') {
                                       ValidacionGuardadoArchivo($("#file_acta").get(0).files, nom_archivo);
                                       alert('El Comite con IdComite:' + arr[3] + ' ha sido dado de alta satisfactoriamente');
                                       $('#mask, .window').hide();
                                       RedibujarGrid();
                                   } else {
                                       alert(cadena);
                                   }
                               }
                           })
                           .fail(function (xhr) {
                                 console.log(xhr.responseText);
                                 alert("No fue posible dar de alta el Comite");
                           })
                }
            }


            if (accion == 1) {                
                objComite.idcomite = $("#lblidcomite").text();
                objComite.cestatus = 1;
                objComite.num_sesion = $("#txtnum_sesion").val();
                objComite.tipo_sesion = $("#lsttipo_sesion").val();
                objComite.formato_comite = $("#lstformato_comite").val();
                objComite.acta_comite = 'ActaComite_' + $("#txtnum_sesion").val() + '_' + $("#lblidcomite").html() + '.pdf';
                objComite.num_sesion_romano = 'disponible'
                objComite.leyenda = $("#lblnum_sesion_romano").html();
                objComite.fec_comite = $("#txtfec_comite").val();
                var valido = ValidarValores(objComite);
                if (valido) {
                    objComite.fec_comite = ConvertirCadenaToFecha($("#txtfec_comite").val());
                    RegistrarComiteBD(objComite)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   var error = arr[1];
                                   if (error == '0') {
                                       ValidacionGuardadoArchivo($("#file_acta").get(0).files, objComite.acta_comite);
                                       alert('El Comite con IdComite:' + arr[3] + ' ha sido modificado satisfactoriamente');
                                       $('#mask, .window').hide();
                                       RedibujarGrid();
                                   } else {
                                       alert(cadena);
                                   }
                               }
                           })
                               .fail(function (xhr) {
                                   console.log(xhr.responseText);
                                   alert("No fue posible dar de alta el Comite");
                               })
                }

            }

            if (accion == 2) {
                objComite.idcomite = $("#lblidcomite").text();
                objComite.cestatus = 1;
                objComite.num_sesion = $("#txtnum_sesion").val();
                objComite.tipo_sesion = $("#lsttipo_sesion").val();
                objComite.formato_comite = $("#lstformato_comite").val();
                objComite.acta_comite = 'ActaComite_' + $("#txtnum_sesion").val() + '_' + $("#lblidcomite").html() + '.pdf';
                objComite.num_sesion_romano = 'disponible'
                objComite.leyenda = $("#lblnum_sesion_romano").html();
                objComite.fec_comite = $("#txtfec_comite").val();
                objComite.cestatus = 0;
                objComite.idComite = parseInt($("#lblid_Comite").html());
                objComite.nom_cont = $("#txtnom_cont").val();
                var resp = confirm('¿Desea desactivar el Comite: ' + objComite.nom_cont + '?');
                if (resp) {

                }

            }

            if (accion == 3) {
                objComite.cestatus = 1;
                objComite.idComite = parseInt($("#lblid_Comite").html());
                objComite.nom_cont = $("#txtnom_cont").val();
                var resp = confirm('¿Desea activar el Comite: ' + objComite.nom_cont + '?');
                if (resp) {
                    RegistrarComiteBD(objComite)
                     .done(function (r) {
                         var cadena = r.d;
                         if (cadena != '<NewDataSet />') {
                             var arr = cadena.split(':');
                             alert('El Comite con id: ' + arr[1] + ' ha sido activado satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         }
                     })
                     .fail(function (xhr) {
                         console.log(xhr.responseText);
                         alert("No fue posible activar el Comite solicitado");
                     })
                }

            }
        }


        function EjecutarAccionAcuerdo() {
            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var idusu = arrusuario[2];

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());
                        
            var usu_cre_acuerdo = idusu;
            var accion = parseInt($("#lblaccion_acuerdo").html());


            var objAcuerdo = {
                "idacuerdo": 0,
                "idcomite": '',
                "num_acuerdo": '',
                "folio_acuerdo": '',
                "num_acuerdo_romano": '',
                "descrip_acuerdo": '',
                "acuerdo_terminado":0,
                "fec_cre": hoy,
                "fec_mod": hoy,                
                "usu_cre": idusu,
                "usu_mod": idusu,
                "cestatus": 0,                
                "accion": accion,
            }


            if (accion == 0) { /*Registrar Accion*/
                objAcuerdo.idcomite = $("#lblidcomite2").text();
                objAcuerdo.idacuerdo = $("#lblidacuerdo").text();
                objAcuerdo.num_acuerdo = $("#txtnum_acuerdo").val();
                objAcuerdo.folio_acuerdo = $("#lblfolio_acuerdo").text();
                objAcuerdo.num_acuerdo_romano = $("#lblnum_acuerdo_romano").text();
                objAcuerdo.descrip_acuerdo = $("#txtdescrip_acuerdo").val();

                
                var acuerdo2 = $('#check_acuerdo').is(":checked");
                if (acuerdo2) {
                    objAcuerdo.acuerdo_terminado = 1;
                } else {
                    objAcuerdo.acuerdo_terminado = 0;
                }

                    
                objAcuerdo.cestatus = 1;
                

                var valido = ValidarValoresAcuerdo(objAcuerdo);
                if (valido) {                    
                    RegistrarAcuerdoBD(objAcuerdo)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   var error = arr[1];
                                   if (error == '0') {                                       
                                       alert('El acuerdo con idAcuerdo:' + arr[3] + ' ha sido dado de alta satisfactoriamente');
                                       $('#mask, .window').hide();
                                       RedibujarGrid();
                                   } else {
                                       alert(cadena);
                                   }
                               }
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fue posible dar de alta el Comite");
                           })
                }
            }


            if (accion == 1) {
                objAcuerdo.idcomite = $("#lblidcomite2").text();
                objAcuerdo.idacuerdo = $("#lblidacuerdo").text();
                objAcuerdo.num_acuerdo = $("#txtnum_acuerdo").val();
                objAcuerdo.folio_acuerdo = $("#lblfolio_acuerdo").text();
                objAcuerdo.num_acuerdo_romano = $("#lblnum_acuerdo_romano").text();
                objAcuerdo.descrip_acuerdo = $("#txtdescrip_acuerdo").val();


                var acuerdo2 = $('#check_acuerdo').is(":checked");
                if (acuerdo2) {
                    objAcuerdo.acuerdo_terminado = 1;
                } else {
                    objAcuerdo.acuerdo_terminado = 0;
                }

                objAcuerdo.cestatus = 1;


                var valido = ValidarValoresAcuerdo(objAcuerdo);
                if (valido) {
                    RegistrarAcuerdoBD(objAcuerdo)
                           .done(function (r) {
                               var cadena = r.d;
                               if (cadena != '<NewDataSet />') {
                                   var arr = cadena.split(':');
                                   var error = arr[1];
                                   if (error == '0') {
                                       alert('El acuerdo con idAcuerdo: ' + arr[3] + ' ha sido dado de alta satisfactoriamente');
                                       $('#mask, .window').hide();
                                       RedibujarGrid();
                                   } else {
                                       alert(cadena);
                                   }
                               }
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fue posible dar de alta el Acuerdo");
                           })
                }
            }

            if (accion == 2) {
                objAcuerdo.cestatus = 0;
                objAcuerdo.num_acuerdo = parseInt($("#txtnum_acuerdo").val());
                objAcuerdo.idcomite = $("#lblidcomite2").text();
                objAcuerdo.idacuerdo = $("#lblidacuerdo").text();
                

                var resp = confirm('¿Desea desactivar el acuerdo: ' + $("#txtnum_acuerdo").val() + '?');
                if (resp) {
                    RegistrarAcuerdoBD(objAcuerdo)
                    .done(function (r) {
                        var cadena = r.d;
                        if (cadena != '<NewDataSet />') {
                            var arr = cadena.split(':');
                            alert('El acuerdo con id: ' + arr[3] + ' ha sido activado satisfactoriamente');
                            $('#mask, .window').hide();
                            RedibujarGrid();
                        }
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fue posible desactivar el acuerdo solicitado");
                    })
                }

            }

            
        }


        function ValidarValores(objComite) {
            var validar = true;
          
            var fecha_comite_date = ConvertirCadenaToFecha(objComite.fec_comite);
            var fecha_comite_txt = objComite.fec_comite;

            var date = new Date();
            var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());

            if (fecha_comite_date > hoy) {
                validar = false
                alert('La fecha capturada es mayor al día de hoy, solo se capturan sesiones de comité realizados.');
            }

            if (fecha_comite_txt == '01/01/1900') {
                validar = false
                alert('Es necesario capturar la fecha de Comité.');
            }

            var num_sesion = $("#txtnum_sesion").val();

            if ($.trim(num_sesion)=='' || $.trim(num_sesion) =='null') {
                validar = false;
                alert('Favor de capturar el número de sesión.');
            }

            if (validar) {
                if ($("#file_acta").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#file_acta")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        validar = true;
                    }
                    else {
                        $("#file_acta").val("");
                        validar = false;
                    }
                }
                else {
                    if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                        validar = true;
                    }
                    else {
                        alert("No se capturado el Acta de Comité");
                        validar = false;
                    }
                }
            }

            return validar;
        }


        function ValidarValoresAcuerdo(objAcuerdo) {
            var validar = true;

            var numero_acuerdo = parseInt(objAcuerdo.num_acuerdo);

            if (isNaN(numero_acuerdo)) {                
                validar = false
                alert('El número de acuerdo es incorrecto.');
            }
            
            var descrip_acuerdo = $.trim(objAcuerdo.descrip_acuerdo);

            if (descrip_acuerdo.length <= 10) {
                validar = false;
                alert('El encabezado del acuerdo es erróneo.');
            }           

            return validar;
        }

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

        function sonLetrasSolamente(texto) {
            var regex = /^[a-zA-Z ]+$/;
            return regex.test(texto);
        }

        function GestionComite(objComite, accion) {

            if (accion == 0) {  /*Alta de Accion*/
                $("#lsttipo_sesion").html('0');
                $("#txtfec_comite").val('');
                $("#txtnum_sesion").val('');
                $("#lblnum_sesion_romano").text('');                
                $("#lblidcomite").text(0);
                $("#lblaccion").text(0);
                $("#file_acta").val('');
                $("#archivo").text('')
                $("#txtnum_sesion").prop('disabled', false);
                llenarTipoComite(0)
                llenarFormatoComite(0)
            }
            else {
                if (accion == 1 || accion == 2 || accion == 3) {
                    $("#lblidcomite").text(objComite.idComite);
                    $("#txtnum_sesion").prop('disabled', true);
                    $("#lsttipo_sesion").html(objComite.Tipo_Sesion);
                    $("#txtfec_comite").val(objComite.Fecha_Comite.substr(1,10));
                    $("#txtnum_sesion").val(objComite.No_Sesion);
                    $("#lblnum_sesion_romano").text(objComite.Etiqueta);
                    $("#lblaccion").text(accion);
                    $("#file_acta").val('');
                    $("#archivo").text(objComite.Dcto_ActaComite)
                    llenarTipoComite(parseInt(objComite.Num_Tipo_Sesion))
                    llenarFormatoComite(parseInt(objComite.Num_Formato_Comite))

                    if (accion == 2 || accion == 3) {                        
                        $("#lsttipo_sesion").prop('disabled', true);
                        $("#txtfec_comite").prop('disabled', true);                        
                        $("#file_acta").prop('disabled', true);
                    }
                    else {                        
                        $("#lsttipo_sesion").prop('disabled', false);
                        $("#txtfec_comite").prop('disabled', false);                                               
                        $("#file_acta").prop('disabled', false);
                    }

                }
            }
            MostrarModalComite();
        }


        function GestionAcuerdo(objAcuerdo,objComite, accion) {

            $("#bodegadatos").data("fecha_comite", objComite.Fecha_Comite);

            
            $("#lblacuerdo_terminado").html('Acuerdo Terminado');

            if (accion == 0) {  /*Alta de Accion*/
                $("#lblfolio_acuerdo").html('');               
                $("#txtnum_acuerdo").val('');
                $("#lblnum_acuerdo_romano").html('');
                $("#lblidacuerdo").text('0');
                $("#lblidcomite2").text(objComite.idComite);
                $("#lblaccion_acuerdo").text('0');
                $("#txtdescrip_acuerdo").val('');
                $("#txtnum_acuerdo").prop('disabled', false);
                $("#txtdescrip_acuerdo").prop('disabled', false);
                $("#check_acuerdo").prop('disabled', false);
                $("#checkbox").prop("checked", false);
            }
            else {
                if (accion == 1 || accion == 2) {
                    $("#lblfolio_acuerdo").html(objAcuerdo.Folio_Acuerdo);
                    $("#txtnum_acuerdo").val(objAcuerdo.Num_Acuerdo);
                    $("#lblnum_acuerdo_romano").html(objAcuerdo.Num_Acuerdo_Romano);
                    $("#lblidacuerdo").text(objAcuerdo.idAcuerdo);
                    $("#lblidcomite2").text(objComite.idComite);
                    $("#lblaccion_acuerdo").text(accion);
                    $("#txtdescrip_acuerdo").val(objAcuerdo.Descripcion);
                    $("#txtnum_acuerdo").prop('disabled', true);
                    $("#txtdescrip_acuerdo").prop('disabled', false);
                    $("#check_acuerdo").prop('disabled', false);
                    if (objAcuerdo.ATerminado=='TERMINADO') {
                        $("#check_acuerdo").prop("checked", true);
                    }
                    else {
                        $("#check_acuerdo").prop("checked", false);
                    }



                        if (accion == 2) {
                            $("#txtdescrip_acuerdo").prop('disabled', true);
                        }

                }
            }
            MostrarModalAcuerdo();
        }

        function CreaFolioAcuerdo(numero_acuerdo) {
            var folio_acuerdo;
            var arr;
            var fecha_comite = $("#bodegadatos").data("fecha_comite");
            if (fecha_comite == '01/01/1900' || fecha_comite == '') {
                folio_acuerdo = '0000000000-000/00'
            } else {
                arr = fecha_comite.split('/');
                var numero_acuerdo_r;
                if (numero_acuerdo.length > 0 && numero_acuerdo.length <= 3) {
                    numero_acuerdo = $("#txtnum_acuerdo").val();
                    numero_acuerdo_r = ("000" + numero_acuerdo).substr(-3, 3);

                } else {
                    numero_acuerdo_r = "000";
                }
                
                folio_acuerdo = arr[0] + arr[1] + arr[2] + '-' + numero_acuerdo_r + '/' + arr[2].substr(2, 2);
            }

            $("#lblnum_acuerdo_romano").text(romanos(numero_acuerdo));            
            $("#lblfolio_acuerdo").text(folio_acuerdo);
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


            function MostrarModalComite() {
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
                $("#dialogo_comite").css('top', winH / 2 - $("#dialogo_comite").height() / 2);
                $("#dialogo_comite").css('left', winW / 2 - $("#dialogo_comite").width() / 2);

                //transition effect
                $("#dialogo_comite").fadeIn(2000);
            };

            function MostrarModalAcuerdo() {
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
                $("#dialogo_acuerdo").css('top', winH / 2 - $("#dialogo_acuerdo").height() / 2);
                $("#dialogo_acuerdo").css('left', winW / 2 - $("#dialogo_acuerdo").width() / 2);

                //transition effect
                $("#dialogo_acuerdo").fadeIn(2000);
            };

            function llenarTipoComite(idtipo_comite) {

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceTipoComite.asmx/GetTipoComite",
                    data: "{'idtipocomite':'" + '0' + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lsttipo_sesion").html('');
                        $(data.d).find("tipo_comite").each(function () {
                            var option = $(document.createElement('option'));
                            var idtipo_comite = $(this).find("idtipo_comite_r").text();
                            var etiqueta_tipo_comite = $(this).find("etiqueta_tipo_comite_r").text();
                            var descrip_tipo_comite = $(this).find("descrip_r").text();
                            var fec_cre_comite = $(this).find("fec_cre_r").text();
                            var fec_mod_comite = $(this).find("fec_mod_r").text();
                            var usucre_tipo_comite = $(this).find("usu_cre_r").text();
                            var usu_tipo_comite = $(this).find("usu_mod_r").text();
                            var estatus_comite = $(this).find("cestatus_r").text();
                            option.html(etiqueta_tipo_comite);
                            option.val(idtipo_comite);
                            $("#lsttipo_sesion").append(option);
                        });


                        if (idtipo_comite > 0) { //
                            $("#lsttipo_sesion").val(idtipo_comite);
                        } 
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText);
                    }
                });
            }


            function llenarFormatoComite(idformato_comite) {

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../../WebServices/WebServiceFormatoComite.asmx/GetFormatoComite",
                    data: "{'idformatocomite':'" + '0' + "'}",
                    success: function (data) {
                        var elementos = 0;
                        $("#lstformato_comite").html('');
                        $(data.d).find("formato_comite").each(function () {
                            var option = $(document.createElement('option'));
                            var idformato_comite = $(this).find("idformato_comite_r").text();
                            var etiqueta_formato_comite = $(this).find("etiqueta_formato_comite_r").text();
                            var descrip_formato_comite = $(this).find("descrip_r").text();
                            var fec_cre_comite = $(this).find("fec_cre_r").text();
                            var fec_mod_comite = $(this).find("fec_mod_r").text();
                            var usucre_comite_comite = $(this).find("usu_cre_r").text();
                            var usu_comite_comite = $(this).find("usu_mod_r").text();
                            var estatus_comite = $(this).find("cestatus_r").text();
                            option.html(etiqueta_formato_comite);
                            option.val(idformato_comite);
                            $("#lstformato_comite").append(option);
                        });


                        if (idformato_comite > 0) { //
                            $("#lstformato_comite").val(idformato_comite);
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
    
    <label>No. Sesión:</label><input type="text" name="num_sesion" id="txtnum_sesion_q" style="width:250px" maxlength ="6" onkeyup = "this.value=formatea_num_sesion(this.value);"/><br/><br/> 
    <label>Fecha_Comite:</label><input type="text" name="fec_comite" id="txtfec_comite_q" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_comite"><== Buscar COMITE TECNICO ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_comite"><== Alta COMITE TECNICO ==></a><br/><br/>        
         
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



