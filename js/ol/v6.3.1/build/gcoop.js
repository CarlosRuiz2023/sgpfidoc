
/*Variables globales*/
var accion = 'infcoop';
var draw, select = null;


/*Funcion para llamar una pagina*/

function GenerarSolicitud(idusu, idasunto, fid, pid, obr_clv_int, oid, cid) {
    //alert(img);
    var url1 = "../../Procesos/salida_solicitud_asunto.html?ResponseType=Edit&idusu=" + idusu + "&idasunto=" + idasunto + "&fid=" + fid + "&pid=" + pid + "&obr_clv_int" + obr_clv_int + "&oid=" + oid + "&cid=" + cid;
    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=1600,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
    if (newWindow.focus()) {
        newWindow.focus()
    }
}



/*Funciones para validar*/
function checkLength(largo, n, min, max) {
    if (largo > max || largo < min) {
        updateTips("La longitud de:  " + n + " debe ser entre  " + min + " y " + max + ".");
        return false;
    } else {
        return true;
    }
}

function FormatoMoneda(parametro) {
    if (!isNaN(parametro)) {
        resultado = ('$' + parseFloat(parametro, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString());
    } else {
        resultado = 0;
    }
    return resultado
}

function MostrarFormatoFecha(parametro) {
    /* var hora = parametro.substr(11, str.length);*/
    var fecha = parametro.substr(0, 10);
    var an = fecha.split('-')[0];
    var mes = fecha.split('-')[1];;
    var dia = fecha.split('-')[2];;
    var fecha_res = dia + "/" + mes + "/" + an;
    return fecha_res;
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

function checkRegexp(o, regexp, n) {
    if (regexp.test(o)) {
        return true;
    } else {
        updateTips(n);
        return false;
    }
}


function checkVacio(conten, regexp, msj) {
    if (conten == "" || conten == " ") {
        return true;
    }
    else {
        return checkRegexp(conten, regexp, msj);
    }
}

/*Funcion para recuperar el número de la factibilidad */
function recuperarParametro(campo) {
    var RE = new RegExp("[&?]" + campo + "=([^&]*)&");
    var href = location.href + "&";
    if (RE.test(href)) {
        RE.exec(href);
        return unescape(RegExp.$1);
    }
}

function updateTips(t) {
    alert(t);
}


function MostrarModalEliminarFrente() {
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
    $("#eliminar_frente").css('top', winH / 2 - $("#eliminar_frente").height() / 2);
    $("#eliminar_frente").css('left', winW / 2 - $("#eliminar_frente").width() / 2);

    //transition effect
    $("#eliminar_frente").fadeIn(2000);
}


function MostrarModalCoop() {
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
    $("#edit_coop").css('top', winH / 2 - $("#edit_coop").height() / 2);
    $("#edit_coop").css('left', winW / 2 - $("#edit_coop").width() / 2);

    //transition effect
    $("#edit_coop").fadeIn(2000);
}


function MostrarModalObservAdic() {
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
    $("#formObservAdic").css('top', winH / 2 - $("#formObservAdic").height() / 2);
    $("#formObservAdic").css('left', winW / 2 - $("#formObservAdic").width() / 2);

    //transition effect
    $("#formObservAdic").fadeIn(2000);
}



/*Borrar punto sin guardar en BD serán siempre etiquetados con -1*/


function validarcoop() {
    var valid = checkLength($("#apaterno").val().length, "Apellino Paterno", 1, 40);            /*Valida la longitud del Apellido Paterno*/
    valid = valid && checkLength($("#amaterno").val().length, "Apellino Materno", 1, 40);            /*Valida la longitud del Apellido Materno*/
    valid = valid && checkLength($("#nombrescoop").val().length, "Nombre(s)", 1, 60);
    valid = valid && checkRegexp($("#nomfichacoop").val(), /^([ a-zA-Z0-9áéíóúüñÑÁÉÍÓÚ\.\#])+$/i, "Debes introducir nombre del cooperador");
    valid = valid && checkRegexp($("#nooficnotif").val(), /^([0-9\-a-zA-Z])|(S\/N)|(s\/n)+$/i, "Introduce S/N si no existe número oficial de notificación");
    valid = valid && checkVacio($("#telcoop").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
    valid = valid && checkVacio($("#emailcoop").val(), /^[\w-+]+(\.[\w-]{1,62}){0,126}@[\w-]{1,63}(\.[\w-]{1,62})+[\w-]+$/, "Introduce dirección email correctamente ejem.: micorreo@dominio.com");
    valid = valid && checkVacio($("#curp").val(), /^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$/, "Introduce CURP correctamente.");
    valid = valid && checkVacio($("#ine").val(), /^([0-9]{13})/i, "Introduce cuenta unica de identificación");
    if (valid) {
        if ($("#file1").val().length > 0) {                         /*Valida si existe archivo capturado en el control input file*/
            if (ValidarArchivo($("#file1")[0].files[0])) { /*Valida que el archivo sea de tipo PDF y tenga un tamaño menor a 1 MB*/
                valid = true;
            }
            else {
                $("#file1").val("");
                valid = false;
            }
        }
        else {
            if ($("#archivo").text() != "") {     /*Si la propiedad TEXT de la etiqueta que contiene el nombre de archivo contiene algo significa que la interfaz esta en estatus de edición, por lo tanto se regresará TRUE porque significa que no se desea cambiar el archivo*/
                valid = true;
            }
            else {
                alert("No se capturado ningún documento de identificación");
                valid = false;
            }
        }
    }
    valid = valid && checkVacio($("#ctapred").val(), /^([0-9]{2})+([a-zA-Z]{1})+([a-zA-Z0-9]{1})+([0-9]{8})+$/i, "Introduce correctamente la cuenta predial");
    valid = valid && checkRegexp($("#mtsfte").val(), /^[0-9]+([.])?([0-9]+)?$/, "Introduce correctamente los metros de frente");
    valid = valid && checkRegexp($("#nooficial").val(), /^([0-9\-a-zA-Z])|(S\/N)|(s\/n)+$/i, "Introduce S/N si no existe número oficial del predio");
    valid = valid && checkVacio($("#r20").val(), /^[\w-+]+$/i, "Introduce R20 correspondiente a la escritura");
    valid = valid && checkVacio($("#recsapal").val(), /^[\w-+]+$/i, "Introduce cuenta de SAPAL");
    valid = valid && checkVacio($("#ctaimuvi").val(), /^[\w-+]+$/i, "Introduce cuenta de imuvi");
    valid = valid && checkVacio($("#cup").val(), /^[\w-+]+$/i, "Introduce cuenta unica de predio");
    return valid;
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





function ConsultarPredio(ctapredial) {

    return $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServicePredio.asmx/GetNumPredio",
        data: "{'ctapredial':'" + ctapredial + "'}"
    });
}



function leerArchivo(nom_archivo) {
    var url = "../../temp/" + nom_archivo;
    window.open(url, '_blank', 'toolbar=0');
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
            default:
                alert("El archivo: " + fn + " no tiene extensión .PDF");
                return false
        }
    }
}


function llenarNombresCoops(cidcoop, accionx) {
    var enviarObj = {
        "idcoop": cidcoop,
        "accion": accionx
    }

    var stringData = JSON.stringify(enviarObj);

    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json; utf-8',
        url: "../../WebServices/WebServiceCoop.asmx/Getcoop",
        data: "{objCoop:" + stringData + "}",
        success: function (data) {
            var elementos = 0;
            $("#cmbNombresReg").html('');
            $(data.d).find("coops").each(function () {
                var option = $(document.createElement('option'));
                var idcoop = $(this).find("midcoopr").text();
                var nombre = $(this).find("mnomfichar").text();
                option.html(nombre);
                option.val(idcoop);
                $("#cmbNombresReg").append(option);
            });

            if (cidcoop != 0) { //Si la clave de sector es diferente de 0, es decir si el registro es para editar
                $("#cmbNombresReg").val(cidcoop);
            }
        },
        error: function (xhr) {
            alert(xhr);
            console.log(xhr.responseText);
        }
    });
}


function ConsultaObrasS(oid, accion) {


    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceObras.asmx/GetObrasifidoc",
        data: "{'accion':'" + accion + "','oid':'" + oid + "'}",
        success: function (data) {
            var cadena = $.trim(data.d);
            if (cadena != "<NewDataSet />") {
                $("#lstobras").html('');
                $(data.d).find("obrass").each(function () {
                    var option = $(document.createElement('option'));
                    var noobra = $(this).find("noobrar").text();
                    var oidr = $(this).find("oidr").text();
                    option.html(noobra);
                    option.val(noobra);
                    $("#lstobras").append(option);
                });
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}



function ConsultaPresupprog(xid) {
    return $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServicePresup.asmx/GetPresupprog",
        data: "{'oid':'" + xid + "'}"
    });
}

function ConsultaNumeroPredio(ctapredial) {
    return $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServicePredio.asmx/GetNumPredio",
        data: "{'ctapredial':'" + ctapredial + "'}"
    });
}


