
/*Variables globales*/
var accion = 'infcoop';
var draw, select = null;


/*Funciones para validar*/

function checkLength(largo, n, min, max) {
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
    $("#formcoop").css('top', winH / 2 - $("#formcoop").height() / 2);
    $("#formcoop").css('left', winW / 2 - $("#formcoop").width() / 2);

    //transition effect
    $("#formcoop").fadeIn(2000);
}




/*Borrar punto sin guardar en BD serán siempre etiquetados con -1*/


function validarcoop() {
    var valid = checkLength($("#apaterno").val().length, "Apellino Paterno", 1, 40);            /*Valida la longitud del Apellido Paterno*/
    valid = valid && checkLength($("#amaterno").val().length, "Apellino Materno", 1, 40);            /*Valida la longitud del Apellido Materno*/
    valid = valid && checkLength($("#nombrescoop").val().length, "Nombre(s)", 1, 60);
    valid = valid && checkRegexp($("#nomfichacoop").val(), /^([ a-zA-Z0-9áéíóúüñÑÁÉÍÓÚ\.\#])+$/i, "Debes introducir nombre del cooperador");
    valid = valid && checkRegexp($("#nooficnotif").val(), /^([0-9]+)[\w-]+|(S\/N)|(s\/n)$/i, "Introduce S/N si no existe número");
    valid = valid && checkVacio($("#telcoop").val(), /^([0-9]{3})+(-){0,1}([0-9]{3})+(-){0,1}([0-9]{4})+$/i, "Introduce el teléfono correctamente");
    valid = valid && checkVacio($("#emailcoop").val(), /^[\w-+]+(\.[\w-]{1,62}){0,126}@[\w-]{1,63}(\.[\w-]{1,62})+[\w-]+$/, "Introduce dirección email correctamente ejem.: micorreo@dominio.com");
    valid = valid && checkVacio($("#curp").val(), /^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$/, "Introduce CURP correctamente.");
    valid = valid && checkVacio($("#ine").val(), /^([0-9]{13})/i, "Introduce cuenta unica de predio");
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
    valid = valid && checkVacio($("#ctapred").val(), /^([0-9]{2})+([a-zA-Z]{1})+([a-cA-C]{1})+([0-9]{8})+$/i, "Introduce correctamente la cuenta predial");
    valid = valid && checkRegexp($("#mtsfte").val(), /^[0-9]+([.])?([0-9]+)?$/, "Introduce correctamente los metros de frente");
    valid = valid && checkRegexp($("#nooficial").val(), /^([0-9 \-a-zA-Z])|(S\/N)|(s\/n)+$/i, "999 - AAA Introduce S/N si no existe número");
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


function llenarColonias(cvesector, cvesubsector, cvecalle) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceCalCol.asmx/GetColonias",
        data: "",
        success: function (data) {
            var elementos = 0;
            $("#colonia").html('');
            $(data.d).find("ColoniasDU").each(function () {
                var option = $(document.createElement('option'));
                var sector = $(this).find("CveSector").text();
                var subsector = $(this).find("CveSubsector").text();
                var colnom = $(this).find("Colonia").text();
                option.html(colnom);
                option.val(sector + "*" + subsector);
                $("#colonia").append(option);
            });
            if (cvesector != 0) { //Si la clave de sector es diferente de 0, es decir si el registro es para editar
                $("#colonia").val(cvesector + "*" + cvesubsector);
            }
            //llenarCalles((cvesector + "*" + cvesubsector), cvecalle);                        
            llenarCalles($("#colonia").val(), cvecalle);
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}

function llenarCalles(cvecolonia, cvecallesel) {
    var arr = cvecolonia.split("*");
    var colonia = arr[0] + arr[1];
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceCalCol.asmx/GetCalles",
        data: "{'parametro':'" + colonia + "'}",
        success: function (data) {
            $("#calle").html('');
            // Data.d trae un string con el XML generado dentro del servicio web asmx
            $(data.d).find("CallesDU").each(function () {
                var option = $(document.createElement('option'));
                var cvecalle = $(this).find("CveCalle").text();
                var callenom = $(this).find("Calle").text();
                option.html(callenom);
                option.val(cvecalle);
                $("#calle").append(option);
            });
            if (cvecallesel > 0) {
                $("#calle").val(cvecallesel);
            }
        },
        error: function (response) {
            if (response.length != 0)
                alert(response);
        }
    });
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
        url: "../../WebServices/WebServiceCoop.asmx/GetCoop",
        data: "{objCoop:" + stringData + "}",
        success: function (data) {
            var elementos = 0;
            $("#cmbNombresReg").html('');
            $(data.d).find("coops").each(function () {
                var option = $(document.createElement('option'));
                var idcoop = $(this).find("mIdCoopr").text();
                var nombre = $(this).find("mNomFichar").text();
                option.html(nombre);
                option.val(idcoop);
                $("#cmbNombresReg").append(option);
            });
            if (cidcoop != 0) { //Se pregunta si el id del cooperador es diferente de cero para la modalidad de edición y ubicar el combo en el valor que se quiere editar
                $("#cmbNombresReg").val(cidcoop);
            }
        },
        error: function (xhr) {
            console.log(xhr.responseText);
        }
    });
}



