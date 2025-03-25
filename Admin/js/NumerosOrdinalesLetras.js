function Unidades(num) {

    switch (num) {
        case 1: return "PRIMERO";
        case 2: return "SEGUNDO";
        case 3: return "TERCERO";
        case 4: return "CUARTO";
        case 5: return "QUINTO";
        case 6: return "SEXTO";
        case 7: return "SEPTIMO";
        case 8: return "OCTAVO";
        case 9: return "NOVENO";
    }

    return "";
}

function Decenas(num) {

    decena = Math.floor(num / 10);
    unidad = num - (decena * 10);

    switch (decena) {
        case 1:
            switch (unidad) {
                case 0: return "DECIMO";
                case 1: return "DECIMO";
                case 2: return "DECIMO";
                case 3: return "DECIMO";
                case 4: return "DECIMO";
                case 5: return "DECIMO";
                default: return "DECIMO" + Unidades(unidad);
            }
        case 2:
            switch (unidad) {
                case 0: return "VIGESIMO";
                default: return "VIGESIMO" + Unidades(unidad);
            }
        case 3: return DecenasY("TRIGESIMO", unidad);
        case 4: return DecenasY("CUADRAGESIMO", unidad);
        case 5: return DecenasY("QUINCUAGESIMO", unidad);
        case 6: return DecenasY("SEXTOAGESIMO", unidad);
        case 7: return DecenasY("HEPTAGESIMO", unidad);
        case 8: return DecenasY("OCTAGESIMO", unidad);
        case 9: return DecenasY("NONAGESIMO", unidad);
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
                return "CENTISIMO " + Decenas(decenas);
            return "CENTESIMO";
        case 2: return "DUCENTESIMO " + Decenas(decenas);
        case 3: return "TRICENTESIMO " + Decenas(decenas);
        case 4: return "CUADRINGENTESIMO " + Decenas(decenas);
        case 5: return "QUINCUAGESIMO " + Decenas(decenas);
        case 6: return "SEXAGENTESIMO " + Decenas(decenas);
        case 7: return "HEPTAGENTESIMO " + Decenas(decenas);
        case 8: return "OCTIGENTESIMO " + Decenas(decenas);
        case 9: return "NONIGENTESIMO " + Decenas(decenas);
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

    strMiles = Seccion(num, divisor, "MILESIMO", "MILESIMOS");
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

    strMillones = Seccion(num, divisor, "MILLONESIMO", "MILLONESIMOS");
    strMiles = Miles(resto);

    if (strMillones == "")
        return strMiles;

    return strMillones + " " + strMiles;

    //return Seccion(num, divisor, "UN MILLON", "MILLONES") + " " + Miles(resto);
}//Millones()

function NumeroALetras(num, centavos) {
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
        return "CERO " + data.letrasMonedaPlural + " " + data.letrasCentavos;
    if (data.enteros == 1)
        return Millones(data.enteros) + " " + data.letrasMonedaSingular + " " + data.letrasCentavos;
    else
        return Millones(data.enteros) + " " + data.letrasMonedaPlural + " " + data.letrasCentavos;
}//NumeroALetras()