function llenarRelPred_formEdit(idrelpredio, accion) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceRelCoopPred.asmx/ConsultaRelCoopPredioP",
        data: "{'accion':'" + accion + "'}",
        success: function (data) {
            var elementos = 0;
            $("#lstrelpred_coop").html('');
            $(data.d).find("relpredio").each(function () {
                var option = $(document.createElement('option'));
                var idrelpred = $(this).find("cidrelpredr").text();
                var relpred = $(this).find("crelacionpredior").text();
                option.html(relpred);
                option.val(idrelpred);
                $("#lstrelpred_coop").append(option);
            });
            if (idrelpredio != 0) { //Se pregunta si el id del cooperador es diferente de cero para la modalidad de edición y ubicar el combo en el valor que se quiere editar
                $("#lstrelpred_coop").val(idrelpredio);
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}


function llenarRelPred(idrelpredio, accion) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceRelCoopPred.asmx/ConsultaRelCoopPredioP",
        data: "{'accion':'" + accion + "'}",
        success: function (data) {
            var elementos = 0;
            $("#lstrelpred").html('');
            $(data.d).find("relpredio").each(function () {
                var option = $(document.createElement('option'));
                var idrelpred = $(this).find("cidrelpredr").text();
                var relpred = $(this).find("crelacionpredior").text();
                option.html(relpred);
                option.val(idrelpred);
                $("#lstrelpred").append(option);
            });
            if (idrelpredio != 0) { //Se pregunta si el id del cooperador es diferente de cero para la modalidad de edición y ubicar el combo en el valor que se quiere editar
                $("#lstrelpred").val(idrelpredio);
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}

function llenarUsoPred(idusopredio, accion) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceUsoPredio.asmx/ConsultaUsoPredio",
        data: "{'accion':'" + accion + "'}",
        success: function (data) {
            var elementos = 0;
            $("#tipopredio").html('');
            $(data.d).find("usopredio").each(function () {
                var option = $(document.createElement('option'));
                var idusopred = $(this).find("idtipopredior").text();
                var usopred = $(this).find("usosuelor").text();
                option.html(usopred);
                option.val(idusopred);
                $("#tipopredio").append(option);
            });
            if (idusopredio != 0) { //Se pregunta si el id del cooperador es diferente de cero para la modalidad de edición y ubicar el combo en el valor que se quiere editar
                $("#tipopredio").val(idusopredio);
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}

function llenarUsoPred_formEdit(idusopredio, accion) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceUsoPredio.asmx/ConsultaUsoPredio",
        data: "{'accion':'" + accion + "'}",
        success: function (data) {
            var elementos = 0;
            $("#lsttipo_predio").html('');
            $(data.d).find("usopredio").each(function () {
                var option = $(document.createElement('option'));
                var idusopred = $(this).find("idtipopredior").text();
                var usopred = $(this).find("usosuelor").text();
                option.html(usopred);
                option.val(idusopred);
                $("#lsttipo_predio").append(option);
            });
            if (idusopredio != 0) { //Se pregunta si el id del cooperador es diferente de cero para la modalidad de edición y ubicar el combo en el valor que se quiere editar
                $("#lsttipo_predio").val(idusopredio);
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}

function RegistrarSolicitud(objUsuarioTareaAccion, objHistAct) {

    var stringData = JSON.stringify(objUsuarioTareaAccion);
    var stringData2 = JSON.stringify(objHistAct);

    return $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json; utf-8',
        url: "../../WebServices/WebServiceTarea.asmx/RegistraEjecuta_Tarea",
        data: "{objUsuarioTareaAccion:" + stringData + ",objHistAct:" + stringData2 + "}"
    });
}


/* function llenarCoop(idcoop) {
     limpiarDatosCoop();
     $.ajax({
         type: "POST",
         dataType: "json",
         contentType: "application/json",
         url: "../../WebServices/WebServiceCoop.asmx/GetCoop",
         data:"{'idcoop':'" + idcoop + "'}",
         success: function (data) {
             $(data.d).find("NombreCoops").each(function () {
                 $("#apaterno").val($(this).find("mApellidoP").text());
                 $("#amaterno").val($(this).find("mApellidoM").text());
                 $("#nombrescoop").val($(this).find("mNombres").text());
                 $("#nomfichacoop").val($(this).find("mNomFicha").text());
                 $("#nooficnotif").val($(this).find("mNoOficial_Ext").text());
                 $("#telcoop").val($(this).find("mTelCoop").text());
                 $("#emailcoop").val($(this).find("mCorreo").text());
                 $("#curp").val($(this).find("mCurp").text());
                 var secfno = $(this).find("secfno").text();
                 var ssfcno = $(this).find("secfno").text();
                 var clacno = $(this).find("clacno").text();
                 if (secfno != '') {
                     $("#calle").val(clacno);
                 }
                 else {
                     alert("El cooperador no tiene domicilio de notificación")
                 }

             });                    
         },
         error: function (xhr) {
             console.log(xhr.responseText);
         }
     });
 }*/

function limpiarDatosCoop() {
    $("#apaterno").val('');
    $("#amaterno").val('');
    $("#nombrescoop").val('');
    $("#nomfichacoop").val('');
    $("#txtcallenotif").val('');
    $("#txtcolnotif").val('');
    $("#nooficnotif").val('');
    $("#telcoop").val('');
    $("#emailcoop").val('');
    $("#curp").val('');
    $("#lstrelpred").index(1);
    $("#cmbNombresReg").index(1);
    $("#calle").index(1);
    $("#colonia").index(1);
    $("#ine").val('');
    $("#file1").val('');
    $("#archivo").text('');
    $("#txtcallenotif").val('');
    $("#txtnooficnotif").val('');
    $("#txtcolnotif").val('');
}

function limpiarDatosFrente() {
    $("#mtsfte").val('');
    $("#nooficial").val('');
    $("#lstobras").html('');
    $("#lstprogs").html('');


}


function limpiarDatosPredio() {
    $("#ctapred").val('');
    $("#ctaimuvi").val('');
    $("#cup").val('');
    $("#recsapal").val('');
    $("#nooficial").val('');
    $("#r20").val('');
    $("#tipopredio").val('');
    $("#txtmzna").val('');
    $("#txtlote").val('');
    $("#recsapal").val('');
    $("#lblnompropmunic").text('');
    $("#lblcallepropmunic").text('');
    $("#lblcoloniamunic").text('');
    $("#lblmunicdomprop").text('');
    $("#lblmuniccolprop").text('');
    $("#tipousosuelo").text('');
}

function callWebServicePred() {
    var ctapred = $("#ctapred").val();
    if (ctapred) {
        var urlctapred = "http://201.116.205.135:8081/ccgleon/IIC/wss_DatPredial.php?sCtaPred=" + ctapred;
        try {
            $.get(urlctapred, function (xml) {
                xmlDoc = $.parseXML(xml),
                    $xml = $(xmlDoc),
                    $nomprop = $xml.find("NomProp");
                $("#lblnompropmunic").text($.trim($nomprop.text()));
                $callenotif = $xml.find("DomProp");
                $numoficext = $xml.find("NumExtP");
                $letraoficialext = $xml.find("LetraExtP");
                $numoficint = $xml.find("NumIntP");
                $colnotif = $xml.find("ColProp");
                $usosuelo = $xml.find("TipPred");
                $("#lblcallepropmunic").text($.trim($callenotif.text()) + " " + $.trim($numoficext.text()) + " " + $.trim($letraoficialext.text()) + " " + $.trim($numoficint.text()));
                $("#lblcoloniamunic").text($.trim($colnotif.text()));

                $callenumpred = $xml.find("DomPred");
                $numoficextpred = $xml.find("NumExt");
                $letraoficextpred = $xml.find("LetraExt");
                $numoficintpred = $xml.find("NumInt");
                $coloniapred = $xml.find("ColPred");

                $("#lblmunicdomprop").text($.trim($callenumpred.text()) + ' ' + $.trim($numoficextpred.text()) + ' ' + $.trim($letraoficextpred.text()) + ' ' + $.trim($numoficintpred.text()));
                $("#lblmuniccolprop").text($.trim($coloniapred.text()));
                $("#tipousosuelo").text($.trim($usosuelo.text()));
                if ($.trim($nomprop.text()) != '') {
                    $("#bodegadatos").data("ctaenpadron", 1);
                }
            });
        }
        catch (err) {
            alert(err);
        }
    }
    else {
        alert("No se ha capturado ninguna cuenta predial")
    }
}







function checaCtaPred(ctapred) {
    var hayprop = '';
    var urlctapred = "http://201.116.205.135:8081/ccgleon/IIC/wss_DatPredial.php?sCtaPred=" + ctapred;
    try {
        $.get(urlctapred, function (xml) {
            xmlDoc = $.parseXML(xml),
                $xml = $(xmlDoc),
                $nomprop = $xml.find("NomProp");
            hayprop = $.trim($nomprop.text());
        });
    }
    catch (err) {
        alert("ERROR no es posible verificar la cta predial en el padrón:" + err);
    }
    return hayprop;
}

var misValores = {
    polygons: {
        text: 'normal',
        align: 'center',
        baseline: 'middle',
        rotation: '0',
        font: 'Arial',
        weight: 'normal',
        placement: 'point',
        maxangle: '0.7853981633974483',
        overflow: 'false',
        size: '15px',
        offsetX: '0',
        offsetY: '0',
        color: 'black',
        outline: '#ffffff',
        outlineWidth: '4',
        maxreso: '1200'
    }
}

function etiqueta_frente(feature, resolution, dom) {

    var type = dom.text;
    var maxResolution = dom.maxreso;
    var att = feature.getProperties();
    var text = att.coopid;
    if (resolution > maxResolution) {
        text = '';
    }
    return text;
}

function GetPredio(ctapredial) {
    if (ctapred.length == 12) {
        var urlctapred = "../../WebServices/WebServicePredio.asmx/GetNumPredio?ctapredial=" + GetNumPredio;
        try {
            $.get(urlctapred, function (xml) {
                xmlDoc = $.parseXML(xml),
                    $xml = $(xmlDoc),
                    $nomprop = $xml.find("NomProp");
                $("#lblnomprop_padronpred").text($.trim($nomprop.text()));
                $callenotif = $xml.find("DomProp");
                $numoficext = $xml.find("NumExtP");
                $letraoficialext = $xml.find("LetraExtP");
                $numoficint = $xml.find("NumIntP");
                $colnotif = $xml.find("ColProp");
                $usosuelo = $xml.find("TipPred");
                $("#lblcalle_notific_padronpred").text($.trim($callenotif.text()) + " " + $.trim($numoficext.text()) + " " + $.trim($letraoficialext.text()) + " " + $.trim($numoficint.text()));
                $("#lblcolonia_notific_padronpred").text($.trim($colnotif.text()));

                $callenumpred = $xml.find("DomPred");
                $numoficextpred = $xml.find("NumExt");
                $letraoficextpred = $xml.find("LetraExt");
                $numoficintpred = $xml.find("NumInt");
                $coloniapred = $xml.find("ColPred");

                $("#lblcalle_noofic_padronpred").text($.trim($callenumpred.text()) + ' ' + $.trim($numoficextpred.text()) + ' ' + $.trim($letraoficextpred.text()) + ' ' + $.trim($numoficintpred.text()));
                $("#lblcolonia_padronpred").text($.trim($coloniapred.text()));
                $("#lblusosuelo_padronpred").text($.trim($usosuelo.text()));

            });
        }
        catch (err) {
            alert(err);
        }
    }
}


function GetDatosPredial(ctapred) {
    if (ctapred.length == 12) {
        var urlctapred = "http://201.116.205.135:8081/ccgleon/IIC/wss_DatPredial.php?sCtaPred=" + ctapred;
        try {
            $.get(urlctapred, function (xml) {
                xmlDoc = $.parseXML(xml),
                    $xml = $(xmlDoc),
                    $nomprop = $xml.find("NomProp");
                var nom_prop = $.trim($nomprop.text());
                if (nom_prop) {
                    ConsultarPredio(ctapred)
                        .done(function (result) {
                            var data = result.d;
                            var ctapredial_valida = 0;
                            var dato_predial = ($("#lblfid_dato").text()).split(':');

                            var pid_actual = parseInt(dato_predial[1]);

                            if (data != '<NewDataSet />') {
                                $(data).find("predio").each(function () {
                                    var pid_encontrado = $(this).find("pidr").text();
                                    if (parseInt(pid_encontrado) == pid_actual) {
                                        ctapredial_valida = 1;
                                    }
                                    else {
                                        alert('Dato inválido, la cuenta predial se encuentra asignada al predio:  ' + pid_encontrado);
                                        $("#txtctapred_predio").val('');
                                    }
                                });

                            } else {
                                ctapredial_valida = 1;
                            }

                            if (ctapredial_valida) {
                                $("#lblnomprop_padronpred").text($.trim($nomprop.text()));
                                $callenotif = $xml.find("DomProp");
                                $numoficext = $xml.find("NumExtP");
                                $letraoficialext = $xml.find("LetraExtP");
                                $numoficint = $xml.find("NumIntP");
                                $colnotif = $xml.find("ColProp");
                                $usosuelo = $xml.find("TipPred");
                                $("#lblcalle_notific_padronpred").text($.trim($callenotif.text()) + " " + $.trim($numoficext.text()) + " " + $.trim($letraoficialext.text()) + " " + $.trim($numoficint.text()));
                                $("#lblcolonia_notific_padronpred").text($.trim($colnotif.text()));
                                $callenumpred = $xml.find("DomPred");
                                $numoficextpred = $xml.find("NumExt");
                                $letraoficextpred = $xml.find("LetraExt");
                                $numoficintpred = $xml.find("NumInt");
                                $coloniapred = $xml.find("ColPred");

                                $("#lblcalle_noofic_padronpred").text($.trim($callenumpred.text()) + ' ' + $.trim($numoficextpred.text()) + ' ' + $.trim($letraoficextpred.text()) + ' ' + $.trim($numoficintpred.text()));
                                $("#lblcolonia_padronpred").text($.trim($coloniapred.text()));
                                $("#lblusosuelo_padronpred").text($.trim($usosuelo.text()));
                            }

                        })
                        .fail(function (r) {
                            alert("No pudieron consultarse los datos de predial");
                        });
                }
                else {

                    alert('Cuenta predial: ' + ctapred + ' no válida, no se encontró en el padrón de predial ');
                    $("#txtctapred_predio").val('');
                }
            });
        }
        catch (err) {
            alert(err);
        }
    }
    else {

        $("#lblnomprop_padronpred").text('');

        $("#lblcalle_notific_padronpred").text('');
        $("#lblcolonia_notific_padronpred").text('');

        $("#lblcalle_noofic_padronpred").text('');
        $("#lblcolonia_padronpred").text('');

        $("#lblusosuelo_padronpred").text('');

    }
}

function HabilitarCajasTexto(estatus) {
    $("#cmbNombresReg").prop("disabled", estatus);
    $("#apaterno").prop("disabled", estatus);
    $("#amaterno").prop("disabled", estatus);
    $("#nombrescoop").prop("disabled", estatus);
    $("#ine").prop("disabled", estatus);
    $("#nomfichacoop").prop("disabled", estatus);
    $("#nooficnotif").prop("disabled", estatus);
    $("#txtcallenotif").prop("disabled", estatus);
    $("#txtcolnotif").prop("disabled", estatus);
    $("#txtnooficnotif").prop("disabled", estatus);
    $("#telcoop").prop("disabled", estatus);
    $("#emailcoop").prop("disabled", estatus);
    $("#curp").prop("disabled", estatus);
    $("#archivo").prop("disabled", estatus);
    $("#file1").prop("disabled", estatus);

    $("#ctapred").prop("disabled", estatus);
    $("#lstrelpred").prop("disabled", estatus);
    $("#tipopredio").prop("disabled", estatus);
    $("#r20").prop("disabled", estatus);
    $("#recsapal").prop("disabled", estatus);
    $("#ctaimuvi").prop("disabled", estatus);
    $("#cup").prop("disabled", estatus);
    $("#txtmzna").prop("disabled", estatus);
    $("#txtlote").prop("disabled", estatus);

    $("#mtsfte").prop("disabled", estatus);
    $("#lstobras").prop("disabled", estatus);
    $("#lstprogs").prop("disabled", estatus);
    $("#nooficial").prop("disabled", estatus);
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}






$(document).ready(function () {  //**INICIA SCRIPT PRINCIPAL**/

    /*SECCION GLOBAL*/
    /*Codigo para controlar los eventos del clic*/
    proj4.defs("EPSG:32614", "+proj=utm +zone=14 +datum=WGS84 +units=m +no_defs");
    var SourceProjection = new proj4.Proj('EPSG:3857');
    var DestinationProjections = new proj4.Proj('EPSG:32614');
    $("#bodegadatos").data("idcoop", 0);


    /*proj4.defs("EPSG:32614","+proj=utm +zone=14 +datum=WGS84 +units=m +no_defs");*/
    var centro, numPredios, numFrentes, numPredAsig, numFacti;
    var x, y;
    var mapview;
    var container = document.getElementById('popup');
    var content = document.getElementById('popup-content');
    var closer = document.getElementById('popup-closer');
    var overlay = new ol.Overlay({
        element: container,
        autoPan: true,
        autoPanAnimation: {
            duration: 250
        }
    });


    var geomfrente;
    var geompred;
    var oid = recuperarParametro("oid"); /*Recupera valor de factibilidad*/
    var obr_clv_int = recuperarParametro("obr_clv_int");
    var obr_clv = recuperarParametro("obr_clv");
    var obr_estatus = recuperarParametro("obr_estatus");
    var programa = recuperarParametro("programa");
    var idusu = recuperarParametro("idusu");
    RescatarReglasUsuario(idusu, 0);
    var fid = recuperarParametro("fid");
    var numpagos = recuperarParametro("num_pagos");
    var fecvenp = recuperarParametro("fec_venc");
    var coopid = recuperarParametro("coopid");
    var coopid = coopid.replace('#', '');

    var image = new ol.style.Circle({
        radius: 5,
        fill: new ol.style.Fill({ color: 'blue' }),
        stroke: new ol.style.Stroke({ color: 'black', width: 1 })
    });

    var imageselected = new ol.style.Circle({
        radius: 4,
        fill: new ol.style.Fill({ color: 'orange' }),
        stroke: new ol.style.Stroke({ color: 'yellow', width: 1 })
    });

    $("#bodegadatos").data("idusu", idusu);
    $("#bodegadatos").data("numpagos", numpagos);
    $("#bodegadatos").data("fecvenp", fecvenp);

    var vectorPrediosPosibles = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return geoserverConfig.host+'/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Avw_predios_posibles&outputFormat=application%2Fjson&CQL_FILTER=oid=' + oid.toString();
        }
        //http://localhost:8080/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Avw_predios_unicos&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=oid=9999
    });

    var vectorPredios = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return geoserverConfig.host +'/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Avw_predios_unicos&outputFormat=application%2Fjson&CQL_FILTER=oid=' + oid.toString();
        }
        //http://localhost:8080/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Avw_predios_posibles&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=oid=9999
    });


    var vSourceObra = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return geoserverConfig.host +'/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc:obra_geo&outputFormat=application/json&featureid=obra_geo.' + oid.toString();
        }
        //http://localhost:8080/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc:obra_geo&maxFeatures=50&outputFormat=application/json&featureid=obra_geo.9999
        //http://localhost:8080/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Aobra_geo&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=sector=12
    });

    var vSourceFrentes = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return geoserverConfig.host +'/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Avw_coops_4&outputFormat=application%2Fjson&CQL_FILTER=obr_clv_int=' + obr_clv_int.toString();
        }
    });



    /*var source = new VectorSource({ wrapX: false });*/ /*Esta línea es del ejemplo*/

    var vectorPred = new ol.layer.Vector({
        source: vectorPredios,
        style: styleFunction
    });

    var vectorPredPosibles = new ol.layer.Vector({
        source: vectorPrediosPosibles,
        style: styleFunction
    });


    /*capa vectorial de factibilidades se configuró el propio estilo*/
    var vectorObra = new ol.layer.Vector({
        source: vSourceObra,
        style: new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: 'blue',
                width: 2
            }),
            fill: new ol.style.Fill({
                color: 'rgba(0, 1, 255, 0.3)'
            })
        })
    });

    /*capa vectorial de frentes*/
    var vectorFrentes = new ol.layer.Vector({
        source: vSourceFrentes,
        style: styleFunction
    });

    /*Imagen del mapa de google*/
    var raster = new ol.layer.Tile({
        source: new ol.source.OSM()
    });


    /* Se ejecuta en el lugar 1 */
    var map = new ol.Map({
        layers: [raster, vectorObra, vectorPred, vectorPredPosibles],
        target: document.getElementById('map'),
        overlays: [overlay],
        view: new ol.View({
            center: [-11319096.234, 2406669.952],
            maxzoom: 23,
            zoom: 19.2
        })
    });

    /* Se ejecuta en el lugar 2 */
    vSourceObra.on('addfeature', function (evt) {
        if (vSourceObra.getState() == 'ready') {
            var numFacti = evt.feature.values_.oid; /*Existen poligonos de factibilidad*/
            /* if (numFacti) {
                
                /*$('#map').css('cursor', 'wait');*/
        }
        else {
            alert("NO SE ENCUENTRA POLIGONO DE OBRA.");
            /*window.close();
        } */
            var feature = evt.feature;
            var coords = feature.getGeometry().getCoordinates();
            var coord = feature.getGeometry().getExtent();
            centro = ol.extent.getCenter(coord);
            x = centro[0];
            y = centro[1];
            map.getView().setCenter(centro);
        }
    });

    vectorPred.getSource().on('change', function (evt) {
        var source = evt.target;
        if (source.getState() === 'ready') {
            numPredIntersect = source.getFeatures().length;
            if (numPredIntersect) {
                map.addLayer(vectorFrentes);
                map.updateSize();
            }
            else {
                alert("No existen predios que se intersecten,favor de dar de alta predios");
            }
            $('#map').css('cursor', 'default');
        }
    });


    vSourceFrentes.on('addfeature', function (evt) {
        if (vSourceFrentes.getState() == 'ready') {
            var numFrente = evt.feature.values_.fid; /*Existen poligonos de factibilidad*/
            var predio = evt.feature.values_.pid;
            if (parseInt(fid) == numFrente) {
                var feature = evt.feature;
                var coords = feature.getGeometry().getCoordinates();
                var coord = feature.getGeometry().getExtent();
                centro = ol.extent.getCenter(coord);
                x = centro[0];
                y = centro[1];
                map.getView().setCenter(centro);
                map.getView().setZoom(23);
                feature.setStyle(frenteSeleccionado(feature, map.getView().getResolution(), misValores));

            }
        }
    });






    map.on('click', function (evt) {
        var geompred; //Geometría del predio
        var pid; //Id del predio     
        var coopid_edicion;

        var geomfrente; //Geometria del frente
        allFeaturesAtPixel = [];
        map.forEachFeatureAtPixel(evt.pixel, function (feature, layer) {
            geomfrente = evt.coordinate;
            allFeaturesAtPixel.push(feature);
        });
        if (allFeaturesAtPixel.length > 0) { //Si se encuentra features en el pixel clicado                    
            var i;
            for (i = 0; i < allFeaturesAtPixel.length; ++i) { //Búsqueda del feature de predio                        
                if (allFeaturesAtPixel[i].get('fid')) {
                    fid = allFeaturesAtPixel[i].get('fid');
                }
                else {
                    fid = 0;
                }

                var pid = allFeaturesAtPixel[i].get('pid');
                if (pid) {              //Si se encuentra el predio                             
                    geompred = allFeaturesAtPixel[i].getGeometry();
                    $("#bodegadatos").data("geompred", geompred);
                    $("#bodegadatos").data("pid", pid);
                    $("#bodegadatos").data("geomfrente", geomfrente);
                    break;
                }
            }


            $("#lblusuario").text(idusu);
            $("#lblaccioncoop").text(accion);

            $("#lbloid").text(oid);
            $("#lblobr_clv").text(obr_clv);
            $("#lblobr_clv_int").text(obr_clv_int);
            $("#lblprograma").text(programa);
            $("#lblfid").text(fid);
            $("#lblnumpagos").text(numpagos);
            $("#lblfecvenp").text(fecvenp);
            $("#lblcoopsifidoc").text('000');


            /*Plantilla de edicion de datos 10/05/2023*/

            $("#lbloid_prop").text('oid:');
            $("#lbloid_dato").text(oid);

            $("#lblobr_clv_int_prop").text('obr_clv_int:');
            $("#lblobr_clv_int_dato").text(obr_clv_int);

            $("#lblobra_s_prop").text('Obra SIFIDOC:');
            $("#lblobra_s_dato").text(obr_clv);

            /*--------------------------------------*/
            $("#lblfid_prop").text('fid:');
            $("#lblfid_dato").text(fid);


            $("#lblcoop_id_prop").text('coopid:');
            $("#lblcoop_id_dato").text(coopid);


            $("#lblpid_prop").text('pid:');
            $("#lblpid_dato").text(pid);
            /*-----------------------------------------*/

            $("#lblidusu_prop").text('idusu:');
            $("#lblidusu_dato").text(idusu);

            $("#lblaccion_prop").text('accion:');
            $("#lblaccion_dato").text(accion);

            /*******************************************/
            if (fid) {

                if (accion == 'editcoop' || accion == 'elimcoop') {

                    var permiso_eliminar = $("#bodegadatos").data("eliminar_coop_obra_rec") || $("#bodegadatos").data("eliminar_coop_obra_proc") || $("#bodegadatos").data("eliminar_coop_obra_cob");
                    var permiso_editar = $("#bodegadatos").data("checarEditarObraRec") ||
                        $("#bodegadatos").data("checarEditarObraProc") ||
                        $("#bodegadatos").data("checarEditarObraCob") ||
                        $("#bodegadatos").data("checarSolicitarEditarObraRec") ||
                        $("#bodegadatos").data("checarSolicitarEditarObraProc") ||
                        $("#bodegadatos").data("checarSolicitarEditarObraCob");


                    if (permiso_eliminar || permiso_editar) {
                        /*HabilitarCajasTexto_EditElim();*/
                        LeerFrente('consulta', fid)
                            .done(function (r) {
                                var frente = [];
                                var data = r.d;

                                if (data != '<NewDataSet />') {
                                    $(data).find("frentefinanc").each(function () {
                                        var objFrente = {
                                            "fid": 0,
                                            "geom_frente": '',
                                            "pid": 0,
                                            "oid": 0,
                                            "obr_clv_int": 0,
                                            "obra_sifidoc": '',
                                            "coopid": '',
                                            "coop_s": '',
                                            "midcoop": 0,
                                            "mapellidop": '',
                                            "mapellidom": '',
                                            "mnombres": '',
                                            "mnomficha": '',
                                            "mcorreo": '',
                                            "mcurp": '',
                                            "ine": '',
                                            "doc_identific": '',
                                            "telcoop": '',
                                            "mcallecoop": '',
                                            "mcolcoop": '',
                                            "mnooficial_ext": '',
                                            "mnooficial_int": '',
                                            "dom_notif": '',
                                            "cidrelpred": 0,
                                            "relacionpredio": '',
                                            "obr_status": 0,
                                            "cestatus": '',
                                            "nomprog": '',
                                            "progdescrip": '',
                                            "obr_npago": 0,
                                            "tipo_obra": 0,
                                            "calle": '',
                                            "colonia": '',
                                            "tramo": '',
                                            "nooficial": '',
                                            "ctapredial": '',
                                            "cup": '',
                                            "cta_imuvi": '',
                                            "sapal": '',
                                            "r20": '',
                                            "lote": '',
                                            "mzna": '',
                                            "cve_uso_suelo": '',
                                            "uso_suelo": '',
                                            "mts_frente": 0,
                                            "inc": '',
                                            "costo_mto": 0,
                                            "capital_sin_inc": 0,
                                            "capital": 0,
                                            "monto_capital_pagado": 0,
                                            "saldo_capital": 0,
                                            "feciniproc": '',
                                            "fecinicob": '',
                                            "fecinip": '',
                                            "fecvenp": '',
                                            "descto_capital_por_aplic": 0,
                                            "descto_capital_aplic": 0,
                                            "saldo_total": 0
                                        }
                                        objFrente.fid = $(this).find("fidr").text();
                                        objFrente.geom_frente = $(this).find("geom_frenter").text();
                                        objFrente.pid = $(this).find("pidr").text();
                                        objFrente.oid = $(this).find("oidr").text();
                                        objFrente.obr_clv_int = $(this).find("obr_clv_intr").text();
                                        objFrente.obra_sifidoc = $(this).find("obra_sifidocr").text();
                                        objFrente.coopid = $(this).find("coopidr").text();
                                        objFrente.coop_s = $(this).find("obra_sifidocr").text() + '-' + $(this).find("coopidr").text();
                                        objFrente.midcoop = $(this).find("midcoopr").text();
                                        objFrente.mapellidop = $(this).find("mapellidopr").text();
                                        objFrente.mapellidom = $(this).find("mapellidomr").text();
                                        objFrente.mnombres = $(this).find("mnombresr").text();
                                        objFrente.mnomficha = $(this).find("mnomfichar").text();
                                        objFrente.mcorreo = $(this).find("mcorreor").text();
                                        objFrente.mcurp = $(this).find("mcurpr").text();
                                        objFrente.ine = $(this).find("iner").text();
                                        objFrente.doc_identific = $(this).find("doc_identificr").text();
                                        objFrente.telcoop = $(this).find("mtelcoopr").text();
                                        objFrente.mcallecoop = $(this).find("mcallecoopr").text();
                                        objFrente.mcolcoop = $(this).find("mcolcoopr").text();
                                        objFrente.mnooficial_ext = $(this).find("mnooficial_extr").text();
                                        objFrente.mnooficial_int = $(this).find("mnooficial_intr").text();
                                        objFrente.dom_notif = $(this).find("dom_notif").text();
                                        objFrente.cidrelpred = $(this).find("cidrelpredr").text();
                                        objFrente.relacionpredio = $(this).find("crelacionpredior").text();
                                        objFrente.obr_status = $(this).find("obr_statusr").text();
                                        objFrente.cestatus = $(this).find("cestatusr").text();
                                        objFrente.nomprog = $(this).find("nomprogr").text();
                                        objFrente.progdescrip = $(this).find("progdescripr").text();
                                        objFrente.obr_npago = parseFloat($(this).find("num_pagosr").text());
                                        objFrente.tipo_obra = $(this).find("tipo_obrar").text();
                                        objFrente.calle = $(this).find("caller").text();
                                        objFrente.colonia = $(this).find("coloniar").text();
                                        objFrente.tramo = $(this).find("tramor").text();
                                        objFrente.nooficial = $(this).find("nooficialr").text();
                                        objFrente.ctapredial = $(this).find("ctapredialr").text();
                                        objFrente.cup = $(this).find("cupr").text();
                                        objFrente.cta_imuvi = $(this).find("ctaimuvir").text();
                                        objFrente.sapal = $(this).find("sapalr").text();
                                        objFrente.r20 = $(this).find("r20r").text();
                                        objFrente.lote = $(this).find("loter").text();
                                        objFrente.mzna = $(this).find("mznar").text();
                                        objFrente.cve_uso_suelo = $(this).find("idtipopredior").text();
                                        objFrente.uso_suelo = $(this).find("uso_suelor").text();
                                        objFrente.mts_frente = $(this).find("mts_frenter").text();
                                        objFrente.inc = $(this).find("incr").text();
                                        objFrente.costo_mto = parseFloat($(this).find("costo_mtor").text());
                                        objFrente.capital_sin_inc = $(this).find("capital_sin_incr").text();
                                        objFrente.capital = $(this).find("capitalr").text();
                                        objFrente.monto_capital_pagado = parseFloat($(this).find("monto_capital_pagador").text());
                                        objFrente.saldo_capital = $(this).find("saldo_capitalr").text();
                                        objFrente.feciniproc = MostrarFormatoFecha($(this).find("feciniprocr").text());
                                        objFrente.fecinicob = MostrarFormatoFecha($(this).find("fecinicobr").text());
                                        objFrente.fecinip = MostrarFormatoFecha($(this).find("fecinipr").text());
                                        objFrente.fecvenp = MostrarFormatoFecha($(this).find("fecvenpr").text());
                                        objFrente.descto_capital_por_aplic = $(this).find("descto_capital_por_aplicr").text();
                                        objFrente.descto_capital_aplic = $(this).find("descto_capital_aplicr").text();
                                        objFrente.saldo_total = $(this).find("saldo_totalr").text();
                                        frente.push(objFrente);

                                        if (accion == 'editcoop') {
                                            var objFrente_Inicial = objFrente;
                                            $("#bodegadatos").data("objFrente_Inicial", objFrente_Inicial);
                                            PreparaInterfazEdicionFrente(objFrente, idusu)
                                        }
                                        else {
                                            PreparaInterfazEliminacionFrente(objFrente, idusu)
                                        }


                                    });


                                    var monto_pagado = $("#bodegadatos").data("monto_pagado");
                                    var monto_pagado_txt = monto_pagado.toString();

                                    if (accion == 'editcoop') {
                                        PrepararTareasAccionesCampos_Editar(obr_estatus, monto_pagado);

                                    } else {
                                        if (monto_pagado == 0) {
                                            if (obr_estatus == '2') { /*Si la obra esta en Recaudación*/
                                                if ($("#bodegadatos").data("eliminar_coop_obra_rec")) {
                                                    MostrarModalEliminarFrente();
                                                }
                                                else {
                                                    alert('No tiene permiso para eliminar un frente de una obra en Recaudación');
                                                }
                                            } else {
                                                if (obr_estatus == '4') {
                                                    if ($("#bodegadatos").data("eliminar_coop_obra_proc")) {
                                                        MostrarModalEliminarFrente();
                                                    }
                                                    else {
                                                        alert('No tiene permiso para eliminar un frente de una obra en Proceso');
                                                    }
                                                } else {
                                                    if (obr_estatus == '5') {
                                                        if ($("#bodegadatos").data("eliminar_coop_obra_cob")) {
                                                            MostrarModalEliminarFrente();
                                                        }
                                                        else {
                                                            alert('No tiene permiso para eliminar un frente de una obra en Cobranza');
                                                        }

                                                    } else {
                                                        alert('Considerar otros estatus de obras');
                                                    }

                                                }
                                            }
                                        } else {
                                            alert('No es posible eliminar el frente seleccionado porque tiene un monto pagado de: ' + FormatoMoneda(monto_pagado_txt) + ', si desea eliminar el frente debe proceder como una Cancelación de Cooperador');
                                        }
                                    }
                                }
                                else {
                                    alert('No se encontraron datos del frente solicitado.')
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("Falla al recuperar el dato del frente a consultar.");
                            })
                    }
                    else {
                        alert('No tiene permiso para eliminar o editar un frente');
                    }
                } else {
                    if (accion == 'infcoop') {
                        ArmaVentanaCoop(fid);
                        overlay.setPosition(geomfrente);
                    }
                }

            }
            else {
                if (accion == 'altacoop') { //Si la acción es para dar de alta un cooperador o dar de alta solo el frente a un cooperador existente.
                    if (geompred) { //Si existe geometria de predio                  
                        limpiarDatosCoop();
                        limpiarDatosFrente();
                        limpiarDatosPredio();
                        llenarNombresCoops(0, accion);
                        llenarRelPred(0, 'consultarelpredio');
                        /*llenarCoopsSIFIDOC(obr_clv, '000')*/
                        MostrarModalAltaCoop();
                        MostrarDatosPredio(pid);
                        $("#bodegadatos").data("idcoop", 0);
                    }
                    else {
                        alert("El frente no está dentro de un predio");
                        borrapuntosinregistrarseBD();
                    }
                } else {
                    alert('Seleccione un frente por favor...')
                }
            }
        }
    });





    $(".t_accion").click(function (e) {
        var campo_accion = e.target.id;
        var objUsuarioTareaAccion = {
            "id_accion_tarea": 0,
            "fid": 0,
            "pid": 0,
            "oid": 0,
            "obr_clv_int": 0,
            "cid": 0,
            "idtarea": 0,
            "idusu_solicita": 0,
            "idusu_autoriza": 0,
            "idusu_rubrica": 0,
            "idusu_rubrica2": 0,
            "folio_solic": '',
            "parametro1": '',
            "parametro2": '',
            "parametro3": '',
            "parametro4": '',
            "parametro5": '',
            "parametro6": '',
            "parametro7": '',
            "parametro8": '',
            "parametro9": '',
            "parametro10": '',
            "parametro11": '',
            "parametro12": '',
            "parametro13": '',
            "parametro14": '',
            "parametro15": '',
            "parametro16": '',
            "parametro17": '',
            "parametro18": '',
            "parametro19": '',
            "parametro20": ''
        };

        var objHistAct = {
            "idactividad": 0,
            "estatus_actividad": 0,
            "fecha_actividad": 0,
            "hora_actividad": 0,
            "idusu": 0,
            "idaccion": 0
        };


        var date = new Date();
        var fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
        var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();


        var simbolo_accion = $("#" + campo_accion).text();

        objHistAct.idusu = parseInt($("#lblidusu_dato").text());
        objHistAct.idactividad = 0;
        objHistAct.fecha_actividad = ConvertirCadenaToFecha(fecha_hoy);
        objHistAct.hora_actividad = time

        var fid_pid = $("#lblfid_dato").text();
        var fid_1 = fid_pid.split(':')[0];
        var pid_2 = fid_pid.split(':')[1];

        objUsuarioTareaAccion.fid = parseInt(fid_1);
        objUsuarioTareaAccion.pid = parseInt(pid_2);
        objUsuarioTareaAccion.oid = parseInt($("#lbloid_dato").text());
        objUsuarioTareaAccion.obr_clv_int = parseInt($("#lblobr_clv_int_dato").text());
        objUsuarioTareaAccion.cid = parseInt($("#lblcid_dato").text());

        objUsuarioTareaAccion.parametro1 = campo_accion;
        objUsuarioTareaAccion.parametro2 = obr_estatus;


        var objFrente_Inicial = $("#bodegadatos").data("objFrente_Inicial");
        var objValores = ObtenerValores(objFrente_Inicial, campo_accion);

        objUsuarioTareaAccion.parametro4 = objValores.valor_inicial;
        objUsuarioTareaAccion.parametro5 = objValores.valor_final;

        if (simbolo_accion == '>') {
            objHistAct.estatus_actividad = 3;  /*Accion "EJECUTAR"*/
            objHistAct.idaccion = 3;
            objUsuarioTareaAccion.parametro3 = objHistAct.idaccion;

            RegistrarSolicitud(objUsuarioTareaAccion, objHistAct)
                .done(function (result) {
                    alert(result.d);
                }).fail(function (result) {
                    alert("No fue posible ejecutar la TAREA");
                });

        }

        if (simbolo_accion == '?') {
            objHistAct.estatus_actividad = 1;  /*Accion "EJECUTAR"*/
            objHistAct.idaccion = 1;
            objUsuarioTareaAccion.parametro3 = objHistAct.idaccion;
            $("#bodegadatos").data("objHistAct_storage", objHistAct);
            $("#bodegadatos").data("objUsuarioTareaAccion_storage", objUsuarioTareaAccion);
            $('#mask, .window').hide();
            MostrarModalObservAdic();
        }

    });



    $(".b_generar_solicitud_sin").click(function (e) {
        var objHistAct = $("#bodegadatos").data("objHistAct_storage");
        var objUsuarioTareaAccion = $("#bodegadatos").data("objUsuarioTareaAccion_storage");
        GenerarSolicitud(0);
    });


    $(".t_propiedad").click(function (e) {
        var etiqueta_label_sel2 = e.currentTarget.text;
        var accion = etiqueta_label_sel2.substr(0, 1);
        var tarea = etiqueta_label_sel2.substr(1, etiqueta_label_sel.indexOf('_') - 1);
        PrepararCapturaDato(accion, tarea);

    });

    function GenerarSolicitud(con_folio) {
        var objActividad = $("#bodegadatos").data("objActividad");
        var objHistAct = $("#bodegadatos").data("objHistAct");
        var objFrenteInicial = $("#bodegadatos").data("objFrente_Inicial");

        var pdf = new jsPDF('p', 'mm', 'letter');
        pdf.setFontSize(12);
        pdf.setFontType('bold');



        var tab1 = 10;
        var tab2 = 52;
        var tab3 = tab2 * 2;
        var tab4 = tab2 * 3;
        var tab5 = 208;
        var reng_ref = 30;
        var reng_inc2 = 5;

        var date = new Date();
        var fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
        var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

        pdf.line(10, 15, 204, 15);
        pdf.line(10, 16, 204, 16);
        pdf.text(tab3 - (pdf.getTextWidth('MEMORANDUM DE OFICINA') / 2), 22, 'MEMORANDUM DE OFICINA');
        pdf.line(10, 25, 204, 25);
        pdf.line(10, 26, 204, 26);


        pdf.text(tab2 - pdf.getTextWidth('PARA: MARGARITA GUEVARA MENDEZ'), reng_ref + reng_inc2 * 1, 'PARA: ');
        pdf.text(tab2 - pdf.getTextWidth('DE: '), reng_ref + reng_inc2 * 2, 'DE: ');
        pdf.text(tab2 - pdf.getTextWidth('ASUNTO: '), reng_ref + reng_inc2 * 3, 'ASUNTO: ');
        pdf.text(tab2 - pdf.getTextWidth('FECHA: '), reng_ref + reng_inc2 * 4, 'FECHA: ');
        pdf.text(tab2 - pdf.getTextWidth('CCP: ARCHIVO'), reng_ref + reng_inc2 * 5, 'CCP: ARCHIVO');

        pdf.line(10, reng_ref + reng_inc2 * 6, 204, reng_ref + reng_inc2 * 6);

        var date = new Date();
        var fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
        var time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        var solicitud = '';
        if (!con_folio) {
            solicitud = 'Prueba_';
        }

        solicitud = solicitud + 'Solicitud_' + fecha_hoy + '.pdf';
        pdf.save(solicitud.toString());
    }


    function ObtenerValores(objFrente_Inicial, campo_accion) {
        var objValores = {
            "valor_inicial": '',
            "valor_final": ''
        }


        if (campo_accion == 'lblnomcoop_accion') {
            objValores.valor_inicial = $("#txtnoms_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mnombres; /*Valor anterior*/
        }

        if (campo_accion == 'lblapaterno_accion') {
            objValores.valor_inicial = $("#txtapaterno_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mapellidop; /*Valor anterior*/
        }


        if (campo_accion == 'lblamaterno_accion') {
            objValores.valor_inicial = $("#txtamaterno_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mapellidom; /*Valor anterior*/
        }

        if (campo_accion == 'lblcalle_notific_accion') {
            objValores.valor_inicial = $("#txtcalle_notific_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.callenotif; /*Valor anterior*/
        }


        if (campo_accion == 'lblcolonia_notific_accion') {
            objValores.valor_inicial = $("#txtcolonia_notific_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.colnotif; /*Valor anterior*/
        }

        if (campo_accion == 'lblctapred_accion') {

            var cta_predial = $.trim($("#txtctapred_predio").val());
            if (cta_predial.length < 12) {
                alert('Cuenta predial inválida, tiene menos de  12 caractéres, se eliminara lo capturado y se asignará el campo vacío de CUENTA PREDIAL')
                $("#txtctapred_predio").val('');
                $("#lblnomprop_padronpred").text('');

                $("#lblcalle_notific_padronpred").text('');
                $("#lblcolonia_notific_padronpred").text('');

                $("#lblcalle_noofic_padronpred").text('');
                $("#lblcolonia_padronpred").text('');

                $("#lblusosuelo_padronpred").text('');

            }
            objValores.valor_inicial = $("#txtctapred_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.ctapredial; /*Valor anterior*/


        }

        if (campo_accion == 'lblcurp_accion') {
            objValores.valor_inicial = $("#txtcurp_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mcurp; /*Valor anterior*/
        }

        if (campo_accion == 'lbline_accion') {
            objValores.valor_inicial = $("#txtine_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.ine; /*Valor anterior*/

        }
        if (campo_accion == 'lbltel_accion') {

            objValores.valor_inicial = $("#txttelefono_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.telcoop; /*Valor anterior*/

        }
        if (campo_accion == 'lblemail_accion') {
            objValores.valor_inicial = $("#txtemail_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mcorreo; /*Valor anterior*/
        }
        if (campo_accion == 'lblrelpred_accion') {
            objValores.valor_inicial = $("#lstrelpred_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.relacionpredio; /*Valor anterior*/
        }
        if (campo_accion == 'lbldocident_accion') {
            objValores.valor_inicial = $("#txtdocident_coop").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.doc_identific; /*Valor anterior*/
        }
        if (campo_accion == 'lblnoofic_accion') {
            objValores.valor_inicial = $("#txtnumofic_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.nooficial; /*Valor anterior*/
        }
        if (campo_accion == 'lbllote_accion') {
            objValores.valor_inicial = $("#txtlote_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.lote; /*Valor anterior*/
        }
        if (campo_accion == 'lblmanzana_accion') {
            objValores.valor_inicial = $("#txtmanzana_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mzna; /*Valor anterior*/
        }
        if (campo_accion == 'lblctaimuvi_accion') {
            objValores.valor_inicial = $("#txtctaimuvi_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.cta_imuvi; /*Valor anterior*/
        }
        if (campo_accion == 'lblsapal_accion') {
            objValores.valor_inicial = $("#txtsapal_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.sapal; /*Valor anterior*/
        }

        if (campo_accion == 'lblcup_accion') {
            objValores.valor_inicial = $("#txtcup_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.cup; /*Valor anterior*/
        }
        if (campo_accion == 'lblr20_accion') {

            objValores.valor_inicial = $("#txtr20_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.r20; /*Valor anterior*/
        }
        if (campo_accion == 'lblaccion_tipo_predio') {
            objValores.valor_inicial = $("#lsttipo_predio").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.tipo_predio; /*Valor anterior*/
        }
        if (campo_accion == 'lblmtsfte_accion') {

            objValores.valor_inicial = $("#txtmtsfte_frente").val(); /*Valor actual*/
            objValores.valor_final = objFrente_Inicial.mts_frente; /*Valor anterior*/
        }


        return objValores;
    }

    function PrepararTareasAccionesCampos_Editar(obr_estatus, monto_pagado) {
        if (obr_estatus == '2') { /*Si la obra esta en Recaudación */
            if ($("#bodegadatos").data("editar_nombre_coop_obr_rec") == 1) {
                $("#lblnomcoop_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_nombre_coop_obr_rec") == 1) {
                    $("#lblnomcoop_accion").text('?');
                } else {
                    $("#lblnomcoop_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_apaterno_coop_obr_rec") == 1) {
                $("#lblapaterno_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_rec") == 1) {
                    $("#lblapaterno_accion").text('?');
                } else {
                    $("#lblapaterno_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_amaterno_coop_obr_rec") == 1) {
                $("#lblamaterno_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_rec") == 1) {
                    $("#lblamaterno_accion").text('?');
                } else {
                    $("#lblamaterno_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_ctapred_predio_obr_rec") == 1) {
                $("#lblctapred_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_rec") == 1) {
                    $("#lblctapred_accion").text('?');
                } else {
                    $("#lblctapred_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_curp_coop_obr_rec") == 1) {
                $("#lblcurp_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_curp_coop_obr_rec") == 1) {
                    $("#lblcurp_accion").text('?');
                } else {
                    $("#lblcurp_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_ine_coop_obr_rec") == 1) {
                $("#lbline_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_ine_coop_obr_rec") == 1) {
                    $("#lbline_accion").text('?');
                } else {
                    $("#lbline_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_tel_coop_obr_rec") == 1) {
                $("#lbltel_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_tel_coop_obr_rec") == 1) {
                    $("#lbltel_accion").text('?');
                } else {
                    $("#lbltel_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_calle_notific_coop_obr_rec") == 1) {
                $("#lblcalle_notific_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_calle_notific_coop_obr_rec") == 1) {
                    $("#lblcalle_notific_accion").text('?');
                } else {
                    $("#lblcalle_notific_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_colonia_notific_coop_obr_rec") == 1) {
                $("#lblcolonia_notific_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_rec") == 1) {
                    $("#lblcolonia_notific_accion").text('?');
                } else {
                    $("#lblcolonia_notific_accion").text('');
                }
            }


            if ($("#bodegadatos").data("editar_email_coop_obr_rec") == 1) {
                $("#lblemail_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_email_coop_obr_rec") == 1) {
                    $("#lblemail_accion").text('?');
                } else {
                    $("#lblemail_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_relacion_predio_coop_obr_rec") == 1) {
                $("#lblrelpred_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_rec") == 1) {
                    $("#lblrelpred_accion").text('?');
                } else {
                    $("#lblrelpred_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_identific_coop_obr_rec") == 1) {
                $("#lbldocident_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_identific_coop_obr_rec") == 1) {
                    $("#lbldocident_accion").text('?');
                } else {
                    $("#lbldocident_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_numofic_predio_obr_rec") == 1) {
                $("#lblnoofic_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_numofic_predio_obr_rec") == 1) {
                    $("#lblnoofic_accion").text('?');
                } else {
                    $("#lblnoofic_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_lote_predio_obr_rec") == 1) {
                $("#lbllote_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_lote_predio_obr_rec") == 1) {
                    $("#lbllote_accion").text('?');
                } else {
                    $("#lbllote_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_mzna_predio_obr_rec") == 1) {
                $("#lblmanzana_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_mzna_predio_obr_rec") == 1) {
                    $("#lblmanzana_accion").text('?');
                } else {
                    $("#lblmanzana_accion").text('');
                }
            }


            if ($("#bodegadatos").data("editar_imuvi_predio_obr_rec") == 1) {
                $("#lblctaimuvi_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_rec") == 1) {
                    $("#lblctaimuvi_accion").text('?');
                } else {
                    $("#lblctaimuvi_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_sapal_predio_obr_rec") == 1) {
                $("#lblsapal_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_sapal_predio_obr_rec") == 1) {
                    $("#lblsapal_accion").text('?');
                } else {
                    $("#lblsapal_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_cup_predio_obr_rec") == 1) {
                $("#lblcup_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_cup_predio_obr_rec") == 1) {
                    $("#lblcup_accion").text('?');
                } else {
                    $("#lblcup_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_r20_predio_obr_rec") == 1) {
                $("#lblr20_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_r20_predio_obr_rec") == 1) {
                    $("#lblr20_accion").text('?');
                } else {
                    $("#lblr20_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_tipo_predio_obr_rec") == 1) {
                $("#lblnomcoop_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_tipo_predio_obr_rec") == 1) {
                    $("#lblnomcoop_accion").text('?');
                } else {
                    $("#lblnomcoop_accion").text('');
                }
            }

            if ($("#bodegadatos").data("editar_mts_frente_obr_rec") == 1) {
                $("#lblmtsfte_accion").text('>');
            } else {
                if ($("#bodegadatos").data("solicitar_editar_mts_frente_obr_rec") == 1) {
                    $("#lblmtsfte_accion").text('?');
                } else {
                    $("#lblmtsfte_accion").text('');
                }
            }

        } else {
            if (obr_estatus == '4') {
                if ($("#bodegadatos").data("editar_nombre_coop_obr_proc") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblnomcoop_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_nombre_coop_obr_proc") == 1) {
                            $("#lblnomcoop_accion").text('?');
                        }
                        else {
                            $("#lblnomcoop_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_nombre_coop_obr_proc") == 1) {
                        $("#lblnomcoop_accion").text('?');
                    }
                    else {
                        $("#lblnomcoop_accion").text('');
                    }
                }

                if ($("#bodegadatos").data("editar_apaterno_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblapaterno_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_rec") == 1) {
                            $("#lblapaterno_accion").text('?');
                        }
                        else {
                            $("#lblapaterno_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_rec") == 1) {
                        $("#lblapaterno_accion").text('?');
                    }
                    else {
                        $("#lblapaterno_accion").text('');
                    }
                }

                if ($("#bodegadatos").data("editar_amaterno_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblamaterno_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_rec") == 1) {
                            $("#lblamaterno_accion").text('?');
                        }
                        else {
                            $("#lblamaterno_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_rec") == 1) {
                        $("#lblamaterno_accion").text('?');
                    }
                    else {
                        $("#lblamaterno_accion").text('');
                    }
                }


                if ($("#bodegadatos").data("editar_ctapred_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblctapred_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_rec") == 1) {
                            $("#lblctapred_accion").text('?');
                        }
                        else {
                            $("#lblctapred_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_rec") == 1) {
                        $("#lblctapred_accion").text('?');
                    }
                    else {
                        $("#lblctapred_accion").text('');
                    }
                }


                if ($("#bodegadatos").data("editar_curp_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblcurp_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_curp_coop_obr_rec") == 1) {
                            $("#lblcurp_accion").text('?');
                        }
                        else {
                            $("#lblcurp_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_curp_coop_obr_rec") == 1) {
                        $("#lblcurp_accion").text('?');
                    }
                    else {
                        $("#lblcurp_accion").text('');
                    }
                }

                if ($("#bodegadatos").data("editar_ine_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lbline_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_ine_coop_obr_rec") == 1) {
                            $("#lbline_accion").text('?');
                        }
                        else {
                            $("#lbline_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_ine_coop_obr_rec") == 1) {
                        $("#lbline_accion").text('?');
                    }
                    else {
                        $("#lbline_accion").text('');
                    }
                }

                if ($("#bodegadatos").data("editar_tel_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lbltel_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_tel_coop_obr_rec") == 1) {
                            $("#lbltel_accion").text('?');
                        }
                        else {
                            $("#lbltel_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_calle_notific_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblcalle_notific_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_calle_notific_coop_obr_rec") == 1) {
                            $("#lblcalle_notific_accion").text('?');
                        }
                        else {
                            $("#lblcalle_notific_accion").text('');
                        }
                    }
                }


                if ($("#bodegadatos").data("editar_colonia_notific_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblcolonia_notific_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_rec") == 1) {
                            $("#lblcolonia_notific_accion").text('?');
                        }
                        else {
                            $("#lblcolonia_notific_accion").text('');
                        }
                    }
                }


                if ($("#bodegadatos").data("editar_email_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblemail_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_email_coop_obr_rec") == 1) {
                            $("#lblemail_accion").text('?');
                        }
                        else {
                            $("#lblemail_accion").text('');
                        }
                    }
                }


                if ($("#bodegadatos").data("editar_relacion_predio_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblrelpred_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_rec") == 1) {
                            $("#lblrelpred_accion").text('?');
                        }
                        else {
                            $("#lblrelpred_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_identific_coop_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lbldocident_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_identific_coop_obr_rec") == 1) {
                            $("#lbldocident_accion").text('?');
                        }
                        else {
                            $("#lbldocident_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_numofic_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblnoofic_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_numofic_predio_obr_rec") == 1) {
                            $("#lblnoofic_accion").text('?');
                        }
                        else {
                            $("#lblnoofic_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_lote_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lbllote_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_lote_predio_obr_rec") == 1) {
                            $("#lbllote_accion").text('?');
                        }
                        else {
                            $("#lbllote_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_mzna_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblmanzana_accion").text('>');

                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_mzna_predio_obr_rec") == 1) {
                            $("#lblmanzana_accion").text('?');
                        }
                        else {
                            $("#lblmanzana_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_imuvi_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblctaimuvi_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_rec") == 1) {
                            $("#lblctaimuvi_accion").text('?');
                        }
                        else {
                            $("#lblctaimuvi_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_sapal_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblsapal_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_sapal_predio_obr_rec") == 1) {
                            $("#lblsapal_accion").text('?');
                        }
                        else {
                            $("#lblsapal_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_cup_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblcup_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_cup_predio_obr_rec") == 1) {
                            $("#lblcup_accion").text('?');
                        }
                        else {
                            $("#lblcup_accion").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_r20_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblr20_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_r20_predio_obr_rec") == 1) {
                            $("#lblr20_accion").text('?');
                        }
                        else {
                            $("#lblr20_accion").text('');
                        }
                    }
                }


                if ($("#bodegadatos").data("editar_tipo_predio_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblaccion_tipo_predio").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_tipo_predio_obr_rec") == 1) {
                            $("#lblaccion_tipo_predio").text('?');
                        }
                        else {
                            $("#lblaccion_tipo_predio").text('');
                        }
                    }
                }

                if ($("#bodegadatos").data("editar_mts_frente_obr_rec") == 1) {
                    if (monto_pagado == 0) {
                        $("#lblmtsfte_accion").text('>');
                    }
                    else {
                        if ($("#bodegadatos").data("solicitar_editar_mts_frente_obr_rec") == 1) {
                            $("#lblmtsfte_accion").text('?');
                        }
                        else {
                            $("#lblmtsfte_accion").text('');
                        }
                    }
                } else {
                    if ($("#bodegadatos").data("solicitar_editar_mts_frente_obr_rec") == 1) {
                        $("#lblmtsfte_accion").text('?');
                    }
                    else {
                        $("#lblmtsfte_accion").text('');
                    }
                }

            } else {
                if (obr_estatus == '5') {

                    if ($("#bodegadatos").data("editar_nombre_coop_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblnomcoop_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_nombre_coop_obr_cob") == 1) {
                                $("#lblnomcoop_accion").text('?');
                            }
                            else {
                                $("#lblnomcoop_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_nombre_coop_obr_cob") == 1) {
                            $("#lblnomcoop_accion").text('?');
                        }
                        else {
                            $("#lblnomcoop_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_apaterno_coop_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblapaterno_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_cob") == 1) {
                                $("#lblapaterno_accion").text('?');
                            }
                            else {
                                $("#lblapaterno_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_cob") == 1) {
                            $("#lblapaterno_accion").text('?');
                        }
                        else {
                            $("#lblapaterno_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_amaterno_coop_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblamaterno_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_cob") == 1) {
                                $("#lblamaterno_accion").text('?');
                            }
                            else {
                                $("#lblamaterno_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_cob") == 1) {
                            $("#lblamaterno_accion").text('?');
                        }
                        else {
                            $("#lblamaterno_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_ctapred_predio_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblctapred_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_cob") == 1) {
                                $("#lblctapred_accion").text('?');
                            }
                            else {
                                $("#lblctapred_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_cob") == 1) {
                            $("#lblctapred_accion").text('?');
                        }
                        else {
                            $("#lblctapred_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_curp_coop_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblcurp_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_curp_coop_obr_cob") == 1) {
                                $("#lblcurp_accion").text('?');
                            }
                            else {
                                $("#lblcurp_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_curp_coop_obr_cob") == 1) {
                            $("#lblcurp_accion").text('?');
                        }
                        else {
                            $("#lblcurp_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_ine_coop_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lbline_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_ine_coop_obr_cob") == 1) {
                                $("#lbline_accion").text('?');
                            }
                            else {
                                $("#lbline_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_ine_coop_obr_cob") == 1) {
                            $("#lbline_accion").text('?');
                        }
                        else {
                            $("#lbline_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_tel_coop_obr_cob") == 1) {
                        $("#lbltel_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_tel_coop_obr_cob") == 1) {
                            $("#lbltel_accion").text('?');
                        }
                        else {
                            $("#lbltel_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_calle_notific_coop_obr_cob") == 1) {
                        $("#lblcalle_notific_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_calle_notific_coop_obr_cob") == 1) {
                            $("#lblcalle_notific_accion").text('?');
                        }
                        else {
                            $("#lblcalle_notific_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_colonia_notific_coop_obr_cob") == 1) {
                        $("#lblcolonia_notific_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_cob") == 1) {
                            $("#lblcolonia_notific_accion").text('?');
                        }
                        else {
                            $("#lblcolonia_notific_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_email_coop_obr_cob") == 1) {
                        $("#lblemail_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_email_coop_obr_cob") == 1) {
                            $("#lblemail_accion").text('?');
                        }
                        else {
                            $("#lblemail_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_relacion_predio_coop_obr_cob") == 1) {
                        $("#lblrelpred_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_cob") == 1) {
                            $("#lblrelpred_accion").text('?');
                        }
                        else {
                            $("#lblrelpred_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_identific_coop_obr_cob") == 1) {
                        $("#lbldocident_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_identific_coop_obr_cob") == 1) {
                            $("#lbldocident_accion").text('?');
                        }
                        else {
                            $("#lbldocident_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_numofic_predio_obr_cob") == 1) {
                        $("#lblnoofic_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_numofic_predio_obr_cob") == 1) {
                            $("#lblnoofic_accion").text('?');
                        }
                        else {
                            $("#lblnoofic_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_lote_predio_obr_cob") == 1) {
                        $("#lbllote_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_lote_predio_obr_cob") == 1) {
                            $("#lbllote_accion").text('?');
                        }
                        else {
                            $("#lbllote_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_mzna_predio_obr_cob") == 1) {
                        $("#lblmanzana_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_mzna_predio_obr_cob") == 1) {
                            $("#lblmanzana_accion").text('?');
                        }
                        else {
                            $("#lblmanzana_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_imuvi_predio_obr_cob") == 1) {
                        $("#lblctaimuvi_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_cob") == 1) {
                            $("#lblctaimuvi_accion").text('?');
                        }
                        else {
                            $("#lblctaimuvi_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_sapal_predio_obr_cob") == 1) {
                        $("#lblsapal_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_sapal_predio_obr_cob") == 1) {
                            $("#lblsapal_accion").text('?');
                        }
                        else {
                            $("#lblsapal_accion").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_cup_predio_obr_cob") == 1) {
                        $("#lblcup_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_cup_predio_obr_cob") == 1) {
                            $("#lblcup_accion").text('?');
                        }
                        else {
                            $("#lblcup_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_r20_predio_obr_cob") == 1) {
                        $("#lblr20_accion").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_r20_predio_obr_cob") == 1) {
                            $("#lblr20_accion").text('?');
                        }
                        else {
                            $("#lblr20_accion").text('');
                        }
                    }


                    if ($("#bodegadatos").data("editar_tipo_predio_obr_cob") == 1) {
                        $("#lblaccion_tipo_predio").text('>');
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_tipo_predio_obr_cob") == 1) {
                            $("#lblaccion_tipo_predio").text('?');
                        }
                        else {
                            $("#lblaccion_tipo_predio").text('');
                        }
                    }

                    if ($("#bodegadatos").data("editar_mts_frente_obr_cob") == 1) {
                        if (monto_pagado == 0) {
                            $("#lblmtsfte_accion").text('>');
                        }
                        else {
                            if ($("#bodegadatos").data("solicitar_editar_mts_frente_obr_cob") == 1) {
                                $("#lblmtsfte_accion").text('?');
                            }
                            else {
                                $("#lblmtsfte_accion").text('');
                            }
                        }
                    } else {
                        if ($("#bodegadatos").data("solicitar_editar_mts_frente_obr_cob") == 1) {
                            $("#lblmtsfte_accion").text('?');
                        }
                        else {
                            $("#lblmtsfte_accion").text('');
                        }
                    }

                } else {
                    alert('Considerar otros estatus de obras');
                }

            }
        }

        MostrarModalEditCoop();
    }


    function PreparaInterfazEliminacionFrente(objFrente, idusu) {
        $("#lbleliminarfte_fid").text('fid:');
        $("#lbleliminarfte_obr_clv_int").text('obr_clv_int:');
        $("#lbleliminarfte_coop_s").text('Cooperador (SIFIDOC):');
        $("#lbleliminarfte_nomcoop").text('Nombre Cooperador:');
        $("#lbleliminarfte_calle").text('Calle:');
        $("#lbleliminarfte_no_oficial").text('No_Ofcial:');
        $("#lbleliminarfte_colonia").text('Colonia:');
        $("#lbleliminarfte_tramo").text('Tramo:');
        $("#lbleliminarfte_ctapredial").text('CtaPredial:');
        $("#lbleliminarfte_mtsfrente").text('MtsFrente:');
        $("#lbleliminarfte_programa").text('Programa:');
        $("#lbleliminarfte_obr_estatus").text('Estaus de Obra:');
        $("#lbleliminarfte_idusu").text('Id. Usuario:');

        $("#bodegadatos").data("monto_pagado", objFrente.monto_capital_pagado);
        $("#lbleliminarfte_fid_d").text(objFrente.fid);
        $("#lbleliminarfte_obr_clv_int_d").text(objFrente.obr_clv_int);
        $("#lbleliminarfte_coop_s_d").text(objFrente.coop_s);
        $("#lbleliminarfte_nomcoop_d").text(objFrente.mnomficha);
        $("#lbleliminarfte_calle_d").text(objFrente.calle);
        $("#lbleliminarfte_no_oficial_d").text(objFrente.nooficial);
        $("#lbleliminarfte_colonia_d").text(objFrente.colonia);
        $("#lbleliminarfte_tramo_d").text(objFrente.tramo);
        $("#lbleliminarfte_ctapredial_d").text(objFrente.ctapredial);
        $("#lbleliminarfte_mtsfrente_d").text(objFrente.mts_frente);
        $("#lbleliminarfte_programa_d").text(objFrente.nomprog);
        $("#lbleliminarfte_obr_estatus_d").text(objFrente.cestatus);
        $("#lbleliminarfte_idusu_d").text(idusu);

        $("#lblelminarfte_aceptar").text('ACEPTAR');
        $("#lbleliminarfte_cancelar").text('CANCELAR');

    }

    function PreparaInterfazEdicionFrente(objFrente, idusu) {
        /*PERSONA DE COOPERADOR*/
        $("#txtnoms_coop").val(objFrente.mnombres);
        $("#txtapaterno_coop").val(objFrente.mapellidop);
        $("#txtamaterno_coop").val(objFrente.mapellidom);
        $("#txttelefono_coop").val(objFrente.telcoop);
        $("#txtine_coop").val(objFrente.ine);
        $("#txtemail_coop").val(objFrente.mcorreo);
        $("#txtcurp_coop").val(objFrente.mcurp);
        $("#txtdocident_coop").val(objFrente.doc_identific);




        var idrel_pred = objFrente.cidrelpred;
        if (isNaN(idrel_pred)) {
            llenarRelPred_formEdit(idrel_pred, 0);
        }
        else {
            llenarRelPred_formEdit(idrel_pred, 'consultarelpredio');
        }

        if ($("#bodegadatos").data("editar_nombre_coop")) {
            $("#lblnomcoop_accion").text('>');
        }
        else {
            $("#lblnomcoop_accion").text('?');
        }

        $("#lblfid_dato").text(objFrente.fid + ':' + objFrente.pid);
        $("#lblcoop_s_dato").text(objFrente.coop_s);
        $("#lblcid_dato").text(objFrente.midcoop);
        $("#lblidusu_dato").text(idusu.toString());



        /*PREDIO*/

        $("#txtnumofic_predio").val(objFrente.nooficial);
        $("#txtctapred_predio").val(objFrente.ctapredial);

        var ctapredial = objFrente.ctapredial;
        if (ctapredial.length == 12) {
            GetDatosPredial(ctapredial)
        }
        else {
            $("#lblnomprop_padronpred").text('');
            $("#lblcalle_notific_padronpred").text('');
            $("#lblcolonia_notific_padronpred").text('');
            $("#lblcalle_noofic_padronpred").text('');
            $("#lblcolonia_padronpred").text('');
            $("#lblusosuelo_padronpred").text('');
        }


        $("#txtcup_predio").val(objFrente.cup);
        $("#txtctaimuvi_predio").val(objFrente.cta_imuvi);
        $("#txtsapal_predio").val(objFrente.sapal);
        $("#txtr20_predio").val(objFrente.r20);
        $("#txtlote_predio").val(objFrente.lote);
        $("#txtmanzana_predio").val(objFrente.mzna);
        $("#txtmtsfte_frente").val(objFrente.mts_frente);
        $("#lblobr_clv_int_dato").text(objFrente.obr_clv_int);





        var cve_uso_suelo = objFrente.cve_uso_suelo;
        if (isNaN(cve_uso_suelo)) {
            llenarUsoPred_fomEdit(0, 'consultausospredio');
        }
        else {
            llenarUsoPred_formEdit(cve_uso_suelo, 'consultausospredio');
        }



        /*OBRA*/
        $("#lblcalle_obra").text(objFrente.calle);
        $("#lblcolonia_obra").text(objFrente.colonia);
        $("#lbltramo_obra").text(objFrente.tramo);
        var fecinip = objFrente.fecinip;
        var fecfinp = objFrente.fecvenp;

        $("#lblprec_obra").text(objFrente.fecinip + ' - ' + objFrente.fecvenp);
        $("#lblestatus_obra").text(objFrente.cestatus);
        $("#lblnumpag_obra").text(objFrente.obr_npago);
        $("#lblprograma_obra").text(objFrente.nomprog);
        $("#lblestatus_obra").text(objFrente.cestatus);
        $("#lbloid_dato").text(objFrente.oid);
        $("#lblobr_clv_int_dato").text(objFrente.obr_clv_int);


        $("#bodegadatos").data("monto_pagado", objFrente.monto_capital_pagado);

    }





    function RescatarReglasUsuario(idusu, accion) {

        ConsultaReglasUsuario(idusu, accion)
            .done(function (r) {
                var regla = $.trim(r.d);
                if (regla != "<NewDataSet />") {  // Si encontró reglas para el usuario, preparar las propiedades correspondientes
                    var reglas_usu = [];


                    $(r.d).find("regla").each(function () {

                        var objReglaUsu = {
                            "idrol": 0,
                            "crolnombre": '',
                            "croldescripcion": 0,
                            "idaccion": 0,
                            "etiqueta_accion": 0,
                            "idtarea": '',
                            "etiqueta_tarea": 0,
                            "fec_cre": 0,
                            "musuid": '',
                            "musunombre": '',
                            "musucuenta": 0
                        }

                        objReglaUsu.idrol = $(this).find("idrol_r").text();
                        objReglaUsu.crolnombre = $(this).find("crolnombre_r").text();
                        objReglaUsu.croldescripcion = $(this).find("croldescripcion_r").text();
                        objReglaUsu.idaccion = $(this).find("idaccion_r").text();
                        objReglaUsu.etiqueta_accion = $(this).find("etiqueta_accion_r").text();
                        objReglaUsu.idtarea = $(this).find("idtarea_r").text();
                        objReglaUsu.etiqueta_tarea = $(this).find("etiqueta_tarea_r").text();
                        objReglaUsu.fec_cre = $(this).find("fec_cre_r").text();
                        objReglaUsu.musuid = $(this).find("musuid_r").text();
                        objReglaUsu.musunombre = $(this).find("musunombre_r").text();
                        objReglaUsu.musucuenta = $(this).find("musucuenta_r").text();
                        reglas_usu.push(objReglaUsu);
                    });


                    /*Tarea 28: Alta de un cooperador en obra de Recaudación*/
                    var alta_coop_obra_rec = reglas_usu.find(tarea => (tarea.idtarea == 28 && tarea.idaccion == 3));
                    if (alta_coop_obra_rec == null) {
                        $("#bodegadatos").data("alta_coop_obra_rec", 0);
                    }
                    else {
                        $("#bodegadatos").data("alta_coop_obra_rec", 1);
                    }

                    /*Tarea 29: Alta de un cooperador en obra de Proceso*/

                    var alta_coop_obra_proc = reglas_usu.find(tarea => (tarea.idtarea == 29 && tarea.idaccion == 3));
                    if (alta_coop_obra_proc == null) {
                        $("#bodegadatos").data("alta_coop_obra_proc", 0);
                    }
                    else {
                        $("#bodegadatos").data("alta_coop_obra_proc", 1);
                    }


                    /*Tarea 34: Alta de un cooperador en una obra de cobranza*/

                    var alta_coop_obra_cob = reglas_usu.find(tarea => (tarea.idtarea == 34 && tarea.idaccion == 3));
                    if (alta_coop_obra_cob == null) {
                        $("#bodegadatos").data("alta_coop_obra_cob", 0);
                    }
                    else {
                        $("#bodegadatos").data("alta_coop_obra_cob", 1);
                    }



                    /*Tarea 30: Eliminar cooperador de una obra en Recaudación*/

                    var eliminar_coop_obra_rec = reglas_usu.find(tarea => (tarea.idtarea == 30 && tarea.idaccion == 3));
                    if (eliminar_coop_obra_rec == null) {
                        $("#bodegadatos").data("eliminar_coop_obra_rec", 0);
                    }
                    else {
                        $("#bodegadatos").data("eliminar_coop_obra_rec", 1);
                    }

                    /*Tarea 31: Eliminar un cooperador de una obra en Proceso*/

                    var eliminar_coop_obra_proc = reglas_usu.find(tarea => (tarea.idtarea == 31 && tarea.idaccion == 3));
                    if (eliminar_coop_obra_proc == null) {
                        $("#bodegadatos").data("eliminar_coop_obra_proc", 0);
                    }
                    else {
                        $("#bodegadatos").data("eliminar_coop_obra_proc", 1);
                    }

                    /*Tarea 36: Eliminar un cooperador de una obra en cobranza*/

                    var eliminar_coop_obra_cob = reglas_usu.find(tarea => (tarea.idtarea == 36 && tarea.idaccion == 3));
                    if (eliminar_coop_obra_cob == null) {
                        $("#bodegadatos").data("eliminar_coop_obra_cob", 0);
                    }
                    else {
                        $("#bodegadatos").data("eliminar_coop_obra_cob", 1);
                    }


                    /*Inicia reglas para poder Editar y Solicitar editar los datos del Cooperador de Obra en los 3 estatus*/

                    var checarEditarObraRec = 0;
                    var checarEditarObraProc = 0;
                    var checarEditarObraCob = 0;

                    var checarSolicitarEditarObraRec = 0;
                    var checarSolicitarEditarObraProc = 0;
                    var checarSolicitarEditarObraCob = 0;

                    /*Tarea 5: Modificar el nombre del cooperador de una OBRA EN RECAUDACIÓN*/

                    var editar_nombre_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 5 && tarea.idaccion == 3));
                    if (editar_nombre_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_nombre_coop_obr_rec", 0);

                        var solicitar_editar_nombre_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 129 && tarea.idaccion == 1));
                        if (solicitar_editar_nombre_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_nombre_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 1: Modificar el apellido paterno del cooperador e una obra en recaudación*/

                    var editar_apaterno_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 1 && tarea.idaccion == 3));
                    if (editar_apaterno_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_rec", 0);
                        var solicitar_editar_apaterno_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 125 && tarea.idaccion == 1));
                        if (solicitar_editar_apaterno_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 3: Modificar el nombre de amaterno del cooperador de la obra recaudación*/

                    var editar_amaterno_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 3 && tarea.idaccion == 3));
                    if (editar_amaterno_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_rec", 0);
                        var solicitar_editar_amaterno_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 127 && tarea.idaccion == 1));
                        if (solicitar_editar_amaterno_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }

                    }
                    else {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 6: Modificar el nombre de calle del domicilio de notificación del cooperador de la obra recaudación*/

                    var editar_calle_notific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 6 && tarea.idaccion == 3));
                    if (editar_calle_notific_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_calle_notific_coop_obr_rec", 0);
                        var solicitar_editar_calle_notific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 130 && tarea.idaccion == 1));
                        if (solicitar_editar_calle_notific_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_calle_notific_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_calle_notific_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_calle_notific_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 7: Modificar el nombre de colonia del domicilio de notificación del cooperador de la obra de recaudación*/

                    var editar_colonia_notific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 7 && tarea.idaccion == 3));
                    if (editar_colonia_notific_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_colonia_notific_coop_obr_rec", 0);
                        var solicitar_editar_colonia_notific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 131 && tarea.idaccion == 1));
                        if (solicitar_editar_colonia_notific_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_colonia_notific_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 8: Modificar el número oficial del domicilio de notificación del cooperador de la obra de recaudación*/

                    var editar_numofic_notif_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 8 && tarea.idaccion == 3));
                    if (editar_numofic_notif_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_rec", 0);
                        var solicitar_editar_numofic_notif_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 132 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_notif_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_notif_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_colonia_notific_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 9: Modificar la cuenta predial del predio de una obra en recaudación*/

                    var editar_ctapred_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 9 && tarea.idaccion == 3));
                    if (editar_ctapred_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_rec", 0);
                        var solicitar_editar_ctapred_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 133 && tarea.idaccion == 1));
                        if (solicitar_editar_ctapred_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 10: Modificar el CURP del cooperador del predio de una obra en recaudación*/

                    var editar_curp_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 10 && tarea.idaccion == 3));
                    if (editar_curp_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_curp_coop_obr_rec", 0);
                        var solicitar_editar_curp_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 134 && tarea.idaccion == 1));
                        if (solicitar_editar_curp_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_curp_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 11: Modificar el INE del cooperador de una obra en recaudación */

                    var editar_ine_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 11 && tarea.idaccion == 3));
                    if (editar_ine_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_ine_coop_obr_rec", 0);
                        var solicitar_editar_ine_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 135 && tarea.idaccion == 1));
                        if (solicitar_editar_ine_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ine_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 9: Modificar el número telefónico del cooperador*/

                    var editar_tel_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 9 && tarea.idaccion == 3));
                    if (editar_tel_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_tel_coop_obr_rec", 0);
                        var solicitar_editar_tel_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 136 && tarea.idaccion == 1));
                        if (solicitar_editar_tel_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tel_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 13: Modificar el email del cooperador*/

                    var editar_email_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 13 && tarea.idaccion == 3));
                    if (editar_email_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_email_coop_obr_rec", 0);
                        var solicitar_editar_email_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 137 && tarea.idaccion == 1));
                        if (solicitar_editar_email_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_email_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 9: Modificar la relación que mantiene el cooperador con el predio*/

                    var editar_relacion_predio_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 14 && tarea.idaccion == 3));
                    if (editar_relacion_predio_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_rec", 0);
                        var solicitar_editar_relacion_predio_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 138 && tarea.idaccion == 1));
                        if (solicitar_editar_relacion_predio_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 15: Modificar el documento de la identificación digital del cooperador*/

                    var editar_identific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 15 && tarea.idaccion == 3));
                    if (editar_identific_coop_obr_rec == null) {
                        $("#bodegadatos").data("editar_identific_coop_obr_rec", 0);
                        var solicitar_editar_identific_coop_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 139 && tarea.idaccion == 1));
                        if (solicitar_editar_identific_coop_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_identific_coop_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 4: Modificar el número oficial del Predio*/

                    var editar_numofic_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 4 && tarea.idaccion == 3));
                    if (editar_numofic_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_numofic_predio_obr_rec", 0);
                        var solicitar_editar_numofic_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 128 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 16: Modificar el número de lote del predio*/

                    var editar_lote_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 16 && tarea.idaccion == 3));
                    if (editar_lote_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_lote_predio_obr_rec", 0);
                        var solicitar_editar_lote_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 140 && tarea.idaccion == 1));
                        if (solicitar_editar_lote_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_lote_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 17: Modificar el número de manzana al que pertenece el predio*/

                    var editar_mzna_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 17 && tarea.idaccion == 3));
                    if (editar_mzna_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_mzna_predio_obr_rec", 0);
                        var solicitar_editar_mzna_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 141 && tarea.idaccion == 1));
                        if (solicitar_editar_mzna_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_mzna_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 18: Modificar la calve de IMUVI del cooperador*/

                    var editar_imuvi_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 18 && tarea.idaccion == 3));
                    if (editar_imuvi_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_rec", 0);
                        var solicitar_editar_imuvi_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 142 && tarea.idaccion == 1));
                        if (solicitar_editar_imuvi_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 19: Modificar el número de referencia de SAPAL */

                    var editar_sapal_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 19 && tarea.idaccion == 3));
                    if (editar_sapal_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_sapal_predio_obr_rec", 0);
                        var solicitar_editar_sapal_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 143 && tarea.idaccion == 1));
                        if (solicitar_editar_sapal_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_sapal_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 20: Modificar el número de referencia CUP, clave única de predio */

                    var editar_cup_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 20 && tarea.idaccion == 3));
                    if (editar_cup_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_cup_predio_obr_rec", 0);
                        var solicitar_editar_cup_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 144 && tarea.idaccion == 1));
                        if (solicitar_editar_cup_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_cup_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 21: Modificar el número de escritura r20*/

                    var editar_r20_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 21 && tarea.idaccion == 3));
                    if (editar_r20_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_r20_predio_obr_rec", 0);
                        var solicitar_editar_r20_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 145 && tarea.idaccion == 1));
                        if (solicitar_editar_r20_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_r20_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }
                    /*Tarea 22: Modificar tipo de predio  */

                    var editar_tipo_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 22 && tarea.idaccion == 3));
                    if (editar_tipo_predio_obr_rec == null) {
                        $("#bodegadatos").data("editar_tipo_predio_obr_rec", 0);
                        var solicitar_editar_tipo_predio_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 146 && tarea.idaccion == 1));
                        if (solicitar_editar_tipo_predio_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tipo_predio_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }

                    /*Tarea 2: Modificar los metros de frente del predio beneficiado  */

                    var editar_mts_frente_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 2 && tarea.idaccion == 3));
                    if (editar_mts_frente_obr_rec == null) {
                        $("#bodegadatos").data("editar_mts_frente_obr_rec", 0);
                        var solicitar_editar_mts_frente_obr_rec = reglas_usu.find(tarea => (tarea.idtarea == 126 && tarea.idaccion == 1));
                        if (solicitar_editar_mts_frente_obr_rec == null) {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_rec", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_rec", 1);
                            checarSolicitarEditarObraRec = 1;
                        }

                    }
                    else {
                        $("#bodegadatos").data("editar_mts_frente_obr_rec", 1);
                        checarEditarObraRec = 1;
                    }




                    /*Inicia rescate de reglas para las obra en proceso*/

                    /*Tarea 5: Modificar el nombre del cooperador de una obra en proceso*/

                    var editar_nombre_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 41 && tarea.idaccion == 3));
                    if (editar_nombre_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_nombre_coop_obr_proc", 0);
                        var solicitar_editar_nombre_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 107 && tarea.idaccion == 1));
                        if (solicitar_editar_nombre_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_nombre_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 1: Modificar el apellido paterno del cooperador e una obra en recaudación*/

                    var editar_apaterno_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 37 && tarea.idaccion == 3));
                    if (editar_apaterno_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_proc", 0);
                        var solicitar_editar_apaterno_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 103 && tarea.idaccion == 1));
                        if (solicitar_editar_apaterno_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 3: Modificar el nombre de amaterno del cooperador de la obra en proceso*/

                    var editar_amaterno_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 39 && tarea.idaccion == 3));
                    if (editar_amaterno_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_proc", 0);
                        var solicitar_editar_amaterno_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 105 && tarea.idaccion == 1));
                        if (solicitar_editar_amaterno_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 6: Modificar el nombre de calle del domicilio de notificación del cooperador de la obra en proceso*/

                    var editar_calle_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 42 && tarea.idaccion == 3));
                    if (editar_calle_notif_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_calle_notif_coop_obr_proc", 0);
                        var solicitar_editar_calle_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 108 && tarea.idaccion == 1));
                        if (solicitar_editar_calle_notif_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_calle_notif_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_calle_notif_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_calle_notif_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 7: Modificar el nombre de colonia del domicilio de notificación del cooperador de la obra en proceso*/

                    var editar_col_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 43 && tarea.idaccion == 3));
                    if (editar_col_notif_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_col_notif_coop_obr_proc", 0);
                        var solicitar_editar_col_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 109 && tarea.idaccion == 1));
                        if (solicitar_editar_col_notif_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_col_notif_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_col_notif_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_col_notif_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 8: Modificar el número oficial del domicilio de notificación del cooperador de la obra en proceso*/

                    var editar_numofic_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 44 && tarea.idaccion == 3));
                    if (editar_numofic_notif_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_proc", 0);
                        var solicitar_editar_numofic_notif_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 110 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_notif_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_notif_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_numofic_notif_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 9: Modificar la cuenta predial del predio dde la obra en proceso*/

                    var editar_ctapred_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 45 && tarea.idaccion == 3));
                    if (editar_ctapred_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_proc", 0);
                        var solicitar_editar_ctapred_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 111 && tarea.idaccion == 1));
                        if (solicitar_editar_ctapred_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 10: Modificar el CURP del cooperador del predio de la obra en proceso*/

                    var editar_curp_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 46 && tarea.idaccion == 3));
                    if (editar_curp_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_curp_coop_obr_proc", 0);
                        var solicitar_editar_curp_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 112 && tarea.idaccion == 1));
                        if (solicitar_editar_curp_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_curp_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 11: Modificar el INE del cooperador de la obra en proceso*/

                    var editar_ine_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 47 && tarea.idaccion == 3));
                    if (editar_ine_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_ine_coop_obr_proc", 0);
                        var solicitar_editar_ine_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 113 && tarea.idaccion == 1));
                        if (solicitar_editar_ine_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ine_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 9: Modificar el número telefónico del cooperador de una obra en proceso*/

                    var editar_tel_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 48 && tarea.idaccion == 3));
                    if (editar_tel_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_tel_coop_obr_proc", 0);
                        var solicitar_editar_tel_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 114 && tarea.idaccion == 1));
                        if (solicitar_editar_tel_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tel_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 13: Modificar el email del cooperador de una obra en proceso*/

                    var editar_email_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 49 && tarea.idaccion == 3));
                    if (editar_email_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_email_coop_obr_proc", 0);
                        var solicitar_editar_email_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 115 && tarea.idaccion == 1));
                        if (solicitar_editar_email_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_email_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 9: Modificar la relación que mantiene el cooperador con el predio de una obra en proceso*/

                    var editar_relacion_predio_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 50 && tarea.idaccion == 3));
                    if (editar_relacion_predio_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_proc", 0);
                        var solicitar_editar_relacion_predio_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 116 && tarea.idaccion == 1));
                        if (solicitar_editar_relacion_predio_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 15: Modificar el documento de la identificación digital del cooperador de una obra en proceso*/

                    var editar_identific_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 51 && tarea.idaccion == 3));
                    if (editar_identific_coop_obr_proc == null) {
                        $("#bodegadatos").data("editar_identific_coop_obr_proc", 0);
                        var solicitar_editar_identific_coop_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 117 && tarea.idaccion == 1));
                        if (solicitar_editar_identific_coop_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_identific_coop_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 4: Modificar el número oficial del Predio de una obra en proceso*/

                    var editar_numofic_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 40 && tarea.idaccion == 3));
                    if (editar_numofic_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_numofic_predio_obr_proc", 0);
                        var solicitar_editar_numofic_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 106 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 16: Modificar el número de lote del predio de una obra en proceso*/

                    var editar_lote_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 52 && tarea.idaccion == 3));
                    if (editar_lote_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_lote_predio_obr_proc", 0);
                        var solicitar_editar_lote_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 118 && tarea.idaccion == 1));
                        if (solicitar_editar_lote_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_lote_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 17: Modificar el número de manzana al que pertenece el predio de una obra en proceso*/

                    var editar_mzna_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 53 && tarea.idaccion == 3));
                    if (editar_mzna_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_mzna_predio_obr_proc", 0);
                        var solicitar_editar_mzna_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 119 && tarea.idaccion == 1));
                        if (solicitar_editar_mzna_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_mzna_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 18: Modificar la calve de IMUVI del cooperador de una obra en proceso*/

                    var editar_imuvi_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 54 && tarea.idaccion == 3));
                    if (editar_imuvi_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_proc", 0);
                        var solicitar_editar_imuvi_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 120 && tarea.idaccion == 1));
                        if (solicitar_editar_imuvi_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 19: Modificar el número de referencia de SAPAL de una obra en proceso*/

                    var editar_sapal_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 55 && tarea.idaccion == 3));
                    if (editar_sapal_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_sapal_predio_obr_proc", 0);
                        var solicitar_editar_sapal_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 121 && tarea.idaccion == 1));
                        if (solicitar_editar_sapal_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_sapal_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 20: Modificar el número de referencia CUP, clave única de predio de una obra en proceso*/

                    var editar_cup_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 56 && tarea.idaccion == 3));
                    if (editar_cup_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_cup_predio_obr_proc", 0);
                        var solicitar_editar_cup_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 122 && tarea.idaccion == 1));
                        if (solicitar_editar_cup_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_cup_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 21: Modificar el número de escritura r20 de una obra en proceso*/

                    var editar_r20_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 57 && tarea.idaccion == 3));
                    if (editar_r20_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_r20_predio_obr_proc", 0);
                        var solicitar_editar_r20_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 123 && tarea.idaccion == 1));
                        if (solicitar_editar_r20_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_r20_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }
                    /*Tarea 22: Modificar tipo de predio de una obra én proceso */

                    var editar_tipo_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 58 && tarea.idaccion == 3));
                    if (editar_tipo_predio_obr_proc == null) {
                        $("#bodegadatos").data("editar_tipo_predio_obr_proc", 0);
                        var solicitar_editar_tipo_predio_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 124 && tarea.idaccion == 1));
                        if (solicitar_editar_tipo_predio_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tipo_predio_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }

                    /*Tarea 2: Modificar los metros de frente del predio beneficiado por una obra en proceso */

                    var editar_mts_frente_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 38 && tarea.idaccion == 3));
                    if (editar_mts_frente_obr_proc == null) {
                        $("#bodegadatos").data("editar_mts_frente_obr_proc", 0);
                        var solicitar_editar_mts_frente_obr_proc = reglas_usu.find(tarea => (tarea.idtarea == 104 && tarea.idaccion == 1));
                        if (solicitar_editar_mts_frente_obr_proc == null) {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_proc", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_proc", 1);
                            checarSolicitarEditarObraProc = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_mts_frente_obr_proc", 1);
                        checarEditarObraProc = 1;
                    }



                    /*Inicia rescate de reglas para las obra en cobranza*/

                    /*Tarea 5: Modificar el nombre del cooperador de una obra en cobranza*/

                    var editar_nombre_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 63 && tarea.idaccion == 3));
                    if (editar_nombre_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_nombre_coop_obr_cob", 0);
                        var solicitar_editar_nombre_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 85 && tarea.idaccion == 1));
                        if (solicitar_editar_nombre_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_nombre_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_nombre_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 1: Modificar el apellido paterno del cooperador e una obra en cobranza*/

                    var editar_apaterno_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 59 && tarea.idaccion == 3));
                    if (editar_apaterno_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_cob", 0);
                        var solicitar_editar_apaterno_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 81 && tarea.idaccion == 1));
                        if (solicitar_editar_apaterno_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_apaterno_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_apaterno_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 3: Modificar el nombre de amaterno del cooperador de la obra en cobranza*/

                    var editar_amaterno_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 61 && tarea.idaccion == 3));
                    if (editar_amaterno_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_cob", 0);
                        var solicitar_editar_amaterno_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 83 && tarea.idaccion == 1));
                        if (solicitar_editar_amaterno_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_amaterno_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_amaterno_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 6: Modificar el nombre de calle del domicilio de notificación del cooperador de la obra en cobranza*/

                    var editar_calle_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 64 && tarea.idaccion == 3));
                    if (editar_calle_notif_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_calle_notif_coop_obr_cob", 0);
                        var solicitar_editar_calle_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 86 && tarea.idaccion == 1));
                        if (solicitar_editar_calle_notif_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_calle_notif_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_calle_notif_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_calle_notif_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 7: Modificar el nombre de colonia del domicilio de notificación del cooperador de la obra en cobranza*/

                    var editar_col_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 65 && tarea.idaccion == 3));
                    if (editar_col_notif_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_col_notif_coop_obr_cob", 0);
                        var solicitar_editar_col_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 87 && tarea.idaccion == 1));
                        if (solicitar_editar_col_notif_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_col_notif_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_col_notif_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_col_notif_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 8: Modificar el número oficial del domicilio de notificación del cooperador de la obra en cobranza*/

                    var editar_numofic_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 66 && tarea.idaccion == 3));
                    if (editar_numofic_notif_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_cob", 0);
                        var solicitar_editar_numofic_notif_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 88 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_notif_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_notif_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_numofic_notif_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_notif_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 9: Modificar la cuenta predial del predio dde la obra en proceso*/

                    var editar_ctapred_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 67 && tarea.idaccion == 3));
                    if (editar_ctapred_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_cob", 0);
                        var solicitar_editar_ctapred_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 89 && tarea.idaccion == 1));
                        if (solicitar_editar_ctapred_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ctapred_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ctapred_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 10: Modificar el CURP del cooperador del predio de la obra en cobranza*/

                    var editar_curp_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 68 && tarea.idaccion == 3));
                    if (editar_curp_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_curp_coop_obr_cob", 0);
                        var solicitar_editar_curp_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 90 && tarea.idaccion == 1));
                        if (solicitar_editar_curp_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_curp_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_curp_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 11: Modificar el INE del cooperador de la obra en proceso*/

                    var editar_ine_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 69 && tarea.idaccion == 3));
                    if (editar_ine_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_ine_coop_obr_cob", 0);
                        var solicitar_editar_ine_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 91 && tarea.idaccion == 1));
                        if (solicitar_editar_ine_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_ine_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_ine_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 9: Modificar el número telefónico del cooperador de una obra en cobranza*/

                    var editar_tel_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 70 && tarea.idaccion == 3));
                    if (editar_tel_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_tel_coop_obr_cob", 0);
                        var solicitar_editar_tel_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 92 && tarea.idaccion == 1));
                        if (solicitar_editar_tel_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tel_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tel_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 13: Modificar el email del cooperador de una obra en cobranza*/

                    var editar_email_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 71 && tarea.idaccion == 3));
                    if (editar_email_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_email_coop_obr_cob", 0);
                        var solicitar_editar_email_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 93 && tarea.idaccion == 1));
                        if (solicitar_editar_email_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_email_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_email_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 9: Modificar la relación que mantiene el cooperador con el predio de una obra en cobranza*/

                    var editar_relacion_predio_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 72 && tarea.idaccion == 3));
                    if (editar_relacion_predio_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_cob", 0);
                        var solicitar_editar_relacion_predio_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 94 && tarea.idaccion == 1));
                        if (solicitar_editar_relacion_predio_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_relacion_predio_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_relacion_predio_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 15: Modificar el documento de la identificación digital del cooperador de una obra en cobranza*/

                    var editar_identific_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 73 && tarea.idaccion == 3));
                    if (editar_identific_coop_obr_cob == null) {
                        $("#bodegadatos").data("editar_identific_coop_obr_cob", 0);
                        var solicitar_editar_identific_coop_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 95 && tarea.idaccion == 1));
                        if (solicitar_editar_identific_coop_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_identific_coop_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_identific_coop_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 4: Modificar el número oficial del Predio de una obra en cobranza*/

                    var editar_numofic_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 62 && tarea.idaccion == 3));
                    if (editar_numofic_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_numofic_predio_obr_cob", 0);
                        var solicitar_editar_numofic_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 84 && tarea.idaccion == 1));
                        if (solicitar_editar_numofic_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_numofic_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_numofic_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 16: Modificar el número de lote del predio de una obra en cobranza*/

                    var editar_lote_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 74 && tarea.idaccion == 3));
                    if (editar_lote_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_lote_predio_obr_cob", 0);
                        var solicitar_editar_lote_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 96 && tarea.idaccion == 1));
                        if (solicitar_editar_lote_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_lote_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_lote_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 17: Modificar el número de manzana al que pertenece el predio de una obra en cobranza*/

                    var editar_mzna_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 75 && tarea.idaccion == 3));
                    if (editar_mzna_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_mzna_predio_obr_cob", 0);
                        var solicitar_editar_mzna_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 97 && tarea.idaccion == 1));
                        if (solicitar_editar_mzna_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mzna_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_mzna_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 18: Modificar la calve de IMUVI del cooperador de una obra en cobranza*/

                    var editar_imuvi_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 76 && tarea.idaccion == 3));
                    if (editar_imuvi_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_cob", 0);
                        var solicitar_editar_imuvi_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 98 && tarea.idaccion == 1));
                        if (solicitar_editar_imuvi_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_imuvi_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_imuvi_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 19: Modificar el número de referencia de SAPAL de una obra en cobranza*/

                    var editar_sapal_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 77 && tarea.idaccion == 3));
                    if (editar_sapal_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_sapal_predio_obr_cob", 0);
                        var solicitar_editar_sapal_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 99 && tarea.idaccion == 1));
                        if (solicitar_editar_sapal_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_sapal_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_sapal_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 20: Modificar el número de referencia CUP, clave única de predio de una obra en cobranza*/

                    var editar_cup_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 78 && tarea.idaccion == 3));
                    if (editar_cup_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_cup_predio_obr_cob", 0);
                        var solicitar_editar_cup_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 100 && tarea.idaccion == 1));
                        if (solicitar_editar_cup_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_cup_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_cup_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 21: Modificar el número de escritura r20 de una obra en cobranza*/

                    var editar_r20_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 79 && tarea.idaccion == 3));
                    if (editar_r20_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_r20_predio_obr_cob", 0);
                        var solicitar_editar_r20_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 101 && tarea.idaccion == 1));
                        if (solicitar_editar_r20_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_r20_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_r20_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }
                    /*Tarea 22: Modificar tipo de predio de una obra en cobranza */

                    var editar_tipo_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 80 && tarea.idaccion == 3));
                    if (editar_tipo_predio_obr_cob == null) {
                        $("#bodegadatos").data("editar_tipo_predio_obr_cob", 0);
                        var solicitar_editar_tipo_predio_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 102 && tarea.idaccion == 1));
                        if (solicitar_editar_tipo_predio_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_tipo_predio_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_tipo_predio_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }

                    /*Tarea 2: Modificar los metros de frente del predio beneficiado por una obra en cobranza */

                    var editar_mts_frente_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 60 && tarea.idaccion == 3));
                    if (editar_mts_frente_obr_cob == null) {
                        $("#bodegadatos").data("editar_mts_frente_obr_cob", 0);
                        var solicitar_editar_mts_frente_obr_cob = reglas_usu.find(tarea => (tarea.idtarea == 82 && tarea.idaccion == 1));
                        if (solicitar_editar_mts_frente_obr_cob == null) {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_cob", 0);
                        }
                        else {
                            $("#bodegadatos").data("solicitar_editar_mts_frente_obr_cob", 1);
                            checarSolicitarEditarObraCob = 1;
                        }
                    }
                    else {
                        $("#bodegadatos").data("editar_mts_frente_obr_cob", 1);
                        checarEditarObraCob = 1;
                    }


                    $("#bodegadatos").data("checarEditarObraRec", checarEditarObraRec); /*Globaliza el indicador de si el usuario puede editar al menos un campo una obra en recaudacion*/
                    $("#bodegadatos").data("checarEditarObraProc", checarEditarObraProc); /*Globaliza el indicador de si el usuario puede editar al menos un campo una obra en proceso*/
                    $("#bodegadatos").data("checarEditarObraCob", checarEditarObraCob)    /*Globaliza el indicador de si el usuario puede editar al menos un campo una obra en Cobranza*/

                    $("#bodegadatos").data("checarSolicitarEditarObraRec", checarSolicitarEditarObraRec); /*Globaliza el indicador de si el usuario puede solicitar editar al menos un campo obra en recaudacion*/
                    $("#bodegadatos").data("checarSolicitarEditarObraProc", checarSolicitarEditarObraProc); /*Globaliza el indicador de si el usuario puede editar al menos solicitar editar un campo de una obra en proceso*/
                    $("#bodegadatos").data("checarSolicitarEditarObraCob", checarSolicitarEditarObraCob)    /*Globaliza el indicador de si el usuario puede al menos solicitar editar un campo de una obra en Cobranza*/
                }

            }).fail(function (r) {
                alert("No fué posible consultar las reglas del usuario.");
            });



    }


    function MostrarModalAltaCoop() {
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
        $("#formcoop").css('top', winH / 2 - $("#formcoop").height() / 2);
        $("#formcoop").css('left', winW / 2 - $("#formcoop").width() / 2);

        //transition effect
        $("#formcoop").fadeIn(2000);
    };


    function MostrarModalEditCoop() {
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
        $("#edit_coop").css('top', winH / 2 - $("#edit_coop").height() / 2);
        $("#edit_coop").css('left', winW / 2 - $("#edit_coop").width() / 2);

        //transition effect
        $("#edit_coop").fadeIn(2000);
    };

    /*evento para llenar el list de calles*/

    $('#button').on('toolbarItemClick',
        function (event, buttonClicked) {
            map.removeInteraction(draw);
            $('#map').css('cursor', 'default');
            accion = buttonClicked.id;
            if (accion == 'altacoop') {
                HabilitarCajasTexto(false);
                draw = new ol.interaction.Draw({
                    source: vSourceFrentes,
                    type: 'Point'
                });
                map.addInteraction(draw);
            }
            if (accion == 'editcoop') {
                HabilitarCajasTexto(false);
                $('#map').css('cursor', 'alias');

            }
            if (accion == 'elimcoop') {
                $('#map').css('cursor', 'pointer');
            }
            if (accion == 'infcoop') {
                $('#map').css('cursor', 'help');
            }
            if (accion == 'exportar') {
                $('#map').css('cursor', 'progress');
                Exportar_pdf('a5', '150');/*formato,resolución*/
                $('#map').css('cursor', 'default');
            }

        });

    /*Prepara la barra de herramientas*/
    $('#button').toolbar({
        content: '#toolbar-options',
        position: 'right',
        style: 'primary',
        event: 'click',
        hideOnClick: true
    });



    closer.onclick = function () {
        overlay.setPosition(undefined);
        closer.blur();
        return false;
    };



    $("#ctapred").on('input', function (e) {
        if (accion != 'elimcoop') {
            var ctapred = $(this).val();
            $("#bodegadatos").data("ctaenpadron", 0)
            if (ctapred.length == 12) {
                callWebServicePred();
            }
            else {
                $("#lblnompropmunic").text('');
                $("#lblcallepropmunic").text('');
                $("#lblcoloniamunic").text('');
                $("#lblmunicdomprop").text('');
                $("#lblmuniccolprop").text('');
                $("#tipousosuelo").text('');
            }
        }
    });

    $(".copiapeganomcoop").click(function (e) {
        if (accion != 'elimcoop') {
            var nombrecompleto = $("#apaterno").val().toUpperCase() + " " + $("#amaterno").val().toUpperCase() + " " + $("#nombrescoop").val().toUpperCase();
            $("#nomfichacoop").val(nombrecompleto);
        }
    });

    $(".clearcoop").click(function (e) {
        limpiarDatosCoop();
        $("#bodegadatos").data("idcoop", 0);
    });


    $(".b_aceptar_observ_adic").click(function (e) {
        $("#bodegadatos").data("observ_adic", $("#txtobserv_adic").val());
        $('#mask, .window').hide();
    });



    $(".getcoop").click(function (e) {
        if (accion != 'elimcoop') {
            var idcoop = $("#cmbNombresReg").val();
            $("#bodegadatos").data("idcoop", idcoop);
            ConsultaCoop(idcoop, 'infcoop')
                .done(function (r) {
                    var cadena2 = $.trim(r.d);
                    if (cadena2 != "<NewDataSet />") {
                        $(r.d).find("coops").each(function () {
                            var apaterno = $(this).find("mapellidopr").text();
                            var amaterno = $(this).find("mapellidomr").text();
                            var nombres = $(this).find("mnombresr").text();
                            var nomficha = $(this).find("mnomfichar").text();
                            var correo = $(this).find("mcorreor").text();
                            var secfno = parseInt($(this).find("secfnor").text());
                            var ssfcno = parseInt($(this).find("ssfcno").text());
                            var clacno = parseInt($(this).find("clacno").text());
                            var callecoop = $(this).find("mcallecoopr").text();
                            var colcoop = $(this).find("mcolcoopr").text();
                            var nooficial = $(this).find("mnooficial_extr").text();
                            var telcoop = $(this).find("mtelcoopr").text();
                            var curp = $(this).find("mcurpr").text();
                            var ine = $(this).find("iner").text();
                            var numrelpredio = $(this).find("mrelacionpredior").text();
                            var relpredio = $(this).find("crelacionpredior").text();
                            var usrcre = parseInt($(this).find("pusrcrer").text());
                            var feccre = ArreglaFecha($(this).find("pfecha_crr").text());
                            var usrmod = parseInt($(this).find("pusrmodr").text());
                            var fecmod = ArreglaFecha($(this).find("pfecmodr").text());
                            var nom_archivo = $(this).find("doc_identificr").text();
                            if (secfno != '') {
                                $("#calle").val(clacno);
                            }
                            $("#apaterno").val(apaterno);
                            $("#amaterno").val(amaterno);
                            $("#nombrescoop").val(nombres);
                            $("#nomfichacoop").val(nomficha);
                            $("#telcoop").val(telcoop);
                            $("#emailcoop").val(correo);
                            $("#curp").val(curp);
                            $("#ine").val(ine);
                            $("#txtcallenotif").val(callecoop);
                            $("#txtnooficnotif").val(nooficial);
                            $("#txtcolnotif").val(colcoop);
                            $("#archivo").text(nom_archivo);
                            llenarRelPred(numrelpredio, 'consultarelpredio');
                        })
                    }
                    else {
                        alert("El cooperador no contiene datos");
                    }
                }).fail(function (r) {
                    alert("No fue posible consultar los datos del cooperador");
                });
        }
    });

    $(".verarchivo").click(function (e) { //Ver documento                   
        var archivo = $("#archivo").text();
        leerArchivo(archivo);
    });
    /*       function barra() {
               var progressbar = $("#progressbar"),
                 progressLabel = $(".progress-label");
   
               progressbar.progressbar({
                   value: false,
                   change: function () {
                       progressLabel.text(progressbar.progressbar("value") + "%");
                   },
                   complete: function () {
                       progressLabel.text("Mapa completo!!");
                       $("#progressbar").hide();
   
                   }
               });
           }
   
           function progress() {
               var progressbar = $("#progressbar");
               var val = progressbar.progressbar("value") || 0;
               progressbar.progressbar("value", val + 1);
               if (val < 99) {
                   setTimeout(progress, 465);
               }          
           }      */





    $(".boton_accion_eliminar_fte").click(function (e) {
        var fid = $("#lbleliminarfte_fid_d").text();
        var idusu = $("#lbleliminarfte_idusu_d").text();

        EliminarFrente(fid, idusu)
        borrapuntosinregistrarseBD();
    });

    $(".salir").click(function (e) {

        $('#mask, .window').hide();

    });





    /*Codigo para mostrar el formulario modal*/

    $(".window .posicion_boton_cancelar_coop").click(function (e) {
        //Cancel the link behavior          

        /*opcion = opcion - 1;*/
        if (accion == 'altacoop') {
            borrapuntosinregistrarseBD();
        }
        $('#mask, .window').hide();

    });


    $(".window .boton_cancelar_edit_coop").click(function (e) {

        $('#mask, .window').hide();

    });

    function EnviarCalidad() {
        SolicitaPresup(idsol, idanu)
            .done(function (r) {
                var resp = r.d;
                var arr = resp.split(":");
                var haycoops = parseInt(arr[2]);
                if (haycoops) {
                    alert("Presupuesto solicitado");
                }
                else {
                    alert("El número de cooperadores capturados no es sufiente para solicitar un presupuesto, la política indica que deben ser 50% + 1 de metros capturados, por lo tanto deben capturar más cooperadores");
                }

            }).fail(function (r) {
                alert("No fué posible solicitar el presupuesto de la zona");
            });
    }







    $(".window .posicion_boton_accion_coop").click(function (e) {

        var fid = $("#bodegadatos").data("fid");
        var pid = $("#bodegadatos").data("pid");
        var cup = $("#cup").val();
        var fecha_cr = new Date();
        var fecha_mo = new Date();
        var usrcre = ArreglarNumUsu($("#bodegadatos").data("idusu"));
        var usrmod = ArreglarNumUsu($("#bodegadatos").data("idusu"));

        var tipo = 0;
        var tipopredio = $("#tipopredio").val();
        var ctapredial = $.trim($("#ctapred").val().toUpperCase());
        var ctaimuvi = $("#ctaimuvi").val();
        var observacio = '';
        var usopredio = $("#tipopredio").val();
        var r20 = $("#r20").val();
        var nooficial = $("#nooficial").val();
        var sapal = $("#recsapal").val();
        var geom = ''/*$("#bodegadatos").data("geompred")*/;
        var mzna = $("#txtmzna").val();
        var lote = $("#txtlote").val();

        var idcoop = $("#bodegadatos").data("idcoop");



        var hayprop = $("#bodegadatos").data("ctaenpadron");

        var objPredio = {
            "pid": pid,
            "cup": cup,
            "fecha_cr": fecha_cr,
            "fecha_mo": fecha_mo,
            "usrcre": usrcre,
            "usrmod": usrmod,
            "tipo": tipo,
            "tipopredio": tipopredio,
            "ctapredial": ctapredial,
            "ctaimuvi": ctaimuvi,
            "observacio": observacio,
            "usopredio": usopredio,
            "r20": r20,
            "nooficial": nooficial,
            "sapal": sapal,
            "mzna": mzna,
            "lote": lote,
            "geom": geom,
            "accion": 'consultapredio'
        }




        if (accion != 'elimcoop') {
            if ($.trim($("#ctapred").val()) != "") {
                if (hayprop) {
                    RevisaCuentaPredial(objPredio)
                        .done(function (r) {
                            var cadena = $.trim(r.d);
                            if (cadena != "<NewDataSet />") {
                                $(r.d).find("Predio").each(function () { /*Si la cuenta predial tiene datos relacionados debemos validar si el predio */
                                    var ctapredial = $(this).find("ctapredialr").text();
                                    var pidr = parseInt($(this).find("pidr").text());
                                    if (pid != pidr) {  // Si el predio encontrado con la cuenta predial es el mismo donde se dió clic (porque un predio puede tener dos o mas frentes)
                                        alert("La cuenta predial: " + ctapredial + ' se encuentra registrada con el predio: ' + pidr + ' por lo tanto no es posible registrar el cooperador')
                                    }
                                    else {
                                        if (validarcoop()) {  /*Valida que los datos del cooperador sean correctos*/
                                            AsignaCoop(idcoop, accion);
                                        }
                                    }
                                })
                            }
                            else {/*Se capturó una cuenta predial pero no se ha usado en otro predio del SIGFIDOC*/
                                if (validarcoop()) {  /*Valida que los datos del cooperador sean correctos*/
                                    AsignaCoop(idcoop, accion);
                                }
                            }

                        }).fail(function (r) {
                            alert("No fue posible consultar la cuenta predial");
                        });
                }
                else {
                    alert("La cuenta predial capturada no pertenece al padrón de predial, por lo tanto no es posible dar de alta el frente con dicha cuenta");
                }

            }
            else {   /*Cuando NO existe una cuenta predial capturada*/
                if (validarcoop()) {   /*Valida que los datos del cooperador sean correctos*/
                    alert("El frente será dado de alta, sin embargo no podrá ser considerado para PAE porque no se asignó CUENTA PREDIAL válida");
                    AsignaCoop(idcoop, accion);
                }
            }
        }
        else {
            EliminarFrente(fid, usrcre);
        }
        map.updateSize();
    });


    function frenteSeleccionado(feature, resolution, dom) {

        var style_simple = new ol.style.Style({
            image: image,/*new ol.style.Circle({
                radius: 7,
                stroke: new ol.style.Stroke({
                    width: 1,
                    color: 'black'
                }),
                fill: new ol.style.Fill({
                    color: 'red'
                })*/
            text: new ol.style.Text({
                font: '15px sans-serif',
                text: etiqueta_frente(feature, resolution, dom),
                fill: new ol.style.Fill({ color: dom.color }),
                offsetX: dom.offsetX,
                offsetY: dom.offsetY,
                stroke: new ol.style.Stroke({
                    color: 'yellow',
                    width: 3
                }),
                placement: dom.placement ? dom.placement : undefined,
                maxAngle: dom.maxangle ? parseFloat(dom.maxangle) : undefined,
                overflow: dom.overflow ? (dom.overflow == 'true') : undefined
            })
        });

        return style_simple;
    }


    function styles(feature, resolution, dom) {
        var tipogeom = feature.getGeometry().getType();
        var stylegral = {
            'Point': new ol.style.Style({
                //image: image,
                text: new ol.style.Text({
                    textAlign: dom.align == '' ? undefined : dom.align,
                    textBaseline: dom.baseline,
                    font: dom.weight + ' ' + dom.size + ' ' + dom.font,
                    text: etiqueta_frente(feature, resolution, dom),
                    fill: new ol.style.Fill({ color: dom.color }),
                    offsetX: dom.offsetX,
                    offsetY: dom.offsetY,
                    stroke: new ol.style.Stroke({
                        color: '#000',
                        width: 1
                    }),
                    placement: dom.placement ? dom.placement : undefined,
                    maxAngle: dom.maxangle ? parseFloat(dom.maxangle) : undefined,
                    overflow: dom.overflow ? (dom.overflow == 'true') : undefined,
                    rotation: parseFloat(dom.rotation)
                })
            }),
            'LineString': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'green',
                    width: 1
                })
            }),
            'MultiLineString': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'green',
                    width: 1
                })
            }),
            'MultiPoint': new ol.style.Style({
                //image: image,
                text: new ol.style.Text({
                    textAlign: dom.align == '' ? undefined : dom.align,
                    textBaseline: dom.baseline,
                    font: dom.weight + ' ' + dom.size + ' ' + dom.font,
                    text: etiqueta_frente(feature, resolution, dom),
                    fill: new ol.style.Fill({ color: dom.color }),
                    offsetX: dom.offsetX,
                    offsetY: dom.offsetY,
                    stroke: new ol.style.Stroke({
                        color: '#000',
                        width: 1
                    }),
                    placement: dom.placement ? dom.placement : undefined,
                    maxAngle: dom.maxangle ? parseFloat(dom.maxangle) : undefined,
                    overflow: dom.overflow ? (dom.overflow == 'true') : undefined,
                    rotation: parseFloat(dom.rotation)
                })
            }),
            'MultiPolygon': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: '#000',
                    width: 0.8
                }),
                fill: new ol.style.Fill({
                    color: '#F3CDC0'
                })

            }),
            'Polygon': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'blue',
                    lineDash: [4],
                    width: 3
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(0, 0, 255, 0.1)'
                })
            }),
            'GeometryCollection': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'magenta',
                    width: 2
                }),
                fill: new ol.style.Fill({
                    color: 'magenta'
                }),
                image: new ol.style.Circle({
                    radius: 10,
                    fill: null,
                    stroke: new ol.style.Stroke({
                        color: 'magenta'
                    })
                })
            }),
            'Circle': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'red',
                    width: 2
                }),
                fill: new ol.style.Fill({
                    color: 'brown'
                })
            })
        }
        return stylegral[tipogeom];
    }

    function styleFunction(feature, resolution) {
        return styles(feature, resolution, misValores.polygons);
    }

    function ArreglaFecha(fecha) {
        var arrfecha = fecha.split("T");
        return arrfecha[0];
    }

    function EliminarFrente(fid, usrcre) {

        var objFrente = {
            "fid": fid,
            "latitud": 0,
            "longitud": 0,
            "mts": 0,
            "cid": 0,
            "coopid": '',
            "pid": 0,
            "oid": 0,
            "obrafidoc": '',
            "obs_grales": '',
            "gid": 0,
            "prid": 0,
            "feccre": '',
            "usucre": usrcre,
            "fecmod": '',
            "usrmod": usrcre,
            "obr_clv_int": 0,
            "coo_clv2": 0,
            "accion": 'elimcoop'
        }

        $('#mask, .window').hide();
        AccionFrente(objFrente) //*Tener cuidado ya que elimina fisicamente el registro.
            .done(function (r) {
                var features = vSourceFrentes.getFeatures();
                for (var i = 0; i < (features.length - 1); i++) {
                    if (features[i].get('fid') == fid) {
                        break;
                    }
                }
                vSourceFrentes.removeFeature(features[i])
                alert("Frente eliminado correctamente")
            }).fail(function (response) {
                alert("El frente no se ha podido eliminar");
            });
    }


    function ArmaVentanaCoop(fid) {
        var coorfter;
        var mtsfter;
        var cidr;
        var pidr;
        var gidr;

        var fusrcrer;
        var ffecha_crr;
        var fusrmodr;
        var ffecha_mor;

        var cupr;
        var ctapredialr;
        var ctaimuvir;
        var usopredior;
        var r20r;
        var nooficialr;
        var sapalr;
        var mzna;
        var lote;
        var coorpredr;

        var pusrcrer;
        var pfecha_crr;
        var pusrmodr;
        var pfecha_mor;
        var nomprop = '', callenotif, letraoficialext, numoficint, colnotif, usosuelo, callenumpred, numoficext, numoficextpred, letraoficextpred, numoficintpred, coloniapred, domanuencia = '', dompredio = '', domnotific = '', numoficnotif, numoficpredio;

        var nomficha;
        var callecoop;
        var colcoop;
        var nooficial;
        var telcoop;
        var relpredio;
        var usrcre;
        var feccre;
        var usrmod;
        var fecmod;


        ConsultaFrente(fid)
            .done(function (r) {
                $(r.d).find("Frente").each(function () {
                    coorfter = $(this).find("coorfter").text();
                    mtsfter = parseFloat($(this).find("mtsfter").text());
                    cidr = parseInt($(this).find("cidr").text());
                    pidr = parseInt($(this).find("pidr").text());
                    gidr = parseInt($(this).find("gidr").text());
                    fusrcrer = parseInt($(this).find("fusrcrer").text());
                    ffecha_crr = ArreglaFecha($(this).find("ffecha_crr").text());
                    fusrmodr = parseInt($(this).find("fusrmodr").text());
                    ffecha_mor = ArreglaFecha($(this).find("ffecha_mor").text());

                    cupr = $(this).find("cupr").text();
                    ctapredialr = $(this).find("ctapredialr").text();
                    ctaimuvir = $(this).find("ctaimuvir").text();
                    usopredior = $(this).find("usopredior").text();
                    r20r = $(this).find("r20r").text();
                    nooficialr = $(this).find("nooficialr").text();
                    sapalr = $(this).find("sapalr").text();
                    mznar = $(this).find("mznar").text();
                    loter = $(this).find("loter").text();
                    coorpredr = $(this).find("coorpredr").text();

                    pusrcrer = parseInt($(this).find("fusrcrer").text());
                    pfecha_crr = ArreglaFecha($(this).find("ffecha_crr").text());
                    pusrmodr = parseInt($(this).find("fusrmodr").text());
                    pfecha_mor = ArreglaFecha($(this).find("ffecha_mor").text());

                    if (isNaN(cidr)) {
                        alert("No está ligado ningúna persona");
                        if (ctapredialr) {
                            var ctapredial, nomprop, dompred, domprop, manzana, lote, tipopred;
                            ConsultaPredial(ctapredialr)
                                .done(function (xml) {
                                    ctapredial = $.trim($("CtaPred", xml).text());
                                    if (ctapredial) {
                                        nomprop = $.trim($("NomProp", xml).text());
                                        dompred = 'Calle: ' + $.trim($("DomPred", xml).text()) + ' ' + $.trim($("NumExt", xml).text()) + ' ' + $.trim($("LetraExt", xml).text()) + ' ' + $.trim($("NumInt", xml).text()) + ' Colonia: ' + $.trim($("ColPred", xml).text());
                                        domprop = 'Calle: ' + $.trim($("DomProp", xml).text()) + ' ' + $.trim($("NumExtP", xml).text()) + ' ' + $.trim($("LetraExtP", xml).text()) + ' ' + $.trim($("NumIntP", xml).text()) + ' Colonia: ' + $.trim($("ColProp", xml).text());
                                        manzana = $.trim($("Manzana", xml).text());
                                        lote = $.trim($("Lote", xml).text());
                                        tipopred = $.trim($("TipPred", xml).text());
                                        content.innerHTML = '<table class="letratabla"><tr><th>Metros</th><th>CoopID</th><th>pID</th><th>fID</th></tr>'
                                            + '<tr><td>' + mtsfter + '</td><td>' + cidr + '</td><td>' + pidr + '</td><td>' + fid + '<td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL COOPERADOR</th></tr>'
                                            + '<tr><td colspan=2>Cooperador:</td><td colspan=2>' + nomficha + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Coop (FIDOC):</td><td colspan=2>' + domanuencia + '</td></tr>'
                                            + '<tr><td colspan=2>Tel:</td><td colspan=2>' + telcoop + '</td><td>'
                                            + '<tr><td colspan=2>Relación cooperador:</td><td colspan=2>' + relpredio + '</td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL PREDIO (PADRON PREDIAL)</th></tr>'
                                            + '<tr><td colspan=2>Cta_Predial:</td><td colspan=2>' + ctapredialr + '</td></tr>'
                                            + '<tr><td colspan=2>Propietario:</td><td colspan=2>' + nomprop + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Predio</td><td colspan=2>' + dompred + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Prop.</td><td colspan=2>' + domprop + '</td></tr>'
                                            + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + manzana + '</td></tr>'
                                            + '<tr><td colspan=2>Lote:</td><td colspan=2>' + lote + '</td></tr>'
                                            + '<tr><td colspan=2>Uso predio (PREDIAL):</td><td colspan=2>' + tipopred + '</td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL PREDIO FIDOC</th></tr>'
                                            + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                            + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                            + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                            + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                            + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                            + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
                                            + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + mznar + '</td></tr>'
                                            + '<tr><td colspan=2>Lote:</td><td colspan=2>' + loter + '</td></tr>'
                                            + '</table>'
                                    }
                                    else {
                                        alert("No se tiene cuenta predial registrada");
                                    }
                                })
                                .fail(function (r) {
                                    alert("No pudieron consultarse los datos de predial");
                                });
                        }
                        else {
                            content.innerHTML = '<table class="letratabla"><tr><th>Metros</th><th>CoopID</th><th>pID</th><th>fID</th></tr>'
                                + '<tr><td>' + mtsfter + '</td><td>' + cidr + '</td><td>' + pidr + '</td><td>' + fid + '<td></tr>'
                                + '<tr><th colspan=4>DATOS DEL COOPERADOR</th></tr>'
                                + '<tr><td colspan=2>Cooperador:</td><td colspan=2>' + nomficha + '</td></tr>'
                                + '<tr><td colspan=2>Domic. Coop (FIDOC):</td><td colspan=2>' + domanuencia + '</td></tr>'
                                + '<tr><td colspan=2>Tel:</td><td colspan=2>' + telcoop + '</td></tr>'
                                + '<tr><td colspan=2>Relación cooperador:</td><td colspan=2>' + relpredio + '</td></tr>'
                                + '<tr><th colspan=4>DATOS DEL PREDIO (PADRON PREDIAL)</th></tr>'
                                + '<tr><td colspan=2>Cta_Predial:</td><td colspan=2>' + 'NO CAPTURADA' + '</td></tr>'
                                + '<tr><td colspan=2>Propietario:</td><td colspan=2>' + nomprop + '</td></tr>'
                                + '<tr><td colspan=2>Domic. Predio</td><td colspan=2>' + dompred + '</td></tr>'
                                + '<tr><td colspan=2>Domic. Prop.</td><td colspan=2>' + domprop + '</td></tr>'
                                + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + manzana + '</td></tr>'
                                + '<tr><td colspan=2>Lote:</td><td colspan=2>' + lote + '</td></tr>'
                                + '<tr><td colspan=2>Uso predio (PREDIAL):</td><td colspan=2>' + tipopred + '</td></tr>'
                                + '<tr><th colspan=4>DATOS DEL PREDIO FIDOC</th></tr>'
                                + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
                                + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + mznar + '</td></tr>'
                                + '<tr><td colspan=2>Lote:</td><td colspan=2>' + loter + '</td></tr>'
                                + '</table>'


                        }
                    }
                    else {
                        ConsultaCoop(cidr, 'infcoop')
                            .done(function (r) {
                                $(r.d).find("coops").each(function () {
                                    nomficha = $(this).find("mnomfichar").text();
                                    callecoop = $(this).find("mcallecoopr").text();
                                    colcoop = $(this).find("mcolcoopr").text();
                                    nooficial = $(this).find("mnooficial_extr").text();
                                    telcoop = $(this).find("mtelcoopr").text();
                                    relpredio = $(this).find("crelacionpredior").text();
                                    usrcre = parseInt($(this).find("usrcrer").text());
                                    feccre = ArreglaFecha($(this).find("feccrer").text());
                                    usrmod = parseInt($(this).find("usrmodr").text());
                                    fecmod = ArreglaFecha($(this).find("fecmodr").text());
                                    domanuencia = callecoop + ' ' + nooficial + ' ' + colcoop;

                                    if (ctapredialr) {
                                        var ctapredial, nomprop, dompred, domprop, manzana, lote, tipopred;
                                        ConsultaPredial(ctapredialr)
                                            .done(function (xml) {
                                                ctapredial = $.trim($("CtaPred", xml).text());
                                                if (ctapredial) {
                                                    nomprop = $.trim($("NomProp", xml).text());
                                                    dompred = 'Calle: ' + $.trim($("DomPred", xml).text()) + ' ' + $.trim($("NumExt", xml).text()) + ' ' + $.trim($("LetraExt", xml).text()) + ' ' + $.trim($("NumInt", xml).text()) + ' Colonia: ' + $.trim($("ColPred", xml).text());
                                                    domprop = 'Calle: ' + $.trim($("DomProp", xml).text()) + ' ' + $.trim($("NumExtP", xml).text()) + ' ' + $.trim($("LetraExtP", xml).text()) + ' ' + $.trim($("NumIntP", xml).text()) + ' Colonia: ' + $.trim($("ColProp", xml).text());
                                                    manzana = $.trim($("Manzana", xml).text());
                                                    lote = $.trim($("Lote", xml).text());
                                                    tipopred = $.trim($("TipPred", xml).text());
                                                    content.innerHTML = '<table class="letratabla"><tr><th>Metros</th><th>CoopID</th><th>pID</th><th>fID</th></tr>'
                                                        + '<tr><td>' + mtsfter + '</td><td>' + cidr + '</td><td>' + pidr + '</td><td>' + fid + '<td></tr>'
                                                        + '<tr><th colspan=4>DATOS DEL COOPERADOR</th></tr>'
                                                        + '<tr><td colspan=2>Cooperador:</td><td colspan=2>' + nomficha + '</td></tr>'
                                                        + '<tr><td colspan=2>Domic. Coop (FIDOC):</td><td colspan=2>' + domanuencia + '</td></tr>'
                                                        + '<tr><td colspan=2>Tel:</td><td colspan=2>' + telcoop + '</td><td>'
                                                        + '<tr><td colspan=2>Relación cooperador:</td><td colspan=2>' + relpredio + '</td></tr>'
                                                        + '<tr><th colspan=4>DATOS DEL PREDIO (PADRON PREDIAL)</th></tr>'
                                                        + '<tr><td colspan=2>Cta_Predial:</td><td colspan=2>' + ctapredialr + '</td></tr>'
                                                        + '<tr><td colspan=2>Propietario:</td><td colspan=2>' + nomprop + '</td></tr>'
                                                        + '<tr><td colspan=2>Domic. Predio</td><td colspan=2>' + dompred + '</td></tr>'
                                                        + '<tr><td colspan=2>Domic. Prop.</td><td colspan=2>' + domprop + '</td></tr>'
                                                        + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + manzana + '</td></tr>'
                                                        + '<tr><td colspan=2>Lote:</td><td colspan=2>' + lote + '</td></tr>'
                                                        + '<tr><td colspan=2>Uso predio (PREDIAL):</td><td colspan=2>' + tipopred + '</td></tr>'
                                                        + '<tr><th colspan=4>DATOS DEL PREDIO FIDOC</th></tr>'
                                                        + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                                        + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                                        + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                                        + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                                        + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                                        + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
                                                        + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + mznar + '</td></tr>'
                                                        + '<tr><td colspan=2>Lote:</td><td colspan=2>' + loter + '</td></tr>'
                                                        + '</table>'
                                                }
                                                else {
                                                    alert("No se tiene cuenta predial registrada");
                                                }
                                            })
                                            .fail(function (r) {
                                                alert("No pudieron consultarse los datos de predial");
                                            });
                                    }
                                    else {
                                        content.innerHTML = '<table class="letratabla"><tr><th>Metros</th><th>CoopID</th><th>pID</th><th>fID</th></tr>'
                                            + '<tr><td>' + mtsfter + '</td><td>' + cidr + '</td><td>' + pidr + '</td><td>' + fid + '<td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL COOPERADOR</th></tr>'
                                            + '<tr><td colspan=2>Cooperador:</td><td colspan=2>' + nomficha + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Coop (FIDOC):</td><td colspan=2>' + domanuencia + '</td></tr>'
                                            + '<tr><td colspan=2>Tel:</td><td colspan=2>' + telcoop + '</td></tr>'
                                            + '<tr><td colspan=2>Relación cooperador:</td><td colspan=2>' + relpredio + '</td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL PREDIO (PADRON PREDIAL)</th></tr>'
                                            + '<tr><td colspan=2>Cta_Predial:</td><td colspan=2>' + 'NO CAPTURADA' + '</td></tr>'
                                            + '<tr><td colspan=2>Propietario:</td><td colspan=2>' + nomprop + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Predio</td><td colspan=2>' + dompred + '</td></tr>'
                                            + '<tr><td colspan=2>Domic. Prop.</td><td colspan=2>' + domprop + '</td></tr>'
                                            + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + manzana + '</td></tr>'
                                            + '<tr><td colspan=2>Lote:</td><td colspan=2>' + lote + '</td></tr>'
                                            + '<tr><td colspan=2>Uso predio (PREDIAL):</td><td colspan=2>' + tipopred + '</td></tr>'
                                            + '<tr><th colspan=4>DATOS DEL PREDIO FIDOC</th></tr>'
                                            + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                            + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                            + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                            + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                            + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                            + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
                                            + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + mznar + '</td></tr>'
                                            + '<tr><td colspan=2>Lote:</td><td colspan=2>' + loter + '</td></tr>'
                                            + '</table>'
                                    }
                                })
                            }).fail(function (r) {
                                alert("No fue posible consultar los datos del cooperador");
                            })
                    }
                })

            }).fail(function (r) {
                alert("No fue posible consultar los datos del frente");
            });
    }



    function ArreglarNumUsu(idusu) {
        var arr = idusu.split("#");
        return arr[0];
    }

    function ConsultaPredial(ctapredial) {
        var urlctapred = "http://201.116.205.135:8081/ccgleon/IIC/wss_DatPredial.php?sCtaPred=" + ctapredial;
        var text;
        return $.ajax({
            url: urlctapred,
            type: "GET",
            dataType: "xml"
        });
    }

    function ConsultaFrente(fid) {
        var enviarObj = {
            "fid": fid,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        return $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServiceFrente.asmx/GetFrente",
            data: "{objFrente:" + stringData + "}"
        });
    }

    function ConsultaCoop(idcoop, accionx) {
        var enviarObj = {
            "idcoop": idcoop,
            "accion": accionx
        }

        var stringData = JSON.stringify(enviarObj);

        return $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; utf-8',
            url: "../../WebServices/WebServiceCoop.asmx/GetCoop",
            data: "{objCoop:" + stringData + "}"
        });
    }

    function RecargaCapaFrentes(obr_clv_int) {
        var url = geoserverConfig.host +'/geoserver/sigFidoc/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc%3Afrentes&maxFeatures=50&outputFormat=application%2Fjson&CQL_FILTER=obr_clv_int=' + obr_clv_int.toString() + ' AND activo = 1';

        return $.ajax({
            url: url,
            dataType: 'json',
            error: function (xhr) {
                alert(xhr.statusText);
            }

        });

    }

    function ConsultaReglasUsuario(idusu, accion) {

        return $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; utf-8',
            url: "../../WebServices/WebServiceRolAccionTarea.asmx/GetUsuAccionTarea",
            data: "{'idusu':'" + idusu + "','accion':'" + accion + "'}",
        });
    }







    function AsignaCoop(idcoop, accion) {

        /*Datos auxiliares o comunes*/
        var oid = $("#lbloid").html();
        var pid = $("#bodegadatos").data("pid");
        var obr_clv = $("#lblobr_clv").html();
        var obr_clv_int = $("#lblobr_clv_int").html();
        var numpagos = $("#lblnumpagos").html();
        var fecvenp = $("#lblfecvenp").html();

        var date = new Date();
        obr_fecha_hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
        var hoy = ConvertirCadenaToFecha(obr_fecha_hoy);

        var usrcrecoop = $("#lblusuario").html();
        var feccrecoop = ConvertirCadenaToFecha(obr_fecha_hoy);
        var usrmodcoop = $("#lblusuario").html();
        var fecmodcoop = ConvertirCadenaToFecha(obr_fecha_hoy);
        // var domcoop = 'Calle: ' + $.trim(callenotif) + ' No.' + $.trim(nooficialnotif) + ' Colonia:' + $.trim(colnotif);/*NO se utilizo*/


        //*Datos del cooperador



        var apaterno = $("#apaterno").val();
        var amaterno = $("#amaterno").val();
        var nombres = $("#nombrescoop").val();
        var callecoop = $("#txtcallenotif").val();
        var colcoop = $("#txtcolnotif").val();
        var numoficialcoop = $("#txtnooficnotif").val();
        var telcoop = $("#telcoop").val();
        var nomficha = $("#nomfichacoop").val();
        var estadocoop = 'GTO';
        var paiscoop = 'México';
        var correocoop = $("#emailcoop").val();

        var curp = $("#curp").val();
        var relacionpredio = parseInt($("#lstrelpred").val());
        var ine = $("#ine").val();
        var doc_identific = $("#file1").get(0).files;
        var nom_archivo_ident_coop = idcoop.toString() + '_ident.pdf';



        var objCoop = {
            "idcoop": idcoop,
            "apellidoP": apaterno,
            "apellidoM": amaterno,
            "nombres": nombres,
            "callecoop": callecoop,
            "colcoop": colcoop,
            "nooficialext": numoficialcoop,
            "nooficialint": '',
            "telcoop": telcoop,
            "nomficha": nomficha,
            "pais": 'México',
            "estado": 'Guanajuato',
            "correo": correocoop,
            "usrcre": usrcrecoop,
            "feccre": hoy,
            "usrmod": usrmodcoop,
            "fecmod": hoy,
            "curp": curp,
            "relpred": relacionpredio,
            "ine": ine,
            "doc": nom_archivo_ident_coop,
            "accion": accion
        }




        //*Datos del frente*/
        var fid = $("#bodegadatos").data("fid");
        var mtsfte = parseFloat($("#mtsfte").val());
        var obra_clv = $("#lblobr_clv").html();
        var obra_clv_int = $("#lblobr_clv_int").html();
        /*var lonlat = ol.proj.transform(geomcoop, 'EPSG:3857', 'EPSG:32614');*/
        var geomcoop = $("#bodegadatos").data("geomfrente");
        var pointOrigen = { x: geomcoop[0], y: geomcoop[1] };
        var pointReproyected = proj4(SourceProjection, DestinationProjections, pointOrigen);
        var longitud = pointReproyected.x;
        var latitud = pointReproyected.y;
        var gid = 0; /*Esta pieza de script no contempla factibilidades, solo obra que ya estan dadas de alta, es decir, "oid" directamente registrados*/
        var obs_grales = '';
        var programa = $("#lblprograma").html();
        var arr_prid = programa.split(':');
        var prid = arr_prid[0];
        /*var coopid_seleccionado = $("#lstcoopssifidoc").val();*/
        var coopid_seleccionado = 0






        var objFrente = {
            "fid": fid,
            "latitud": latitud,
            "longitud": longitud,
            "mts": mtsfte,
            "cid": idcoop,
            "coopid": coopid_seleccionado,
            "pid": pid,
            "oid": oid,
            "obrafidoc": obr_clv,
            "obs_grales": obs_grales,
            "gid": gid,
            "prid": prid,
            "feccre": hoy,
            "usucre": usrcrecoop,
            "fecmod": hoy,
            "usrmod": usrmodcoop,
            "obr_clv_int": obr_clv_int,
            "coo_clv2": 0,
            "accion": accion
        }





        //*Datos del predio*/

        var cup = $("#cup").val();
        var tipo = '0';
        var tipopredio = parseInt($("#tipopredio").val());
        var ctapredial = $.trim($("#ctapred").val().toUpperCase());
        var ctaimuvi = $("#ctaimuvi").val();
        var observacio = '';
        var usopredio = parseInt($("#tipopredio").val());
        var r20 = $("#r20").val();
        var nooficial = $("#nooficial").val();
        var sapal = $("#recsapal").val();
        var mzna = $("#txtmzna").val();
        var lote = $("#txtlote").val();
        var geompred = $("#bodegadatos").data("geompred");


        var objPredio = {
            "pid": pid,
            "cup": cup,
            "fecha_cr": hoy,
            "fecha_mo": hoy,
            "usrcre": parseInt(usrcrecoop),
            "usrmod": parseInt(usrmodcoop),
            "tipo": tipo,
            "tipopredio": tipopredio,
            "ctapredial": ctapredial,
            "ctaimuvi": ctaimuvi,
            "observacio": observacio,
            "usopredio": usopredio,
            "r20": r20,
            "nooficial": nooficial,
            "sapal": sapal,
            "mzna": mzna,
            "lote": lote,
            "geom": '',
            "accion": accion
        }


        /*Datos del cooperador del access*/

        var objCoopAccess = {
            "coo_clv": obr_clv + coopid_seleccionado,
            "coo_pat": apaterno.toUpperCase(),
            "coo_mat": amaterno.toUpperCase(),
            "coo_nom": nombres.toUpperCase(),
            "coo_nof": nooficial,
            "coo_call": callecoop,
            "coo_num": numoficialcoop,
            "coo_col": colcoop,
            "coo_ciu": 'León',
            "coo_est": 'Gto.',
            "coo_cp": '',
            "coo_tel": telcoop,
            "coo_lote": lote,
            "coo_ant": 0,
            "coo_npag": numpagos,
            "coo_venc1": fecvenp,
            "coo_obr": obr_clv,
            "coo_mts": mtsfte,
            "coo_inc": 0,
            "coo_clv1": coopid_seleccionado,
            "coo_pred": ctapredial,
            "coo_nombre": nomficha.toUpperCase(),
            "coo_pagos": 0,
            "coo_cargos": 0,
            "coo__gto_req": 0,
            "coo_gto_ejec": 0,
            "coo_notificado": '01/01/1900',
            "coo_requerido": '01/01/1900',
            "coo_ejecutado": '01/01/1900',
            "coo_ultimoaviso": '01/01/1900',
            "coo_propx": 0,
            "coo_rfc": '',
            "coo_fiscal": '',
            "coo_razonsoc": '',
            "coo_grupo": '',
            "coo_fecgrupo": '01/01/1900',
            "coo_dec": 0,
            "coo_transferida": 0,
            "accion": 1    /*Se pone para definir el atributo del objeto en cada opcion se cambia la acción*/
        }



        /**************************************/
        /******* No se contempla domicilio de notificacion de acuerdo al catalogo de desarrollo urbano, 
        porque los domicilios los da la gente directamente y muchas veces no coinciden con las calles del catalogo*/
        /**************************************/


        if (accion == 'altacoop') {

            //objCoopAccess.accion = 1;  /*Alta de cooperador en ACCESS */
            InsertarCoop(objCoop)
                .done(function (r) {
                    if (parseInt(idcoop) == 0) {
                        var msgresultCoop = r.d;
                        var msgresultCoop = msgresultCoop.split(":");
                        idcoop = parseInt(msgresultCoop[1]);
                        objFrente.cid = idcoop;
                    }

                    objCoop.doc = idcoop.toString() + '_IDENT.pdf';


                    ValidacionGuardadoArchivo(doc_identific, objCoop.doc);
                    ActualizaPredio(objPredio)
                        .done(function (r) {
                            AccionFrente(objFrente)
                                .done(function (r) {
                                    mensaje = r.d;
                                    /*arr_mensaje = mensaje.split(":");
                                    objCoopAccess.coo_clv1 = arr_mensaje[2];
                                    objCoopAccess.coo_clv = objCoopAccess.coo_obr + objCoopAccess.coo_clv1;
      
                                    if (coopid_seleccionado == '000') { /*Si seleccionó crear un nuevo cooperador
                                        objCoopAccess.accion = 1;
                                    } else {
                                        objCoopAccess.accion = 2;
                                        objCoopAccess.coo_clv = objCoopAccess.coo_obr + coopid_seleccionado;
                                    }*/
                                    $("#bodegadatos").data("idcoop", "");
                                    RecargaCapaFrentes(objFrente.obr_clv_int)
                                        .done(function (result) {
                                            var format = vSourceFrentes.getFormat();
                                            vSourceFrentes.forEachFeature(function (feature) {
                                                vSourceFrentes.removeFeature(feature)
                                            });
                                            var features = format.readFeatures(result);
                                            vSourceFrentes.addFeatures(features);

                                        }).fail(function (response) {
                                            console.log("Error, no fue posible mostrar la capa de frentes");
                                        });
                                    /* objCoopAccess.coo_dec = 1;  /*Para activar el campo a 1 y que no aparezca
                                     GuardarCoopAccess(objCoopAccess)
                                      .done(function (r) {
                                          console.log("Se guardó el frente en ACCESS");
                                          $("#bodegadatos").data("idcoop", "");
                                          RecargaCapaFrentes(objFrente.obr_clv_int)
                                             .done(function (result) {
                                                 var format = vSourceFrentes.getFormat();
                                                 vSourceFrentes.forEachFeature(function (feature) {
                                                     vSourceFrentes.removeFeature(feature)
                                                 });
                                                 var features = format.readFeatures(result);
                                                 vSourceFrentes.addFeatures(features);
                                             }).fail(function (response) {
                                                 console.log("Error, no fue posible mostrar la capa de frentes");
                                             });
       
                                      }).fail(function (response) {
                                          alert("Error, no fue posible guardar cooperador en BD de ACCESS");
                                      });*/
                                })
                                .fail(function (x) {
                                    alert("No fué posible guardar los datos del frente en BD PostgresSQL");
                                });
                        })
                        .fail(function (x) {
                            alert("No fue posible actualizar los datos del predio");
                        });
                })
                .fail(function (x) {
                    alert("No fué posible guardar los datos del cooperador...");
                });

            $('#mask, .window').hide();
        }

        if (accion == 'editcoop') {
            objCoopAccess.accion = 2;  /*Actualización de cooperador en ACCESS */
            objCoop.nomarchivo_ident = idcoop.toString() + '_IDENT.pdf';
            InsertarCoop(objCoop)
                .done(function (r) {
                    if (idcoop == 0) {
                        var msgresultCoop = r.d;
                        var msgresultCoop = msgresultCoop.split(":");
                        idcoop = parseInt(msgresultCoop[1]);
                    }
                    ValidacionGuardadoArchivo(doc_identific, objCoop.nomarchivo_ident);
                    ActualizaPredio(objPredio)
                        .done(function (r) {
                            AccionFrente(objFrente)
                                .done(function (r) {
                                    objCoopAccess.coo_dec = 1;

                                    GuardarCoopAccess(objCoopAccess)
                                        .done(function (r) {
                                            console.log("Se guardó el frente")
                                        })
                                        .fail(function (x) {
                                            alert("No fué posible guardar los datos del cooperador en ACCESS")
                                        })

                                })
                                .fail(function (x) {
                                    alert("No fué posible guardar los datos del frente")
                                })
                        })
                        .fail(function (x) {
                            console.log("No fué posible guardar los datos del predio")
                        })
                })
                .fail(function (x) {
                    alert("No fué posible guardar los datos del cooperador...");
                });
            $('#mask, .window').hide();
        }

    }


    //if mask is clicked
    $('#mask').click(function () {
        if (accion == 'altacoop') {
            borrapuntosinregistrarseBD();
        }
        $(this).hide();
        $('.window').hide();
    });


    function borrapuntosinregistrarseBD() {
        var features = vSourceFrentes.getFeatures();
        var fid;
        for (var i = 0; i < (features.length - 1); i++) {
            fid = features[i].get('fid');
            if (!fid) {
                break;
            }
        }
        vSourceFrentes.removeFeature(features[i]);
        map.updateSize();
    }




    function ActualizaPredio(objPredio) {


        var stringData = JSON.stringify(objPredio);

        return $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePredio.asmx/GetPredio",
            data: "{objPredio:" + stringData + "}"
        });
    }




    function AccionFrente(objFrente) { /*Inserta los registros de los documentos en la tabla de mDocumento*/


        var stringData = JSON.stringify(objFrente);

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceFrente.asmx/ActFrente",
            data: "{objFrente:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    alert("Se ejecutó correctamente el proceso con datos del frente");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Existe un error");
            }
        });
    }

    function MostrarDatosPredio(pid) {
        /*RevisaCuentaPredial(pid, cup, fecha_cr, fecha_mo, usrcre, usrmod, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geom, accion)*/


        limpiarDatosPredio();

        var objPredio = {
            "pid": pid,
            "cup": '',
            "fecha_cr": '',
            "fecha_mo": '',
            "usrcre": 1,
            "usrmod": 1,
            "tipo": 'A',
            "tipopredio": 0,
            "ctapredial": '',
            "ctaimuvi": '',
            "observacio": '',
            "usopredio": 1,
            "r20": '',
            "nooficial": '',
            "sapal": '',
            "mzna": '',
            "lote": '',
            "geom": '',
            "accion": 'consultaprediopid'
        }


        RevisaCuentaPredial(objPredio)
            .done(function (r) {
                $(r.d).find("Predio").each(function () {
                    var tipo_predio = parseInt($(this).find("usopredior").text());
                    $("#ctapred").val($(this).find("ctapredialr").text());
                    $("#ctaimuvi").val($(this).find("ctaimuvir").text());
                    $("#cup").val($(this).find("cupr").text());
                    $("#recsapal").val($(this).find("sapalr").text());
                    $("#nooficial").val($(this).find("nooficialr").text());
                    $("#r20").val($(this).find("r20r").text());
                    $("#txtmzna").val($(this).find("mznar").text());
                    $("#txtlote").val($(this).find("loter").text());
                    if (isNaN(tipo_predio)) {
                        llenarUsoPred(0, 'consultausospredio');
                    }
                    else {
                        llenarUsoPred(tipo_predio, 'consultausospredio');
                    }

                    if ($("#ctapred").val() != '') {
                        callWebServicePred();
                    }
                })

            }).fail(function (r) {
                alert("No fue posible consultar los datos del predio");
            });

    }


    function RevisaCuentaPredial(objPredio) {


        var stringData = JSON.stringify(objPredio);

        return $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePredio.asmx/GetPredio",
            data: "{objPredio:" + stringData + "}"
        });
    }

    function GuardarCoopAccess(objCoopS) { /**/


        var stringData = JSON.stringify(objCoopS);

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceCoop.asmx/RegCoop_Access",
            data: "{objCoopS:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            sucess: function (data) {
                if (data.d != null) {
                    console.log("Se guardo el cooperador correctamente en ACCESS")
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }

    function InsertarCoop(objCoop) { /**/


        var stringData = JSON.stringify(objCoop);

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceCoop.asmx/GuardarCoop",
            data: "{objCoop:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            sucess: function (data) {
                if (data.d != null) {
                    console.log("Se guardo el cooperador correctamente")
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }


    function LeerFrente(accion, fid) { /**/

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceFrente.asmx/GetFrenteFinanc",
            data: "{'accion':'" + accion + "','fid':'" + fid + "'}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            sucess: function (data) {
                if (data.d != null) {
                    console.log("")
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            }
        });
    }

    function llenarCoopsSIFIDOC(obr_clv, coopid) {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            data: "{obr_clv:" + obr_clv + "}",
            url: "../../WebServices/WebServiceCoop.asmx/GetCoopSIFIDOC",
            /*url: "../../WebServices/WebServiceCoop.asmx/GetCoopSIFIDOC",*/
            success: function (data) {
                var elementos = 0;
                $("#lstcoopssifidoc").html('');
                $(data.d).find("coops_sifidoc").each(function () {
                    var option = $(document.createElement('option'));
                    var idcoop = $(this).find("coo_clv1").text();
                    var nom_coop = $(this).find("coo_nombre").text();
                    var no_ofic = $(this).find("coo_nof").text();

                    option.html(idcoop + '||' + nom_coop + '||' + no_ofic);
                    option.val(idcoop);
                    $("#lstcoopssifidoc").append(option);
                });
                var option_adicional = $(document.createElement('option'));
                option_adicional.html('Nuevo COOP en SIFIDOC');
                option_adicional.val('000');
                $("#lstcoopssifidoc").append(option_adicional);
                if (obr_clv != '') {
                    $("#lstcoopssifidoc").val(coopid);
                }

            },
            error: function (xhr) {
                console.log(xhr.responseText);
            }
        });
    }



    function Exportar_pdf(formato, resolucion) {
        /*Dimensiones para la impresion*/
        var dims = {
            a0: [1189, 841],
            a1: [841, 594],
            a2: [594, 420],
            a3: [420, 297],
            a4: [297, 210],
            a5: [210, 148]
        };

        var dim = dims[formato];
        var width = Math.round(dim[0] * resolucion / 26);
        var height = Math.round(dim[1] * resolucion / 22);
        var size = map.getSize();
        var viewResolution = map.getView().getResolution();


        var mapCanvas = document.createElement('canvas');
        mapCanvas.width = width;
        mapCanvas.height = height;
        var mapContext = mapCanvas.getContext('2d');
        Array.prototype.forEach.call(document.querySelectorAll('.ol-layer canvas'), function (canvas) {
            if (canvas.width > 0) {
                var opacity = canvas.parentNode.style.opacity;
                mapContext.globalAlpha = opacity === '' ? 1 : Number(opacity);
                var transform = canvas.style.transform;
                // Get the transform parameters from the style's transform matrix
                var matrix = transform.match(/^matrix\(([^\(]*)\)$/)[1].split(',').map(Number);
                // Apply the transform to the export map context
                CanvasRenderingContext2D.prototype.setTransform.apply(mapContext, matrix);
                mapContext.drawImage(canvas, 0, 0);
            }
        });
        var pdf = new jsPDF('landscape', undefined, formato);
        pdf.addImage(mapCanvas.toDataURL('image/jpeg'), 'JPEG', 0, 0, dim[0], dim[1]);


        var frentes = vSourceFrentes.getFeatures();
        var obra = vSourceObra.getFeatures();
        var predios = vectorPredios.getFeatures();
        var prop_obra = obra[0].values_;


        var prop_pred = predios[0].values_;
        var numFrentes = vectorFrentes.getSource().getFeatures().length;

        pdf.addPage('letter', 'landscape');

        /*var geojson = new ol.format.GeoJSON();
        var frentes_geojson = geojson.writeFeatures(frentes);*/


        /**TITULO**/

        pdf.text(130, 10, "Relación de FRENTES de la OBRA", 'center');

        /*DATOS DE FACTIBILIDAD*/

        var encabezado = "oid:" + prop_obra.oid + "\nCALLE:" + prop_obra.calle + "\nCOLONIA:" + prop_obra.colonia + "\nTramo:" + prop_obra.tramo;


        /*MATRIZ DE FRENTES*/
        var totalPagesExp = '{total_pages_count_string}'
        var columns = ['fid', 'coop_sifidoc', 'mts_frente', 'pid', 'NoOficial', 'ctaimuvi', 'ctapredial', 'sapal', 'r20', 'CUP'];
        var currentpage = 0;
        var total_mts = 0;
        var result = [];
        var prop_frente;



        for (var i = 0; i < numFrentes; i += 1) {
            prop_frente = frentes[i].values_;
            var x = Object.assign(prop_frente);
            total_mts = total_mts + prop_frente.mts_frente;
            result.push([prop_frente.fid,
            prop_frente.obr_clv + prop_frente.coopid,
            prop_frente.mts_frente,
            prop_frente.pid,
            prop_frente.nooficial,
            prop_frente.ctaimuvi,
            prop_frente.ctapredial,
            prop_frente.sapal,
            prop_frente.r20,
            prop_frente.cup]);
        }


        pdf.autoTable(columns, result, {
            margin: { horizontal: 5, top: 52 },
            headerStyles: {
                halign: 'center',
                fontSize: 7,

            },
            /*columnStyles: {
                0: { cellWidth: 5 },
                1: { cellWidth: 5 },
                2: { cellWidth: 10 },
                3: { cellWidth: 10 },
                4: { cellWidth: 10 },
                5: { cellWidth: 10 },
                6: { cellWidth: 10 }
            },*/
            styles: {
                valign: 'middle',
                overflow: 'linebreak',
                rowHeight: 5,
                fontSize: 6
            },
            beforePageContent: function (data) {
                pdf.setFontSize(12);
                pdf.text(10, 20, encabezado);
            },
            afterPageContent: function (data) {
                if (currentpage < pdf.internal.getNumberOfPages()) {
                    pdf.setFontSize(10);
                    var str = "Página: " + pdf.internal.getNumberOfPages();
                    str = str + " de " + totalPagesExp;
                    pdf.text(str, 220, pdf.internal.pageSize.height - 10);
                    var d = new Date();
                    var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
                    var strTime = d.getHours() + ":" + d.getMinutes();
                    pdf.text(strDate + '|' + strTime + '|' + idusu.toString(), 10, pdf.internal.pageSize.height - 10);
                    currentpage = pdf.internal.getNumberOfPages();
                }
            }

        });


        if (typeof pdf.putTotalPages === 'function') {
            pdf.putTotalPages(totalPagesExp);
        }

        pdf.setFontSize(12);
        var strTotales = "Total de FRENTES: " + numFrentes + "\nTotal de metros beneficiados: " + total_mts;
        pdf.text(strTotales, 10, pdf.internal.pageSize.height - 24);


        pdf.save('map.pdf');


        // Reset original map size
        map.setSize(size);
        map.getView().setResolution(viewResolution);
        /*exportButton.disabled = false;*/
        /*document.body.style.cursor = 'auto';*/


        // Set print size
        /* var printSize = [width, height];
         map.setSize(printSize);
         var scaling = Math.min(width,height);
         map.getView().setResolution(viewResolution / scaling);*/
    }

});