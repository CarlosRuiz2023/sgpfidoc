<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="consultar_contratista.aspx.vb" Inherits="Admin_procesos_consultar_contratista" %>
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
                    if (IsNumeric(dia) == false) { fecha = ""; }
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



            function MostrarContratista(idusu, filtro) {


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
                                    url: "../../WebServices/WebServiceContratista.asmx/GetContratista_Grid", //PageMethod
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
                            id: "idcontratista"
                        },
                        colModel: [{
                            index: 'idcontratista', width: 50, align: 'Center', name: 'idContratista', hidden: true
                        },
                        {
                            index: 'nom_cont', width: 80, align: 'Center', name: 'NoIMSS'
                        },
                        {
                            index: 'razonsoc_cont', width: 200, align: 'Center', name: 'RazonSocial'
                        },
                        {
                            index: 'rfc_cont', width: 100, align: 'Center', name: 'RFC'
                        },
                        {
                            index: 'num_prov_cont', width: 100, align: 'Center', name: 'NoPadronProv'
                        },
                        {
                            index: 'reg_pub_cont', width: 100, align: 'Center', name: 'RegistroPublico'
                        },
                        {
                            index: 'repres_legal_cont', width: 200, align: 'Center', name: 'Represent_Legal'
                        },
                        {
                            index: 'calle_cont', width: 200, align: 'Center', name: 'Calle'
                        },
                        {
                            index: 'colonia_cont', width: 200, align: 'Center', name: 'Colonia'
                        },
                        {
                            index: 'ciudad_cont', width: 100, align: 'Center', name: 'Ciudad'
                        },
                        {
                            index: 'estado_cont', width: 100, align: 'Center', name: 'Estado'
                        },
                        {
                            index: 'tel1_cont', width: 50, align: 'Center', name: 'Tel1'
                        },
                        {
                            index: 'tel2_cont', width: 50, align: 'Center', name: 'Tel2'
                        },
                        {
                            index: 'email', width: 100, align: 'Center', name: 'email'
                        },
                        {
                            index: 'cp_cont', width: 50, align: 'Center', name: 'CodigoPostal'
                        },
                        {
                            index: 'no_oficial_cont', width: 50, align: 'Center', name: 'No_Oficial'
                        },
                        {
                            index: 'usu_cre', width: 50, align: 'Center', name: 'UsuCre', hidden: true
                        },
                        {
                            index: 'usu_mod', width: 50, align: 'Center', name: 'UsuMod', hidden: true
                        },
                        {
                            index: 'fec_cre', width: 50, align: 'Center', name: 'FecCre', hidden: true
                        },
                        {
                            index: 'fec_mod', width: 50, align: 'Center', name: 'FecMod', hidden: true
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
                        sortname: "idcontratista", //login SortColumn
                        sortorder: "asc", //login SortOrder.
                        width: "1800",
                        height: "800",
                        caption: "CATALOGO DE CONTRATISTAS"

                    }).navGrid('#pager', { edit: false, add: false, search: false, del: false })
                    .navButtonAdd('#pager',
                        {
                            caption: "AltaCont",
                            id: "alta_cont",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContratista = myGrid.jqGrid('getRowData', selectedRowId);

                                GestionContratista(objContratista, 0);

                            },
                            position: "last",
                            title: "AltaCont",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "EditCont",
                            id: "edit_cont",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {
                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContratista = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContratista.idContratista) {
                                    GestionContratista(objContratista, 1);
                                }
                                else {
                                    alert("Selecciona un Contratista...");
                                }
                            },
                            position: "last",
                            title: "EditCont",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "DesactivarContratista",
                            id: "desact_contratista",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContratista = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContratista.idContratista) {
                                    if (objContratista.Estatus == 1) {
                                        GestionContratista(objContratista, 2);
                                    }
                                    else {
                                        alert('El Contratista está desactivado');
                                    }
                                }
                                else {
                                    alert("Selecciona un Contratista...");
                                }
                            },
                            position: "last",
                            title: "DesCont",
                            cursor: "pointer"
                        })

                    .navButtonAdd('#pager',
                        {
                            caption: "ActivarContratista",
                            id: "activar_contratista",
                            buttonicon: "ui-icon-document",
                            onClickButton: function () {

                                var myGrid = $('#grid');
                                var selectedRowId = myGrid.jqGrid('getGridParam', 'selrow');
                                var objContratista = myGrid.jqGrid('getRowData', selectedRowId);

                                if (objContratista.idContratista) {
                                    if (objContratista.Estatus == 0) {
                                        GestionContratista(objContratista, 3);
                                    }
                                    else {
                                        alert('El Contratista esta activado');
                                    }
                                }
                                else {
                                    alert("Selecciona un Contratista...");
                                }

                            },
                            position: "last",
                            title: "ActCont",
                            cursor: "pointer"
                        });

            }



            function ObtenerFiltro() {


                var nom_contratista = $('#txtnom_contratista_q').val();
                if (nom_contratista.length <= 0 || nom_contratista.length > 30) {
                    nom_contratista = "NULL";
                }

                var filtro = nom_contratista.toString();
                return filtro;
            }


            function Buscar_Contratista(idusu) {
                MostrarContratista(idusu, ObtenerFiltro());
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




                $(".buscar_contratista").click(function () {
                    Buscar_Contratista(idusu);
                });

                $(".alta_contratista").click(function () {
                    GestionContratista(0, 0);
                });

                $("#bodegadatos").data("idusu", idusu);

                $(".posicion_boton_cancelar_contratista").click(function (e) {
                    //Cancel the link behavior
                    //e.preventlogin();
                    $('#mask, .window').hide();
                });


                $(".posicion_boton_accion_contratista").click(function (e) {
                    EjecutarAccionContratista();
                });


                $('#mask').click(function () {
                    $(this).hide();
                    $('.window').hide();
                });

            });

            function RegistrarContratistaBD(objContratista) {

                var stringData = JSON.stringify(objContratista);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceContratista.asmx/GuardarContratista",
                    data: "{objContratista:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function RevisarRFC_Contratista(objContratista) {

                var stringData = JSON.stringify(objContratista);
                return $.ajax({
                    type: 'POST',
                    url: "../../WebServices/WebServiceContratista.asmx/GuardarContratista",
                    data: "{objContratista:" + stringData + "}",
                    contentType: 'application/json; utf-8',
                    dataType: 'json'
                });

            };

            function EjecutarAccionContratista() {
                var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                var arrusuario = bienveusuario.split(":");
                var usuario = arrusuario[1];
                var idusu = arrusuario[2];

                var date = new Date();
                var hoy = ConvertirCadenaToFecha(date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString());



                var usu_cre_contratista = idusu;

                var accion = parseInt($("#lblaccion").html());
                var objContratista = {
                    "idcontratista": 0,
                    "nom_cont": '',
                    "razonsoc_cont": '',
                    "rfc_cont": '',
                    "num_prov_cont": '',
                    "reg_pub_cont": '',
                    "repres_legal_cont": '',
                    "calle_cont": '',
                    "colonia_cont": '',
                    "ciudad_cont": '',
                    "estado_cont": '',
                    "tel1_cont": '',
                    "tel2_cont": '',
                    "email": '',
                    "cp_cont": 0,
                    "no_oficial_cont": '',
                    "usu_cre": idusu,
                    "usu_mod": idusu,
                    "fec_cre": hoy,
                    "fec_mod": hoy,
                    "cestatus": 0,
                    "accion": accion,
                }

                /*--------------    Formatear datos capturados     -----------------------------------*/
                var rfc_capturado = $("#txt_rfc_cont").val();
                rfc_capturado.replace(/ /g, "");




                if (accion == 0) { /*Registrar Accion*/
                    objContratista.idcontratista = 1;
                    objContratista.cestatus = 1;
                    objContratista.nom_cont = $("#txtnom_cont").val();
                    objContratista.razonsoc_cont = $("#txtrazon_soc_cont").val();
                    objContratista.rfc_cont = rfc_capturado;
                    objContratista.num_prov_cont = $("#txt_num_prov").val();
                    objContratista.reg_pub_cont = $("#txtreg_pub_cont").val();
                    objContratista.repres_legal_cont = $("#txtrepres_legal").val();
                    objContratista.calle_cont = $("#txtcalle_cont").val();
                    objContratista.colonia_cont = $("#txtcolonia_cont").val();
                    objContratista.ciudad_cont = $("#txtciudad_cont").val();
                    objContratista.estado_cont = $("#txtestado_cont").val();
                    objContratista.tel1_cont = $("#txttel1_cont").val();
                    objContratista.tel2_cont = $("#txttel2_cont").val();
                    objContratista.email = $("#txtemail_cont").val();
                    objContratista.cp_cont = $("#txtcp_cont").val();
                    objContratista.no_oficial_cont = $("#txtnum_ofic_cont").val();
                    var valido = ValidarValores(objContratista);
                    if (valido) {
                        RegistrarContratistaBD(objContratista)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = arr[1];
                                    if (error == '0') {
                                        alert('El contratista con IdContratista:' + arr[3] + ' ha sido dado de alta satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible dar de alta el Contratista");
                            })
                    }
                }


                if (accion == 1) {
                    objContratista.idcontratista = parseInt($("#lblid_contratista").html());
                    objContratista.cestatus = 1;
                    objContratista.nom_cont = $("#txtnom_cont").val();
                    objContratista.razonsoc_cont = $("#txtrazon_soc_cont").val();
                    objContratista.rfc_cont = $("#txt_rfc_cont").val();
                    objContratista.num_prov_cont = $("#txt_num_prov").val();
                    objContratista.reg_pub_cont = $("#txtreg_pub_cont").val();
                    objContratista.repres_legal_cont = $("#txtrepres_legal").val();
                    objContratista.calle_cont = $("#txtcalle_cont").val();
                    objContratista.colonia_cont = $("#txtcolonia_cont").val();
                    objContratista.ciudad_cont = $("#txtciudad_cont").val();
                    objContratista.estado_cont = $("#txtestado_cont").val();
                    objContratista.tel1_cont = $("#txttel1_cont").val();
                    objContratista.tel2_cont = $("#txttel2_cont").val();
                    objContratista.email = $("#txtemail_cont").val();
                    objContratista.cp_cont = $("#txtcp_cont").val();
                    objContratista.no_oficial_cont = $("#txtnum_ofic_cont").val();
                    var valido = ValidarValores(objContratista);
                    if (valido) {
                        RegistrarContratistaBD(objContratista)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    var error = arr[1];
                                    if (error == '0') {
                                        alert('El contratista con IdContratista:' + arr[3] + ' ha sido modificado satisfactoriamente');
                                        $('#mask, .window').hide();
                                        RedibujarGrid();
                                    } else {
                                        alert(cadena);
                                    }
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible dar de alta el Contratista");
                            })
                    }

                }

                if (accion == 2) {
                    objContratista.cestatus = 0;
                    objContratista.idcontratista = parseInt($("#lblid_contratista").html());
                    objContratista.nom_cont = $("#txtnom_cont").val();
                    var resp = confirm('¿Desea desactivar el Contratista: ' + objContratista.nom_cont + '?');
                    if (resp) {

                    }

                }

                if (accion == 3) {
                    objContratista.cestatus = 1;
                    objContratista.idcontratista = parseInt($("#lblid_contratista").html());
                    objContratista.nom_cont = $("#txtnom_cont").val();
                    var resp = confirm('¿Desea activar el Contratista: ' + objContratista.nom_cont + '?');
                    if (resp) {
                        RegistrarContratistaBD(objContratista)
                            .done(function (r) {
                                var cadena = r.d;
                                if (cadena != '<NewDataSet />') {
                                    var arr = cadena.split(':');
                                    alert('El Contratista con id: ' + arr[1] + ' ha sido activado satisfactoriamente');
                                    $('#mask, .window').hide();
                                    RedibujarGrid();
                                }
                            })
                            .fail(function (xhr) {
                                console.log(xhr.responseText);
                                alert("No fue posible activar el Contratista solicitado");
                            })
                    }

                }
            }


            function ValidarValores(objContratista) {
                var validar = true;

                nombre_contratista = objContratista.razonsoc_cont;
                rfc_contratista = objContratista.rfc_cont;

                if (nombre_contratista.length == 0 || nombre_contratista == '' || $.trim(nombre_contratista) == '') {
                    validar = false;
                    alert("El Nombre del contratista capturado no es válido");
                } else {
                    if (rfc_contratista.length == 0 || rfc_contratista == '' || $.trim(rfc_contratista) == '') {
                        validar = false;

                    } else {
                        if (rfc_contratista.length == 12) {
                            var rfc_parte1;

                            rfc_parte1 = rfc_contratista.substr(0, 3);

                            var rfc_parte2 = $.trim(rfc_contratista).substr(3, 2); //year
                            var rfc_parte3 = $.trim(rfc_contratista).substr(5, 2); //mes
                            var rfc_parte4 = $.trim(rfc_contratista).substr(7, 2); //dia
                            var rfc_parte5 = $.trim(rfc_contratista).substr(9, 3);

                            var residuo = parseInt(rfc_parte2) % 4;
                            var es_bisiesto;
                            if (residuo == 0) {
                                es_bisiesto = 1;
                            } else {
                                es_bisiesto = 0;
                            }

                            if (rfc_parte1.length == 3) {
                                if (!sonLetrasSolamente(rfc_parte1)) {
                                    validar = false;

                                } else {
                                    if (rfc_parte2.length != 2) {
                                        validar = false;
                                    }
                                    else {
                                        if (!IsNumeric(rfc_parte2)) {
                                            validar = false;
                                        } else {
                                            if (rfc_parte3.length != 2) {
                                                validar = false;
                                            } else {
                                                mes = parseInt(rfc_parte3);
                                                if (mes > 12) {
                                                    validar = false;
                                                } else {
                                                    if (rfc_parte4.length != 2) {
                                                        validar = false;
                                                    }
                                                    else {
                                                        if (!IsNumeric(rfc_parte4)) {
                                                            validar = false;
                                                        } else {
                                                            if (parseInt(rfc_parte4) > 31) {
                                                                validar = false;
                                                            } else {
                                                                if (parseInt(rfc_parte4) == 31 && (parseInt(rfc_parte3) == 4 || parseInt(rfc_parte3) == 6 || parseInt(rfc_parte3) == 9 || parseInt(rfc_parte3) == 11)) {
                                                                    validar = false;
                                                                } else {
                                                                    if (es_bisiesto == 0 && parseInt(rfc_parte4) == 29) {
                                                                        validar = false;
                                                                    } else {
                                                                        if (rfc_parte5.length != 3) {
                                                                            validar = false;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            if (rfc_contratista.length == 13) {
                                var rfc_parte1;
                                rfc_parte1 = rfc_contratista.substr(0, 4);
                                var rfc_parte2 = $.trim(rfc_contratista.substr(4, 2)); //year
                                var rfc_parte3 = $.trim(rfc_contratista.substr(6, 2)); //mes
                                var rfc_parte4 = $.trim(rfc_contratista.substr(8, 2)); //dia
                                var rfc_parte5 = $.trim(rfc_contratista.substr(10, 3));

                                var residuo = parseInt(rfc_parte2) % 4;
                                var es_bisiesto;
                                if (residuo == 0) {
                                    es_bisiesto = 1;
                                } else {
                                    es_bisiesto = 0;
                                }

                                if (rfc_parte1.length == 4) {
                                    if (!sonLetrasSolamente(rfc_parte1)) {
                                        validar = false;

                                    } else {
                                        if (rfc_parte2.length != 2) {
                                            validar = false;
                                        }
                                        else {
                                            if (!IsNumeric(rfc_parte2)) {
                                                validar = false;
                                            } else {
                                                if (rfc_parte3.length != 2) {
                                                    validar = false;
                                                } else {
                                                    mes = parseInt(rfc_parte3);
                                                    if (mes > 12) {
                                                        validar = false;
                                                    } else {
                                                        if (rfc_parte4.length != 2) {
                                                            validar = false;
                                                        }
                                                        else {
                                                            if (!IsNumeric(rfc_parte4)) {
                                                                validar = false;
                                                            } else {
                                                                if (parseInt(rfc_parte4) > 31) {
                                                                    validar = false;
                                                                } else {
                                                                    if (parseInt(rfc_parte4) == 31 && (parseInt(rfc_parte3) == 4 || parseInt(rfc_parte3) == 6 || parseInt(rfc_parte3) == 9 || parseInt(rfc_parte3) == 11)) {
                                                                        validar = false;
                                                                    } else {
                                                                        if (es_bisiesto == 0 && parseInt(rfc_parte4) == 29) {
                                                                            validar = false;
                                                                        } else {
                                                                            if (rfc_parte5.length != 3) {
                                                                                validar = false;
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    validar = false;
                                }
                            } else {
                                validar = false;
                            }
                        }
                    }
                }

                if (!validar) {
                    alert("El RFC capturado no es válido");
                }

                return validar;
            }

            function sonLetrasSolamente(texto) {
                var regex = /^[a-zA-Z ]+$/;
                return regex.test(texto);
            }

            function GestionContratista(objContratista, accion) {

                if (accion == 0) {  /*Alta de Accion*/
                    $("#lblid_contratista").html('0');
                    $("#lblaccion").html(accion);
                    $("#txtnom_cont").val('');
                    $("#txtrazon_soc_cont").val('');
                    $("#txt_rfc_cont").val('');
                    $("#txt_num_prov").val('');
                    $("#txtreg_pub_cont").val('');
                    $("#txtrepres_legal").val('');
                    $("#txtcalle_cont").val('');
                    $("#txtcolonia_cont").val('');
                    $("#txtciudad_cont").val('');
                    $("#txtestado_cont").val('');
                    $("#txttel1_cont").val('');
                    $("#txttel2_cont").val('');
                    $("#txttel2_cont").val('');
                    $("#txtemail_cont").val('');
                    $("#txtnum_ofic_cont").val('');
                }
                else {
                    if (accion == 1 || accion == 2 || accion == 3) {
                        $("#lblid_contratista").html(objContratista.idContratista);
                        $("#lblaccion").html(accion);
                        $("#txtnom_cont").val(objContratista.NoIMSS);
                        $("#txtrazon_soc_cont").val(objContratista.RazonSocial);
                        $("#txt_rfc_cont").val(objContratista.RFC);
                        $("#txt_num_prov").val(objContratista.NoPadronProv);
                        $("#txtreg_pub_cont").val(objContratista.RegistroPublico);
                        $("#txtrepres_legal").val(objContratista.Represent_Legal);
                        $("#txtcalle_cont").val(objContratista.Calle);
                        $("#txtcolonia_cont").val(objContratista.Colonia);
                        $("#txtciudad_cont").val(objContratista.Ciudad);
                        $("#txtestado_cont").val(objContratista.Estado);
                        $("#txttel1_cont").val(objContratista.Tel1);
                        $("#txttel2_cont").val(objContratista.Tel2);
                        $("#txtemail_cont").val(objContratista.email);
                        $("#txtcp_cont").val(objContratista.CodigoPostal);
                        $("#txtnum_ofic_cont").val(objContratista.No_Oficial);

                        if (accion == 2 || accion == 3) {
                            $("#txtnom_cont").prop('disabled', true);
                            $("#txtrazon_soc_cont").prop('disabled', true);
                            $("#txt_rfc_cont").prop('disabled', true);
                            $("#txt_num_prov").prop('disabled', true);
                            $("#txtreg_pub_cont").prop('disabled', true);
                            $("#txtrepres_legal").prop('disabled', true);
                            $("#txtcalle_cont").prop('disabled', true);
                            $("#txtcolonia_cont").prop('disabled', true);
                            $("#txtciudad_cont").prop('disabled', true);
                            $("#txtestado_cont").prop('disabled', true);
                            $("#txttel1_cont").prop('disabled', true);
                            $("#txttel2_cont").prop('disabled', true);
                            $("#txtemail_cont").prop('disabled', true);
                            $("#txtcp_cont").prop('disabled', true);
                            $("#txtnum_ofic_cont").prop('disabled', true);
                        }
                        else {
                            $("#txtnom_cont").prop('disabled', false);
                            $("#txtrazon_soc_cont").prop('disabled', false);
                            $("#txt_rfc_cont").prop('disabled', false);
                            $("#txt_num_prov").prop('disabled', false);
                            $("#txtreg_pub_cont").prop('disabled', false);
                            $("#txtrepres_legal").prop('disabled', false);
                            $("#txtcalle_cont").prop('disabled', false);
                            $("#txtcolonia_cont").prop('disabled', false);
                            $("#txtciudad_cont").prop('disabled', false);
                            $("#txtestado_cont").prop('disabled', false);
                            $("#txttel1_cont").prop('disabled', false);
                            $("#txttel2_cont").prop('disabled', false);
                            $("#txtemail_cont").prop('disabled', false);
                            $("#txtcp_cont").prop('disabled', false);
                            $("#txtnum_ofic_cont").prop('disabled', false);
                        }

                    }
                }
                MostrarModalContratista();
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


            function MostrarModalContratista() {
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
                $("#dialogo_contratista").css('top', winH / 2 - $("#dialogo_contratista").height() / 2);
                $("#dialogo_contratista").css('left', winW / 2 - $("#dialogo_contratista").width() / 2);

                //transition effect
                $("#dialogo_contratista").fadeIn(2000);
            };



        </script>

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <label>Razón Social del Contratista:</label><input type="text" name="contratista" id="txtnom_contratista_q"
            style="width:250px" maxlength="120" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#"
            class="buscar_contratista">
            <== Buscar CONTRATISTA==>
        </a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="#" class="alta_contratista">
            <== Alta CONTRATISTA==>
        </a><br /><br />

        <table id="grid"></table>
        <div id="pager"></div>&nbsp
        <div id="bodegadatos"></div>


        <div id="boxes">
            <div id="dialogo_contratista" class="window">
                <table class="t_modulo">
                    <tbody>
                        <tr>
                            <td colspan="4" class="titulo_modulo">GESTION DE CONTRATISTA</td>
                        </tr>
                        <tr>
                            <td class="f">Razón Social Contratista:</td>
                            <td class="e" colspan="3"><input type="text" name="razon_soc" id="txtrazon_soc_cont"
                                    size="120" maxlength="50" /></td>
                        </tr>
                        <tr>
                            <td class="f">Representante Legal:</td>
                            <td class="e" colspan="3"><input type="text" name="repres_legal" id="txtrepres_legal"
                                    size="120" maxlength="120" /></td>
                        </tr>
                        <tr>
                            <td class="f">Calle:</td>
                            <td class="e" colspan="3"><input type="text" name="calle_contratista" id="txtcalle_cont"
                                    size="120" maxlength="120" /></td>

                        </tr>
                        <tr>
                            <td class="f">Colonia:</td>
                            <td class="e" colspan="3"><input type="text" name="colonia_cont" id="txtcolonia_cont"
                                    size="120" maxlength="120" /></td>
                        </tr>
                        <tr>
                            <td class="f">Ciudad:</td>
                            <td class="e"><input type="text" name="ciudad_cont" id="txtciudad_cont" size="30"
                                    maxlength="30" /></td>
                            <td class="f">Estado:</td>
                            <td class="e"><input type="text" name="estado_cont" id="txtestado_cont" size="30"
                                    maxlength="30" /></td>
                        </tr>
                        <tr>
                            <td class="f">No.Oficial:</td>
                            <td class="e"><input type="text" name="NoOficial" id="txtnum_ofic_cont" size="12"
                                    maxlength="12" /></td>
                            <td class="f">Código Postal:</td>
                            <td class="e"><input type="text" name="codigo_postal" id="txtcp_cont" size="12"
                                    maxlength="12" /></td>
                        </tr>
                        <tr>
                            <td class="f">RFC:</td>
                            <td class="e"><input type="text" name="rfc" id="txt_rfc_cont" size="13" maxlength="13" />
                            </td>
                            <td class="f">No.Padrón_Proveedores:</td>
                            <td class="e"><input type="text" name="num_prov" id="txt_num_prov" size="30"
                                    maxlength="30" /></td>
                        </tr>
                        <tr>
                            <td class="f">No.Reg_Público:</td>
                            <td class="e"><input type="text" name="reg_pub" id="txtreg_pub_cont" size="20"
                                    maxlength="30" /></td>
                            <td class="f">No. Reg. IMSS</td>
                            <td class="e"><input type="text" name="nom_cont" id="txtnom_cont" size="20"
                                    maxlength="20" /></td>
                        </tr>
                        <tr>
                            <td class="f">Teléfono 1:</td>
                            <td class="e"><input type="text" name="telefono1" id="txttel1_cont" size="12"
                                    maxlength="12" /></td>
                            <td class="f">Teléfono 2:</td>
                            <td class="e"><input type="text" name="telefono2" id="txttel2_cont" size="12"
                                    maxlength="12" /></td>
                        </tr>
                        <tr>
                            <td class="f">Correo Electrónico:</td>
                            <td colspan="3" class="e"><input type="text" name="reg_pub" id="txtemail_cont" size="120"
                                    maxlength="200" /></td>
                        </tr>
                        <tr class="renglon_sistema">
                            <td>Acción:</td>
                            <td class="columna_sistema"><label id="lblaccion" /></td>
                            <td>IdContratista:</td>
                            <td class="columna_sistema"><label id="lblid_contratista" /></td>
                        </tr>
                        <tr>

                            <td colspan="2" class="boton_dialog"><a href="#"
                                    class="posicion_boton_accion_contratista">ACEPTAR</a></td>

                            <td colspan="2" class="boton_dialog"><a href="#"
                                    class="posicion_boton_cancelar_contratista">CANCELAR</a></td>

                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="mask"></div>
        </div>
    </asp:Content>