function llenarRelPred(idrelpredio) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceRelCoopPred.asmx/ConsultaRelCoopPredio",
        data: '',
        success: function (data) {
            var elementos = 0;
            $("#lstrelpred").html('');
            $(data.d).find("AllRelPred").each(function () {
                var option = $(document.createElement('option'));
                var idrelpred = $(this).find("cidrelpred").text();
                var relpred = $(this).find("crelacionpredio").text();
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

function llenarUsoPred(idusopredio) {
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json",
        url: "../../WebServices/WebServiceUsoPredio.asmx/ConsultaUsoPredio",
        data: '',
        success: function (data) {
            var elementos = 0;
            $("#tipopredio").html('');
            $(data.d).find("AllUsoPred").each(function () {
                var option = $(document.createElement('option'));
                var idusopred = $(this).find("cTUSueId").text();
                var usopred = $(this).find("cTUSueNombre").text();
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
}

function limpiarDatosFrente() {
    $("#mtsfte").val('');
}

function limpiarDatosPredio() {
    $("#ctapred").val('');
    $("#ctaimuvi").val('');
    $("#cup").val('');
    $("#recsapal").val('');
    $("#nooficial").val('');
    $("#r20").val('');
    $("#tipopredio").val('');
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
        size: '13px',
        offsetX: '0',
        offsetY: '0',
        color: 'blue',
        outline: '#ffffff',
        outlineWidth: '4',
        maxreso: '1200'
    }
}

function etiqueta_frente(feature, resolution, dom) {

    var type = dom.text;
    var maxResolution = dom.maxreso;
    var att = feature.getProperties();
    var text = 'fid:' + att.fid + ',pid:' + att.pid;
    if (resolution > maxResolution) {
        text = '';
    }
    return text;
}


function HabilitarCajasTexto(estatus) {
    $("#cmbNombresReg").prop("disabled", estatus);
    $("#apaterno").prop("disabled", estatus);
    $("#amaterno").prop("disabled", estatus);
    $("#nombrescoop").prop("disabled", estatus);
    $("#ine").prop("disabled", estatus);
    $("#nomfichacoop").prop("disabled", estatus);
    $("#nooficnotif").prop("disabled", estatus);
    $("#telcoop").prop("disabled", estatus);
    $("#emailcoop").prop("disabled", estatus);
    $("#curp").prop("disabled", estatus);
    $("#ctapred").prop("disabled", estatus);
    $("#mtsfte").prop("disabled", estatus);
    $("#nooficial").prop("disabled", estatus);
    $("#r20").prop("disabled", estatus);
    $("#recsapal").prop("disabled", estatus);
    $("#ctaimuvi").prop("disabled", estatus);
    $("#cup").prop("disabled", estatus);
    $("#calle").prop("disabled", estatus);
    $("#colonia").prop("disabled", estatus);
    $("#lstrelpred").prop("disabled", estatus);
    $("#tipopredio").prop("disabled", estatus);
    $("#file1").prop("disabled", estatus);
    $("#archivo").prop("disabled", estatus);
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
    var idsol = getParameterByName('idsol');
    var idusu = getParameterByName('idusu');
    var idanu = getParameterByName('idanu');

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
    //var parametro = recuperarParametro("gid"); /*Recupera valor de factibilidad*/

    var oid = recuperarParametro("oid"); /*Recupera valor de la solicitud*/
    var obr_clv_int = recuperarParametro("obr_clv_int");
    var obr_clv = recuperarParametro("obr_clv");
    var programa = recuperarParametro("programa");
    var idusu = recuperarParametro("idusu"); /*Recupera valor de usuario*/
    var fid = recuperarParametro("fid"); /*Recupera valor de usuario*/




    $("#bodegadatos").data("idusu", idusu);

    var vectorSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return 'http://192.168.1.5:8090/geoserver/sigFidoc1/ows?service=WFS' +
                '&version=1.0.0&request=GetFeature&typeName=sigFidoc1:vw_predios_fidoc' +
                '&outputFormat=application%2Fjson&CQL_FILTER=gid=' + parametro.toString();
        }
    });

    var vectorPredFidoc = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return 'http://192.168.1.5:8090/geoserver/sigFidoc1/ows?service=WFS' +
                '&version=1.0.0&request=GetFeature&typeName=sigFidoc1:vw_predios_fuente' +
                '&outputFormat=application%2Fjson&CQL_FILTER=gid=' + parametro.toString();
        }
    });

    var vSourceFact = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return 'http://192.168.1.5:8090/geoserver/sigFidoc1/ows?service=WFS&' +
                'version=1.0.0&request=GetFeature&typeName=sigFidoc1:factibilidad&' +
                'outputFormat=application%2Fjson&CQL_FILTER=gid=' + parametro.toString();
        }

    });

    var vSourceFrentes = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function (extent) {
            return 'http://192.168.1.5:8090/geoserver/sigFidoc1/ows?service=WFS&' +
                'version=1.0.0&request=GetFeature&typeName=sigFidoc1:vw_frentes_v2&' +
                'outputFormat=application%2Fjson&CQL_FILTER=gid=' + parametro.toString();
        }
    });

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



    /*var source = new VectorSource({ wrapX: false });*/ /*Esta línea es del ejemplo*/

    var vectorPred = new ol.layer.Vector({
        source: vectorSource,
        style: styleFunction
    });

    var vectorPredAsignados = new ol.layer.Vector({
        source: vectorSource,
        style: styleFunction
    });


    /*capa vectorial de factibilidades se configuró el propio estilo*/
    var vectorFacti = new ol.layer.Vector({
        source: vSourceFact,
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
        layers: [raster, vectorFacti, vectorPredAsignados],
        target: document.getElementById('map'),
        overlays: [overlay],
        view: new ol.View({
            center: [-11319096.234, 2406669.952],
            maxzoom: 23,
            zoom: 19.2
        })
    });

    /* Se ejecuta en el lugar 2 */
    vSourceFact.on('addfeature', function (evt) {
        if (vSourceFact.getState() == 'ready') {
            var numFacti = evt.feature.values_.gid; /*Existen poligonos de factibilidad*/

            if (numFacti) {
                var feature = evt.feature;
                var coords = feature.getGeometry().getCoordinates();
                var coord = feature.getGeometry().getExtent();
                centro = ol.extent.getCenter(coord);
                x = centro[0];
                y = centro[1];
                map.getView().setCenter(centro);
                $('#map').css('cursor', 'wait');
            }
            else {
                alert("NO SE ENCUENTRA POLIGONO DE FACTIBILIDAD.");
                /*window.close();*/
            }
        }
    });

    /*  vectorSource.on('addfeature', function (evt) {
          if (vectorSource.getState() == 'ready') {
              var numPrediosIntersectan = evt.target.V.length; /*Existen poligonos de predios que intersectan con la factibilidad*/
    /*          if (numPrediosIntersectan) {
                  $('#map').css('cursor', 'wait');                                   
              }
              else {
                  alert("No existen predios que se intersecten,favor de dar de alta predios");
                  window.close();
              }
          }
      });


      /* Se ejecuta en el lugar  3 */
    /*vectorPredAsignados.getSource().on('change', function (evt) {
        var source = evt.target;
        if (source.getState() === 'ready') {
            numPredAsig = source.getFeatures().length;
            if (numPredAsig) {                                                                
                
            }                    
        }
    });*/

    /* Se ejecuta en el lugar  3 */
    vectorPredAsignados.getSource().on('change', function (evt) {
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



    map.on('click', function (evt) {
        var geompred; //Geometría del predio
        var pid; //Id del predio
        var fid; //Id del frente
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
                var pid = allFeaturesAtPixel[i].get('pid');
                if (pid) {              //Si se encuentra el predio                             
                    geompred = allFeaturesAtPixel[i].getGeometry();
                    $("#bodegadatos").data("geompred", geompred);
                    $("#bodegadatos").data("pid", pid);
                    $("#bodegadatos").data("geomfrente", geomfrente);
                    break;
                }
            }
            limpiarDatosCoop();
            limpiarDatosFrente();
            limpiarDatosPredio();
            $("#lblsolicitud").text(idsol);
            $("#lblfact").text(parametro);
            $("#lblusuario").text(idusu);
            if (accion == 'editcoop' || accion == 'elimcoop') {
                if (fid) {
                    map.removeInteraction(select);
                    select = new ol.interaction.Select({
                        style: new ol.style.Style({
                            image: imageselected
                        })
                    })
                    map.addInteraction(select);

                    ConsultaFrente(fid)
                        .done(function (r) {
                            var cadena = $.trim(r.d);
                            if (cadena != "<NewDataSet />") {  // Si no se encontró frente con el frente seleccionado.
                                $(r.d).find("Frente").each(function () {
                                    $("#bodegadatos").data("fid", fid);
                                    var coorfter = $(this).find("coorfter").text();
                                    var mtsfter = parseFloat($(this).find("mtsfter").text());
                                    var cidr = parseInt($(this).find("cidr").text());
                                    var pidr = parseInt($(this).find("pidr").text());
                                    var gidr = parseInt($(this).find("gidr").text());
                                    $("#bodegadatos").data("idcoop", cidr);
                                    $("#bodegadatos").data("pid", pidr);
                                    var ctapredialr = $(this).find("ctapredial").text();
                                    var fusrcrer = parseInt($(this).find("fusrcrer").text());
                                    var ffecha_crr = ArreglaFecha($(this).find("ffecha_crr").text());
                                    var fusrmodr = parseInt($(this).find("fusrmodr").text());
                                    var ffecha_mor = ArreglaFecha($(this).find("ffecha_mor").text());
                                    $("#mtsfte").val(mtsfter);
                                    llenarNombresCoops(cidr, accion);
                                    MostrarDatosPredio(pidr);
                                    if (!isNaN(cidr)) {
                                        ConsultaCoop(cidr, 'infcoop')
                                            .done(function (r) {
                                                var cadena2 = $.trim(r.d);
                                                if (cadena2 != "<NewDataSet />") {
                                                    $(r.d).find("coops").each(function () {
                                                        var apaterno = $(this).find("mapellidopr").text();
                                                        var amaterno = $(this).find("mapellidomr").text();
                                                        var nombres = $(this).find("mnombresr").text();
                                                        var nomficha = $(this).find("mnomfichar").text();
                                                        var secfno = parseInt($(this).find("secfnor").text());
                                                        var ssfcno = parseInt($(this).find("ssfcno").text());
                                                        var clacno = parseInt($(this).find("clacno").text());
                                                        var callecoop = parseFloat($(this).find("mcallecoopr").text());
                                                        var colcoop = parseInt($(this).find("mcolcoopr").text());
                                                        var nooficial = parseInt($(this).find("mnooficial_extr").text());
                                                        var telcoop = parseInt($(this).find("mtelcoopr").text());
                                                        var curp = $(this).find("mcurpr").text();
                                                        var relpredio = $(this).find("mrelacionpredior").text();
                                                        var usrcre = parseInt($(this).find("pusrcrer").text());
                                                        var feccre = ArreglaFecha($(this).find("pfecha_crr").text());
                                                        var usrmod = parseInt($(this).find("pusrmodr").text());
                                                        var fecmod = ArreglaFecha($(this).find("pfecmodr").text());
                                                        var ine = $(this).find("iner").text();
                                                        var nom_archivo = $(this).find("doc_identificr").text();
                                                        $("#apaterno").val(apaterno);
                                                        $("#amaterno").val(amaterno);
                                                        $("#nombrescoop").val(nombres);
                                                        $("#nomfichacoop").val(nomficha);
                                                        $("#nooficnotif").val(nooficial);
                                                        $("#telcoop").val(telcoop);
                                                        $("#emailcoop").val($(this).find("mcorreor").text());
                                                        $("#curp").val(curp);
                                                        $("#ine").val(ine);
                                                        $("#file1").val('');
                                                        $("#archivo").text(nom_archivo);
                                                        llenarRelPred(relpredio);
                                                        llenarColonias(secfno, ssfcno, clacno);
                                                    })
                                                    MostrarModalCoop();
                                                    if (accion == 'elimcoop') {
                                                        HabilitarCajasTexto(true);
                                                        alert('Se eliminará el frente seleccionado');
                                                    }
                                                }
                                                else {
                                                    alert("No se encuentra asignado algún cooperador.");
                                                }
                                            }).fail(function (r) {
                                                alert("No fué posible consultar los datos del cooperador.");
                                            })
                                    } else {
                                        alert("No se encuentra ligado cooperador al frente.");
                                        MostrarModalCoop();
                                    }
                                })
                            }
                            else {
                                alert("El número de frente se encuentra vacío.");
                            }
                        }).fail(function (r) {
                            alert("No fué posible consultar el frente solicitado.");
                        });

                }
            }
            if (accion == 'altacoop') { //Si la acción es para dar de alta un cooperador o dar de alta solo el frente a un cooperador existente.
                if (geompred) { //Si existe geometria de predio                                                       
                    llenarColonias(0, 0, 0);
                    llenarNombresCoops(0, accion);
                    llenarRelPred(0);
                    llenarUsoPred(0);
                    MostrarModalCoop();
                    MostrarDatosPredio(pid);
                }
                else {
                    alert("El frente no está dentro de un predio");
                    borrapuntosinregistrarseBD();
                }
            }
            if (accion == 'infcoop') {
                if (fid) {
                    ArmaVentanaCoop(fid);
                    overlay.setPosition(geomfrente);
                }
            }
        }

    });



    /*evento para llenar el list de calles*/

    $("#colonia").change(function () {
        llenarCalles($("#colonia").val(), 0);
    });

    $('#button').on('toolbarItemClick',
        function (event, buttonClicked) {
            map.removeInteraction(draw);
            $('#map').css('cursor', 'default');
            accion = buttonClicked.id;
            if (accion == 'altacoop' || accion == 'altafrente') {
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
            if (accion == 'calidad') {
                EnviarCalidad();
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

    $("#colnotif").change(function () {
        llenarCalles($("#colnotif").val(), 0);
    });


    closer.onclick = function () {
        overlay.setPosition(undefined);
        closer.blur();
        return false;
    };

    $(".consultarpred").click(function (e) {
        if (accion != 'elimcoop') {
            callWebServicePred();
        }
    });

    $(".copiapeganomcoop").click(function (e) {
        if (accion != 'elimcoop') {
            var nombrecompleto = $("#nombrescoop").val().toUpperCase() + " " + $("#apaterno").val().toUpperCase() + " " + $("#amaterno").val().toUpperCase();
            $("#nomfichacoop").val(nombrecompleto);
        }
    });

    $(".clearcoop").click(function (e) {
        limpiarDatosCoop();
        limpiarDatosFrente();
        limpiarDatosPredio();
        $("#bodegadatos").data("idcoop", "");
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
                            var callecoop = parseFloat($(this).find("mcallecoopr").text());
                            var colcoop = parseInt($(this).find("mcolcoopr").text());
                            var nooficial = parseInt($(this).find("mnooficial_extr").text());
                            var telcoop = parseInt($(this).find("mtelcoopr").text());
                            var curp = $(this).find("mcurpr").text();
                            var ine = $(this).find("iner").text();
                            var idrelpredio = $(this).find("mrelacionpredior").text();
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
                            $("#nooficnotif").val(nooficial);
                            $("#telcoop").val(telcoop);
                            $("#emailcoop").val(correo);
                            $("#curp").val(curp);
                            $("#ine").val(ine);
                            $("#archivo").text(nom_archivo);
                            llenarRelPred(idrelpredio);
                            llenarColonias(secfno, ssfcno, clacno)
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




    /*Codigo para mostrar el formulario modal*/

    $(".window .posicion_boton_cancelar_coop").click(function (e) {
        //Cancel the link behavior          

        /*opcion = opcion - 1;*/
        if (accion == 'altacoop') {
            borrapuntosinregistrarseBD();
        }
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

    function SolicitaPresup(idsol, idanu) {

        var usrmod = ArreglarNumUsu($("#bodegadatos").data("idusu"));
        var hoy = new Date();

        var enviarObj = {
            "idsol": idsol,
            "idanu": idanu,
            "folio": '',
            "fecentrega": hoy,
            "fecrecibo": hoy,
            "NomPromCalle": '',
            "DomicProm": '',
            "TelProm": '',
            "PromFidoc": '',
            "EstatusAnuencia": 6, /*Valor del estatus de la anuencia en PRESUPUESTO*/
            "usucre": '',
            "feccre": hoy,
            "usumod": usrmod,
            "fecmod": hoy,
            "accion": '3', /*Valor que indica la actualización del estatus de la anuencia*/
            "docdig": ''
        }


        var stringData = JSON.stringify(enviarObj);
        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceAnuencia.asmx/ActAnuencia",
            data: "{objAnu:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    alert(data.d);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus + jqXHR + errorThrown);
            }
        });
    }




    function HabilitarCajasTexto(estatus) {
        $("#cmbNombresReg").prop("disabled", estatus);
        $("#apaterno").prop("disabled", estatus);
        $("#amaterno").prop("disabled", estatus);
        $("#nombrescoop").prop("disabled", estatus);
        $("#nomfichacoop").prop("disabled", estatus);
        $("#nooficnotif").prop("disabled", estatus);
        $("#telcoop").prop("disabled", estatus);
        $("#emailcoop").prop("disabled", estatus);
        $("#curp").prop("disabled", estatus);
        $("#ctapred").prop("disabled", estatus);
        $("#mtsfte").prop("disabled", estatus);
        $("#nooficial").prop("disabled", estatus);
        $("#r20").prop("disabled", estatus);
        $("#recsapal").prop("disabled", estatus);
        $("#ctaimuvi").prop("disabled", estatus);
        $("#cup").prop("disabled", estatus);
        $("#calle").prop("disabled", estatus);
        $("#colonia").prop("disabled", estatus);
        $("#lstrelpred").prop("disabled", estatus);
        $("#tipopredio").prop("disabled", estatus);
        $("#ine").prop("disabled", estatus);
        $("#file1").prop("disabled", estatus);
    };


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

        var idcoop = 0;
        if ($("#bodegadatos").data("idcoop") > 0) {
            idcoop = $("#bodegadatos").data("idcoop");
        }




        if (accion != 'elimcoop') {
            if ($.trim($("#ctapred").val()) != "") {
                RevisaCuentaPredial(pid, cup, fecha_cr, fecha_mo, usrcre, usrmod, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geom, 'consultapredio')
                    .done(function (r) {
                        var cadena = $.trim(r.d);
                        if (cadena != "<NewDataSet />") {
                            $(r.d).find("Predio").each(function () { /*Si la cuenta predial tiene datos relacionados debemos validar si el predio */
                                var ctapredial = $(this).find("ctapredialr").text();
                                var pidr = parseInt($(this).find("pidr").text());
                                if (pid != pidr) {  // Si el predio encontrado con la cuenta predial es el mismo donde se dió clic
                                    alert("La cuenta predial: " + ctapredial + ' se encuentra registrada con el predio: ' + pidr + ' por lo tanto no es posible registrar el cooperador')
                                }
                                else {
                                    if (validarcoop()) {  /*Valida que los datos del cooperador sean correctos*/
                                        AsignaCoop(idcoop);
                                    }
                                }
                            })
                        }
                        else {/*Si existe una cuenta predial capturada y no es válida, es decir, no se encontraron datos con esa cuenta predial, de todas formas hacemos el proceso de guardado*/
                            if (validarcoop()) {  /*Valida que los datos del cooperador sean correctos*/
                                AsignaCoop(idcoop);
                            }
                        }
                    }).fail(function (r) {
                        alert("No fue posible consultar la cuenta predial");
                    });
            }
            else {   /*Cuando NO existe una cuenta predial capturada*/
                if (validarcoop()) {   /*Valida que los datos del cooperador sean correctos*/
                    AsignaCoop(idcoop);
                }
            }

        }
        else {
            EliminarFrente(fid, usrcre);
        }
        map.updateSize();
    });



    function styles(feature, resolution, dom) {
        var tipogeom = feature.getGeometry().getType();
        var stylegral = {
            'Point': new ol.style.Style({
                image: image,
                text: new ol.style.Text({
                    textAlign: dom.align == '' ? undefined : dom.align,
                    textBaseline: dom.baseline,
                    font: dom.weight + ' ' + dom.size + ' ' + dom.font,
                    text: etiqueta_frente(feature, resolution, dom),
                    fill: new ol.style.Fill({ color: dom.color }),
                    offsetX: dom.offsetX,
                    offsetY: dom.offsetY,
                    stroke: new ol.style.Stroke({
                        color: '#fff',
                        width: 2
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
                image: image,
                text: new ol.style.Text({
                    textAlign: dom.align == '' ? undefined : dom.align,
                    textBaseline: dom.baseline,
                    font: dom.weight + ' ' + dom.size + ' ' + dom.font,
                    text: etiqueta_frente(feature, resolution, dom),
                    fill: new ol.style.Fill({ color: dom.color }),
                    offsetX: dom.offsetX,
                    offsetY: dom.offsetY,
                    stroke: new ol.style.Stroke({
                        color: '#fff',
                        width: 2
                    }),
                    placement: dom.placement ? dom.placement : undefined,
                    maxAngle: dom.maxangle ? parseFloat(dom.maxangle) : undefined,
                    overflow: dom.overflow ? (dom.overflow == 'true') : undefined,
                    rotation: parseFloat(dom.rotation)
                })
            }),
            'MultiPolygon': new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'red',
                    width: 0.8
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(102, 0, 102, 0.5)'
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
        $('#mask, .window').hide();
        AccionFrente(fid, 0, 0, 0, 0, '', 0, 0, '', 0, '', usrcre, '', usrcre, accion) //*Tener cuidado ya que elimina fisicamente el registro.
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
                    coorpredr = $(this).find("coorpredr").text();

                    pusrcrer = parseInt($(this).find("fusrcrer").text());
                    pfecha_crr = ArreglaFecha($(this).find("ffecha_crr").text());
                    pusrmodr = parseInt($(this).find("fusrmodr").text());
                    pfecha_mor = ArreglaFecha($(this).find("ffecha_mor").text());

                    if (isNaN(cidr)) {
                        alert("No está ligado ningúna persona");
                        content.innerHTML = '<table class="letratabla"><tr><th>Metros</th><th>CoopID</th><th>pID</th><th>fID</th></tr>'
                            + '<tr><td>' + mtsfter + '</td><td>' + cidr + '</td><td>' + pidr + '</td><td>' + fid + '<td></tr>'
                            + '<tr><th colspan=4>DATOS DEL COOPERADOR</th></tr>'
                            + '<tr><td colspan=2>Cooperador:</td><td colspan=2> POR IDENTIFICAR </td><td>'
                            + '<tr><td colspan=2>Domic. Coop (FIDOC):</td><td colspan=2> SIN DOMICILIO </td><td>'
                            + '<tr><td colspan=2>Tel:</td><td colspan=2> SIN TELEFONO</td><td>'
                            + '<tr><td colspan=2>Relación cooperador:</td><td colspan=2> SIN RELACION</td><td>'
                            + '<tr><th colspan=4>DATOS DEL PREDIO</th></tr>'
                            + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td><td>'
                            + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td><td>'
                            + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td><td>'
                            + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td><td>'
                            + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td><td>'
                            + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td><td>'
                            + '</table>'
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
                                    relpredio = $(this).find("mrelacionpredior").text();
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
                                                        + '<tr><th colspan=4>DATOS DEL PREDIO</th></tr>'
                                                        + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                                        + '<tr><td colspan=2>Propietario:</td><td colspan=2>' + nomprop + '</td></tr>'
                                                        + '<tr><td colspan=2>Cta_Predial:</td><td colspan=2>' + ctapredial + '</td></tr>'
                                                        + '<tr><td colspan=2>Domic. Predio</td><td colspan=2>' + dompred + '</td></tr>'
                                                        + '<tr><td colspan=2>Domic. Prop.</td><td colspan=2>' + domprop + '</td></tr>'
                                                        + '<tr><td colspan=2>Manzana:</td><td colspan=2>' + manzana + '</td></tr>'
                                                        + '<tr><td colspan=2>Lote:</td><td colspan=2>' + lote + '</td></tr>'
                                                        + '<tr><td colspan=2>Uso predio (PREDIAL):</td><td colspan=2>' + tipopred + '</td></tr>'
                                                        + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                                        + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                                        + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                                        + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                                        + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
                                                        + '</table>'
                                                }
                                                else {
                                                    alert("No se encontró la cuenta predial solicitada");
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
                                            + '<tr><th colspan=4>DATOS DEL PREDIO</th></tr>'
                                            + '<tr><td colspan=2>Uso_Predio (FIDOC):</td><td colspan=2>' + usopredior + '</td></tr>'
                                            + '<tr><td colspan=2>No. Oficial:</td><td colspan=2>' + nooficialr + '</td></tr>'
                                            + '<tr><td colspan=2>CUP:</td><td colspan=2>' + cupr + '</td></tr>'
                                            + '<tr><td colspan=2>CTA_IMUVI:</td><td colspan=2>' + ctaimuvir + '</td></tr>'
                                            + '<tr><td colspan=2>R20:</td><td colspan=2>' + r20r + '</td></tr>'
                                            + '<tr><td colspan=2>Cta. SAPAL:</td><td colspan=2>' + sapalr + '</td></tr>'
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

    function RecargaCapaFrentes() {
        var url = 'http://192.168.1.5:8090/geoserver/sigFidoc1/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=sigFidoc1:frentes&outputFormat=application%2Fjson&CQL_FILTER=gid=' + parametro.toString();

        return $.ajax({
            url: url,
            dataType: 'json',
            error: function (xhr) {
                alert(xhr.statusText);
            }

        });

    }


    function AsignaCoop(idcoop) {
        //*Datos del cooperador

        var apaterno = $("#apaterno").val();
        var amaterno = $("#amaterno").val();
        var nombres = $("#nombrescoop").val();

        var callecoop = $("#calle option:selected").text();
        var colcoop = $("#colonia option:selected").text();
        var nooficialext = $("#nooficnotif").val();
        var nooficialint = $("#nooficnotif").val();
        var telcoop = $("#telcoop").val();
        var nomficha = $("#nomfichacoop").val();
        var estado = 'GTO';
        var pais = 'MEXICO';
        var domcoop = 'Calle: ' + $.trim(callecoop) + ' No.' + $.trim(nooficialext) + ' Colonia:' + $.trim(colcoop);
        var email = $("#emailcoop").val();
        var sifidoc = '';
        var usuario = ArreglarNumUsu($("#bodegadatos").data("idusu"));
        var hoy = new Date();
        var curp = $("#curp").val();
        var relpred = parseInt($("#lstrelpred").val());
        var arrcolonia = $("#colonia").val();
        var cvecolonia = arrcolonia.split("*");
        var secfno = parseInt(cvecolonia[0]);
        var sscfno = parseInt(cvecolonia[1]);
        var cvecalle = parseInt($("#calle").val());
        var ine = $("#ine").val();
        var nomarchivo = '';


        var archivo = $("#file1").get(0).files;

        //*Datos del frente*/
        var fid = $("#bodegadatos").data("fid");
        var mtsfte = parseFloat($("#mtsfte").val());
        var geompred = $("#bodegadatos").data("geompred");
        /*var lonlat = ol.proj.transform(geomcoop, 'EPSG:3857', 'EPSG:32614');*/
        var geomcoop = $("#bodegadatos").data("geomfrente");
        var pointOrigen = { x: geomcoop[0], y: geomcoop[1] };
        var pointReproyected = proj4(SourceProjection, DestinationProjections, pointOrigen);
        var longitud = pointReproyected.x;
        var latitud = pointReproyected.y;
        var gid = parseInt(parametro);
        var msgresultCoop;
        var txtidcoopr;


        //*Datos del predio*/
        var pid = $("#bodegadatos").data("pid");
        var cup = $("#cup").val();
        var tipo = 0;
        var tipopredio = $("#tipopredio").val();
        var ctapredial = $.trim($("#ctapred").val().toUpperCase());
        var ctaimuvi = $("#ctaimuvi").val();
        var observacio = '';
        var usopredio = $("#tipopredio").val();
        var r20 = $("#r20").val();
        var nooficial = $("#nooficial").val();
        var sapal = $("#recsapal").val();
        var geompredio = ''/*$("#bodegadatos").data("geompred")*/;


        if (accion == 'altacoop') {
            estanu = 5;
            InsertarCoop(idcoop, apaterno, amaterno, nombres, callecoop, colcoop, nooficialext, nooficialint, telcoop, nomficha, estado, pais, domcoop, email, sifidoc, usuario, hoy, usuario, hoy, curp, relpred, secfno, sscfno, cvecalle, ine, nomarchivo, accion)
                .done(function (r) {
                    if (idcoop == 0) {
                        var msgresultCoop = r.d;
                        var msgresultCoop = msgresultCoop.split(":");
                        idcoop = parseInt(msgresultCoop[1]);
                        nomarchivo = idcoop.toString() + '_IDENT.pdf';
                    }
                    ValidacionGuardadoArchivo(archivo, nomarchivo);
                    ActualizaPredio(pid, cup, hoy, hoy, usuario, usuario, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geompredio, accion)
                        .done(function (r) {
                            AccionFrente(0, latitud, longitud, mtsfte, idcoop, idcoop.toString(), pid, 0, '', gid, hoy, usuario, hoy, usuario, accion)
                                .done(function (r) {
                                    console.log("Se guardó el frente");
                                    $("#bodegadatos").data("idcoop", "");
                                    RecargaCapaFrentes()
                                        .done(function (result) {
                                            var format = vSourceFrentes.getFormat();
                                            vSourceFrentes.forEachFeature(function (feature) {
                                                vSourceFrentes.removeFeature(feature);
                                            });
                                            var features = format.readFeatures(result);
                                            vSourceFrentes.addFeatures(features);
                                        }).fail(function (response) {
                                            alert("Error")
                                        })
                                })
                                .fail(function (x) {
                                    alert("No fué posible guardar los datos del frente");
                                })
                        })
                        .fail(function (x) {
                            alert("No fue posible actualizar los datos del predio");
                        })
                })
                .fail(function (x) {
                    alert("No fué posible guardar los datos del cooperador...");
                });
            $('#mask, .window').hide();
        }

        if (accion == 'editcoop') {
            nomarchivo = idcoop.toString() + '_IDENT.pdf';
            InsertarCoop(idcoop, apaterno, amaterno, nombres, callecoop, colcoop, nooficialext, nooficialint, telcoop, nomficha, estado, pais, domcoop, email, sifidoc, usuario, hoy, usuario, hoy, curp, relpred, secfno, sscfno, cvecalle, ine, nomarchivo, accion)
                .done(function (r) {
                    ValidacionGuardadoArchivo(archivo, nomarchivo);
                    ActualizaPredio(pid, cup, hoy, hoy, usuario, usuario, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geompredio, accion)
                        .done(function (r) {
                            AccionFrente(fid, latitud, longitud, mtsfte, idcoop, idcoop.toString(), pid, 0, '', gid, hoy, usuario, hoy, usuario, accion)
                                .done(function (r) {
                                    console.log("Se guardó el frente")
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


    function ActualizaPredio(pid, cup, fecha_cr, fecha_mo, usrcre, usrmod, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geom, accion) {
        var enviarObj = {
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
            "geom": geom,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        return $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePredio.asmx/GetPredio",
            data: "{objPredio:" + stringData + "}"
        });
    }




    function AccionFrente(fid, latitud, longitud, mts, cid, coopid, pid, oid, obrafidoc, gid, feccre, usucre, fecmod, usrmod, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/
        var enviarObj = {
            "fid": fid,
            "latitud": latitud,
            "longitud": longitud,
            "mts": mts,
            "cid": cid,
            "coopid": coopid,
            "pid": pid,
            "oid": oid,
            "obrafidoc": obrafidoc,
            "gid": gid,
            "feccre": feccre,
            "usucre": usucre,
            "fecmod": fecmod,
            "usrmod": usrmod,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        return $.ajax({
            type: 'POST',
            url: "../../WebServices/WebServiceFrente.asmx/ActFrente",
            data: "{objFrente:" + stringData + "}",
            contentType: 'application/json; utf-8',
            dataType: 'json',
            success: function (data) {
                if (data.d != null) {
                    alert("Se guardó correctamente los datos del frente");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Existe un error");
            }
        });
    }

    function MostrarDatosPredio(pid) {
        /*RevisaCuentaPredial(pid, cup, fecha_cr, fecha_mo, usrcre, usrmod, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geom, accion)*/
        RevisaCuentaPredial(pid, '', '', '', 1, 1, 'A', 0, '', '', '', 1, '', '', '', '', 'consultaprediopid')
            .done(function (r) {
                $(r.d).find("Predio").each(function () {
                    var tipo_predio = parseInt($(this).find("usopredior").text());
                    $("#ctapred").val($(this).find("ctapredialr").text());
                    $("#ctaimuvi").val($(this).find("ctaimuvir").text());
                    $("#cup").val($(this).find("cupr").text());
                    $("#recsapal").val($(this).find("sapalr").text());
                    $("#nooficial").val($(this).find("nooficialr").text());
                    $("#r20").val($(this).find("r20r").text());
                    llenarUsoPred(tipo_predio);
                    if ($("#ctapred").val() != '') {
                        callWebServicePred();
                    }
                })

            }).fail(function (r) {
                alert("No fue posible consultar los datos del predio");
            });

    }


    function RevisaCuentaPredial(pid, cup, fecha_cr, fecha_mo, usrcre, usrmod, tipo, tipopredio, ctapredial, ctaimuvi, observacio, usopredio, r20, nooficial, sapal, geom, accion) {

        var enviarObj = {
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
            "geom": geom,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

        return $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            url: "../../WebServices/WebServicePredio.asmx/GetPredio",
            data: "{objPredio:" + stringData + "}"
        });
    }



    function InsertarCoop(idcoop, apaterno, amaterno, nombres, callecoop, colcoop, nooficialext, nooficialint, telcoop, nomficha, estado, pais, domcoop, email, sifidoc, usuario, hoy, usuario, hoy, curp, relpred, secfno, sscfno, cvecalle, ine, nomarchivo, accion) { /*Inserta los registros de los documentos en la tabla de mDocumento*/
        var enviarObj = {
            "idcoop": idcoop,
            "apellidoP": apaterno,
            "apellidoM": amaterno,
            "nombres": nombres,
            "callecoop": callecoop,
            "colcoop": colcoop,
            "nooficialext": nooficialext,
            "nooficialint": nooficialint,
            "telcoop": telcoop,
            "nomficha": nomficha,
            "pais": pais,
            "estado": estado,
            "dom": domcoop,
            "correo": email,
            "sifidoc": sifidoc,
            "usrcre": usuario,
            "feccre": hoy,
            "usrmod": usuario,
            "fecmod": hoy,
            "curp": curp,
            "relpred": relpred,
            "secfno": secfno,
            "ssfcno": sscfno,
            "clacno": cvecalle,
            "ine": ine,
            "doc": nomarchivo,
            "accion": accion
        }

        var stringData = JSON.stringify(enviarObj);

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
        var facti = vSourceFact.getFeatures();
        var prop_facti = facti[0].values_;
        var numFrentes = vectorFrentes.getSource().getFeatures().length;

        pdf.addPage('letter', 'landscape');

        /*var geojson = new ol.format.GeoJSON();
        var frentes_geojson = geojson.writeFeatures(frentes);*/


        /**TITULO**/

        pdf.text(130, 10, "Relación de FRENTES contenidos en la ANUENCIA", 'center');

        /*DATOS DE FACTIBILIDAD*/

        var encabezado = "id_Solicitud:" + idsol.toString() + "\nid_Factibilidad:" + prop_facti.gid + "\nid_Anuencia:" + idanu.toString() + "\nCALLE:" + prop_facti.callenom + "\nCOLONIA:" + prop_facti.colnom + "\nTramo:" + prop_facti.tramo;


        /*MATRIZ DE FRENTES*/
        var totalPagesExp = '{total_pages_count_string}'
        var columns = ['fid', 'mts_frente', 'pid', 'cid', 'coopid', 'ctaimuvi', 'ctapredial', 'sapal', 'r20', 'CUP'];
        var currentpage = 0;
        var total_mts = 0;
        var result = [];
        for (var i = 0; i < numFrentes; i += 1) {
            prop_facti = frentes[i].values_;
            var x = Object.assign(prop_facti);
            total_mts = total_mts + prop_facti.mts_frente;
            result.push([prop_facti.fid,
            prop_facti.mts_frente,
            prop_facti.pid,
            prop_facti.cid,
            prop_facti.coopid,
            prop_facti.ctaimuvi,
            prop_facti.ctapredial,
            prop_facti.sapal,
            prop_facti.r20,
            prop_facti.CUP,
            ]);
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