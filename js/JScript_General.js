// Declaring valid date character, minimum year and maximum year
var dtCh = "/";
var minYear = 1900;
var maxYear = 2100;

function conMayusculas(e) {
    e.value = e.value.toString().toUpperCase();
}

function allownumbers(e) {
    alert(e);
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    var reg = new RegExp("[0-9.]")
    if (key == 8) {
        keychar = String.fromCharCode(key);
    }
    if (key == 13) {
        key = 8;
        keychar = String.fromCharCode(key);
    }
    return reg.test(keychar);
}

function ColorGotFocus(ctl) {
    //ctl.style.background = "#D0A9F5";
    //ctl.style.background = "#A9A9F5";
    ctl.style.background = "#FF6600";

    ctl.style.color = "white";
    //ctl.style.color = "blue";

    //if (ctl.tagName == 'INPUT')
    ctl.select();
}

function ColorLostFocus(ctl) {
    ctl.style.background = "white";
    ctl.style.color = "black";
    //ctl.value = ctl.value.toUpperCase();
}


function AbreVentanaReporte(reporte, nombreventana) {
    //window.open(reporte,nombreventana,"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=800,height=600,top=0,left=0");									
    window.open(reporte, "REPORTE", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=800,height=600,top=0,left=0");
}

function AbreVentana(ventana) {
    window.open(ventana, "ventana1", "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=1100,height=900,top=0,left=0")
}

function AbreVentanaVariable(ventana, nombreventana, pwidth, pheight, ptop, pleft, centrado) {
    var left = (screen.width / 2) - (pwidth / 2);
    var top = (screen.height / 2) - (pheight / 2);
    //centrado=1=centrado
    //centrado=0=sin centrado

    if (centrado == 0) {
        left = pleft;
        top = ptop;
    }

    //window.open(ventana, nombreventana, "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=" + pwidth + ",height=" + pheight + ",top=" + top + ",left=" + left)
    window.showModalDialog(ventana, nombreventana, "dialogHeight:" + pheight + ";dialogWidth:" + pwidth + ";toolbar:no;location:no;directories:no;status=no;menubar:no;scrollbars:yes;resizable:yes;copyhistory:no;dialogtop:" + top + ";dialogleft:" + left)
}

function AbreVentanaToPrint(ventana, pwidth, pheight, ptop, pleft, centrado) {
    var left = (screen.width / 2) - (250 / 2);
    var top = (screen.height / 2) - (200 / 2);
    //centrado=1=centrado
    //centrado=0=sin centrado

    if (centrado == 0) {
        left = pleft;
        top = ptop;
    }

    window.open(ventana, "ventana1", "toolbar=yes,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=" + pwidth + ",height=" + pheight + ",top=" + top + ",left=" + left)
}

function mensaje(mensaje) {
    alert(mensaje);
    return false
    //window.location.href='../../FormVarias/Default.aspx';
}

function confirmar(mensaje) {
    if ((mensaje == '') || (mensaje == undefined)) {
        return confirm('Deseas Continuar?');
    }
    else return confirm(mensaje);
}

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}

function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this
}

function isDate(dtStr) {
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf(dtCh)
    var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
    var strMonth = dtStr.substring(0, pos1)
    var strDay = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)

    var strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }

    var month = parseInt(strMonth)
    var day = parseInt(strDay)
    var year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        alert("El formato de la fecha debe ser : dd/mm/yyyy")
        return false
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        alert("Introduce un mes valido")
        return false
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        alert("Introduce un dia valido")
        return false
    }
    if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
        alert("Introduce una fecha entre " + minYear + " y " + maxYear)
        return false
    }
    if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        alert("Introduce una fecha valida")
        return false
    }
    return true
}

//---
function esFechaValida(fecha) {
    if (fecha != undefined && fecha.value != "" ) {
        if (!/^\d{2}\/\d{2}\/\d{4}$/.test(fecha.value)) {
            alert("formato de fecha no valida (dd/mm/aaaa)");
            return false;
        }
        
        var dia = parseInt(fecha.value.substring(0, 2), 10);
        var mes = parseInt(fecha.value.substring(3, 5), 10);
        var anio = parseInt(fecha.value.substring(6), 10);

        switch (mes) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                numDias = 31;
                break;
            case 4: case 6: case 9: case 11:
                numDias = 30;
                break;
            case 2:
                if (comprobarSiBisisesto(anio)) { numDias = 29 } else { numDias = 28 };
                break;
            login:
                alert("Fecha introducida erronea");
                return false;
        }

        if (dia > numDias || dia == 0) {
            alert("Fecha introducida erronea");
            return false;
        }
        return true;
    }
}

