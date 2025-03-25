<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master" CodeFile="consultar_cv.aspx.vb" Inherits="Admin_procesos_consultar_cv" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
        
    <script type="text/javascript" language="JavaScript">

        //// FUNCION PRINCIPAL

        function ActualizarCV(idusu) {
            //alert(img);
            var url1 = "../../Procesos/cargar_cv.html?ResponseType=Edit&idusu=" + idusu;
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=800,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }

        function InsertarMovs_CV(idusu) {
            //alert(img);
            var url1 = "../../Procesos/cargar_movs_cv.html?ResponseType=Edit&idusu=" + idusu;
            newWindow = window.open(url1, "_blank", "top=150,left=200,menubar=no,toolbar=no,location=no, resizable=no,height=780,width=800,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no,modal=yes");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }

        $(document).ready(function () {

            var bienvusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienvusuario.split(":");      /*Se recupera el id de factibilidad para que sea parte del nombre del archivo, lo regresa el WebServiceFact como respuesta*/
            idusu = arrusuario[2];


            $(".actualiza_pagos ").click(function (e) {
                //Cancel the link behavior 
                if (idusu == '46') {
                    ActualizarCV(idusu);
                }
                else {
                    alert('El usuario no tiene permisos para desbloquear cuentas');
                }
            });

            
            $(".inserta_movs_cv ").click(function (e) {
                //Cancel the link behavior 
                if (idusu == '46') {
                    InsertarMovs_CV(idusu);
                }
                else {
                    alert('El usuario no tiene permiso para insertar movimientos fiancieros desde archivo de texto');
                }
            });

        });


    </script>     

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  

    <br/><br/><br/><br/>
<b>INSERCCION DE CUENTAS EN CREDITOS SIN ADEUDO  </b><a href="#" class="actualiza_pagos"> ===>>></a>

    <br/><br/><br/><br/>
<b>INSERCCION DE MOVIMIENTOS FINANCIEROS  </b><a href="#" class="inserta_movs_cv"> ===>>></a>
    
    
 
</asp:Content>
