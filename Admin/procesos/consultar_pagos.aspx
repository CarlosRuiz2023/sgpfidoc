<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_pagos.aspx.vb"
    Inherits="Admin_procesos_consultar_pagos" %>
    <%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>



        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

            <script type="text/javascript" language="JavaScript">

                //// FUNCION PRINCIPAL



                function NomDia(f) {
                    var dia = f.getDate();
                    var mes = f.getMonth() + 1;
                    var anio = f.getFullYear();
                    var d = new Array()
                    var dias = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
                    var dt = new Date(mes + ' ' + dia + ', ' + anio + ' 12:00:00');
                    return dias[dt.getUTCDay()];
                }


                function fecha_ini_AS400() {
                    var d = new Date();
                    var month = d.getMonth() + 1;
                    var day = d.getDate();
                    var nom_dia = NomDia(d);
                    if (nom_dia == 'Lunes') {
                        day = day - 3;
                    }
                    if (nom_dia == 'Sábado') {
                        day = day - 1;
                    }
                    if (nom_dia == 'Domingo') {
                        day = day - 2;
                    }

                    return d.getFullYear() + (month < 10 ? '0' : '') + month + (day < 10 ? '0' : '') + day;
                }

                function fecha_fin_AS400() {
                    var d = new Date();
                    var month = d.getMonth() + 1;
                    var day = d.getDate();
                    return d.getFullYear() + (month < 10 ? '0' : '') + month + (day < 10 ? '0' : '') + day;
                }


                function ActualizarPagos(idusu) {
                    //alert(img);
                    var url1 = "./cargar_pagos.html?ResponseType=Edit&idusu=" + idusu;
                    newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=800,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
                    if (newWindow.focus()) {
                        newWindow.focus()
                    }
                }

                function ActualizarPagosTesoreria() {

                    fecini = fecha_ini_AS400();
                    fecfin = fecha_fin_AS400();

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebServices/WebServicePagos.asmx/GetActPagosAS400",
                        data: "{'fec_inicial':'" + fecini + "','fec_final':'" + fecfin + "'}",
                        success: function (data) {
                            alert(data.d);
                        },
                        error: function (xhr) {
                            console.log(xhr.responseText);
                        }
                    });
                }



                $(document).ready(function () {

                    var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
                    var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
                    idusu = arrusuario[2];


                    $(".actualiza_pagos ").click(function (e) {
                        //Cancel the link behavior           
                        ActualizarPagos(idusu);
                    });

                    $(".actualiza_pagos_tesoreria").click(function (e) {
                        //Cancel the link behavior           
                        ActualizarPagosTesoreria();
                    });


                });


            </script>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <br /><br /><br /><br />
            <b>ACTUALIZACION DE PAGOS </b><a href="#" class="actualiza_pagos"> ===>>></a>
            <br /><br /><br /><br />
            <b>LEER PAGOS DE TESORERIA </b><a href="#" class="actualiza_pagos_tesoreria"> ===>>></a>


        </asp:Content>