function comprobarSiBisisesto(anio) {
    if (anio % 4 == 0) {
        if ((anio % 100 == 0) && (anio % 400 != 0)) {
            return false;
        }
        else return true;
    }
    else return false;
}

//---
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g, '');
    if (gMuestraCentavos == false) {
        num = Math.round(num);
    }
    if (isNaN(num))
        num = "0";
    var sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    var cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10)
        cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
        num = num.substring(0, num.length - (4 * i + 3)) + ',' +
    num.substring(num.length - (4 * i + 3));
    //se quitaron los centavos
    if (gMuestraCentavos == false)
    { return (((sign) ? '' : '-') + '$' + num); }
    else
    { return (((sign) ? '' : '-') + '$' + num + '.' + cents); }
}

function numeralsOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function numeralAndPointOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 46) { return true; }
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


function Confirma() {
    var frmc = document.forms[0];
    //vic Confirmacion si se actualiza o no 10/mar/2011
    var pactualizar = confirm("¿Desea guardar Cambios?");
    if (pactualizar) {
        frmc.vactu.value = 1;
        //res = true;
    }
    else {
        frmc.vactu.value = 0;
        //res = false;
    }
    return frmc.fa.value = 1;
    //return res;
}

function PopupPicker(ctl, ptop, pleft, centrado, pDeMaster) {
    var PopupWindow = null;
    var left = (screen.width / 2) - (250 / 2);
    var top = (screen.height / 2) - (200 / 2);
    if (centrado == 0) {
        left = pleft;
        top = ptop;
    }
    settings = 'width=250,height=200,top=' + top + ',left=' + left + ',location=no,directories=no, menubar=no,toolbar=no,status=no, scrollbars=no,resizable=no, dependent=no';
    PopupWindow = window.open('../../FormVarias/DatePicker.aspx?Ctl=' + ctl + '&pDeMaster=' + pDeMaster, 'DatePicker', settings);
    PopupWindow.focus();
}

function PopupMyInputBox(control, pHeadLabel, ptop, pleft, centrado, pDeMaster) {
    var PopupWindow = null;
    var left = (screen.width / 2) - (500 / 2);
    var top = (screen.height / 2) - (150 / 2);
    if (centrado == 0) {
        left = pleft;
        top = ptop;
    }
    settings = 'width=500,height=150,top=' + top + ',left=' + left + ',location=no,directories=no, menubar=no,toolbar=no,status=no, scrollbars=no,resizable=no, dependent=no';
    PopupWindow = window.open('../../FormVarias/frmMyInputBox.aspx?pControl=' + control + '&pDeMaster=' + pDeMaster + '&pHeadLabel=' + pHeadLabel, 'winmyinpbox', settings);
    PopupWindow.focus();
    //Popupwindow=window.showModalDialog('../../FormVarias/frmMyInputBox.aspx?pControl=' + control + '&pDeMaster='+pDeMaster+'&pHeadLabel='+pHeadLabel,'winmyinpbox','resizable: no');
}

function ValidTextOnly(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 160 || charCode == 130 || charCode == 161 || charCode == 162 || charCode == 163 || charCode == 46 || charCode == 32 || charCode == 165 || charCode == 164 || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
        return true;
    }
    return false;
}


function ValidTextUsr(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
        return true;
    }
    return false;
}

function ValidTextNombre(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 46 || charCode == 32 || charCode == 165 || charCode == 164 || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
        return true;
    }
    return false;
}

function ValidTextPuesto(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 46 || charCode == 32 || charCode == 165 || charCode == 164 || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
        return true;
    }
    return false;
}

function ValidTextPassword(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 46 || (charCode > 47 && charCode < 58) || charCode == 165 || charCode == 164 || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
        return true;
    }
    return false;
}

