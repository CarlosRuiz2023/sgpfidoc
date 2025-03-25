<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_obra.aspx.vb" Inherits="Admin_procesos_consultar_obra" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">

    function GestionCooperadores(oid, obr_clv_int, obr_clv,obr_estatus, idprog, idusu, fid, num_pagos, fec_venc, coopid) {
        //alert(img);
        var url1 = "../Procesos/gCoops.html?ResponseType=Edit&oid=" + oid + "&obr_clv_int=" + obr_clv_int + "&obr_clv=" + obr_clv + "&obr_estatus=" + obr_estatus + "&programa=" + idprog + "&idusu=" + idusu + "&fid=" + fid + "&num_pagos=" + num_pagos + "&fec_venc=" + fec_venc + "&coopid=" + coopid;
        newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
        if (newWindow.focus()) {
            newWindow.focus()
        }
    }

    function ConsultaSalidaObra(obr_clv_int,idusu) {
        //alert(img);
        var url1 = "../Procesos/salida_obra.html?ResponseType=Edit&obr_clv_int=" + obr_clv_int + "&idusu=" + idusu;
        newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1900,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
        if (newWindow.focus()) {
            newWindow.focus()
        }
    }


    function ConsultaSalidaPredio(idusu, oid,pid) {
        //alert(img);
        var url1 = "../Procesos/salida_predio.html?ResponseType=Edit&idusu=" + idusu + "&oid=" + oid  + "&pid=" + pid;
        newWindow = window.open(url1, "_blank", "top=150,left=150,menubar=no,toolbar=no,location=no, resizable=no,height=846,width=1674,status=no,scrollbars=yes,minimizable=no,maxmizable=no,titlebar=no,modal=yes");
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

    

    //Fecha de vencimiento de pagos
    function FechaVencPagos(obr_npago) {
        var obr_fecvenp = '';
        var fecvenc2 = new Date();
        var fecvenc = new Date();

        var fecvenc = ConvertirCadenaToFecha($("#txtfecinipag").val());
        if (fecvenc > ConvertirCadenaToFecha('01/01/1900')) {
            fecvenc.setMonth(fecvenc.getMonth() + (parseInt(obr_npago)-1));
            fecvenc2 = new Date(fecvenc.getFullYear(), fecvenc.getMonth() + 1, 0);
            obr_fecvenp = CompletaCerosIzq(fecvenc2.getDate(), 2) + "/" + CompletaCerosIzq(fecvenc2.getMonth()+1, 2) + "/" + CompletaCerosIzq(fecvenc2.getFullYear());  //Fecha de vencimiento de pagos            
        }
        else {
            obr_fecvenp = '01/01/1900';  //Fecha de vencimiento de pagos
        }
        $("#lblfecvenc").html(obr_fecvenp);
        $("#lblfecvenc").css("background", "white");
    }

    function FormatoMoneda(parametro) {
        if (!isNaN(parametro)) {
            resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
        } else {
            resultado = 0;
        }
        return resultado
    }


    function formateacantidad(cantidad) {
        cantidad = cantidad.replace(/\\d+(.\\d+)?/g, '');
        return (cantidad);
    }

    function formateaMesCorresp(parametro) {
        resultado = parametro;
        if (!IsNumeric(parametro)) {
            resultado = 0;
        } 
        return resultado
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

    

    function FechaHora() {
        var hora = new Date()
        var hrs = hora.getHours();
        var min = hora.getMinutes();
        if (min < 10) min = "0" + min;
        var hoy = new Date();
        var m = new Array();
        var d = new Array()
        var an = hoy.getYear();
        d[1] = "lunes";
        d[2] = "martes";
        d[3] = "miercoles";
        d[4] = "jueves";
        d[5] = "viernes";
        d[6] = "sábado";
        d[0] = "domingo";
        m[0] = "enero"; m[1] = "febrero"; m[2] = "marzo";
        m[3] = "abril"; m[4] = "mayo"; m[5] = "junio";
        m[6] = "julio"; m[7] = "agosto"; m[8] = "septiembre";
        m[9] = "octubre"; m[10] = "noviembre"; m[11] = "diciembre";
        var lugarfechahora = d[hoy.getDay()] + " " + hoy.getDate() + " de " + m[hoy.getMonth()] + "  " + hoy.getFullYear() + "," + hrs + ":" + min + ' hrs';

        return lugarfechahora;
    }


    function NombreMes(num_mes) {
        
        var m = new Array();       
        
        m[0] = "Enero"; m[1] = "Febrero"; m[2] = "Marzo";
        m[3] = "Abril"; m[4] = "Mayo"; m[5] = "Junio";
        m[6] = "Julio"; m[7] = "Agosto"; m[8] = "Septiembre";
        m[9] = "Octubre"; m[10] = "Noviembre"; m[11] = "Diciembre";
        var nom_mes = m[num_mes];
        return nom_mes;
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

    function CompletaCerosIzq(valor, longitud) {
        var cadena = valor.toString();
        var j = cadena.length;
        if (j < longitud) {
            for (var i = 1; i < longitud; i++) {
                cadena = '0' + cadena;
            }
        }
        return cadena;
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
        var nomcalle = $.trim($('#txtnomcalle').val());
        if (nomcalle.length <= 0 || nomcalle.length > 20) {
            nomcalle = '';
        }

        var num_obra = $.trim($('#txtnumobra').val());
        if (num_obra.length <= 0 || !$.isNumeric(num_obra)) {
            num_obra = '';
        }

        var num_obra_sgp = $.trim($('#txtclvsgp').val());
        if (num_obra_sgp.length <= 0 || !$.isNumeric(num_obra_sgp)) {
            num_obra_sgp = '';
        }
        
        var filtro = num_obra + "," + nomcalle + ",," + num_obra_sgp + ",";
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



    function GeneraFormato(pdf) {
        
        //***** ENCABEZADO ****///

        var img = new Image();
        img.src = '../imagenes/admon2021_2024.png';
        pdf.addImage(img, 'PNG', 10, 10, 60, 22);
        pdf.setFontSize(12);
        pdf.text(80, 20, "REPORTE DE APORTACIONES DE COOPERADORES");
        pdf.setFontSize(7);
        pdf.text(110, 26, 'León, Guanajuato al día: ' + FechaHora());
        pdf.setFontType('bold')
        pdf.setFontSize(8);



        //**** PIE *****///
        pdf.setFontSize(6);
        var columna_pie = 10;
        var row_ini_pie = 255;
        var reng_adic = 3;

        pdf.line(10, row_ini_pie, 204, row_ini_pie);
        pdf.text(columna_pie, row_ini_pie + reng_adic * 1, 'Blvd. Juan José Torres Landa 1701');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 2, 'Oriente Edificio B de Obras Públicas');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 3, 'Col. El Tlacuache');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 4, 'C.P. 37480');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 5, 'León Gto.');

        pdf.text(107 - pdf.getTextWidth('Horarios de atención: Lunes a Viernes, 8:00 hrs - 15:30 hrs') / 2, row_ini_pie + reng_adic * 1, 'Horarios de atención: Lunes a Viernes, 8:00 hrs - 15:30 hrs');
        pdf.text(107 - pdf.getTextWidth('Tel. Oficina: 477-470-86-15 al 18') / 2, row_ini_pie + reng_adic * 2, 'Tel. Oficina: 477-470-86-15 al 18');
        pdf.text(107 - pdf.getTextWidth('fidoc.leon.gob.mx') / 2, row_ini_pie + reng_adic * 3, 'fidoc.leon.gob.mx');


        var img_facebook = new Image();
        img_facebook.src = "../imagenes/face.png";
        pdf.addImage(img_facebook, 'png', 181, row_ini_pie + reng_adic * 0.4, 3.5, 2.5);

        var img_twitter = new Image();
        img_twitter.src = "../imagenes/twitter.png";
        pdf.addImage(img_twitter, 'png', 189, row_ini_pie + reng_adic * 1.4, 2.5, 2.5);

        var img_whatsapp = new Image();
        img_whatsapp.src = "../imagenes/whatsapp.jpg";
        pdf.addImage(img_whatsapp, 'jpg', 187, row_ini_pie + reng_adic * 2.4, 2.5, 2.5);


        pdf.text(204 - pdf.getTextWidth('facebook/fidocleon'), row_ini_pie + reng_adic, 'facebook/fidocleon');
        pdf.text(204 - pdf.getTextWidth('@fidocleon'), row_ini_pie + reng_adic * 2, '@fidocleon');
        pdf.text(204 - pdf.getTextWidth('477-325-2586'), row_ini_pie + reng_adic * 3, '477-325-2586');

    }

    function GeneraFormatoFichaPagoMes(objFormato,pdf) {

        //***** ENCABEZADO ****///

        var img = new Image();
        img.src = '../imagenes/admon2021_2024.png';
        pdf.addImage(img, 'PNG', 10, 10, 60, 22);
        pdf.setFontSize(15);
        pdf.setFontType('bold')
        pdf.text(90, 20, "FICHA DE PAGO");
        pdf.setFontSize(7);
        pdf.setFontType('normal')
        pdf.text(120, 26, 'Fecha de Impresión:' + FechaHora());
        pdf.setFontSize(5);
        pdf.text(163, 29, objFormato.fid + ':' + objFormato.pid + ':' + objFormato.obr_clv_int + ':' + objFormato.oid + ':' + objFormato.idusu);
        pdf.setFontType('bold')
        pdf.setFontSize(8);



        //**** PIE *****///
        pdf.setFontSize(6);
        var columna_pie = 10;
        var row_ini_pie = 163;
        var reng_adic = 3;

        pdf.setFontSize(10);
        pdf.setFontType('normal')
        var texto = '  Favor de presentar esta ficha en cualquier Caja de Tesorería Municipal y realizar la aportación que corresponde, preferentemente los 10 primeros días hábiles del mes. '

        pdf.text(texto, 10, row_ini_pie + reng_adic * 0.08, { maxWidth: 190, align: "justify" });

        pdf.setFontSize(8);
        pdf.text(104 - pdf.getTextWidth('A T E N T A M E N T E') / 2, row_ini_pie + reng_adic * 4, 'A T E N T A M E N T E');
        pdf.text(104 - pdf.getTextWidth('AREA DE PROMOCION') / 2, row_ini_pie + reng_adic * 5, 'AREA DE PROMOCION');
        pdf.text(104 - pdf.getTextWidth('FIDEICOMISO DE OBRAS POR COOPERACION') / 2, row_ini_pie + reng_adic * 6, 'FIDEICOMISO DE OBRAS POR COOPERACION');


        pdf.setFontSize(6);
        pdf.setFontType('normal')

        pdf.line(10, row_ini_pie + reng_adic * 7.5, 204, row_ini_pie + reng_adic * 7.5);
        pdf.line(10, row_ini_pie + reng_adic * 7.3, 204, row_ini_pie + reng_adic * 7.3);
        
        pdf.text(columna_pie, row_ini_pie + reng_adic * 8.5, 'Blvd. Juan José Torres Landa 1701');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 9.5, 'Oriente Edificio B de Obras Públicas');
        pdf.text(columna_pie, row_ini_pie + reng_adic * 10.5, 'Col. El Tlacuache');
        pdf.text(columna_pie + 20, row_ini_pie + reng_adic * 10.5, 'C.P. 37480');
        pdf.text(columna_pie + 36, row_ini_pie + reng_adic * 10.5, 'León Gto.');

        pdf.text(107 - pdf.getTextWidth('Horarios de atención: Lunes a Viernes, 8:00 hrs - 15:30 hrs') / 2, row_ini_pie + reng_adic * 8.5, 'Horarios de atención: Lunes a Viernes, 8:00 hrs - 15:30 hrs');
        pdf.text(107 - pdf.getTextWidth('Tel. Oficina: 477-470-86-15 al 18') / 2, row_ini_pie + reng_adic * 9.5, 'Tel. Oficina: 477-470-86-15 al 18');
        pdf.text(107 - pdf.getTextWidth('fidoc.leon.gob.mx') / 2, row_ini_pie + reng_adic * 10.5, 'fidoc.leon.gob.mx');



        var img_facebook = new Image();
        img_facebook.src = "../imagenes/face.png";
        pdf.addImage(img_facebook, 'png', 181, row_ini_pie + reng_adic * 7.8, 3.5, 2.5);

        var img_twitter = new Image();
        img_twitter.src = "../imagenes/twitter.png";
        pdf.addImage(img_twitter, 'png', 189, row_ini_pie + reng_adic * 8.8, 2.5, 2.5);

        var img_whatsapp = new Image();
        img_whatsapp.src = "../imagenes/whatsapp.jpg";
        pdf.addImage(img_whatsapp, 'jpg', 187, row_ini_pie + reng_adic * 10, 2.5, 2.5);


        pdf.text(204 - pdf.getTextWidth('facebook/fidocleon'), row_ini_pie + reng_adic * 8.5 , 'facebook/fidocleon');
        pdf.text(204 - pdf.getTextWidth('@fidocleon'), row_ini_pie + reng_adic * 9.5, '@fidocleon');
        pdf.text(204 - pdf.getTextWidth('477-325-2586'), row_ini_pie + reng_adic * 10.5, '477-325-2586');

        pdf.line(10, row_ini_pie + reng_adic * 12.2, 204, row_ini_pie + reng_adic * 12.2);
        pdf.line(10, row_ini_pie + reng_adic * 12.4, 204, row_ini_pie + reng_adic * 12.4);
        pdf.line(10, row_ini_pie + reng_adic * 12.6, 204, row_ini_pie + reng_adic * 12.6);


        
        pdf.addImage(img, 'PNG', 10, row_ini_pie + reng_adic * 13, 60, 22);
        pdf.setFontSize(15);
        pdf.setFontType('bold')
        pdf.text(120 - pdf.getTextWidth('TALON DE FICHA DE PAGO') / 2, row_ini_pie + reng_adic * 15, 'TALON DE FICHA DE PAGO');
        pdf.setFontSize(7);
        pdf.setFontType('normal')
        pdf.text(120 - pdf.getTextWidth('Fecha de Impresión:') / 2, row_ini_pie + reng_adic * 17, 'Fecha de Impresión:' + FechaHora());
        pdf.setFontSize(5);
        pdf.text(130, row_ini_pie + reng_adic *18, objFormato.fid + ':' + objFormato.pid + ':' + objFormato.obr_clv_int + ':' + objFormato.oid + ':' + objFormato.idusu);
      

    }


    function GeneraEncabezado(reg,pdf) {
        var oid = reg[0];
        var obr_clv_int = reg[1];
        var obr_clv = reg[3];
        var calle = reg[5];
        var colonia = reg[6];
        var tramo = reg[7];
        var obr_fecinip = reg[9];
        var obr_fecivenp = reg[10];
        var descrip_tipo_obr = reg[12];
        var estatus_obra = reg[13];
        var nomprog = reg[14];
        var progdescrip = reg[15];
        var fecinip = reg[9];
        var fecvenp = reg[10];
        var costo_obra = reg[33];
        var abono = reg[34];
        var avance_obra=reg[35];
        var columna_ref = 74;
        var reng_ref = 36;
        var reng_inc = 4;


        pdf.text(columna_ref - pdf.getTextWidth('oid:'), reng_ref + reng_inc * 1, 'oid:');
        pdf.text(columna_ref - pdf.getTextWidth('obra:'), reng_ref + reng_inc * 2, 'obra:');
        pdf.text(columna_ref - pdf.getTextWidth('Obra_SIFIDOC:'), reng_ref + reng_inc * 3, 'Obra_SIFIDOC:');

        pdf.setFontType('normal')
        
        
        pdf.text(90 - pdf.getTextWidth(oid), reng_ref + reng_inc * 1, oid);
        pdf.text(90 - pdf.getTextWidth(obr_clv_int), reng_ref + reng_inc * 2, obr_clv_int);
        pdf.text(90 - pdf.getTextWidth(obr_clv), reng_ref + reng_inc * 3, obr_clv);
        /*pdf.line(columna_ref, reng_ref + reng_inc + 10, 185, reng_ref + reng_inc + 10);*/

        pdf.setFontSize(10);
        pdf.setFontType('bold')

        pdf.text(columna_ref - pdf.getTextWidth('CALLE:'), reng_ref + reng_inc * 5, 'CALLE:');
        pdf.text(columna_ref - pdf.getTextWidth('COLONIA:'), reng_ref + reng_inc * 6, 'COLONIA:');
        pdf.text(columna_ref - pdf.getTextWidth('TRAMO:'), reng_ref + reng_inc * 7, 'TRAMO:');
        pdf.text(columna_ref - pdf.getTextWidth('Tipo de Obra:'), reng_ref + reng_inc * 8, 'Tipo de Obra:');
        pdf.text(columna_ref - pdf.getTextWidth('Programa:'), reng_ref + reng_inc * 9, 'Programa:');
        pdf.text(columna_ref - pdf.getTextWidth('Periodo de Recaudación:'), reng_ref + reng_inc * 10, 'Periodo de Recaudación:');


        pdf.setFontType('normal')
        columna_ref = 130;

        pdf.setFontSize(10);
        pdf.text(columna_ref - pdf.getTextWidth(calle) / 2, reng_ref + reng_inc * 5, calle);
        pdf.text(columna_ref - pdf.getTextWidth(colonia) / 2, reng_ref + reng_inc * 6, colonia);
        pdf.text(columna_ref - pdf.getTextWidth(tramo) / 2, reng_ref + reng_inc * 7, tramo);
        pdf.text(columna_ref - pdf.getTextWidth(descrip_tipo_obr) / 2, reng_ref + reng_inc * 8, descrip_tipo_obr);

        pdf.setFontSize(8);
        pdf.text(columna_ref - pdf.getTextWidth(nomprog + '  (' + progdescrip + ')') / 2, reng_ref + reng_inc * 9, nomprog + '  (' + progdescrip + ')');

        pdf.setFontSize(10);
        pdf.text(columna_ref - pdf.getTextWidth(fecinip + '-' + fecvenp) / 2, reng_ref + reng_inc * 10, fecinip + '-' + fecvenp);

        pdf.line(10, reng_ref + reng_inc * 11, 204, reng_ref + reng_inc * 11);
        pdf.line(10, reng_ref + reng_inc * 12, 204, reng_ref + reng_inc * 12);
        pdf.setFontSize(6);
        pdf.setFontType('bold');


        var tamano_col = 14;
        var col_ref1 = 10;
        var reng_ref1 = 83;
        pdf.text(col_ref1 + tamano_col * .5 - pdf.getTextWidth('fid:coopid') / 2, reng_ref1, 'fid:coopid');
        pdf.text(col_ref1 + tamano_col * 2.5 - pdf.getTextWidth('Nombre Cooperador') / 2, reng_ref1, 'Nombre Cooperador');        
        pdf.text(col_ref1 + tamano_col * 4.5 - pdf.getTextWidth('No. Ofic.') / 2, reng_ref1, 'No. Ofic.');
        pdf.text(col_ref1 + tamano_col * 5.5 - pdf.getTextWidth('Mts.') / 2, reng_ref1, 'Mts.');
        pdf.text(col_ref1 + tamano_col * 7 - pdf.getTextWidth('COSTO') / 2, reng_ref1, 'COSTO');
        pdf.text(col_ref1 + tamano_col * 9 - pdf.getTextWidth('CARGOS') / 2, reng_ref1, 'CARGOS');
        pdf.text(col_ref1 + tamano_col * 11 - pdf.getTextWidth('ABONOS') / 2, reng_ref1, 'ABONOS');
        pdf.text(col_ref1 + tamano_col * 13 - pdf.getTextWidth('SALDO') / 2, reng_ref1, 'SALDO');

        return avance_obra;
    }

    function GeneraNumPaginas(pagina,total_paginas,pdf) {
        pdf.setFontSize(8);
        pdf.setFontType('bold');
        pdf.text(204 - pdf.getTextWidth('Página: ' + pagina.toString() + ' de ' + total_paginas.toString()),252, 'Página: ' + pagina.toString() + ' de ' + total_paginas.toString());
    }


    function GeneraPie(total_total_costo, total_total_cargos, total_total_abonos, total_total_saldo,ultimo_reg_coop,avance_obra,num_regs, pdf) {
        var tamano_col = 14;

        pdf.setFontSize(8);
        pdf.setFontType('bold');
        /*Este valor viene desde la vista vw_obra_2, es el valor de avance de pagos por cooperador*/
        var avance_obrax_coop = avance_obra;

        /*Este valor se debe calcular porque se requiere a nivel obra*/
        var avance_obra_dos_decimas = parseFloat(total_total_abonos) * 100 / parseFloat(total_total_costo);
        avance_obra_dos_decimas = avance_obra_dos_decimas.toFixed(2);
        
        pdf.line(10, ultimo_reg_coop + 8, 204, ultimo_reg_coop + 8);
        pdf.text(10 + tamano_col * 5.5 - pdf.getTextWidth('TOTALES:'), ultimo_reg_coop + 12,'TOTALES:');
        pdf.text(10 + tamano_col * 8 - pdf.getTextWidth(FormatoMoneda(total_total_costo.toString())), ultimo_reg_coop + 12, FormatoMoneda(total_total_costo.toString()));
        pdf.text(10 + tamano_col * 10 - pdf.getTextWidth(FormatoMoneda(total_total_cargos.toString())), ultimo_reg_coop + 12, FormatoMoneda(total_total_cargos.toString()));
        pdf.text(10 + tamano_col * 12 - pdf.getTextWidth(FormatoMoneda(total_total_abonos.toString())), ultimo_reg_coop + 12, FormatoMoneda(total_total_abonos.toString()));
        pdf.text(10 + tamano_col * 13.6 - pdf.getTextWidth(FormatoMoneda(total_total_saldo.toString())), ultimo_reg_coop + 12, FormatoMoneda(total_total_saldo.toString()));

        pdf.line(10, ultimo_reg_coop + 14, 204, ultimo_reg_coop + 14);



        pdf.text(10 + tamano_col * 5.5 - pdf.getTextWidth('AVANCE PAGO DE OBRA:'), ultimo_reg_coop + 18.8, 'AVANCE PAGO DE OBRA:');
        pdf.text(10 + tamano_col * 8 - pdf.getTextWidth(avance_obra_dos_decimas + ' %'), ultimo_reg_coop + 18.8, avance_obra_dos_decimas + ' %');
        pdf.text(10 + tamano_col * 5.5 - pdf.getTextWidth('NUM. DE COOPS (FRENTES):'), ultimo_reg_coop + 22.8, 'NUM. DE COOPS (FRENTES):');
        pdf.text(10 + tamano_col * 8 - pdf.getTextWidth(num_regs.toString()), ultimo_reg_coop + 22.8, num_regs.toString());
        pdf.line(10, ultimo_reg_coop + 24.8, 204, ultimo_reg_coop + 24.8);
        
    }

    function GenerarReporteObra(obr_clv_int) {

        
        var filtro2 = ',,,,,,,,' + obr_clv_int + ',,';

        $.ajax({
            url: "../../WebServices/WebServiceFrente.asmx/GetFrentexO", //PageMethod
                data: "{'pPageSize':'10000"  +
                      "','pCurrentPage':'1" +
                      "','pSortColumn':'fid" +
                      "','pSortOrder':'asc" +  
                      "','pFiltro':'" + filtro2 + "'}", //PageMethod Parametros de entrada                                   
                dataType: "json",
                type: "post",
                contentType: "application/json; charset=utf-8",
                complete: function (jsondata, stat) {
                                       
                            var objeto = JSON.parse(jsondata.responseText).d;
                            var num_pag = 0;
                            var reg;
                            var reg2;
                            var num_regs = objeto.RecordCount;
                            

                            if (num_regs > 0) {
                                num_pag = 1;                                            
                                var pdf = new jsPDF('p', 'mm', 'letter');
                                reg = objeto.Items[0].row;
                                var col_ref1 = 10;
                                var reng_ref1 = 87.5;
                                var inc_reng = 3;
                                var tamano_col = 14;


                                var total_total_costo = 0;
                                var total_total_cargos = 0;
                                var total_total_abonos = 0;
                                var total_total_saldo = 0;

                                var regxpag = 45;
                                var residuo = num_regs % regxpag;                        
                                var fraccion = 0;
                                if (residuo > 0) {
                                    fraccion = 1;
                                }
                        
                                var total_paginas = Math.floor(num_regs / regxpag) + fraccion;
                                var pagina = 1;
                                var registros_impresos = 0;
                                var ultimo_reg_coop = 0;


                                GeneraFormato(pdf);  //* Aplica formato a la página*//
                                var avance_obra = GeneraEncabezado(reg, pdf); /*Aplica Encabezado de página*/
                                GeneraNumPaginas(pagina, total_paginas, pdf);
                        
                        
                                pdf.setFontSize(7);
                                pdf.setFontType('normal');

                                for (i = 0; i < num_regs ; i++) {
                                    reg2 = objeto.Items[i].row;                            

                                    if (registros_impresos >= regxpag) {
                                
                                        pdf.addPage();
                                        pagina = pagina + 1;
                                        GeneraFormato(pdf);
                                        GeneraEncabezado(reg2, pdf);
                                        GeneraNumPaginas(pagina, total_paginas, pdf);
                                        registros_impresos = 0;
                                    }

                                    pdf.setFontSize(6);
                                    pdf.setFontType('normal')
                                    /*fid:coopid*/pdf.text(col_ref1 + tamano_col * .5 - pdf.getTextWidth(reg2[16] + ':' + reg[4]) / 2, reng_ref1 + (registros_impresos * inc_reng), reg2[16] + ':' + reg2[4]);
                                    if (pdf.getTextWidth(reg2[20])>42) {
                                        pdf.setFontSize(3.5);
                                    } else {
                                        pdf.setFontSize(6);
                                    }

                                    /*mnomficha*/pdf.text(col_ref1 + tamano_col * 2.5 - pdf.getTextWidth(reg2[20]) / 2, reng_ref1 + (registros_impresos * inc_reng), reg2[20]);
                                    pdf.setFontSize(6);
                                    /*nooficial*/pdf.text(col_ref1 + tamano_col * 4.5 - pdf.getTextWidth(reg2[17]) / 2, reng_ref1 + (registros_impresos * inc_reng), reg2[17]);
                                    /*mts_frente*/pdf.text(col_ref1 + tamano_col * 5.5 - pdf.getTextWidth(reg2[21]) / 2, reng_ref1 + (registros_impresos * inc_reng), reg2[21]);
                                    /*capital*/pdf.text(col_ref1 + tamano_col * 8 - pdf.getTextWidth(FormatoMoneda(reg2[24])), reng_ref1 + (registros_impresos * inc_reng), FormatoMoneda(reg2[24]));
                                    var abonos_float = parseFloat(reg2[25]) + parseFloat(reg2[26]) + parseFloat(reg2[27]);
                                    var abonos_txt = FormatoMoneda(parseFloat(reg2[25]) + parseFloat(reg2[26]) + parseFloat(reg2[27]));
                                    /*recargos_netos*/pdf.text(col_ref1 + tamano_col * 10 - pdf.getTextWidth(FormatoMoneda(reg2[28])), reng_ref1 + (registros_impresos * inc_reng), FormatoMoneda(reg2[28]));
                                    /*capital_pagado + cargos_pagados + desctos_aplicados*/pdf.text(col_ref1 + tamano_col * 12 - pdf.getTextWidth(abonos_txt), reng_ref1 + (registros_impresos * inc_reng), abonos_txt);
                                    /*total_pagar*/pdf.text(col_ref1 + tamano_col * 13.6 - pdf.getTextWidth(FormatoMoneda(reg2[29])), reng_ref1 + (registros_impresos * inc_reng), FormatoMoneda(reg2[29]));


                            total_total_costo = total_total_costo + parseFloat(reg2[24]);
                            total_total_cargos = total_total_cargos + parseFloat(reg2[28]);
                            total_total_abonos = total_total_abonos + parseFloat(abonos_float);
                            total_total_saldo = total_total_saldo + parseFloat(reg2[29]);
                            ultimo_reg_coop = reng_ref1 + (registros_impresos * inc_reng);
                            
                            registros_impresos++;
                        }

                        GeneraPie(total_total_costo, total_total_cargos, total_total_abonos, total_total_saldo,ultimo_reg_coop,avance_obra,num_regs, pdf);
                        
                        var hoy = moment().format("DDMMYYYY");
                        var reporte_obra = 'rep_obr_' + hoy + '.pdf';
                        pdf.save(reporte_obra.toString());
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
              });
    }



    



    function Buscar_obra() {



        var filtro = ObtenerFiltro();
        var filtro2;

        var estatus_obra_seleccionado;


        var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
        var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
        var idusu = arrusuario[2];

        if ($("#grid")[0].grid) {
            $.jgrid.gridUnload("#grid");
            //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
        }

        $("#grid").jqGrid(
         {
             datatype: function () {
                 $.ajax(
                   {
                       url: "../../WebServices/WebServiceObras.asmx/GetObra_psql", //PageMethod
                       data: "{'pPageSize':'" + $('#grid').getGridParam("rowNum") +
                       "','pCurrentPage':'" + $('#grid').getGridParam("page") +
                       "','pSortColumn':'" + $('#grid').getGridParam("sortname") +
                       "','pSortOrder':'" + $('#grid').getGridParam("sortorder") +
                       "','pFiltro':'" + filtro + "'}", //PageMethod Parametros de entrada
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
                 id: "b.obr_clv_int"
             },
             colModel: [
              {
                  index: 'obr_clv_int', width: 120, align: 'center',
                  name: 'ClvObra'
              },
              {
                  index: 'obr_clv2', width: 220, align: 'center',
                  name: 'Obra'
              },
              {
                  index: 'calle', width: 300, align: 'center',
                  name: 'Calle'
              },
              {
                  index: 'colonia', width: 300, align: 'center',
                  name: 'Colonia'
              },
              {
                  index: 'tramo', width: 500, align: 'Center',
                  name: 'Tramo'
              },
              {
                  index: 'nomprog', width: 100, align: 'center',
                  name: 'Prog'
              },
              {
                  index: 'descrip_tipo_obr', width: 200, align: 'center',
                  name: 'TipoObra'
              },
              {
                  index: 'cestatus', width: 300, align: 'center',
                  name: 'EstObra'
              },
              {
                  index: 'obr_fec_pub1', width: 160, align: 'center',
                  name: 'FecPub1'
              },
              {
                  index: 'evid_pub1', width: 200, align: 'center',
                  name: 'EvidPub1', hidden: true
              },
              {
                  index: 'evid_pub1', width: 200, align: 'center',
                  name: 'EvidPub1_vinc', formatter: function (cellvalue) {
                      var archivo = cellvalue;
                      var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                      return url;
                  }
              },
              {
                  index: 'obr_fec_pub2', width: 160, align: 'center',
                  name: 'FecPub2'
              },
              {
                  index: 'evid_pub2', width: 200, align: 'center',
                  name: 'EvidPub2', hidden: true
              },
              {
                  index: 'evid_pub2', width: 200, align: 'center',
                  name: 'EvidPub2_vinc', formatter: function (cellvalue) {
                      var archivo = cellvalue;
                      var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                      return url;
                  }
              },
              {
                  index: 'obr_fecinip', width: 160, align: 'center',
                  name: 'FecIniPag'
              },
              {
                  index: 'obr_fecvenp', width: 160, align: 'center',
                  name: 'FecVenP'
              },
              {
                  index: 'obr_npago', width: 80, align: 'center',
                  name: 'NumPagos'
              },
              {
                  index: 'obr_fec_ini_proc', width: 160, align: 'center',
                  name: 'FecIniProc'
              },
              {
                  index: 'obr_idtipo_recurso', width: 60, align: 'center',
                  name: 'IdTipoRecurso', hidden: true
              },
              {
                  index: 'obr_descrip_tipo_recurso', width: 200, align: 'center',
                  name: 'DescripTipoRec'
              },
              {
                  index: 'evid_obra_proc', width: 200, align: 'center',
                  name: 'EvidObrProc', hidden: true
              },
              {
                  index: 'evid_obra_proc', width: 200, align: 'center',
                  name: 'EvidObrProc_vinc', formatter: function (cellvalue) {
                      var archivo = cellvalue;
                      var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                      return url;
                  }, hidden: true
              },
              {
                  index: 'obr_fec_ini_cob', width: 160, align: 'center',
                  name: 'FecIniCob'
              },
              {
                  index: 'evid_termino_obra', width: 200, align: 'center',
                  name: 'EvidTermObr', hidden: true
              },
               {
                   index: 'evid_termino_obra', width: 200, align: 'center',
                   name: 'EvidTermObr_vinc', formatter: function (cellvalue) {
                       var archivo = cellvalue;
                       var url = '<a target="_blank" toolbar=0 href="../../temp/' + archivo + '">' + archivo + '</a>';
                       return url;
                   }
               },
              {
                  index: 'obr_fec_canc', width: 160, align: 'center',
                  name: 'ObrFecCanc'
              },
              {
                  index: 'no_contrato', width: 300, align: 'center',
                  name: 'NumContrato'
              },
              {
                  index: 'gastos_admvos', width: 300, align: 'center',
                  name: 'GastosAdmvos', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }
              },
              {
                  index: 'oid', width: 80, align: 'Center',
                  name: 'oid'
              },
              {
                  index: 'geom', width: 300, align: 'Center',
                  name: 'Geom', hidden: true
              },
              {
                  index: 'idsol', width: 100, align: 'Center',
                  name: 'IdSol', hidden: true
              },
              {
                  index: 'sector', width: 100, align: 'Center',
                  name: 'Sector', hidden: true
              },
              {
                  index: 'subsector', width: 200, align: 'center',
                  name: 'SubSector', hidden: true
              },
              {
                  index: 'cvecalle', width: 300, align: 'center',
                  name: 'CveCalle', hidden: true
              },
              {
                  index: 'idpoligono', width: 350, align: 'center',
                  name: 'idpoligono', hidden: true
              },
              {
                  index: 'id_implan', width: 220, align: 'center',
                  name: 'Id_Implan', hidden: true
              },
              {
                  index: 'usrmod', width: 135, align: 'center',
                  name: 'usrmod', hidden: true
              },
              {
                  index: 'fec_mod', width: 220, align: 'center',
                  name: 'fec_mod', hidden: true
              },
              {
                  index: 'col_clv2', width: 220, align: 'center',
                  name: 'col_clv2', hidden: true
              },
              {
                  index: 'limite1', width: 220, align: 'center',
                  name: 'limite1', hidden: true
              },
              {
                  index: 'limite2', width: 220, align: 'center',
                  name: 'limite2', hidden: true
              },
              {
                  index: 'obr_estatus', width: 100, align: 'center',
                  name: 'obr_estatus', hidden: true
              },
              {
                  index: 'progmun', width: 220, align: 'center',
                  name: 'progmun', hidden: true
              },
              {
                  index: 'progcoop', width: 220, align: 'center',
                  name: 'progcoop', hidden: true
              },
              {
                  index: 'obr_clv', width: 220, align: 'center',
                  name: 'obr_clv', hidden: true
              },
              {
                  index: 'obr_mts', width: 220, align: 'center',
                  name: 'obr_mts', hidden: true
              },
              {
                  index: 'obr_cost', width: 220, align: 'center',
                  name: 'obr_cost', hidden: true
              },
              {
                  index: 'obr_int', width: 220, align: 'center',
                  name: 'obr_int', hidden: true
              },
              {
                  index: 'obr_fecha', width: 220, align: 'center',
                  name: 'obr_fecha', hidden: true
              },
              {
                  index: 'obr_cost_total', width: 220, align: 'center',
                  name: 'obr_cost_total', hidden: true
              },
              {
                  index: 'obr_inc', width: 220, align: 'center',
                  name: 'obr_inc', hidden: true
              },
              {
                  index: 'obr_opergob', width: 220, align: 'center',
                  name: 'obr_opergob', hidden: true
              },
              {
                  index: 'obr_prog2', width: 150, align: 'center',
                  name: 'obr_prog2', hidden: true
              },
              {
                  index: 'obr_sis', width: 150, align: 'center',
                  name: 'obr_sis', hidden: true
              },
              {
                  index: 'col_nom', width: 220, align: 'center',
                  name: 'col_nom', hidden: true
              },
              {
                  index: 'obr_nat', width: 220, align: 'center',
                  name: 'obr_nat', hidden: true
              }
             ],
             pager: "#pager", //Pager.                 
             loadtext: 'Cargando datos...',
             recordtext: "{0} - {1} de {2} elementos",
             emptyrecords: 'No hay resultados',
             pgtext: 'Pág:{0} de {1}', //Paging input control text format.
             rowNum: "20", // PageSize.
             rowList: [5, 10, 20], //Variable PageSize DropDownList. 
             viewrecords: true, //Show the RecordCount in the pager.
             multiselect: false,
             sortname: "b.obr_clv_int", //login SortColumn
             sortorder: "asc", //login SortOrder.
             width: "1900",
             height: "800",
             caption: "OBRAS",
             subGrid: true,
             subGridBeforeExpand: function (subgrid_id, row_id) {
                 var myGrid = $('#grid');
                 obra = myGrid.jqGrid('getRowData', row_id);
                 filtro2 = ',,,,,,,,' + obra.ClvObra + ',,';                
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
                                     url: "../../WebServices/WebServiceFrente.asmx/GetFrentexO", //PageMethod
                                     data: "{'pPageSize':'" + $("#" + subgrid_table_id).getGridParam("rowNum") +
                                           "','pCurrentPage':'" + $("#" + subgrid_table_id).getGridParam("page") +
                                           "','pSortColumn':'" + $("#" + subgrid_table_id).getGridParam("sortname") +
                                           "','pSortOrder':'" + $("#" + subgrid_table_id).getGridParam("sortorder") +
                                           "','pFiltro':'" + filtro2 + "'}", //PageMethod Parametros de entrada                                   
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
                                id: "fid"
                            },
                           colModel: [
                                 {
                                     index: 'oid', width: 80, align: 'Center', name: 'oid', hidden: true
                                 },
                                 {
                                     index: 'obr_clv_int', width: 100, align: 'Center', name: 'obr_clv_int', hidden: true
                                 },
                                 {
                                     index: 'pid', width: 50, align: 'Center', name: 'pid'
                                 },
                                 {
                                     index: 'obr_clv', width: 80, align: 'Center', name: 'obr_clv'
                                 },
                                 {
                                     index: 'coopid', width: 50, align: 'Center', name: 'coopid'
                                 },
                                 {
                                     index: 'calle', width: 100, align: 'Center', name: 'calle', hidden: true
                                 },
                                 {
                                     index: 'colonia', width: 100, align: 'Center', name: 'colonia', hidden: true
                                 },
                                 {
                                     index: 'tramo', width: 80, align: 'Center', name: 'tramo', hidden: true
                                 },
                                 {
                                     index: 'costo_mto', width: 100, align: 'Center', name: 'costo_mto', hidden: true
                                 },
                                 {
                                     index: 'obr_fecinip', width: 100, align: 'Center', name: 'obr_fecinip', hidden: true
                                 },
                                 {
                                     index: 'obr_fecvenp', width: 100, align: 'Center', name: 'obr_fecvenp', hidden: true
                                 },
                                 {
                                     index: 'obr_npago', width: 100, align: 'Center', name: 'obr_npago', hidden: true
                                 },
                                 {
                                     index: 'descrip_tipo_obr', width: 100, align: 'Center', name: 'descrip_tipo_obr', hidden: true
                                 },
                                 {
                                     index: 'estatus_obra', width: 100, align: 'Center', name: 'estatus_obra', hidden: true
                                 },
                                 {
                                     index: 'nomprog', width: 100, align: 'Center', name: 'nomprog', hidden: true
                                 },
                                 {
                                     index: 'progdescrip', width: 100, align: 'Center', name: 'progdescrip', hidden: true
                                 },
                                 {
                                     index: 'fid', width: 50, align: 'Center', name: 'fid'
                                 },
                                 {
                                     index: 'nooficial', width: 50, align: 'Center', name: 'nooficial'
                                 },
                                 {
                                     index: 'ctapredial', width: 80, align: 'Center', name: 'ctapredial'
                                 },
                                 {
                                     index: 'coo_clv2', width: 100, align: 'Center', name: 'coo_clv2', hidden: true
                                 },
                                 {
                                     index: 'mnomficha', width: 200, align: 'Center', name: 'mnomficha'
                                 },
                                 {
                                     index: 'mts_frente', width: 50, align: 'Center', name: 'mts_frente'
                                 },
                                 {
                                     index: 'inc', width: 50, align: 'Center', name: 'inc', hidden: true
                                 },
                                 {
                                     index: 'capital_sin_inc', width: 100, align: 'Center', name: 'capital_sin_inc', hidden: true
                                 },
                                 {
                                     index: 'capital', width: 100, align: 'Center', name: 'capital', hidden: true
                                 },
                                 {
                                     index: 'capital_pagado', width: 150, align: 'Center', name: 'capital_pagado', hidden: true
                                 },
                                 {
                                     index: 'cargos_pagados', width: 100, align: 'Center', name: 'cargos_pagados', hidden: true
                                 },
                                 {
                                     index: 'desctos_aplicados', width: 100, align: 'Center', name: 'desctos_aplicados', hidden: true
                                 },
                                 {
                                     index: 'recargos_netos', width: 100, align: 'Center', name: 'recargos_netos', hidden: true
                                 },
                                 {
                                     index: 'total_pagar', width: 100, align: 'Center', name: 'total_pagar', formatter: 'currency', formatoptions: { prefix: '$', decimalSeparator: '.', thousandsSeparator: ',' }
                                 },
                                 {
                                     index: 'mapellidom', width: 100, align: 'Center', name: 'mapellidom', hidden: true
                                 },
                                 {
                                     index: 'mapellidop', width: 300, align: 'Center', name: 'mapellidop', hidden: true
                                 },
                                 {
                                     index: 'mnombres', width: 100, align: 'Center', name: 'mnombres', hidden: true
                                 }
                           ],
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
                           sortname: "fid", //login SortColumn
                           sortorder: "asc", //login SortOrder.
                           width: "1200",
                           height: "100%",
                           caption: "COOPERADORES"
                       }).navGrid("#" + pager_id, { edit: false, add: false, search: false, del: false, refresh: false })
                       .navButtonAdd("#" + pager_id,
                             {
                                 caption: "FichaPredio...",
                                 buttonicon: "ui-icon-document",
                                 onClickButton: function () {
                                     var myGrid = $("#" + subgrid_table_id);
                                     selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                     var pid = myGrid.jqGrid('getCell', selectedRowId, 'pid');
                                     var oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                                     if (pid) {
                                         ConsultaSalidaPredio(idusu, oid, pid);
                                     }
                                     else {
                                         alert("Seleccione el cooperador a consultar...");
                                     }
                                 },
                                 position: "last",
                                 title: "Revisar presupuesto",
                                 cursor: "pointer"
                             })

                            .navButtonAdd("#" + pager_id,
                                  {
                                      caption: "Gestion_Coops",
                                      buttonicon: "ui-icon-document",
                                      onClickButton: function () {
                                          var myGrid = $("#" + subgrid_table_id);
                                        
                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                          var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                          var coopid = myGrid.jqGrid('getCell', selectedRowId, 'coopid');
                                          var estatus_obra = obra.obr_estatus;
                                         
                                          var programa = obra.obr_prog2 + ':' + obra.Prog;
                                          if (fid) {
                                              GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv,estatus_obra, programa, idusu, fid, obra.NumPagos, obra.FecVenP, coopid);
                                          }
                                          else {
                                              GestionCooperadores(obra.oid, obra.ClvObra, obra.obr_clv,estatus_obra, programa, idusu, 0, obra.NumPagos, obra.FecVenP, '000');
                                          }
                                      },
                                      position: "last",
                                      title: "Cooperadores",
                                      cursor: "pointer"
                                  })

                          /* .navButtonAdd("#" + pager_id,
                                  {
                                      caption: "ActPagos",
                                      buttonicon: "ui-icon-document",
                                      onClickButton: function () {
                                          var myGrid = $("#" + subgrid_table_id);
                                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                          var fid = myGrid.jqGrid('getCell', selectedRowId, 'fid');
                                          var coo_clv = myGrid.jqGrid('getCell', selectedRowId, 'coopid');
                                          var obr_clv_txt = obra.obr_clv;

                                          if (fid) {

                                              ActualizacionPagosCoop(fid, obra.ClvObra, obr_clv_txt, coo_clv, idusu);
                                          }
                                          else {
                                              alert('Es necesario que selecciones un cooperador')
                                          }

                                      },
                                      position: "last",
                                      title: "Cooperadores",
                                      cursor: "pointer"
                                  })*/


             }

         }).navGrid('#pager', { edit: false, add: false, search: false, del: false })

           .navButtonAdd('#pager',
                    {
                        caption: "Alta Obra",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            /* var myGrid = $('#grid');
                             selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                             cellValue = myGrid.jqGrid('getCell', selectedRowId, 'obr_clv');
                             if (cellValue) {*/
                            var objObra = {
                                "obr_clv": '0000000000',
                                "obr_clv_int": 0,
                                "obr_oid": 0,
                                "accion": 0
                            }
                            AccionRegistroObra(objObra);
                            /* }
                             else {
                                 alert("Selecciona una solicitud...");
                             }*/
                        },
                        position: "last",
                        title: "Alta de Obra",
                        cursor: "pointer"
                    })

            .navButtonAdd('#pager',
                    {
                        caption: "CancObra",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            var myGrid = $('#grid');
                            var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');

                            var objObra = {
                                "obr_clv": '',
                                "obr_clv_int": 0,
                                "obr_oid": 0,
                                "idusu": 0,
                                "accion": 2
                            }

                            objObra.obr_clv = myGrid.jqGrid('getCell', selectedRowId, 'obr_clv');
                            objObra.obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                            objObra.obr_oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                            objObra.idusu = parseInt($("#bodegadatos").data("idusu").split(":")[1]);
                            var obr_estatus = myGrid.jqGrid('getCell', selectedRowId, 'obr_estatus');
                            var obr_estatus_txt = myGrid.jqGrid('getCell', selectedRowId, 'EstObra');
                            var mensaje;
                            if (obr_estatus == 2) {
                                ConsultaPermisoEjecutarTarea(objObra.idusu, 149, 3)
                                  .done(function (result) {
                                      var data = result.d;
                                      var no_tiene_permiso = data.split(":");
                                      var no_tiene = parseInt(no_tiene_permiso[1]);
                                      if (!no_tiene) {
                                          var opcion = confirm("Desea realmente CANCELAR la obra:" + objObra.obr_clv + '---> ADVERTENCIA: Se eliminarán TODOS los frentes activos de la obra, posteriormente es necesario realizar la actualizacion de la Obra en Cajas de Tesorería');
                                          if (opcion == true) {
                                              CancelarObra_psql(objObra)
                                               .done(function (r) {
                                                   var resp = r.d;
                                                   var idobra = parseInt(resp.split(':')[1]);
                                                   var obr_clv_txt = resp.split(':')[2];
                                                   var mensaje = resp.split(':')[0];
                                                   CancelarObra_access(objObra)
                                                       .done(function (r) {
                                                           alert('Obra: ' + obr_clv_txt + ' cancelada correctamente');
                                                           $('#mask, .window').hide();
                                                           RedibujarGrid();
                                                       })
                                                       .fail(function (xhr) {
                                                           console.log(xhr.responseText);
                                                           alert("No fué posible cancelar la obra en ACCESS...");
                                                       })
                                               })
                                              .fail(function (xhr) {
                                                  console.log(xhr.responseText);
                                                  alert("No fué posible cancelar la obra en PostgresSql...");
                                              });
                                          }
                                      } else {
                                          alert('El usuario ' + $("#bodegadatos").data("idusu").split(":")[1] + ' no cuenta con el permiso para cancelar obra.');
                                      }
                                  })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falló consultar permiso de ejecución de tarea.");
                                });
                            }
                            else {
                                alert('No es permitido CANCELAR la obra en estatus de: ' + obr_estatus_txt);
                            }
                        },
                        position: "last",
                        title: "Alta de Obra",
                        cursor: "pointer"
                    })

        .navButtonAdd('#pager',
                  {
                      caption: "EditObra",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                          var myGrid = $('#grid');
                          var objObra = {
                              "obr_clv_int": 0,
                              "obr_clv": '',
                              "obr_mts": 0,
                              "obr_cost": 0,
                              "obr_col": 0,    //SIFIDOC
                              "obr_tipo": 0,
                              "obr_fecha": '01/01/1900',
                              "obr_cost_total": 0,
                              "obr_inc": 0,
                              "obr_fecinip": '01/01/1900',
                              "obr_fecvencp": '01/01/1900',
                              "obr_npago": 0,
                              "obr_opergob": '',
                              "obr_fec_ini_proc": '01/01/1900',
                              "obr_fec_ini_cob": '01/01/1900',
                              "col_clv2": '',
                              "obr_prog2": 0,
                              "obr_programa": '', //SIFIDOC
                              "obr_clv2": '',
                              "obr_estatus": 0,
                              "obr_oid": 0,
                              "obr_fec_canc": '01/01/1900',
                              "obr_sis": '',  //SIFIDOC
                              "idusu": 0,
                              "accion": 0
                          }
                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                          objObra.obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                          objObra.obr_oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                          objObra.obr_clv = myGrid.jqGrid('getCell', selectedRowId, 'Obra');
                          objObra.obr_estatus = myGrid.jqGrid('getCell', selectedRowId, 'obr_estatus');
                          objObra.accion = 1;

                          objObra.obr_prog2 = myGrid.jqGrid('getCell', selectedRowId, 'obr_prog2');
                          objObra.obr_int = myGrid.jqGrid('getCell', selectedRowId, 'obr_int');
                          objObra.obr_cost = myGrid.jqGrid('getCell', selectedRowId, 'obr_cost');
                          objObra.obr_fecinip = myGrid.jqGrid('getCell', selectedRowId, 'FecIniPag');
                          objObra.obr_fecvencp = myGrid.jqGrid('getCell', selectedRowId, 'FecVenP');
                          objObra.obr_npago = myGrid.jqGrid('getCell', selectedRowId, 'NumPagos');

                          if (objObra.obr_estatus == '2') {
                              if (objObra.obr_oid) {
                                  AccionRegistroObra(objObra);
                              }
                              else {
                                  alert("Selecciona una obra...");
                              }
                          }
                          else {
                              alert('Los datos de la obra no pueden ser editados, solo es posible cuando la obra esta en PROMOCION.');
                          }

                      },
                      position: "last",
                      title: "Editar Obra",
                      cursor: "pointer"
                  })

     .navButtonAdd('#pager',
                  {
                      caption: "ExpJur",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                          var myGrid = $('#grid');
                          var objObra = {
                              "obr_clv_int": 0,
                              "obr_clv": '',
                              "obr_oid": 0,
                              "fecjur1": '01/01/1900',
                              "evidjur1": '',
                              "fecjur2": '01/01/1900',
                              "evidjur2": '',
                              "fecvenp": '01/01/1900',
                              "obr_costo_total": 0,
                              "obr_nat": '',
                              "obr_estatus": 0,
                              "idusu": 0,
                              "accion": 5
                          }
                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                          objObra.obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                          objObra.obr_clv = myGrid.jqGrid('getCell', selectedRowId, 'Obra');
                          objObra.obr_oid = myGrid.jqGrid('getCell', selectedRowId, 'oid');
                          objObra.fecjur1 = myGrid.jqGrid('getCell', selectedRowId, 'FecPub1');
                          objObra.fecjur2 = myGrid.jqGrid('getCell', selectedRowId, 'FecPub2');
                          objObra.evidjur1 = myGrid.jqGrid('getCell', selectedRowId, 'EvidPub1');
                          objObra.evidjur2 = myGrid.jqGrid('getCell', selectedRowId, 'EvidPub2');
                          objObra.fecvenp = myGrid.jqGrid('getCell', selectedRowId, 'FecVenP');
                          objObra.obr_costo_total = myGrid.jqGrid('getCell', selectedRowId, 'obr_cost_total');
                          objObra.obr_nat = myGrid.jqGrid('getCell', selectedRowId, 'obr_nat');
                          objObra.obr_estatus = myGrid.jqGrid('getCell', selectedRowId, 'obr_estatus');
                          objObra.idusu = parseInt($("#bodegadatos").data("idusu").split(":")[1]);
                          $("#bodegadatos").data("fecvenp", objObra.fecvenp);


                          if (objObra.obr_oid) {
                              if (objObra.obr_estatus == 4 || objObra.obr_estatus == 5 || objObra.obr_estatus == 2) {
                                  AccionRegistroObra(objObra);
                              }
                              else {
                                  alert("Solo se capturan datos jurídicos en las obras con estatus de PROMOCION, PROCESO y TERMINADA VENCIDA");
                              }
                          }
                          else {

                              alert("Selecciona una obra...");
                          }

                      },
                      position: "last",
                      title: "Datos Jurídicos",
                      cursor: "pointer"
                  })
        .navButtonAdd('#pager',
                    {
                        caption: "ObrProc",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            
                            var myGrid = $('#grid');                            
                            
                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var objObra = myGrid.jqGrid('getRowData', selectedRowId);


                            
                            if (parseInt(objObra.ClvObra) > 0) {
                                if (parseInt(objObra.obr_estatus) == 2 || parseInt(objObra.obr_estatus) == 4) {
                                    ConsultaPermisoEjecutarTarea(parseInt(idusu), 160, 3)
                                   .done(function (result) {
                                      var data = result.d;
                                      var no_tiene_permiso = data.split(":");
                                      var no_tiene = parseInt(no_tiene_permiso[1]);
                                      if (!no_tiene) {
                                          var opcion = confirm("Desea realmente cambiar la obra: " + objObra.obr_clv + ' a estatus de PROCESO.');
                                          if (opcion == true) {
                                              $.extend({}, "accion", objObra);
                                              $.extend({}, "idusu", objObra);
                                              $.extend({}, "obr_clv_int", objObra);
                                              objObra.accion = '4';
                                              objObra.idusu = parseInt(idusu);
                                              objObra.obr_clv_int = parseInt(objObra.ClvObr);
                                              AccionRegistroObra(objObra);
                                          }
                                      } else {
                                          alert('El usuario ' + $("#bodegadatos").data("idusu").split(":")[1] + ' no cuenta con el permiso para cambiar a estatus de obra en PROCESO.');
                                      }
                                  })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falló consultar permiso de ejecución de tarea.");
                                });

                                   
                                }
                                else {
                                    alert("Solo se puede iniciar a proceso una obra en estatus de RECAUDACION");
                                }
                            }
                            else {
                                alert("Selecciona una obra...");
                            }

                            
                        },
                        position: "last",
                        title: "Obra en Proceso",
                        cursor: "pointer"
                    })
                    
       .navButtonAdd('#pager',
                  {
                      caption: "TermObr",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                          var myGrid = $('#grid');
                          var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                          var objObraTerm = myGrid.jqGrid('getRowData', selectedRowId);

                          if (objObraTerm.ClvObra) {
                              if (objObraTerm.obr_estatus == '4') {
                                  ConsultaPermisoEjecutarTarea(idusu, 161, 3) /*Consulta permisos para cambiar de estatus de obra PROCESO --> TERMINADA VENCIDA*/
                                  .done(function (result) {
                                      var data = result.d;
                                      var no_tiene_permiso = data.split(":");
                                      var no_tiene = parseInt(no_tiene_permiso[1]);
                                      if (!no_tiene) {                                        
                                          $.extend({}, "accion", objObraTerm);
                                          objObraTerm.accion = 6;
                                          AccionRegistroObra(objObraTerm);
                                      } else {
                                          alert('El usuario ' + idusu.tostring + ' no cuenta con permiso para cambiar estatus de la obra (PROCESO-->TERMINADA VENCIDA).');
                                      }
                                  })
                                  .fail(function (xhr) {
                                      console.log(xhr.responseText);
                                      alert("Falló consultar permiso de ejecución de tarea.");
                                  });
                              } else {
                                  alert('El estatus de la obra debe estar en PROCESO.');
                              }

                          } else {
                              alert('Selecciona una obra...');
                          }                        

                      },
                      position: "last",
                      title: "Termino de Obra",
                      cursor: "pointer"
                  })

        .navButtonAdd('#pager',
                  {
                      caption: "ReporteObra",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                          var myGrid = $('#grid');
                          var objObra = {
                              "obr_clv_int": 0,
                              "obr_fec_ini_pag": '01/01/1900',
                              "obr_fec_venc_pag": '01/01/1900',
                              "numpagos": 0,
                              "obr_estatus": 0,
                              "idusu": 0,
                              "nom_usu":'',
                              "accion": 'ReporteObra'
                          }

                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                          objObra.obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                          objObra.obr_estatus = myGrid.jqGrid('getCell', selectedRowId, 'obr_estatus');
                          objObra.idusu = parseInt($("#bodegadatos").data("idusu").split(":")[1]);
                          objObra.nom_usu = parseInt($("#bodegadatos").data("idusu").split(":")[2]);
                          
                          if (parseInt(objObra.obr_clv_int) > 0) {                              
                                  GenerarReporteObra(objObra.obr_clv_int);                                                            
                          }
                          else {
                              alert("Selecciona una obra...");
                          }

                      },
                      position: "last",
                      title: "Termino de Obra",
                      cursor: "pointer"
                  })

        .navButtonAdd('#pager',
                  {
                      caption: "Obra",
                      buttonicon: "ui-icon-document",
                      onClickButton: function () {
                          var myGrid = $('#grid');
                          var objObra = {
                              "obr_clv_int": 0,
                              "obr_fec_ini_pag": '01/01/1900',
                              "obr_fec_venc_pag": '01/01/1900',
                              "numpagos": 0,
                              "obr_estatus": 0,
                              "idusu": 0,
                              "nom_usu": '',
                              "accion": 'Obra'
                          }

                          selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                          objObra.obr_clv_int = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra');
                          objObra.idusu = parseInt($("#bodegadatos").data("idusu").split(":")[1]);
                          objObra.nom_usu = parseInt($("#bodegadatos").data("idusu").split(":")[2]);

                          if (parseInt(objObra.obr_clv_int) > 0) {
                              ConsultaSalidaObra(objObra.obr_clv_int, objObra.idusu);
                          }
                          else {
                              alert("Selecciona una obra...");
                          }

                      },
                      position: "last",
                      title: "Obra",
                      cursor: "pointer"
                  })

        .navButtonAdd('#pager',
                    {
                        caption: "FichPagMens",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            var myGrid = $('#grid');
                            var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var cellValue = myGrid.jqGrid('getCell', selectedRowId, 'ClvObra'); 
                            var cellValue2 = myGrid.jqGrid('getCell', selectedRowId, 'NumPagos');
                            var cellValue3 = myGrid.jqGrid('getCell', selectedRowId, 'Obra');
                            var fecinip = myGrid.jqGrid('getCell', selectedRowId, 'FecIniPag');
                            var fecvencp = myGrid.jqGrid('getCell', selectedRowId, 'FecVenP');
                            var obr_estatus = myGrid.jqGrid('getCell', selectedRowId, 'obr_estatus');
                            
                                if (fecvencp.length > 10) {
                                    fecvencp = fecvencp.substr(0, 10);
                                }
                                num_pagos = parseInt(cellValue2);
                                var hoy = moment();
                                var fec_inicial = ConvertirCadenaToFecha(fecinip);
                                var meses_trans = hoy.diff(fec_inicial, 'months'); //Se le suma un mes debido al mes que transcurrió                            
                                var pagos_trans = 0;
                                var mes_actual = hoy.month() + 1;
                                var mes_inicial = fec_inicial.getMonth() + 1;
                                var adelanto_impresion = 0;
                                if (meses_trans == 0) {
                                    if (mes_inicial >= mes_actual) {
                                        pagos_trans = 1; /*<<==== El valor a 1 provoca un mes antes del mes en curso*/
                                        adelanto_impresion = 0; /*La fecha de emision de fichas se anticipa  más de un mes de la fecha inicial de pagos*/
                                    }
                                    if (mes_inicial < mes_actual) {
                                        pagos_trans = 1;
                                        adelanto_impresion = 1; /*La fecha de emision de fichas se anticipa  más de un mes de la fecha inicial de pagos*/
                                    }

                                } else {
                                    pagos_trans = meses_trans + 2;
                                }

                                if (cellValue) {
                                    if (obr_estatus == 2) {
                                        var idusu_aux = $("#bodegadatos").data("idusu").split(":")[1];
                                        ConsultaPermisoEjecutarTarea(idusu_aux, 150, 3)
                                            .done(function (result) {
                                                    var data = result.d;
                                                    var no_tiene_permiso = data.split(":");
                                                    var no_tiene = parseInt(no_tiene_permiso[1]);
                                                    if (!no_tiene) {
                                                          if (adelanto_impresion == 1) {
                                                             alert('ALERTA: Se anticipa más de un mes la emisión de fichas mensuales.');
                                                          }
                                                          if (pagos_trans <= num_pagos) {
                                                             $("#lblobrclvint_x").html(cellValue);
                                                             $("#lblnumfichas_x").html(cellValue2);
                                                             $("#lblnumfichas_y").html(cellValue2);
                                                             $("#lblobrclv_s").html(cellValue3);
                                                             $("#lblfecinipag_x").html(fecinip);
                                                             $("#lblfecfinpag_x").html(fecvencp);
                                                             $("#lblnumfichaactual").html(pagos_trans);
                                                             MostrarModalFichaPagoMes();
                                                         }
                                                         else {
                                                            alert("El periodo de Recaudación ha terminado, por lo tanto ya no es posible emitir Fichas de Pago mensuales");
                                                         }
                                                    }
                                                    else {                                                    
                                                        alert('El usuario ' + $("#bodegadatos").data("idusu").split(":")[1] + ' no cuenta con el permiso para emitir fichas de pago.');
                                                    }
                                            })
                                            .fail(function (xhr) {
                                                    console.log(xhr.responseText);
                                                    alert("Falló consultar permiso de ejecución de tarea.");
                                            });
                                    }
                                    else {
                                        alert('Solo se emiten fichas impresas de obras en estatus de RECAUDACION.');
                                    }
                                } else {                                
                                    alert("Selecciona una Obra...");
                                }
                            
                        },
                        position: "last",
                        title: "Alta de Obra",
                        cursor: "pointer"
                    })

         .navButtonAdd('#pager',
                       {
                        caption: "ExpExcel",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            var obr_clv_int_txt = '0'; /*Todas la obras en el excel*/

                            if (idusu == '51' || idusu == '46') {
                                LeerObrasExcel(obr_clv_int_txt)
                                .done(function (r) {
                                    var obras = [];
                                    var data = r.d;
                                    for (var i = 0; i < data.RecordCount; i++) {
                                        obras.push({
                                            "obr_clv_int": data.Items[i].row[0],
                                            "obr_clv": '\'' + data.Items[i].row[1],
                                            "calle": data.Items[i].row[2],
                                            "colonia": data.Items[i].row[3],
                                            "tramo": data.Items[i].row[4],
                                            "nomprog": data.Items[i].row[5],
                                            "obr_fecinip": data.Items[i].row[14],
                                            "obr_fecvenp": data.Items[i].row[15],
                                            "obr_npago": data.Items[i].row[16],
                                            "num_coops": data.Items[i].row[54],
                                            "num_coops_s": data.Items[i].row[55]
                                        });
                                    }

                                    $("#rep_xls").excelexportjs({
                                        containerid: "dvjson",
                                        datatype: 'json',
                                        dataset: obras,
                                        columns: getColumns(obras),
                                        worksheetName: "Obras_RECAUDACION",
                                        encoding: "utf-8",
                                        locale: 'es-MX'
                                    });

                                })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("Falle al recuperar datos de las obras.");
                                })
                            }
                            else {
                                alert('No existen privilegios para emitir éste reporte.');
                            }
                        },
                        position: "last",
                        title: "Exportar Excela",
                        cursor: "pointer"                        
                    });
        
    }


    function RedibujarSubGrid() {
        //    jQuery("#grid").jqGrid('setGridParam',
        //        {
        //          datatype: function () { ObtenerDatos(ObtenerFiltro()) }                
        //        })
        //.trigger("reloadGrid");
        $("#grid_contrato_anexos").trigger("reloadGrid");
    }



    function RelacionarContratoAnexos(idusu, filtro) {


        if ($("#grid_contrato_anexos")[0].grid) {
            $.jgrid.gridUnload("#grid_contrato_anexos");
            //$("#grid").jqGrid("clearGridData", true).trigger("reloadGrid");
        }

        $("#grid_contrato_anexos").jqGrid(
             {
                 datatype: function () {
                     $.ajax(
                       {
                           url: "../../WebServices/WebServiceContrato.asmx/GetContratoAnexos_Grid", //PageMethod
                           data: "{'pPageSize':'" + $('#grid_contrato_anexos').getGridParam("rowNum") +
                           "','pCurrentPage':'" + $('#grid_contrato_anexos').getGridParam("page") +
                           "','pSortColumn':'" + $('#grid_contrato_anexos').getGridParam("sortname") +
                           "','pSortOrder':'" + $('#grid_contrato_anexos').getGridParam("sortorder") +
                           "','filtro':'" + filtro + "'}", //PageMethod Parametros de entrada
                           dataType: "json",
                           type: "post",
                           contentType: "application/json; charset=utf-8",
                           complete: function (jsondata, stat) {
                               if (stat == "success") {
                                   jQuery("#grid_contrato_anexos")[0].addJSONData(JSON.parse(jsondata.responseText).d);
                                   var objeto = JSON.parse(jsondata.responseText).d;
                                   regs = objeto.RecordCount;
                                   if (!regs) {                                       
                                       alert('No se encontraron contratos referenciados a la obra, por lo tanto no es posible cambiar el estatus a "Terminada Vencida"');
                                   } else {
                                       MostrarModalObraTerm();
                                   }
                               }
                               else {
                                   alert(JSON.parse(jsondata.responseText).Message);
                               }
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
                     id: "idcontrato"
                 },
                 colModel: [
                {
                    index: 'oid', width: 100, align: 'Center', name: 'oid', hidden: true
                },
                {
                    index: 'obr_clv_int', width: 50, align: 'Center', name: 'obr_clv_int', hidden: true
                },
                {
                    index: 'obr_clv', width: 100, align: 'Center', name: 'obr_clv', hidden: true
                },
                {
                    index: 'idcontrato', width: 100, align: 'Center', name: 'idcontrato', hidden: true
                },
                {
                    index: 'num_contrato_limpio', width: 150, align: 'Center', name: 'NumContrato'
                },
                {
                    index: 'calle', width: 150, align: 'Center', name: 'Calle', hidden: true
                },
                {
                    index: 'colonia', width: 80, align: 'Center', name: 'Colonia', hidden: true
                },
                {
                    index: 'tramo', width: 200, align: 'Center', name: 'Tramo', hidden: true
                },
                {
                    index: 'obr_prog2', width: 200, align: 'Center', name: 'IdProg', hidden: true
                },
                {
                    index: 'nomprog', width: 80, align: 'Center', name: 'NomProg', hidden: true
                },
                {
                    index: 'docto_contrato', width: 50, align: 'Center', name: 'DoctoContrato', hidden: true
                },
                {
                    index: 'cestatus_contrato', width: 50, align: 'Center', name: 'CestatusContrato', hidden: true
                },
                {
                    index: 'idanexo_contrato', width: 50, align: 'Center', name: 'IdAnexo_Contrato', hidden: true
                },
                {
                    index: 'idtipo_anexo_contrato', width: 150, align: 'Center', name: 'IdTipoAnexoContrato', hidden: true
                },
                {
                    index: 'etiqueta_anexo', width: 50, align: 'Center', name: 'EtiquetaAnexo', hidden: true
                },
                {
                    index: 'docto_param1', width: 50, align: 'Center', name: 'DoctoCartaTerm', hidden: true
                },
                {
                    index: 'fecha_param2', width: 150, align: 'Center', name: 'FechaTermObra'
                },
                {
                    index: 'valor_param3', width: 150, align: 'Center', name: 'ValorP3', hidden: true
                },
                {
                    index: 'valor_param4', width: 100, align: 'Center', name: 'ValorP4', hidden: true
                },
                {
                    index: 'cactivo_anexo_contrato', width: 100, align: 'Center', name: 'EstatusAnexoContrato', hidden: true
                }],
                 pager: "#pager_contrato_anexos", //Pager.                 
                 loadtext: 'Cargando datos...',
                 recordtext: "{0} - {1} de {2} elementos",
                 emptyrecords: 'No hay resultados',
                 pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                 rowNum: "5", // PageSize.
                 rowList: [5, 10, 20], //Variable PageSize DropDownList. 
                 viewrecords: true, //Show the RecordCount in the pager.
                 multiselect: false,
                 sortname: "idcontrato", //login SortColumn
                 sortorder: "asc", //login SortOrder.
                 width: "1000",
                 height: "100%",
                 caption: 'CONTRATOS DE OBRA Y CARTAS DE TERMINACION'
             }).navGrid('#pager_contrato_anexos', { edit: false, add: false, search: false, del: false })

            .navButtonAdd('#pager_contrato_anexos',
               {
                caption: "AsigFecCob",
                onClickButton: function () {
                    var myGrid = $('#grid_contrato_anexos');
                   var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                   var objContratoAnexo = myGrid.jqGrid('getRowData', selectedRowId);


                   if (objContratoAnexo.idcontrato) {                       
                       $("#lblfecha_inicio_cobranza_capt").html(objContratoAnexo.FechaTermObra);
                   } else {
                       alert('Selecciona un contrato con la fecha de terminación asignada...');

                   }
               },
               position: "last",
               title: "Ver Frente",
               cursor: "pointer"
             });

    }




    function GenerarFichasPagoMes(obr_clv_int,idusu,num_ficha_act) {

        LeerCooperadores(obr_clv_int)
            .done(function (r) {
                var datos = r.d;
                var num_regs = datos.RecordCount;


                if (num_regs > 0) {
                    num_ficha = 1;
                    var pdf = new jsPDF('p', 'mm', 'letter');
                    pdf.deletePage(1);
                    var reg = datos.Items[0].row;                    
                    var col_ref = 70;
                    var col_ref2 = 72;
                    var reng_ref = 35;
                    var reng_inc = 3.3;
                    var reng_inc2 = 5;
                    var tab1 = 10;
                    var tab2 = 52;
                    var tab3 = tab2 * 2;
                    var tab4 = tab2 * 3;
                    var tab5 = 208;
                  
                    var tamano_col = 14;

                    var oid;
                    var obr_clv_int;
                    var obr_clv;
                    var coopid;
                    var nooficial;
                    var numpagos;
                    var calle;
                    var colonia;
                    var tramo;
                    var obr_fecinip;
                    var obr_fecivenp;
                    var descrip_tipo_obr;
                    var estatus_obra;
                    var nomprog;
                    var progdescrip;
                    var fecinip;
                    var fecvenp;
                    var costo_obra;
                    var total_pagar;
                    var abono;
                    var costo_mto;
                    var mts_fte;
                    var fid;
                    


                    var porcentaje_avance = CalcularAvanceObra(datos);


                    
                    var i = 0;
                    
                    while (i < num_regs) {
                        
                        reg = datos.Items[i].row;

                        oid = reg[0];
                        obr_clv_int = reg[1];
                        obr_clv = reg[3];
                        calle = reg[5];
                        colonia = reg[6];
                        tramo = reg[7];
                        obr_fecinip = reg[9];
                        obr_fecivenp = reg[10];
                        descrip_tipo_obr = reg[12];
                        estatus_obra = reg[13];
                        nomprog = reg[14];
                        progdescrip = reg[15];
                        fecinip = reg[9];
                        fecvenp = reg[10];
                        costo_obra = reg[33];
                        abono = reg[34];
                        nom_ficha = reg[20];
                        coopid = reg[4];
                        nooficial= reg[17];
                        numpagos = reg[11];
                        total_pagar = reg[29];
                        costo_mto = reg[8];
                        mts_fte = reg[21];
                        fid = reg[16];
                        pid = reg[2];

                        var objFormato = {
                            "fid": fid,
                            "pid": pid,
                            "obr_clv_int": obr_clv_int,
                            "oid": oid,
                            "idusu":idusu    
                        }
                                               

                        if (parseFloat(total_pagar) > 20)
                        {
                            pdf.addPage();
                            GeneraFormatoFichaPagoMes(objFormato, pdf);  //* Aplica formato a la página de la ficha de pago*//

                            pdf.setFontSize(10);
                            pdf.setFontType('bold')
                            pdf.line(10, reng_ref + reng_inc2 * .1, 204, reng_ref + reng_inc2 * .1);

                            pdf.text(tab2 - pdf.getTextWidth('No. de Cuenta:  '), reng_ref + reng_inc2 * 1, 'No. de Cuenta:  ');
                            pdf.text(tab2 - pdf.getTextWidth('Nombre de Cooperador:  '), reng_ref + reng_inc2 * 2, 'Nombre de Cooperador:  ');
                            pdf.text(tab4 - pdf.getTextWidth('Recibo de pago:  '), reng_ref + reng_inc2 * 1, 'Recibo de pago:  ');

                            pdf.text(tab2, reng_ref + reng_inc2 * 1, obr_clv + ' ' + coopid);
                            pdf.text(tab2, reng_ref + reng_inc2 * 2, nom_ficha);
                            pdf.text(tab5 - pdf.getTextWidth('Recibo de pago:  '), reng_ref + reng_inc2 * 1, num_ficha_act + ' de ' + numpagos);

                            pdf.line(10, reng_ref + reng_inc2 * 2.5, 204, reng_ref + reng_inc2 * 2.5);

                            pdf.setFontSize(9);
                            pdf.setFontType('bold')
                            pdf.text(tab2 - pdf.getTextWidth('CALLE y No.:   '), reng_ref + reng_inc2 * 3.5, 'CALLE y NO.:   ');
                            pdf.text(tab2 - pdf.getTextWidth('COLONIA: '), reng_ref + reng_inc2 * 4.5, 'COLONIA: ');
                            pdf.text(tab2 - pdf.getTextWidth('TRAMO: '), reng_ref + reng_inc2 * 5.5, 'TRAMO: ');
                            pdf.text(tab2 - pdf.getTextWidth('PROGRAMA:  '), reng_ref + reng_inc2 * 6.5, 'PROGRAMA:  ');
                            pdf.text(tab2 - pdf.getTextWidth('TIPO DE OBRA:  '), reng_ref + reng_inc2 * 7.5, 'TIPO DE OBRA:  ');
                            pdf.text(tab4 - pdf.getTextWidth('PERIODO DE RECAUDACION:  '), reng_ref + reng_inc2 * 7.5, 'PERIODO DE RECAUDACION:  ');

                           
                            

                            pdf.setFontType('normal')
                            pdf.setFontSize(9);
                            pdf.text(tab2, reng_ref + reng_inc2 * 3.5, calle + ' ' + nooficial);
                            pdf.text(tab2, reng_ref + reng_inc2 * 4.5, colonia);
                            pdf.text(tab2, reng_ref + reng_inc2 * 5.5, tramo);
                            pdf.text(tab2, reng_ref + reng_inc2 * 6.5, nomprog + '  (' + progdescrip + ')');
                            pdf.text(tab2, reng_ref + reng_inc2 * 7.5, descrip_tipo_obr);
                            pdf.text(tab4, reng_ref + reng_inc2 * 7.5, fecinip + '-' + fecvenp);

                            pdf.line(10, reng_ref + reng_inc2 * 8, 204, reng_ref + reng_inc2 * 8);

                      
                            pdf.setFontSize(10);
                            pdf.setFontType('normal')
                           
                            pdf.text(tab2 - pdf.getTextWidth('Costo por metro lineal:'), reng_ref + reng_inc2 * 9.5, 'Costo por metro lineal:');
                            pdf.text(tab2 - pdf.getTextWidth('Metros del frente:'), reng_ref + reng_inc2 * 10.5, 'Metros del frente:');
                            pdf.text(tab2 - pdf.getTextWidth('Costo Total:'), reng_ref + reng_inc2 * 11.5, 'Costo Total:');
                            pdf.text(tab2 - pdf.getTextWidth('Total Aportado:'), reng_ref + reng_inc2 * 12.5, 'Total Aportado:');
                            pdf.setFontSize(8);
                            pdf.text(tab2 - pdf.getTextWidth('Meses vencidos sin aportación:'), reng_ref + reng_inc2 * 13.5, 'Meses vencidos sin aportación:');
                            pdf.setFontSize(10);
                            pdf.text(tab2 - pdf.getTextWidth('Saldo:'), reng_ref + reng_inc2 * 14.5, 'Saldo:');

                            pdf.line(10, reng_ref + reng_inc2 * 15, 204, reng_ref + reng_inc2 * 15);

                            pdf.setFontSize(12);
                            pdf.setFontType('bold')
                            pdf.text(tab2 - pdf.getTextWidth('Aportación del Mes:'), reng_ref + reng_inc2 * 16, 'Aportación del Mes:');

                            pdf.setFontSize(9);
                            pdf.rect(tab4 - 2 - (pdf.getTextWidth('El avance de su obra es de: ' + porcentaje_avance + ' %') / 2), reng_ref + reng_inc2 * 9.5, 65, 7);
                            pdf.text((tab4 - pdf.getTextWidth('El avance de su obra es de: ' + porcentaje_avance + ' %') / 2), reng_ref + reng_inc2 * 10.3, 'El avance de su obra es de: ' + porcentaje_avance + ' %');



                            pdf.setFontSize(7);
                            pdf.setFontType('bold')

                          

                            pdf.setFontSize(10);
                            pdf.setFontType('normal')
                            pdf.text(tab3 - pdf.getTextWidth(FormatoMoneda(costo_mto)), reng_ref + reng_inc2 * 9.5, FormatoMoneda(costo_mto));
                            pdf.text(tab3 - pdf.getTextWidth(mts_fte), reng_ref + reng_inc2 * 10.5, mts_fte);
                            pdf.text(tab3 - pdf.getTextWidth(FormatoMoneda(costo_obra)), reng_ref + reng_inc2 * 11.5, FormatoMoneda(costo_obra));
                            pdf.text(tab3 - pdf.getTextWidth(FormatoMoneda(abono)), reng_ref + reng_inc2 * 12.5, FormatoMoneda(abono));

                            var aportacion_final_float = 0;
                            var aport_mes = parseFloat(costo_obra) / parseInt(numpagos);
                            aportacion_final_float = aport_mes;
                            var aport_mes_txt = aport_mes.toFixed(2).toString();
                            var aportacion_final_txt = aport_mes_txt;
                            

                            /*Evalua la aportacion para si es la ultima ficha debe mostrar el saldo total*/

                            if (parseInt(num_ficha_act)== parseInt(numpagos)) {
                                aportacion_final_txt = FormatoMoneda(total_pagar);
                                aportacion_final_float = parseFloat(total_pagar);
                            }



                            var cantidad_completa = parseInt(num_ficha_act) - 1;
                            cantidad_completa = cantidad_completa * aport_mes;

                            var cantidad_lleva = parseFloat(abono);
                            var meses_sin_aportacion = (cantidad_completa - cantidad_lleva) / aport_mes;
                            if (meses_sin_aportacion < 0) {
                                meses_sin_aportacion = 0;
                            }
                            var meses_sin_aportaciones_txt = Math.floor(meses_sin_aportacion).toString();

                            pdf.text(tab3 - pdf.getTextWidth(meses_sin_aportaciones_txt), reng_ref + reng_inc2 * 13.5, meses_sin_aportaciones_txt);
                            pdf.text(tab3 - pdf.getTextWidth(FormatoMoneda(total_pagar)), reng_ref + reng_inc2 * 14.5, FormatoMoneda(total_pagar));

                            pdf.setFontSize(12);
                            pdf.setFontType('bold')

                            


                            pdf.text(tab3 - pdf.getTextWidth(aportacion_final_txt), reng_ref + reng_inc2 * 16,aportacion_final_txt);


                            var numletras = NumeroALetras(aportacion_final_float);

                            pdf.setFontSize(6);
                            pdf.text('(' + numletras + ')', tab4 - (pdf.getTextWidth(numletras)/2), reng_ref + reng_inc2 *16, { maxWidth: 550, align: "justify" });

                            pdf.line(10, reng_ref + reng_inc2 * 16.3, 204, reng_ref + reng_inc2 * 16.3);
                            pdf.line(10, reng_ref + reng_inc2 * 16.5, 204, reng_ref + reng_inc2 * 16.5);

                            pdf.text(104 - pdf.getTextWidth('HISTORIAL DE APORTACIONES') / 2, reng_ref + reng_inc2 * 17.3, 'HISTORIAL DE APORTACIONES');
                            pdf.text(tab2 - pdf.getTextWidth('No.Aport  | Mes/Año  |  Estatus'), reng_ref + reng_inc2 * 18, 'No.Aport  | Mes/Año  |  Estatus');
                            pdf.text(104 - pdf.getTextWidth('No.Aport  |  Mes/Año  |  Estatus'), reng_ref + reng_inc2 * 18, 'No.Aport  | Mes/Año  |  Estatus');
                            pdf.text(tab4 - pdf.getTextWidth('No.Aport  |  Mes/Año  |  Estatus'), reng_ref + reng_inc2 * 18, 'No.Aport  | Mes/Año  |  Estatus');

                            pdf.line(10, reng_ref + reng_inc2 * 18.2, 204, reng_ref + reng_inc2 * 18.2);

                            var saldo_pagado = parseFloat(abono);
                            var estatus = '';                          
                       
                            var mes_int = 0;
                            var mes_txt = '';
                            var fec = ConvertirCadenaToFecha(fecinip);
                            var fec2 = new Date();
                            
                            var campo2 = '';
                            var reng_aux = 127;
                            var inc_aux = 3.5;
                            var factor_inc = 0;
                            var tab_aux = 20;
                            var estatus_aportacion = '';
                            var num_pagos_int = parseInt(numpagos);
                            var j = 0;
                            
                            for (j = 0; j < num_pagos_int; j++) {
                                if (saldo_pagado > 0) {
                                    saldo_pagado = saldo_pagado - parseFloat(aport_mes);
                                    estatus = 'SI APORTADO';
                                } else {
                                    estatus = 'NO APORTADO';
                                }
                                fec.setMonth(fec.getMonth() + j);
                                mes_int = fec.getMonth();
                                year_txt = fec.getFullYear();
                                mes_txt = NombreMes(mes_int);
                                campo2 = mes_txt + '/' + year_txt;

                                if (j == 8) {
                                    tab_aux = 73;
                                    factor_inc = 0;
                                }

                                if (j == 16) {
                                    tab_aux = 130;
                                    factor_inc = 0;
                                }
                                estatus_aportacion = (j + 1).toString() + '  :  ' + mes_txt + '/' + year_txt + '  :  ' + estatus;
                                factor_inc++;
                                fec = ConvertirCadenaToFecha(fecinip);
                                pdf.text(tab_aux, reng_aux + inc_aux * factor_inc, estatus_aportacion);
                            
                            }

                            pdf.setFontSize(10);
                            pdf.setFontType('bold')

                            
                           
                            pdf.text(tab2 - pdf.getTextWidth('No. de Cuenta:  '), reng_ref + reng_inc2 * 40, 'No. de Cuenta:  ');
                            pdf.text(tab2 - pdf.getTextWidth('Nombre de Cooperador:  '), reng_ref + reng_inc2 * 41, 'Nombre de Cooperador:  ');
                            pdf.text(tab4 - pdf.getTextWidth('Recibo de pago:  '), reng_ref + reng_inc2 * 40, 'Recibo de pago:  ');

                            pdf.text(tab2, reng_ref + reng_inc2 * 40, obr_clv + ' ' + coopid);
                            pdf.text(tab2, reng_ref + reng_inc2 * 41, nom_ficha);
                            pdf.text(tab5 - pdf.getTextWidth('Recibo de pago:  '), reng_ref + reng_inc2 * 40, num_ficha_act + ' de ' + numpagos);
                            
                            pdf.line(10, reng_ref + reng_inc2 * 42.5, 204, reng_ref + reng_inc2 * 42.5);

                            pdf.setFontSize(10);
                            pdf.setFontType('bold')
                            pdf.text(tab2 - pdf.getTextWidth('Total de Aportación:'), reng_ref + reng_inc2 * 43.5, 'Total de Aportación:');
                            pdf.text(tab3 - pdf.getTextWidth(aportacion_final_txt), reng_ref + reng_inc2 * 43.5, aportacion_final_txt);

                            pdf.setFontSize(5);
                            pdf.text('(' + numletras + ')', tab4 - (pdf.getTextWidth(numletras) / 2), reng_ref + reng_inc2 * 43.5, { maxWidth: 550, align: "justify" });

                            pdf.line(10, reng_ref + reng_inc2 * 44, 204, reng_ref + reng_inc2 * 44);                           
                            
                        }                        

                     
                        i++;                       
                    } 

                    var hoy = moment().format("DDMMYYYY");
                    var fichas = obr_clv_int.toString() + '_' + hoy + '.pdf';
                    pdf.save(fichas.toString());
                  }

                alert('Cooperadores leídos correctamente');                  
            })
            .fail(function (xhr) {
                  console.log(xhr.responseText);
                  alert("No fué posible leer los cooperadores...");
            })
    }

    function CalcularAvanceObra(datos) {
        var num_regs = datos.RecordCount;
        var total_total_pagado = 0;
        var total_total_metros = 0;
        var costo_metro = 0;

        for (i = 0; i < num_regs ; i++) {
            reg = datos.Items[i].row;

            total_total_pagado = total_total_pagado + parseFloat(reg[34]);
            total_total_metros = total_total_metros + parseFloat(reg[21]);
            costo_metro = parseFloat(reg[8]);
        }
        var costo_obra = total_total_metros * costo_metro;
        avance_obra = (total_total_pagado * 100) / costo_obra;
        return avance_obra.toFixed(2);
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


    function LeerCooperadores(obr_clv_int) {

        var filtro3 = ',,,,,,,,' + obr_clv_int + ',,';
        

     return  $.ajax(
               {
                   url: "../../WebServices/WebServiceFrente.asmx/GetFrentexO", //PageMethod
                   data: "{'pPageSize':'" + '10000' +
                         "','pCurrentPage':'" + '1' +
                         "','pSortColumn':'" + 'fid' +
                         "','pSortOrder':'" + 'asc' +
                         "','pFiltro':'" + filtro3 + "'}", //PageMethod Parametros de entrada                                   
                   dataType: "json",
                   type: "post",
                   contentType: "application/json; charset=utf-8"
               });
    }

   /* function LeerEstatusAportaciones(fid,accion) {

        return $.ajax(
               {
                   url: "../../WebServices/WebServiceMovs.asmx/GetPagos", //PageMethod
                   data: "{'fid':'" + fid + "','accion':'" + accion + "'}",
                   dataType: "json",
                   type: "post",
                   contentType: "application/json; charset=utf-8"
               });        

    }*/
        function LeerObrasExcel(obr_clv_int_txt) {
        return $.ajax({
            url: "../../WebServices/WebServiceObras.asmx/GetObra_rep1", //PageMethod
            data: "{'obr_clv_int_txt':'" + obr_clv_int_txt + "'}", //PageMethod Parametros de entrada
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            success: function (data) {                
                    if (data.d != null) {
                        console.log(data.d);
                    }                
            },
            error: function (responseText, textStatus, errorThrown) {
                alert(textStatus + responseText + errorThrown);
            }
        });
    }


    function MostrarCoops_vwcoops4(obr_clv_int, idusu, accion) {
        var url1 = "../../Procesos/gcoops_vwcoops_4.html?ResponseType=Edit&obr_clv_int=" + obr_clv_int + "&idusu=" + idusu + "&accion=" + accion;
        newWindow = window.open(url1, "_blank", "top=30,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=1100,width=1300,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
        if (newWindow.focus()) {
            newWindow.focus()
        }

    };


    function CancelarObra_psql(objObra) {

        var stringData = JSON.stringify(objObra);
        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceObras.asmx/RegObra_PostgresSql",
            data: "{objObraS:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    console.log(data.d);
                }
            },
            error: function (responseText, textStatus, errorThrown) {
                alert(textStatus + responseText + errorThrown);
            }
        });

    };

    function CancelarObra_access(objObra) {

        var stringData = JSON.stringify(objObra);
        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceObras.asmx/RegObra_Access",
            data: "{objObraS:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    console.log(data.d);
                }
            },
            error: function (responseText, textStatus, errorThrown) {
                alert(textStatus + responseText + errorThrown);
            }
        });

    };





    //// FUNCION PRINCIPAL

    $(document).ready(function () {

        var usuario = $("#lblUsuario").html();
        $("#bodegadatos").data("idusu", usuario.split(":")[1] + ":" + usuario.split(":")[2]);

        /*  $("#lstobrassifidoc").change(function () {
              llenarObrasSIFIDOC($("#lstobrassifidoc").val());
              if ($("#lstobrassifidoc").val() == '0000000000') {
                  $("#lstcolonias_s").attr('disabled', false);
                  $("#lstprograma_s").attr('disabled', false);
                  $("#lstsistema_s").attr('disabled', false);
              }
              else {
                  $("#lstcolonias_s").attr('disabled', true);
                  $("#lstprograma_s").attr('disabled', true);
                  $("#lstsistema_s").attr('disabled', true);
              }
          });*/


        $(".buscar_obra").click(function () {
            var noobra = $("#txtnumobra").val();
            Buscar_obra(noobra);
        });

        $(".alta_obra").click(function () {
            var objObra = {
                "obr_clv": '0000000000',
                "obr_clv_int": 0,
                "obr_oid": 0,
                "accion": 0
            }
            AccionRegistroObra(objObra);
        });



        $(".posicion_boton_accion_obraS").click(function () { //Actualizar datos en el registro  

            var accion = parseInt($("#lblaccionobraS").html());
            var usuario = $("#bodegadatos").data("idusu");
            var idusu = usuario.split(":")[1];

            ValidarRegistroObraS(accion, idusu);
        });

        $(".posicion_boton_accion_obra_proc").click(function () { //Actualizar datos en el registro  

            var accion = parseInt($("#lblaccion_proc").html());
            var usuario = $("#bodegadatos").data("idusu");
            var idusu = usuario.split(":")[1];

            ValidarRegistroObraS(accion, idusu);
        });


        $(".posicion_boton_accion_obra_jur1").click(function () { //Actualizar datos en el registro  

            var accion = parseInt($("#lblaccion_obr_jur1").html());
            var usuario = $("#bodegadatos").data("idusu");
            var idusu = usuario.split(":")[1];

            ValidarRegistroObraS(accion, idusu);
        });

        $(".posicion_boton_accion_obra_term").click(function () { //Actualizar datos en el registro  

            var accion = parseInt($("#lblaccion_obra_term").html());
            var idusu = usuario.split(":")[2];

            ValidarRegistroObraS(accion, idusu);
        });

        $(".posicion_boton_accion_ficha_pago_mes").click(function () { //Actualizar datos en el registro  

            var obr_clv_int = $("#lblobrclvint_x").html();
            var num_ficha_act = $("#lblnumfichaactual").html();                        
            var usuario = $("#bodegadatos").data("idusu");
            var idusu = usuario.split(":")[1];

            GenerarFichasPagoMes(obr_clv_int,idusu, num_ficha_act);
        });

        $(".genera_num_contrato").click(function () { //Actualizar datos en el registro  
            var num_captura = $("#txt_num_contrato").val();
            $("#lblnum_contrato_completo").html(CreaNumeroContrato(num_captura));
        });
        

        $(".asignar_contrato").click(function () { //Actualizar datos en el registro  
            var idcontrato = $("#lstcontratos").val();
            var num_contrato = $("#lstcontratos option:selected").text();

            var mydata = [];

            mydata.push({
                idcont: idcontrato,
                num_cont: num_contrato
            });

            $("#grid_contratos").jqGrid({
                datatype: "local",
                data: '',
                height: 250,
                colNames: ['IdContrato', 'NumContrato'],
                colModel: [
                 { name: 'idcont', index: 'idcont', width: 60, align: "center" },
                 { name: 'num_cont', index: 'num_cont', width: 90, align: "center" }
                ],
                caption: "CONTRATOS ASIGNADOS",
                pager: '#pager_id_contrato', //Pager.                 
                loadtext: 'Cargando datos...',
                recordtext: "{0} - {1} de {2} elementos",
                emptyrecords: 'No hay resultados',
                pgtext: 'Pág:{0} de {1}', //Paging input control text format.
                rowNum: "8", // PageSize.
                rowList: [8], //Variable PageSize DropDownList. 
                viewrecords: true, //Show the RecordCount in the pager.                
                multiselect: false,
                width: "1200",
                height: "100%"
            }).navGrid('#pager_id_contrato', { edit: false, add: false, search: false, del: false, refresh: false });


            var ids = jQuery("#grid_contratos").getDataIDs();
            
            if (ids.length > 0) {                
                var i = 0;
                var encontrado = 0;
                var rowData;
                while (i <= ids.length) {
                    rowId = ids[i];
                    rowData = jQuery("#grid_contratos").jqGrid('getRowData', rowId);
                    if (rowData.idcont == mydata[0].idcont) {
                        encontrado = 1;
                        break;
                    };
                    i = i + 1;
                }
            } else {
                if ($("#bodegadatos").data("quedan_registros")==1) {
                    jQuery("#grid_contratos").jqGrid('navButtonAdd', '#pager_id_contrato', {
                        caption: "QuitarContrato",
                        buttonicon: "ui-icon-document",
                        onClickButton: function () {
                            var myGrid = $("#grid_contratos");
                            selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                            var idcont_sel = myGrid.jqGrid('getCell', selectedRowId, 'idcont');
                            if (idcont_sel) {
                                ids = jQuery("#grid_contratos").getDataIDs();
                                if (ids.length == 1) {
                                    $("#bodegadatos").data("quedan_registros", 0);
                                }
                                jQuery("#grid_contratos").delRowData(selectedRowId);
                            }
                            else {
                                alert("Seleccione el contrato a eliminar...");
                            }
                        },
                        position: "last",
                        title: "Eliminar Contrato",
                        cursor: "pointer"
                    });
                }                
            }

            if (!encontrado) {
                if (ids.length < 4) {
                    jQuery("#grid_contratos").jqGrid('addRowData', mydata[0].idcont, mydata[0]);
                } else {
                    alert('Solo es posible asignar un límite máximo de 4 contratos');
                }
            }

         
        });

        


        function ValidarRegistroObraS(accion, idusu) {

            if (validarObraS(accion)) {   /*Valida que los datos del documento sean correctos incluyendo el archivo capturado sea del tipo PDF y menor a 1 MB*/
                /*Reunir parámetros para guardar el levantamiento capturado en el server*/

                var date = new Date();
                var usuario = parseInt(idusu);

                if (accion == 0) {  /*Alta de nueva obra, escribe una nueva obra*/

                    /*Generar clave de obra*/

                    /*var clave_obra_sifidoc = CompletaCerosIzq($("#lsttipoobra").val(), 2) + CompletaCerosIzq($("#lstprograma").val(), 2);*/



                    /*Layout para PostgresSQL*/
                    var obr_clv_int = 0;   //Antigua clave del SIFIDOC
                    var obr_clv = '0000000000';
                    /*1 var obr_clv = $("#lstobrassifidoc").val();   Clave del SIFIDOC*/
                    /*2*/ var obr_mts = 0;    //Metros totales de la obra (suma de todos los frentes)
                    /*3*/ var obr_cost = parseFloat($("#txtcostoxmto").val());  // Monto del costo del metro
                    /*4*/ var obr_tipo = parseInt($("#lsttipoobra").val()); // Contendra el tipo de obra del catalogo de SGPFIDOC                  
                    /*5*/ var obr_fecha = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());//Fecha en que se da de alta la obra;
                    /*6*/ var obr_cost_total = 0; //Suma total del costo por parte de los ciudadanos de la obra
                    /*7*/ var obr_inc = 0; // Incremento que se realiza a la obra
                    /*8*/ var obr_fecinip = ConvertirCadenaToFecha($("#txtfecinipag").val()); //Fecha inicio de pagos                   
                    /*9*/ var obr_fecvencp = ConvertirCadenaToFecha($("#lblfecvenc").html());  //Fecha de vencimiento de pagos
                    /*10*/var obr_npago = parseInt($("#txtnumpag").val());  //Número de pagos del plazo de promoción.     



                    /*12*/var obr_fec_ini_proc = ConvertirCadenaToFecha('01/01/1900');
                    /*13*/var obr_fec_ini_cob = ConvertirCadenaToFecha('01/01/1900');
                    /*14*/var obr_clv_int = 0; /*Clave principal e la obra*/

                    /*15 var col_clv2 = $("#lstcolonias_s").val();   clave de la colonia catalogo de SIFIDOC*/
                    var col_clv2 = 0

                    /*16*/var obr_prog2 = parseInt($("#lstprograma").val());  // Clave del programa catalogo:  public2.programa
                    /*16*/var obr_programa_sifidoc = $("#lstprograma_s").val();  // Clave del programa catalogo SIFIDOC:  


                    var obr_opergob;
                    var idprog_dos_digitos = CompletaCerosIzq(obr_prog2.toString(), 2);
                    var ano_dos_digigtos = date.getFullYear().toString().substr(2, 2);

                    if (obr_clv == '0000000000') {
                        obr_opergob = '22530 0000 0001 ' + idprog_dos_digitos + ano_dos_digigtos + ' ';  //Cuenta contable generada por el area de contabilidad
                    }
                    else {
                        obr_opergob = '22530 0000 0001 '; //Cuenta contable geenrada por el area de contabilidad
                    }

                    /*17*/var obr_clv2 = obr_clv;
                    var obr_status = '2'
                    /*18var obr_status = parseInt($("#lstestatusobra").val()); // Estatus de obra utilizado en el SIFIDOC*/

                    /*19*/ var obr_oid = parseInt($("#lstubicobra").val());
                    /*20*/ var obr_fec_canc = ConvertirCadenaToFecha('01/01/1900');

                    var obr_ss = '2'
                    /*21 var obr_sis = parseInt($("#lstsistema_s").val());  // Clave del sistema catalogo SIFIDOC:  public2.programa */



                    /*Layout para ACCESS*/

                    /*var obr_call = $("#lblcalle").html();*/

                    var obr_call = '';
                    /*obr_call = obr_call.split(": ")[1].trim();*/

                    var obr_col = ''
                    /*var obr_col = col_clv2.toString();*/

                    var obr_tramo = ''
                    /*var obr_tramo = $("#lbletiquetatramo").html();*/
                    /*obr_tramo = obr_tramo.split(": ")[1].trim();*/

                    var obr_fecha_sifidoc = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();//Fecha en que se da de alta la obra;
                    var obr_stat = obr_status;
                    var obr_int = obr_tipo;
                    var obr_contab = '';
                    var col_nom = $("#lblcolonia").html().split(": ")[1].trim();
                    var obr_digito = '';
                    var obr_cuentac = '';
                    var obr_digagr = '';
                    var obr_fecinip_sifidoc = $("#txtfecinipag").val(); //Fecha inicio de pagos                   
                    var obr_fecvencp_sifidoc = $("#lblfecvenc").html();  //Fecha de vencimiento de pagos
                    var obr_numera = '';




                    RegistrarObraBD_psql(obr_clv_int,
                                    obr_clv,
		                            obr_mts,
		                            obr_cost,
		                            obr_tipo,
		                            obr_fecha,
		                            obr_cost_total,
		                            obr_inc,
                                    obr_fecinip,
		                            obr_fecvencp,
		                            obr_npago,
                                    obr_opergob,
                                    obr_fec_ini_proc,
		                            obr_fec_ini_cob,
                                    col_clv2,
                                    obr_prog2,
                                    obr_clv2,
                                    obr_status,
                                    obr_oid,
                                    obr_fec_canc,
                                    obr_sis,
                                    usuario,
                                    accion)
                    .done(function (r) {
                        var resp = r.d;
                        var mensaje = resp.split(':')[0];
                        alert(mensaje);//No se da de alta en acccess     
                        
                        $('#mask, .window').hide();
                        RedibujarGrid();
                       
                       /* var idobra = parseInt(resp.split(':')[1]);
                        var obr_clv_txt = resp.split(':')[2];
                        var mensaje = resp.split(':')[0];
                        if (idobra) {
                            if (obr_clv == '0000000000') {
                                RegistrarObraBD_access(obr_clv_txt,
                                                 obr_call,
                                                 obr_col,
                                                 obr_mts,
                                                 obr_cost,
                                                 obr_stat,
                                                 obr_int,
                                                 obr_tramo,
                                                 obr_fecha_sifidoc,
                                                 obr_cost_total,
                                                 obr_inc,
                                                 obr_contab,
                                                 obr_sis,
                                                 col_nom,
                                                 obr_digito,
                                                 obr_programa_sifidoc,
                                                 obr_cuentac,
                                                 obr_digagr,
                                                 obr_fecinip_sifidoc,
                                                 obr_fecvencp_sifidoc,
                                                 obr_npago,
                                                 obr_numera,
                                                 obr_opergob + obr_clv_txt.substr(6, 4),
                                                 accion)
                                .done(function (r) {
                                    alert('Obra: ' + obr_clv_txt + ' registrada correctamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                })
                                .fail(function (xhr) {
                                    console.log(xhr.responseText);
                                    alert("No fué posible registrar la obra en ACCESS...");
                                });
                            } else {
                                alert('Obra: ' + obr_clv + ' registrada correctamente');
                                console.log('La obra ' + obr_clv + 'se encontraba registrada en ACCESS');
                                $('#mask, .window').hide();
                                RedibujarGrid();
                            }
                        } else {
                            alert(mensaje);//No se da de alta en acccess                           
                        }
                        */
                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fué posible registrar la obra en PostgresSql...");
                    });
                }


                if (accion == 1) { /*Edición de una obra */

                    /*var obr_clv = $("#lstobrassifidoc"*/
                    /*var obr_clv = */
                    var obr_clv_int = parseFloat($("#lblobr_clv_int").html());
                    var obr_cost = parseFloat($("#txtcostoxmto").val());  // Monto del costo del metro
                    var obr_tipo = parseInt($("#lsttipoobra").val()); // Contendra el tipo de obra del catalogo de SGPFIDOC
                    var obr_inc = 0; // Incremento que se realiza a la obra
                    var obr_fecinip = ConvertirCadenaToFecha($("#txtfecinipag").val()); //Fecha inicio de pagos                   
                    var obr_fecvencp = ConvertirCadenaToFecha($("#lblfecvenc").html());  //Fecha de vencimiento de pagos
                    var obr_npago = parseInt($("#txtnumpag").val());  //Número de pagos del plazo de promoción.                                       
                    var obr_prog2 = parseInt($("#lstprograma").val());  // Clave del programa catalogo:  public2.programa

                    var col_clv2 = $("#lstcolonias_s").val();   //clave de la colonia catalogo de SIFIDOC
                    var obr_programa_sifidoc = $("#lstprograma_s").val();  // Clave del programa catalogo SIFIDOC:                   
                    var obr_sis = parseInt($("#lstsistema_s").val());  // Clave del sistema catalogo SIFIDOC:  public2.programa

                    var obr_fecinip_sifidoc = $("#txtfecinipag").val();
                    var obr_fecvencp_sifidoc = $("#lblfecvenc").html();

                    /*    var obr_opergob;
                        var complem_opergob;
                        if (obr_clv != '0000000000') {
                            complem_opergob = CompletaCerosIzq(obr_programa_sifidoc, 4) + obr_clv.substr(6, 4);                        
                        }
                        else {                        
                            complem_opergob = CompletaCerosIzq(obr_clv_int, 8)                       
                        }
    
                        obr_opergob = '22530 0000 0001 ' + complem_opergob;  //Cuenta contable generada por el area de contabilidad*/


                    var usuario = parseInt(idusu);

                    RegistrarObraBD_psql(obr_clv_int,
                                    '',
		                            0,
		                            obr_cost,
		                            obr_tipo,
		                            ConvertirCadenaToFecha('01/01/1900'),
		                            0,
		                            0,
                                    ConvertirCadenaToFecha($("#txtfecinipag").val()),
		                            ConvertirCadenaToFecha($("#lblfecvenc").html()),
		                            obr_npago,
                                    '',
                                    ConvertirCadenaToFecha('01/01/1900'),
		                            ConvertirCadenaToFecha('01/01/1900'),
                                    col_clv2,
                                    obr_prog2,
                                    obr_clv,
                                    0,
                                    0,
                                    ConvertirCadenaToFecha('01/01/1900'),
                                    obr_sis,
                                    usuario,
                                    accion)
                    .done(function (r) {
                        var resp = r.d;
                        var obr_clv_txt = resp.split(':')[2];
                        RegistrarObraBD_access(obr_clv_txt,
                                              '',
                                              col_clv2,
                                              0,
                                              obr_cost,
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              0,
                                              '',
                                              obr_sis,
                                              '',
                                              '',
                                              obr_programa_sifidoc,
                                              '',
                                              '',
                                              obr_fecinip_sifidoc,
                                              obr_fecvencp_sifidoc,
                                              obr_npago,
                                              '',
                                              '',
                                              accion)
                           .done(function (r) {
                               alert('Obra: ' + obr_clv_txt + ' actualizada correctamente');
                               $('#mask, .window').hide();
                               RedibujarGrid();
                           })
                           .fail(function (xhr) {
                               console.log(xhr.responseText);
                               alert("No fué posible actualizar la obra en ACCESS...");
                           })

                    })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fué posible registrar la obra en PostgresSql...");
                    });

                }

            }

            if (accion == 4) { /*Cambio de estatus de obra de recaudacion a proceso*/

                if (validarObraProc()) {

                  
                    
                    var obr_clv_int_txt = $("#lblobr_clv_int_proc").html();
                    var oid = parseInt($("#lbloid_proc").html());
                   /* var f = new Date();
                    
                    var anio = f.getFullYear();
                    var anio_txt = anio.toString();*/
                    
                    /*var ctacont = '22530 0000 0004 00' + anio_txt.substr(2,2) + ' ';*/
                    
                    var feciniproc = ConvertirCadenaToFecha($("#txtfeciniproc").val());
                    var feciniproc_txt = $("#txtfeciniproc").val();
                    
                    
                    var num_contrato = '';
                    var i = 0;
                    var ids = jQuery("#grid_contratos").getDataIDs();
                    while (i<ids.length) {
                        num_contrato = num_contrato + ids[i] + ',';
                        i = i + 1;
                    }                   
                    var idtipo_recurso_obra = $("#lsttipo_recurso").val();
                    var objObraProc = {      
                        "oid":oid,                
                        "obr_clv_int": parseInt(obr_clv_int_txt),
                        "obra_s":$("#lblobra_s").html(),
                        "fec_ini_proc": ConvertirCadenaToFecha($("#txtfeciniproc").val()),
                        "idtipo_recurso": idtipo_recurso_obra,
                        "descrip":'',
                        "gastos_admvos": parseFloat($("#txtgastos_admvos").val()),                
                        "num_contratos": num_contrato,
                        "idusu": idusu,
                        "fec_mod":ConvertirCadenaToFecha('01/01/1900'),
                        "cactivo":1,
                        "accion": accion
                    }

                    
                        RegistrarIniProcObr_psql(objObraProc)
                         .done(function (r) {
                             alert('La obra seleccionada ha sido cambiada de estatus a PROCESO satisfactoriamente');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         })
                         .fail(function (xhr) {
                             console.log(xhr.responseText);
                             alert("No fué posible cambiar estatus la obra a proceso en postgresSQL...");
                        })
                    

                }
            }


            if (accion == 5) { /*Insercción de datos jurídicos*/

                if (validarObraExpJur()) {

                    var idusu = $("#lblusu_jur1").html();
                    var oid = $("#lbloid_jur1").html();
                    var obr_clv_int = $("#lbl_obr_int_jur1").html();
                    var obr_clv = $("#lbl_obr_int_txt_jur1").html();
                    var obr_estatus = $("#lblestatus_obr_jur1").html();
                    var accion = $("#lblaccion_obr_jur1").html();
                    var obr_costo_total = $("#txtcosto_obra").val();
                    var obr_nat = '';
                    $("input[type=checkbox]").each(function () {
                        if (this.checked) {
                            obr_nat = obr_nat + '1,';
                        }
                        else {
                            obr_nat = obr_nat + '0,';
                        }
                    });

                    var fecpub1 = ConvertirCadenaToFecha($("#txtfecpub1").val());
                    var fecpub2 = ConvertirCadenaToFecha($("#txtfecpub2").val());

                    var file_evidpub1 = $("#evidpub1").get(0).files;
                    var nom_file_pub1 = obr_clv_int + '_evid_pub1.pdf';

                    var file_evidpub2 = $("#evidpub2").get(0).files;
                    var nom_file_pub2 = obr_clv_int + '_evid_pub2.pdf';

                    RegistrarExpJurObr_psql(obr_clv_int, fecpub1, fecpub2, nom_file_pub1, file_evidpub1, nom_file_pub2, file_evidpub2, obr_costo_total, obr_nat, idusu, accion)
                         .done(function (r) {
                             alert('Obra: ' + obr_clv + ' ' + 'Datos juridicos guardados');
                             $('#mask, .window').hide();
                             RedibujarGrid();
                         })
                         .fail(function (xhr) {
                             console.log(xhr.responseText);
                             alert("No fué posible los datos jurídicos de la obra en postgresSQL...");
                         })

                }
            }


            if (accion == 6) { /*Cambio de estatus de obra de proceso a terminada vencida*/

                if (validarObrTerm()) {                    

                    var id_tipo_recurso= parseInt($("#lblid_tipo_recurso").html());                    
                    var fec_ini_cob = $("#lblfecha_inicio_cobranza_capt").html();
                    var oid_in = $("#lbloid_obra_term").html();

                    var objObraTerm = {
                        "obr_oid": parseInt(oid_in),
                        "obr_clv_int": parseInt($("#lblobr_clv_int_obra_term").html()),
                        "obr_fec_ini_cob": ConvertirCadenaToFecha(fec_ini_cob),
                        "id_tipo_recurso": id_tipo_recurso,
                        "evid_termino_obra": '',
                        "idusu": idusu,
                        "accion": accion
                    }                    
                
                    if (confirm("¿Desea aplicar el cambio de estatus PROCESO --> COBRANZA?")) {

                        RegistrarObrTerm_psql(objObraTerm)
                         .done(function (r) {                            
                                 alert('Obra establecida en TERMINADA VENCIDA correctamente');
                                 $('#mask, .window').hide();
                                 RedibujarGrid();                            
                         })
                         .fail(function (xhr) {
                             console.log(xhr.responseText);
                             alert("No fué posible registrar la fecha de termino de la obra en postgresSQL...");
                         })

                    } else {
                        console.log("El usuario no acepto registrar los parámetros de obra en Terminada Vencida");
                    }
                }
            }


        }


        function validarObrTerm() {
            var valid = true;
            
            var fec_obrterm = ConvertirCadenaToFecha($("#lblfeciniproc_obra_term").html());
            var feciniproc = ConvertirCadenaToFecha($("#lblfecha_inicio_cobranza_capt").html());

            if (fec_obrterm >= feciniproc) {
                valid = false;
                alert('Las fecha de término de obra debe ser mayor a la fecha de inicio de proceso de obra');                
            }
            else {
                valid = true;
            }
            return valid;
        }



        function validarObraExpJur() {
            var valid = true;

            var fecinicob = ConvertirCadenaToFecha($("#txtfecpub1").val());
            var feciniproc = ConvertirCadenaToFecha($("#txtfecpub2").val());

            var fecvenp = ConvertirCadenaToFecha($("#bodegadatos").data("fecvenp"));
            var costo_obra = parseFloat($("#txtcosto_obra").val());

            if (fecpub1 < fecvenp && fecpub2 < fecvenp) {
                if (fecpub1 < fecpub2) {
                    if (costo_obra > 0) {
                        valid = true;
                    }
                    else {
                        valid = false;
                        alert('El costo de obra debe ser mayor a 0');
                    }
                }
                else {
                    valid = false;
                    alert('La fecha de publicación 1 no es correcta');
                }
            }
            else {
                valid = false;
                alert('Las fechas son erróneas deben ser menor que la fecha de vencimiento de pagos: ' + $("#bodegadatos").data("fecvenp"));
            }


            if (valid) {
                if ($("#evidpub1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#evidpub1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        valid = valid && true;
                    }
                    else {
                        $("#evidpub1").val("");
                        valid = false;
                    }
                }
                else {
                    if ($("#file_evidpub1").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                        valid = valid && true;
                    }
                    else {
                        alert("No se capturado ningún archivo digital de la Publicación 1");
                        valid = false;
                    }
                }
            }


            return valid;
        }



        function validarObraExpJur() {
            var valid = true;

            var fecpub1 = ConvertirCadenaToFecha($("#txtfecpub1").val());
            var fecpub2 = ConvertirCadenaToFecha($("#txtfecpub2").val());
            var fecvenp = ConvertirCadenaToFecha($("#bodegadatos").data("fecvenp"));
            var costo_obra = parseFloat($("#txtcosto_obra").val());

            if (fecpub1 < fecvenp && fecpub2 < fecvenp) {
                if (fecpub1 < fecpub2) {
                    if (costo_obra > 0) {
                        valid = true;
                    }
                    else {
                        valid = false;
                        alert('El costo de obra debe ser mayor a 0');
                    }
                }
                else {
                    valid = false;
                    alert('La fecha de publicación 1 no es correcta');
                }
            }
            else {
                valid = false;
                alert('Las fechas son erróneas deben ser menor que la fecha de vencimiento de pagos: ' + $("#bodegadatos").data("fecvenp"));
            }


            if (valid) {
                if ($("#evidpub1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#evidpub1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        valid = valid && true;
                    }
                    else {
                        $("#evidpub1").val("");
                        valid = false;
                    }
                }
                else {
                    if ($("#file_evidpub1").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                        valid = valid && true;
                    }
                    else {
                        alert("No se capturado ningún archivo digital de la Publicación 1");
                        valid = false;
                    }
                }
            }

            if (valid) {
                if ($("#evidpub2").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
                    if (ValidarArchivo($("#evidpub2")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                        valid = valid && true;
                    }
                    else {
                        $("#evidpub2").val("");
                        valid = false;
                    }
                }
                else {
                    if ($("#file_evidpub2").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                        valid = valid && true;
                    }
                    else {
                        alert("No se capturado ningún archivo digital de la Publicación 2");
                        valid = false;
                    }
                }
            }

            return valid;
        }






        function validarObraProc() {
            var valid = true;

            var ids = jQuery("#grid_contratos").getDataIDs();
            var fec_ini_proc_txt = $("#txtfeciniproc").val();
            var fec_fin_pag_txt = $("#lblfecfinrec").text();

            var ids = jQuery("#grid_contratos").getDataIDs();

            if (parseFloat($("#txtgastos_admvos").val()) > 0) {
                if (ids.length>0) {
                    var x = ConvertirCadenaToFecha(fec_ini_proc_txt);
                    if (fec_ini_proc_txt!='' || fec_ini_proc_txt.length == 10) {
                        var y = ConvertirCadenaToFecha(fec_fin_pag_txt);
                        if (x > y) {
                            valid = true;
                        }
                        else {
                            valid = false;
                            alert('La fecha de inicio de proceso de la obra debe ser mayor que la fecha de vencimiento de pagos. (' + y + ')');
                        }
                    } else {
                        valid = false;
                        alert('La fecha de inicio de proceso no es correcta');
                    }

                }
                else {
                    valid = false;
                    alert('No se han asignado contratos a la obra');
                }
            }
            else {
                valid = false;
                alert('Lo capturado para los gastos administrativos nos son correctos');
            }

            return valid;
        }



        function RegistrarExpJurObr_psql(obr_clv_int, fecpub1, fecpub2, nom_file_pub1, file_evidpub1, nom_file_pub2, file_evidpub2, obr_costo_obra, obr_nat, idusu, accion) {

            var enviarObj = {
                "obr_clv_int": obr_clv_int,
                "obr_fec_pub1": fecpub1,
                "obr_fec_pub2": fecpub2,
                "evid_pub1": nom_file_pub1,
                "evid_pub2": nom_file_pub2,
                "obr_cost_total": obr_costo_obra,
                "obr_nat": obr_nat,
                "idusu": idusu,
                "accion": accion
            }

            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_PostgresSql",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        var hayarchivo1 = file_evidpub1.length;
                        var hayarchivo2 = file_evidpub2.length;
                        if (hayarchivo1 > 0) {
                            ValidacionGuardadoArchivo(file_evidpub1, nom_file_pub1);
                        }
                        else {
                            alert('No registra archivo de evidencia de publicación 1');
                        }
                        if (hayarchivo2 > 0) {
                            ValidacionGuardadoArchivo(file_evidpub2, nom_file_pub2);
                        }
                        else {
                            alert('No registra archivo de evidencia de publicación 2');
                        }
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };


        function RegistrarObrTerm_psql(objObraTerm) {

            var stringData = JSON.stringify(objObraTerm);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_PostgresSql",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {                        
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };



        function RegistrarObrTerm_access(obr_clv, obr_fecinicob, obr_estatus_act, obr_opergob, idusu, accion) {

            var enviarObj = {
                "obr_clv": obr_clv,
                "obr_fecinicob": obr_fecinicob,
                "obr_stat": 'F', /*18/11/2022 Se deja el valor de F debido a que duplica en la tabla obrah el registro de una obra en terminada vencida y afecta la generación de Cartera Vencida*/
                "obr_est_act": obr_estatus_act,
                "obr_opergob": obr_opergob,
                "obr_usuario": idusu,
                "accion": accion
            }

            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_Access",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };


        function RegistrarIniProcObr_psql(objObraProc) {

            var enviarObj = objObraProc;

            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObraProc_PostgresSql",
                data: "{objObraProc:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {                    
                        console.log(data.d);                    
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };

        function RegistrarInicProcObr_access(obr_clv_int_txt,
                                            ctacont,
                                            feciniproc_txt,
                                            obr_estatus,
                                            estatus_actual,
                                            usuario,
                                            accion) {

            var enviarObj = {
                "obr_clv": obr_clv_int_txt,
                "obr_opergob": ctacont,
                "obr_feciniproc": feciniproc_txt,
                "obr_stat": obr_estatus,
                "obr_est_act": estatus_actual,
                "obr_usuario": usuario,
                "accion": accion
            }


            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_Access",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };



        function RegistrarObraBD_psql(obr_clv_int,
                                  obr_clv,
		                         obr_mts,
		                         obr_cost,
		                         obr_tipo,
		                         obr_fecha,
		                         obr_cost_total,
		                         obr_inc,
                                 obr_fecinip,
		                         obr_fecvencp,
		                         obr_npago,
                                 obr_opergob,
                                 obr_fec_ini_proc,
		                         obr_fec_ini_cob,
                                 col_clv2,
                                 obr_prog2,
                                 obr_clv2,
                                 obr_status,
                                 obr_oid,
                                 obr_fec_canc,
                                 obr_sis,
                                 idusu,
                                 accion) {

            var enviarObj = {
                "obr_clv_int": obr_clv_int,
                "obr_clv": obr_clv,
                "obr_mts": obr_mts,
                "obr_cost": obr_cost,
                "obr_tipo": obr_tipo,
                "obr_fecha": obr_fecha,
                "obr_cost_total": obr_cost_total,
                "obr_inc": obr_inc,
                "obr_fecinip": obr_fecinip,
                "obr_fecvencp": obr_fecvencp,
                "obr_npago": obr_npago,
                "obr_opergob": obr_opergob,
                "obr_fec_ini_proc": obr_fec_ini_proc,
                "id_tipo_recurso": 0,
                "obr_fec_ini_cob": obr_fec_ini_cob,
                "col_clv2": col_clv2,
                "obr_prog2": obr_prog2,
                "obr_clv2": obr_clv2,
                "obr_status": obr_status,
                "obr_oid": obr_oid,
                "obr_fec_canc": obr_fec_canc,
                "obr_sis": obr_sis,
                "idusu": idusu,
                "accion": accion
            }




            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_PostgresSql",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };

        function RegistrarObraBD_access(obr_clv,
                                        obr_call,
                                        obr_col,
                                        obr_mts,
                                        obr_cost,
                                        obr_stat,
                                        obr_int,
                                        obr_tramo,
                                        obr_fecha,
                                        obr_costo_total,
                                        obr_inc,
                                        obr_contab,
                                        obr_sis,
                                        col_nom,
                                        obr_digito,
                                        obr_programa,
                                        obr_cuentac,
                                        obr_digagr,
                                        obr_fecinip,
                                        obr_fecvenp,
                                        obr_npago,
                                        obr_numera,
                                        obr_opergob,
                                        accion) {

            var enviarObj = {
                "obr_clv": obr_clv,
                "obr_call": obr_call,
                "obr_col": obr_col,
                "obr_mts": obr_mts,
                "obr_cost": obr_cost,
                "obr_stat": obr_stat,
                "obr_int": obr_int,
                "obr_tramo": obr_tramo,
                "obr_fecha": obr_fecha,
                "obr_costo_total": obr_costo_total,
                "obr_inc": obr_inc,
                "obr_contab": obr_contab,
                "obr_sis": obr_sis,
                "col_nom": col_nom,
                "obr_digito": obr_digito,
                "obr_programa": obr_programa,
                "obr_cuentac": obr_cuentac,
                "obr_digagr": obr_digagr,
                "obr_fecinip": obr_fecinip,
                "obr_fecvenp": obr_fecvenp,
                "obr_npago": obr_npago,
                "obr_numera": obr_numera,
                "obr_opergob": obr_opergob,
                "accion": accion
            }




            var stringData = JSON.stringify(enviarObj);
            return $.ajax({
                type: 'POST',
                url: "../../WebServices/WebServiceObras.asmx/RegObra_Access",
                data: "{objObraS:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json',
                success: function (data) {
                    if (data.d != null) {
                        console.log(data.d);
                    }
                },
                error: function (responseText, textStatus, errorThrown) {
                    alert(textStatus + responseText + errorThrown);
                }
            });

        };

        $(".verarchivo").click(function (e) { //Ver documento                   
            var archivo = $("#archivo").text();
            leerArchivo(archivo);
        });

        $(".verarchivo_file_evidpub1").click(function (e) { //Ver documento                   
            var archivo = $("#file_evidpub1").text();
            leerArchivo(archivo);
        });

        $(".verarchivo_file_evidpub2").click(function (e) { //Ver documento                   
            var archivo = $("#file_evidpub2").text();
            leerArchivo(archivo);
        });



        $(".posicion_boton_cancelar_obraS").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
            $('#mask, .window').hide();
        });

        $(".posicion_boton_cancelar_obra_proc").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
            $('#mask, .window').hide();
        });


        $(".posicion_boton_cancelar_obra_jur1").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
            $('#mask, .window').hide();
        });

        $(".posicion_boton_cancelar_obra_term").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
            $('#mask, .window').hide();
        });


        $(".posicion_boton_cancelar_ficha_pago_mes").click(function (e) {
            //Cancel the link behavior
            //e.preventlogin();
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



        $('.dato_captura_float').keyup(function () {

            var preg = /^([0-9]+\.?[0-9]{0,2})$/;
            if (preg.test(this.value) === false) {
                this.value = '';
            }
        });


    });

    function leerArchivo(nom_archivo) {
        var url = "../../temp/" + nom_archivo;
        window.open(url, '_blank', 'toolbar=0');
    }


    function AccionRegistroObra(objObra) { // accion=0 --->nuevo registro; accion = 1 ---> editar registro, accion = -1 ----> cancelar registro


        var date = new Date();
        obr_fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();

        //Preparación de interfaz para dar de alta la obra.  accion ==0
        var usuario = $("#bodegadatos").data("idusu");
        $("#lblidusu").html(usuario);

        if (objObra.accion == 0) {  //Si la accion es crear una nueva obra en recaudación


            $("#lblaccionobraS").text(objObra.accion);
            $("#lblobr_clv_int").html(objObra.obr_clv_int.toString());


            $("#txtcalle").val('');
            $("#txttramolim1").val('');
            $("#txttramolim2").val('');
            $("#txtnumpag").val('');
            $("#lblfecvenc").html('');
            $("#txtfecinipag").val('01/01/1900');
            $("#txtcostoxmto").val('');
            llenarPrograma(objObra.accion, 0);

            /*llenarObrasSIFIDOC(objObra.obr_clv);*/
            
            llenarTipoObra(objObra.accion, 0);
            llenarUbicObra(objObra.accion, 0);
            llenarEstatusObra('infestatusobra', 2);
            $('#lstestatusobra').prop('disabled', 'false')

            MostrarModalObraS();

        }


        if (objObra.accion == 1) {  /*Si la accion es editar una obra en recaudación, solo se podrá editar:
            costo_metro, 
            programa SGPFDIOC, 
            programa SIFIDOC,
            sistema_SIFIDOC,
            tipo_obra,
            fecha_inicio_pagos,
            fecha_venc_pagos,
            numero de pagos
            */

            $("#lblaccionobraS").text(objObra.accion);
            $("#lblobr_clv_int").html(objObra.obr_clv_int.toString());

            //Preparación de interfaz para editar la obra.  accion ==1
            var usuario = $("#bodegadatos").data("idusu");
            $("#lblidusu").html(usuario);

            llenarUbicObra(objObra.accion, parseInt(objObra.obr_oid));
            /*llenarObrasSIFIDOC(objObra.obr_clv);*/
            llenarEstatusObra('infestatusobra', 2);
            /*$("#lstobrassifidoc").prop('disabled', 'false');*/

            $('#lstestatusobra').prop('disabled', 'false');
            /*$("#lstobrassifidoc").val(objObra.obr_clv);*/
            $("#lblfecvenc").text(objObra.obr_fecvencp);
            $("#txtfecinipag").val(objObra.obr_fecinip);
            $("#txtcostoxmto").val(objObra.obr_cost);
            $("#txtnumpag").val(objObra.obr_npago);

            llenarPrograma(objObra.accion, objObra.obr_prog2);
            llenarTipoObra(objObra.accion, objObra.obr_int);

            MostrarModalObraS();

        }

        if (objObra.accion == 4) {

            $("#lblnomcalle").text(objObra.Calle);
            $("#lblnomcolonia").html(objObra.Colonia);
            $("#lblnomtramo").html(objObra.Tramo);
            $("#lblprog").html(objObra.Prog);
            $("#lblestatus_obra").html(objObra.EstObra);
            $("#lblaccion_proc").html(objObra.accion);            
            $("#lblfecinirec").html(objObra.FecIniPag);
            $("#lblfecfinrec").html(objObra.FecVenP);
            $("#lblidusu_proc").html(objObra.idusu);
            $("#lblctacontable_proc").html(objObra.obr_opergob);
            $("#lbltipo_obra").html(objObra.TipoObra);
            $("#lbloid_proc").html(objObra.oid);
            $("#lblobra_s").html(objObra.Obra);
            $("#lblobr_clv_int_proc").html(objObra.ClvObra);           
            $("#txtnum_contrato").val(objObra.no_contrato);
            $("#lblestact").html(objObra.obr_estatus);
            $("#doc_obr_proc").val('');
            $("#bodegadatos").data("quedan_registros", 1);
            llenarContratos(0, 1);

        }

        if (objObra.accion == 5) {  /*Si la accion es capturar los datos jurídicos de la obra*/


            $("#lblaccionobraS").text(objObra.accion);
            $("#lblobr_clv_int").html(objObra.obr_clv_int.toString());

            $("#lblusu_jur1").html(objObra.idusu);
            $("#lbloid_jur1").html(objObra.obr_oid);
            $("#lbl_obr_int_jur1").html(objObra.obr_clv_int);
            $("#lbl_obr_int_txt_jur1").html(objObra.obr_clv);
            $("#lblestatus_obr_jur1").html(objObra.obr_estatus);
            $("#lblaccion_obr_jur1").html(objObra.accion);
            $("#txtcosto_obra").val(objObra.obr_costo_total);
            var obr_nat = objObra.obr_nat.split(",");
            $("#chkBanq").prop('checked', parseInt(obr_nat[0]));
            $("#chkPav").prop('checked', parseInt(obr_nat[1]));
            $("#chkAtarj").prop('checked', parseInt(obr_nat[2]));
            $("#chkRed").prop('checked', parseInt(obr_nat[3]));
            $("#chkAlum").prop('checked', parseInt(obr_nat[4]));
            $("#chkDren").prop('checked', parseInt(obr_nat[5]));
            $("#chkVias").prop('checked', parseInt(obr_nat[6]));
            $("#chkJard").prop('checked', parseInt(obr_nat[7]));

            $("#txtfecpub1").val(objObra.fecjur1);
            $("#txtfecpub2").val(objObra.fecjur2);

            $("#file_evidpub1").text(objObra.evidjur1);
            $("#file_evidpub2").text(objObra.evidjur2);


            $("#evidpub1").val('');
            $("#evidpub2").val('');


            MostrarModalObraExpJur();

        }

        

        if (objObra.accion == 6) {  /*Si la accion es capturar los datos jurídicos de la obra*/
                        
            $("#lblcalle_obra_term").html(objObra.Calle);
            $("#lblcolonia_obra_term").html(objObra.Colonia);
            $("#lbltramo_obra_term").html(objObra.Tramo);
            $("#lblfeciniproc_obra_term").html(objObra.FecIniProc);
            $("#txtfeciniterm_obra_term").html(objObra.FecIniCob);
            $("#carta_term").text(objObra.EvidTermObr);
            $("#lbloid_obra_term").html(objObra.oid);
            $("#lblid_tipo_recurso").html(objObra.IdTipoRecurso);
            $("#lblobr_clv_int_obra_term").html(objObra.ClvObra);
            $("#lblobra_s_obra_term").html(objObra.Obra);
            $("#lblcta_cont_obra_term").html(objObra.obr_opergob);
            $("#lblidusu_obra_term").html(usuario);
            $("#lblaccion_obra_term").html('6');
            $("#lblfecha_inicio_cobranza_capt").html('01/01/1900');
            

            
            RelacionarContratoAnexos(usuario, objObra.ClvObra + ',');
        }

    }


    function ConsultaObraProc(objObra) {
        var stringData = JSON.stringify(objObra);
        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceObras.asmx/GetObra_obr_clv_int",
            data: "{'accion':'" + objObra.accion + "','obr_clv_int':'" + objObra.obr_clv_int + "'}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    console.log(data.d);
                }
            },
            error: function (responseText, textStatus, errorThrown) {
                alert(textStatus + responseText + errorThrown);
            }
        });
    }




    function ConvertirCadenaToFecha(cadenafec) {
        if (cadenafec != "") {
            var from = cadenafec.split("/");
            var from2 = from[2].split(" ");
            var fecha = new Date(from2[0], from[1] - 1, from[0]);
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




    function validarObraS(accion) {
        var valid = true;
        if (accion == 0 || accion == 1) { /*Si el usuario escogió dar de alta una nueva obra*/


            if (isDate($("#txtfecinipag").val())) {
                var fecinipag = ConvertirCadenaToFecha($("#txtfecinipag").val());
                if (fecinipag > ConvertirCadenaToFecha('01/01/1900')) {   /*Validación de fechas*/

                    valid = valid && true;

                }
                else {
                    alert('La fecha de inicio de pagos no es válida');
                    valid = false;
                }
            }
            else {
                alert('La fecha de inicio de pagos no es válida');
                valid = false;
            }

            if ($("#lblcalle").html() == '*Calle: ') {
                alert('Falta determinar el nombre de la CALLE de la obra');
                valid = false;
            }

            if ($("#lblcolonia").html() == '*Colonia: ') {
                alert('Falta determinar el nombre de la COLONIA de la obra');
                valid = false;
            }

            if ($("#lbletiquetatramo").html() == '*Tramo: ') {
                alert('Falta determinar el TRAMO de la obra');
                valid = false;
            }


            valid = valid && checkRegexp($("#txtnumpag").val(), /^[1-9]{1,3}$/, "El número de pagos debe ser número entero");
            valid = valid && checkRegexp($("#txtcostoxmto").val(), /\d+(.\d+)?/, "Valor de metro lineal erróneo, capturar nuevamente");
        }


        if (accion == 6) {

        }

        return valid;
    }


    function InsertaRegDcto(idsol, iddcto, idpresup, folioDcto, hoy, hoy, idusuario, nomarchivo, tipodcto, nomusuario, hoy, nomusuario, hoy, archivo, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


        var enviarObj = {
            "idsol": idsol,
            "iddcto": iddcto,
            "idref": idpresup,
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
            "accion": accion
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

    /* function RevisaEstatusPresup(idpresup) {
 
         return $.ajax({
             type: 'POST',
             url: "../../WebServices/WebServicePresup.asmx/GetEstatusPresup",
             data: "{idpresup:" + idpresup + "}",
             contentType: 'application/json; utf-8',
             dataType: 'json',
             error: function (jqXHR, textStatus, errorThrown) {
                 alert(textStatus + jqXHR + errorThrown);
             }
         });
 
     };*/


    function ValidacionGuardadoArchivo(archivo, nomarchivo) {
        GuardarArchivo(archivo, nomarchivo)
        .done(function (result) {
            console.log("El archivo fue guardado correctamente")
        }).fail(function (result) {
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


    function MostrarModalObraS() {
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
        $("#dialogoobraS").css('top', winH / 2 - $("#dialogoobraS").height() / 2);
        $("#dialogoobraS").css('left', winW / 2 - $("#dialogoobraS").width() / 2);

        //transition effect
        $("#dialogoobraS").fadeIn(2000);
    }

    function MostrarModalFichaPagoMes() {
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
        $("#dialogofichapagomes").css('top', winH / 2 - $("#dialogofichapagomes").height() / 2);
        $("#dialogofichapagomes").css('left', winW / 2 - $("#dialogofichapagomes").width() / 2);

        //transition effect
        $("#dialogofichapagomes").fadeIn(2000);
    }


    function MostrarModalObraProc() {
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
        $("#dialogoobraproc").css('top', winH / 2 - $("#dialogoobraproc").height() / 2);
        $("#dialogoobraproc").css('left', winW / 2 - $("#dialogoobraproc").width() / 2);

        //transition effect
        $("#dialogoobraproc").fadeIn(2000);
    }

    function MostrarModalObraExpJur() {
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
        $("#dialogoobrajur1").css('top', winH / 2 - $("#dialogoobrajur1").height() / 2);
        $("#dialogoobrajur1").css('left', winW / 2 - $("#dialogoobrajur1").width() / 2);

        //transition effect
        $("#dialogoobrajur1").fadeIn(2000);
    };

    function MostrarModalObraTerm() {
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
        $("#dialogo_obrterm").css('top', winH / 2 - $("#dialogo_obrterm").height() / 2);
        $("#dialogo_obrterm").css('left', winW / 2 - $("#dialogo_obrterm").width() / 2);

        //transition effect
        $("#dialogo_obrterm").fadeIn(2000);
    };





    /*  function llenarUsuario(idusu) {
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
      }*/

    function llenarPrograma(accion, idprog) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePrograma.asmx/GetProg",
            data: "{'accion':'" + accion + "','idprog':'" + idprog + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lstprograma").html('');
                $(data.d).find("Prog").each(function () {
                    var option = $(document.createElement('option'));
                    var idprog = $(this).find("idprogr").text();
                    var descripprog = $(this).find("nomprogr").text();
                    option.html(descripprog);
                    option.val(idprog);
                    //Nombre de combo a poblar
                    $("#lstprograma").append(option);
                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                });
                if (idprog != '') {
                    $("#lstprograma").val(idprog);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }




    function llenarPrograma_SIFIDOC(obr_programa) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePrograma.asmx/GetProgramaSIFIDOC",
            success: function (data) {
                var elementos = 0;
                $("#lstprograma_s").html('');
                $(data.d).find("programa_sifidoc").each(function () {
                    var option = $(document.createElement('option'));
                    var clvprograma = $(this).find("pro_clv").text();
                    var nomprog = $(this).find("pro_nom").text();
                    option.html(nomprog);
                    option.val(clvprograma);
                    $("#lstprograma_s").append(option);
                });
                if (obr_programa != '') { //
                    $("#lstprograma_s").val(obr_programa);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }

    function llenarSistema_SIFIDOC(obr_sis) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePrograma.asmx/GetSistemaSIFIDOC",
            success: function (data) {
                var elementos = 0;
                $("#lstsistema_s").html('');
                $(data.d).find("sistema_sifidoc").each(function () {
                    var option = $(document.createElement('option'));
                    var clvsis = $(this).find("sis_clv").text();
                    var nomsis = $(this).find("sis_nom").text();
                    option.html(nomsis);
                    option.val(clvsis);
                    $("#lstsistema_s").append(option);
                });
                if (obr_sis != '') { //
                    $("#lstsistema_s").val(obr_sis);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }


    function llenarTipoObra(accion, tipoobra) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceTipoObra.asmx/GetTipoObra",
            data: "{'accion':'" + accion + "','tipoobra':'" + tipoobra + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lsttipoobra").html('');
                $(data.d).find("tipoobra").each(function () {
                    var option = $(document.createElement('option'));
                    var idtipoobra = $(this).find("clv_tipo_obrr").text();
                    var descriptipoobra = $(this).find("descrip_tipo_obrr").text();
                    option.html(descriptipoobra);
                    option.val(idtipoobra);
                    //Nombre de combo a poblar
                    $("#lsttipoobra").append(option);
                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                });
                if (tipoobra != '') {
                    $("#lsttipoobra").val(tipoobra);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }

    /* function llenarOpcionPredioMunicipal(accion, opcinicial) {
 
         $("#lstpredmunic").html('');
         var prediosmunicip = [
               { "id": "1", "descrip": "Existen predios municipales" },
               { "id": "2", "descrip": "No existen predios municipales" }];
         
             for (var i = 0; i < prediosmunicip.length; i++) {                
                 var option = $(document.createElement('option'));
                 option.html(prediosmunicip[i].descrip);
                 option.val(prediosmunicip[i].id);
                 $("#lstpredmunic").append(option);
             }
             if (opcinicial > 1) { /*Se requiere editar los datos de la obra*/

    /*}*/


    function llenarUbicObra(accion, oid) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceObras.asmx/GetUbics",
            data: "{'accion':'" + accion + "','oid':'" + oid + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lstubicobra").html('');
                $(data.d).find("oids").each(function () {
                    var option = $(document.createElement('option'));
                    var oid = $(this).find("oidr").text();
                    option.html(oid);
                    option.val(oid);
                    //Nombre de combo a poblar
                    $("#lstubicobra").append(option);
                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.                    
                });
                if (oid > 0) {
                    $("#lstubicobra").val(oid);
                    $('#lstubicobra').prop('disabled', 'false')
                } else {
                    $('#lstubicobra').removeAttr('disabled');
                }

                consulta_oid($("#lstubicobra").val());


            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }


    function llenarEstatusObra(accion, idestatusobrainicial) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceEstatusObra.asmx/GetEstatusObra",
            data: "{'accion':'" + accion + "','idestatusobra':'" + idestatusobrainicial + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lstestatusobra").html('');
                $(data.d).find("EstObra").each(function () {
                    var option = $(document.createElement('option'));
                    var idestatusobra = $(this).find("cidestatusobrar").text();
                    var estatusobra = $(this).find("cestatusr");
                    option.html(estatusobra);
                    option.val(idestatusobra);
                    //Nombre de combo a poblar
                    $("#lstestatusobra").append(option);
                    elementos = elementos + 1; //aqui se cuenta el numero de elementos que se cargan al combo, en otro lugar no lo contempla.
                });
                if (accion == 'infestatusobra') {
                    $("#lstestatusobra").val(idestatusobrainicial);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }


    function llenarColonias(idcolonia) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceCalCol.asmx/GetColoniasS",
            data: "{'idcolonia':'" + idcolonia + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lstcolonias").html('');
                $(data.d).find("colonia").each(function () {
                    var option = $(document.createElement('option'));
                    var clvcolonia = $(this).find("col_clv2r").text();
                    var colnom = $(this).find("col_nomr").text();
                    option.html(colnom);
                    option.val(clvcolonia);
                    $("#lstcolonias").append(option);
                });
                if (idcolonia > 0) { //
                    $("#lstcolonias").val(idcolonia);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }

    function llenarColonias_SIFIDOC(obr_col) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceCalCol.asmx/GetColoniasSIFIDOC",
            success: function (data) {
                var elementos = 0;
                $("#lstcolonias_s").html('');
                $(data.d).find("colonias_sifidoc").each(function () {
                    var option = $(document.createElement('option'));
                    var clvcolonia = $(this).find("col_clv").text();
                    var colnom = $(this).find("col_nom").text();

                    option.html(colnom);
                    option.val(clvcolonia);
                    $("#lstcolonias_s").append(option);
                });
                if (obr_col != '') { //
                    $("#lstcolonias_s").val(obr_col);
                }
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }

    function llenarObrasSIFIDOC(obr_clv) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceObras.asmx/GetObrasSIFIDOC",
            success: function (data) {
                var elementos = 0;
                $("#lstobrassifidoc").html('');
                $(data.d).find("obras_sifidoc").each(function () {
                    var option = $(document.createElement('option'));
                    var obr_clv = $(this).find("obr_clv").text();
                    var obr_call = $(this).find("obr_call").text();
                    var obr_tramo = $(this).find("obr_tramo").text();

                    option.html(obr_call + '     |%|     ' + obr_tramo + '     |%|     ' + obr_clv);
                    option.val(obr_clv);
                    $("#lstobrassifidoc").append(option);
                });
                var option_adicional = $(document.createElement('option'));
                option_adicional.html('Nueva OBRA');
                option_adicional.val('0000000000');
                $("#lstobrassifidoc").append(option_adicional);

                if (obr_clv != '0000000000') {
                    llenaParametrosSIFIDOC(obr_clv);
                }
                else {
                    llenarSistema_SIFIDOC(0);
                    llenarPrograma_SIFIDOC(0);
                    llenarColonias_SIFIDOC(0);
                }

                $("#lstobrassifidoc").val(obr_clv);

            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }



    function llenarContratos(idcontrato,idaccion) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceContrato.asmx/GetContrato_q",
            data: "{'idcontrato':'" + idcontrato + "','idaccion':'" + idaccion + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lstcontratos").html('');
                $(data.d).find("contratos").each(function () {
                    var option = $(document.createElement('option'));
                    var idcontrato = $(this).find("idcontrato_r").text();
                    var num_contrato = $(this).find("num_contrato_limpio_r").text();
                    var rfc_contratista = $(this).find("rfc_contratista_r").text();
                    option.html(num_contrato);
                    option.val(idcontrato);
                    $("#lstcontratos").append(option);
                });                

                var num_contratos = $("#lstcontratos").children().length;
                if (num_contratos<=0) {
                    alert('No existen contratos capturados, por lo tanto no es posible establecer la obra en estatus de PROCESO.');
                } else {
                    $.jgrid.gridUnload("#grid_contratos");
                    llenarTipoRecurso(0);
                    MostrarModalObraProc();
                }

            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }
    

    function llenarTipoRecurso(idtipo_recurso) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceTipoRecursoObra.asmx/GetTipoRecurso",
            data: "{'idtiporecurso':'" + idtipo_recurso + "'}",
            success: function (data) {
                var elementos = 0;
                $("#lsttipo_recurso").html('');
                $(data.d).find("tipo_recurso").each(function () {
                    var option = $(document.createElement('option'));
                    var idtiporecurso = $(this).find("idtipo_recurso_r").text();
                    var nom_tipo_recurso = $(this).find("descrip_r").text();
                    
                    option.html(nom_tipo_recurso);
                    option.val(idtiporecurso);
                    $("#lsttipo_recurso").append(option);
                });

            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }



    function llenaParametrosSIFIDOC(obr_clv) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceObras.asmx/GetObraSIFIDOC",
            data: "{'obr_clv':'" + obr_clv + "'}",
            success: function (data) {
                var elementos = 0;
                $(data.d).find("obra_sifidoc").each(function () {
                    var obr_col = $(this).find("obr_col").text();
                    var obr_programa = $(this).find("obr_programa").text();
                    var obr_sistema = $(this).find("obr_sis").text();
                    llenarSistema_SIFIDOC(obr_sistema);
                    llenarPrograma_SIFIDOC(obr_programa);
                    llenarColonias_SIFIDOC(obr_col);
                });
            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }




    function consulta_oid(val) {
        if (val > 0) {
            var accion = 0;
            $.ajax({
                url: "../../WebServices/WebServiceObras.asmx/GetObra_oid",
                data: "{'accion':'" + accion + "','oid':'" + val + "'}",
                type: "POST",
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    $(data.d).find("oid_p").each(function () {
                        var oid = $(this).find("oidr").text();
                        var colonia = $(this).find("coloniar").text();
                        var calle = $(this).find("caller").text();
                        var tramo = $(this).find("tramor").text();
                        var limite1 = $(this).find("limite1r").text();
                        var limite2 = $(this).find("limite2r").text();
                        $("#lblcalle").css("background", "white");
                        $("#lblcolonia").css("background", "white");
                        $("#lbletiquetatramo").css("background", "white");
                        $("#lbltramolim1").css("background", "white");
                        $("#lbltramolim2").css("background", "white");

                        $("#lblcalle").html('*Calle: ' + calle);
                        $("#lblcolonia").html('*Colonia: ' + colonia);
                        $("#lbletiquetatramo").html('*Tramo: ' + tramo);
                        $("#lbltramolim1").html('*Límite 1: ' + limite1);
                        $("#lbltramolim2").html('*Límite 2: ' + limite2);
                    });
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }

            });
        }
    }


    function ActualizarPagosCoop(pagos) { /**/

        var pagos_correcto = pagos.substr(0, pagos.length - 1);

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceCoop.asmx/ActPagosCoop",
            data: 'pagos=' + pagos_correcto,
            sucess: function (data) {
                if (data.d != null) {
                    consolo.log("Pagos actualizados correctamente en PostgresSQL")
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }



    function ActualizacionPagosCoop(fid, obr_clv_int, obr_clv_txt, coo_clv, idusu) {

        /*var sentecia_inserccion_pagos_coop = 'insert into pagos_temp (elemento,mov_obra_sifidoc,mov_coop_sifidoc,fec_mov_as400,usu_fidoc,monto_abono_sifidoc,fec_aplic_mov,clave_sifidoc,fid,uscre,folio_pago,coo_clv2,obr_clv_int,mov_activo) values (';*/
        var sentecia_inserccion_pagos_coop = '';
        var sentencia = '';


        var date = new Date();
        obr_fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();

        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceCoop.asmx/GetPagosCoopSIFIDOC",
            data: "{'coo_clv':'" + obr_clv_txt + coo_clv + "'}",
            success: function (data) {
                var elementos = 0;
                if (data.d != '<NewDataSet />') { /*Existen pagos*/
                    $(data.d).find("pagos_coops_sifidoc").each(function () {

                        var coop = $(this).find("mov_clv1").text();
                        var idpago = $(this).find("mov_ndep").text();
                        var fec_cap_pag = $(this).find("mov_fecha_cap").text();
                        var monto = $(this).find("mov_cap").text();
                        var fec_pago = $(this).find("mov_fecha").text();
                        var id_mov_sifidoc = $(this).find("ID").text();
                        var usu_sifidoc = $(this).find("mov_usu").text();
                        var datos = '(\'\',\'' + obr_clv_txt + '\',\'' + coo_clv + '\',\'' + fec_pago + '\',\'' + usu_sifidoc + '\',' + monto + ',1' + ',\'' + obr_fecha_hoy + '\',\'' + obr_clv_txt + coo_clv + '\',' + fid + ',\'' + idusu + '\',\'' + idpago + '\',' + id_mov_sifidoc + ',' + obr_clv_int + ',1),'
                        sentencia = datos + sentencia;
                        datos = '';
                    });

                    if (sentencia != '') {
                        ActualizarPagosCoop(sentencia)
                             .done(function (result) {
                                 alert("Pagos actualizados correctamente en PostgresSQL")
                             }).fail(function (result) {
                                 alert("No fue posible actualizar los pagos: " + result.responseText);
                             });
                    }

                }
                else {
                    alert('No existen pagos registrados del frente:' + fid + ', cooperador:' + obr_clv_txt + coo_clv);
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
    <div id="bodegadatos"></div>
         
<label>Nombre de Calle:</label><input type="text" name="calle" id="txtnomcalle" style="width:250px" maxlength ="120"/><br/><br/>        
<label>ClvObra (SGPFIDOC):</label><input type="text" name="obr_clv_int" id="txtclvsgp" style="width:250px" maxlength ="10"/><br/><br/>        
<label>Obra (SIFIDOC):</label><input type="text" name="obra" id="txtnumobra" style="width:250px" maxlength="10"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="buscar_obra"><== Buscar obra ==></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_obra"><== Alta obra ==></a><br/><br/>
 
<table id="grid"></table>
<div id="pager"></div>&nbsp       
 
<div id="boxes">        
    <div id="dialogoobraS" class="window"> 
       <div id="tituloobraS"> 
         <p style="text-align:center">GESTION DE OBRA</p>
         Usuario: <label for="idusu" id="lblidusu"></label><br/> 
         IdObra: <label for="obr_clv_int" id="lblobr_clv_int"></label><br/> 
         Acción:<label for="accion" id="lblaccionobraS"></label><br/> 
       </div>
       <div class="datos" id="bodyobraS">      
          <br/>             
          <br/>             
          <label for="name" id="lblubic">*OID:</label><select name="ubicobra" id="lstubicobra" onchange="consulta_oid(this.value)"></select><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblcalle">*CALLE:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblcolonia">*COLONIA:</label><br/><br/> 
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbletiquetatramo">*TRAMO:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbltramolim1">*Limite 1 del TRAMO:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbltramolim2">*Limite 2 del TRAMO:</label><br/><br/>                
         

          <label for="name" id="lbltipoobra">*Tipo de Obra:</label><select name="tipoobra" id="lsttipoobra"></select><br/><br/>
          <label for="name" id="lblprograma">*Programa (SGPFIDOC):</label><select name="programa" id="lstprograma"></select><br/><br/>
          <label for="name">*Costo x Mto. Lineal:</label><input type="text" name="costoxmto" id="txtcostoxmto" class="numbersOnly" size="6" maxlength="8"/><br/><br/>
          <label for="name" id="lblfecinipag">*Fecha de Inicio de Pagos (dd/mm/aaaa):</label><input type="text" name="fecinipag" id="txtfecinipag" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);" onblur="FechaVencPagos(txtnumpag.value)"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lblnumpagos">*Número de Pagos:</label><input type="text"  size="6" maxlength="5" id="txtnumpag" name="numpag" onkeyup="FechaVencPagos(this.value)"/><br/><br/>
          <label for="name" id="llfecven1">Fecha de vencimiento de pagos (dd/mm/aaaa):</label><label for="name" id="lblfecvenc"></label><br/><br/>          
          
          <label for="name" id="lblestatusobra">Estatus de Obra:</label><select name="estatusobra" id="lstestatusobra"></select><br/><br/>
       </div>                  
       <div class="botonesA" id="botonesC">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_obraS">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_obraS">Cancelar</a></p>                
       </div>
    </div>     
    <div id="dialogoobraproc" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="6" class="titulo_modulo">CAMBIAR DE ESTATUS DE OBRA DE  PROCESO</td>
              </tr>   
              <tr>
                  <td class="f">CALLE:</td>
                  <td class="e" colspan="5"><label id="lblnomcalle"/></td>
              </tr>
              <tr>
                  <td class="f">COLONIA:</td>
                  <td class="e" colspan="5"><label id="lblnomcolonia"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td class="e" colspan="5"><label id="lblnomtramo"/></td>
              </tr>
              <tr>
                  <td class="f">Programa:</td>
                  <td class="e"><label id="lblprog"/></td>
                  <td class="f">Estatus Obra:</td>
                  <td class="e"><label id="lblestatus_obra"/></td>
                  <td  class="f">Tipo de Obra:</td>
                  <td  class="e"><label id="lbltipo_obra"/></td>
              </tr>
              <tr>
                  <td class="f">Fecha Inicio Promoción:</td>
                  <td class="e"><label id="lblfecinirec"/></td>
                  <td class="f">Fecha Fin Recaudación:</td>
                  <td class="e"><label id="lblfecfinrec"/></td>
                  <td  class="f">*Fecha Inicio Proceso:</td>
                  <td  class="e"><input class="dato_captura" type="text" name="feciniproc" id="txtfeciniproc" size="10" maxlength="10"  onkeyup = "this.value=formateafecha(this.value);"/></td>
              </tr>
              <tr>
                  <td  class="f">*Gastos Administrativos:</td>
                  <td  class="e" colspan="2"><input class="dato_captura_float" type="text" name="gastos_admvos" id="txtgastos_admvos"   size="10" maxlength="10"/></td>                  
                  <td  class="f">*Tipo Recurso:</td>
                  <td  class="e" colspan="2"><select class="select_captura" name="tipo_recurso" id="lsttipo_recurso"></select></td>                   
              </tr>
              <tr>
                  <td  class="f" colspan="2">*No. Contrato:</td>
                  <td  colspan="2"><select class="select_captura" name="num_contrato" id="lstcontratos"></select></td> 
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="asignar_contrato">>>></a></td>
                                
              </tr>
              <tr>
                  <td colspan="6">
                      <table id="grid_contratos"></table>
                      <div id="pager_id_contrato"></div>                      
                  </td>
              </tr>
              <tr class="renglon_sistema">                    
                  <td>oid:</td>
                  <td  class="columna_sistema"><label id="lbloid_proc"/></td>
                  <td>obr_clv_int:</td>
                  <td  class="columna_sistema"><label id="lblobr_clv_int_proc"/></td>
                  <td>idusu:</td>
                  <td  class="columna_sistema"><label id="lblidusu_proc"/></td>                  
              </tr>
              <tr class="renglon_sistema">
                  <td>obra_s:</td>
                  <td class="columna_sistema"><label id="lblobra_s"/></td>
                  <td>Cuenta Contable:</td>
                  <td class="columna_sistema"><label id="lblctacontable_proc"/></td>
                  <td>ACCION:</td>
                  <td class="columna_sistema"><label id="lblaccion_proc"/></td>                  
              </tr>   
              <tr>                               
                  <td  colspan="3" class="boton_dialog"><a href="#" class ="posicion_boton_accion_obra_proc">ACEPTAR</a></td>
                  <td  colspan="3" class="boton_dialog"><a href="#" class ="posicion_boton_cancelar_obra_proc">CANCELAR</a></td>
              </tr>
          </tbody>
       </table>
    </div>     
    <div id="dialogoobrajur1" class="window"> 
       <div id="tituloobra_jur1"> 
         <p style="text-align:center">PROCESO JURIDICO DE OBRA</p>
         Usuario: <label for="idusu" id="lblusu_jur1"></label><br/> 
         oid: <label for="oid" id="lbloid_jur1"></label><br/> 
         IdObra_int: <label for="obr_clv_int" id="lbl_obr_int_jur1"></label><br/> 
         IdObra_txt: <label for="obr_clv" id="lbl_obr_int_txt_jur1"></label><br/>                   
         Estatus Obra_Actual:<label for="est_act" id="lblestatus_obr_jur1"></label><br/>  
         Acción:<label for="accion" id="lblaccion_obr_jur1"></label><br/> 
       </div>
       <div class="datos" id="bodyObra_jur1">          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur1">*Fecha de Publicación 1:</label><input type="text" name="fecpub1" id="txtfecpub1" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur2">*Evidencia de Publicación 1:</label><input type="file" name="evidpub1" id="evidpub1"/>&nbsp&nbsp<a href="#" id="file_evidpub1" class="verarchivo_file_evidpub1"></a><br/><br/>           
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur3">*Fecha de Publicación 2:</label><input type="text" name="fecpub2" id="txtfecpub2" size="10" maxlength="10" onkeyup = "this.value=formateafecha(this.value);"/><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur4">*Evidencia de Publicación 2:</label><input type="file" name="evidpub2" id="evidpub2"/>&nbsp&nbsp<a href="#" id="file_evidpub2" class="verarchivo_file_evidpub2"></a><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur5">*Costo de la Obra:</label><input type="text" name="costo_obra" id="txtcosto_obra" size="15" maxlength="15" class="numbersOnly"/><br/><br/>          
          &nbsp&nbsp&nbsp&nbsp&nbsp<label for="name" id="lbljur6">*Naturaleza de la Obra:</label><br/><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkBanq" name="Banquetas"/>Banquetas y guarniciones.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkPav" name="Pavimento"/>Pavimento.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkAtarj" name="Atarjea"/>Atarjeas.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkRed" name="Redes"/>Instalación de redes de distribución.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkAlum" name="Alumbrado"/>Alumbrado público.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkDren" name="Drenaje"/>Instralación de drenaje.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkVias" name="Vias"/>Apertura de nuevas vías públicas.</label><br/>
          &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label><input type="checkbox" id="chkJard" name="Jardines"/>Jardines y obras de equipamiento urbano.</label><br/>
       </div>                  
       <div class="botonesA" id="botones_jur1">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_obra_jur1">Aceptar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_obra_jur1">Cancelar</a></p>                
       </div>
    </div>             
    <div id="dialogo_obrterm" class="window">        
       <table class="t_modulo">
          <tbody> 
              <tr>
                  <td colspan="4" class="titulo_modulo">CAMBIAR ESTATUS DE PROCESO --> TERMINADA VENCIDA</td>
              </tr>   
              <tr>
                  <td class="f">CALLE:</td>
                  <td colspan="3" class="e"><label id="lblcalle_obra_term"/></td>
              </tr>
              <tr>
                  <td class="f">COLONIA:</td>
                  <td colspan="3" class="e"><label id="lblcolonia_obra_term"/></td>
              </tr>
              <tr>
                  <td class="f">TRAMO:</td>
                  <td colspan="3" class="e"><label id="lbltramo_obra_term"/></td>
              </tr>              
              <tr>              
                  <td  class="f">Fecha Inicio de Proceso:</td>
                  <td  class="e"><label id="lblfeciniproc_obra_term"/></td>
                  <td  class="f">*Fecha Terminada Vencida:</td>
                  <td  class="e"><label id="lblfecha_inicio_cobranza_capt"/></td>                  
              </tr>
              <tr>                  
                  <td colspan="6">
                      <table id="grid_contrato_anexos"></table>
                      <div id="pager_contrato_anexos"></div>                      
                  </td>                  
              </tr>              
              <tr class="renglon_sistema">                    
                  <td>oid:</td>
                  <td  class="columna_sistema"><label id="lbloid_obra_term"/></td>
                  <td>obr_clv_int:</td>
                  <td  class="columna_sistema"><label id="lblobr_clv_int_obra_term"/></td>                  
              </tr>              
              <tr class="renglon_sistema">
                  <td>obra_s:</td>
                  <td class="columna_sistema"><label id="lblobra_s_obra_term"/></td>
                  <td>IdTipoRecurso:</td>
                  <td class="columna_sistema"><label id="lblid_tipo_recurso"/></td>                  
              </tr>
              <tr class="renglon_sistema">
                  <td>idusu:</td>
                  <td  class="columna_sistema"><label id="lblidusu_obra_term"/></td>                  
                  <td>accion:</td>
                  <td class="columna_sistema"><label id="lblaccion_obra_term"/></td>                  
              </tr>   
              <tr>                               
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="posicion_boton_accion_obra_term">ACEPTAR</a></td>
                  <td  class="boton_dialog" colspan="2"><a href="#" class ="posicion_boton_cancelar_obra_term">CANCELAR</a></td>
              </tr>
          </tbody>
       </table>
    </div>     
        
    <div id="dialogofichapagomes" class="window"> 
       <div id="titulofichapagomes"> 
         <p style="text-align:center">FICHAS DE PAGO MENSUALES</p>
         Clave de Obra:<label for="obr_clv_int" id="lblobrclvint_x"></label><br/><br/>
         Clave de Obra (SIFIDOC):<label for="obr_clv_int_s" id="lblobrclv_s"></label><br/><br/>
       </div>
       <div class="datos" id="body_fichapagomes">                     
           Periodo de Recaudación:&nbsp&nbsp&nbsp<label for="fecinipag_x" id="lblfecinipag_x"></label>&nbsp&nbsp&nbspde&nbsp&nbsp&nbsp<label for="fecfinpag_x" id="lblfecfinpag_x"></label><br/><br/>
           No. de Pagos:&nbsp&nbsp&nbsp<label for="num_pagos" id="lblnumfichas_x"></label><br/><br/>
           Se genera ficha número:&nbsp&nbsp&nbsp<label for="numfichaactual" id="lblnumfichaactual"></label>&nbsp&nbsp&nbspde&nbsp&nbsp&nbsp<label for="num_fichas" id="lblnumfichas_y"></label><br/><br/>                    
       </div>                  
       <div class="botonesA" id="botones_fichapagomes">
          <p style="text-align:right"><a href="#" class ="posicion_boton_accion_ficha_pago_mes">Generar</a>&nbsp&nbsp&nbsp<a href="#" class="posicion_boton_cancelar_ficha_pago_mes">Cancelar</a></p>                
       </div>
    </div>         
    <div id="mask"></div>
    <div id="rep_xls"></div>

 </div>
</asp:Content>