function ValidTextTel(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    if (charCode == 32 || charCode == 45 || (charCode > 47 && charCode < 58)) {
        return true;
    }
    return false;
}

function ValidTextNormal(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    //|| charCode == 181 || charCode == 144 || charCode == 214 || charCode == 224 || charCode == 233 || charCode == 160 || charCode == 130 || charCode == 161 || charCode == 162 || charCode == 163 ||  charCode==164 || charCode==165 || charCode==129 || charCode==154
    if ((charCode > 31 && charCode < 127) || charCode == 241 || charCode == 209 || charCode == 225 || charCode == 233 || charCode == 237 || charCode == 243 || charCode == 250 || charCode == 251 || charCode == 219 || charCode == 193 || charCode == 201 || charCode == 205 || charCode == 211 || charCode == 218) {
        return true;
    }
    return false;
}

//funcion para validacion de Cuestionarios
//Si se desea que tenga solo numeros entonces en letra debe de venir el numero mayor que debe de validar (0..9)
//Si se desea que tenga solo letras entonces en letra debe de venir la letra mayor que debe de validar (a..z o A..Z)
function ValidaHastaCar(evt, letra) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
        ((evt.which) ? evt.which : 0));
    var asc = 65
    asc = letra.charCodeAt(0);
    //Validacion de numeros 
    if (asc >= 48 && asc <= 57) {
        if (charCode <= asc) {
            return true;
        }
    }
    // Validacion mayusculas
    if (asc >= 65 && asc <= 90) {
        if (charCode >= 65 && charCode <= 90) {
            if (charCode <= asc) {
                return true;
            }
        }
        else
            if (charCode >= 97 && charCode <= 122) {
                if (charCode <= asc + 32) {
                    return true;
                }
            }
    }

    // Validacion minusculas
    if (asc >= 97 && asc <= 122) {
        if (charCode >= 97 && charCode <= 122) {
            if (charCode <= asc + 32) {
                return true;
            }
        }
        else
            if (charCode >= 65 && charCode <= 90) {
                if (charCode <= asc) {
                    return true;
                }
            }
    }
    return false;
}

function esHoraValida(hora) {
    var er_fh = /^(1|01|2|02|3|03|4|04|5|05|6|06|7|07|8|08|9|09|10|11|12)\:([0-5]0|[0-5][1-9])\ (AM|am|PM|pm|)$/
    if (hora.value == "") {
        alert("Introduzca la hora.")
        return false
    }
    if (!(er_fh.test(hora.value))) {
        alert("El dato en el campo hora no es válido.")
        return false
    }
    alert("¡Campo de hora correcto!")
    return true
}

function AgregaCeros(cadena, longMax) {
    var tam = 0
    var strCeros = ""
    tam = cadena.value.length
    if (tam < longMax) {
        for (i = 1; i <= (longMax - tam); i++) {
            strCeros = strCeros + "0"
        }
    }
    cadena.value = strCeros + cadena.value
}

function checkFileExtension(elem) {
    var filePath = elem.value;

    if (filePath.indexOf('.') == -1)
        return false;

    var validExtensions = new Array();
    var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

    //validExtensions[0] = 'jpg'; 
    //validExtensions[1] = 'jpeg'; 
    //validExtensions[2] = 'bmp'; 
    //validExtensions[3] = 'png'; 
    //validExtensions[4] = 'gif'; 
    //validExtensions[5] = 'tif'; 
    //validExtensions[6] = 'tiff'; 
    //validExtensions[7] = 'txt'; 
    //validExtensions[8] = 'doc'; 
    //validExtensions[9] = 'xls'; 
    validExtensions[10] = 'pdf';

    for (var i = 0; i < validExtensions.length; i++) {

        if (ext == validExtensions[i])
            return true;
    }

    alert('La extension del archivo ' + ext.toUpperCase() + ' no es permitido!');
    filePath = '';
    return false;
}

function validardecimales(objeto) {
    var valor = objeto.value;
    if (!(/^\d+(\.{0,1}\d{0,2})?$/.test(valor))) {
        objeto.value = objeto.value.substring(0, objeto.value.length - 1);
    }
}