<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Inicio.aspx.vb" Inherits="Admin_Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script type="text/javascript" language="JavaScript">


         //// FUNCION PRINCIPAL


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


        $(document).ready(function () {

            var bienveusuario = $("#lblUsuario").html();    /*Obtiene el usuario que realiza la transacción*/
            var arrusuario = bienveusuario.split(":");
            var usuario = arrusuario[1];
            var usurec = arrusuario[2];



            RegistrarSesionUsuario(usurec, usuario)
                   .done(function (r) {
                       console.log('Sesion de usuario registrada')
                   })
                   .fail(function (xhr) {
                       console.log(xhr.responseText);
                       alert("No fue posible guardar la fecha de la sesion del usuario");
                   });

           /* TareasIniciales()
            .done(function (r) {

                var resp = r.d;

                var idobra = parseInt(resp.split(':')[1]);
                var mensaje = resp.split(':')[0];
                if (idobra) {
                    alert('Obra registrada correctamente');
                    $('#mask, .window').hide();
                    RedibujarGrid();

                } else {
                    alert(mensaje);
                }
            })
            .fail(function (xhr) {
                console.log(xhr.responseText);
                alert("No fue posible guardar la fecha de la sesion del usuario");
            });*/
                  /*  RegistrarSesionUsuario(usurec, usuario)
                    .done(function (r) {
                        alert('Sesion de usuario registrada')    
                    })
                    .fail(function(xhr) {
                        console.log(xhr.responseText);
                        alert("No fue posible guardar la fecha de la sesion del usuario");
                    });

                })
                    .fail(function (xhr) {
                        console.log(xhr.responseText);
                        alert("No fué posible registrar la obra...");
                });*/

        });


        function GeneraRecargoReq() {
          return $.ajax({
                type: 'POST',
                data: "{'accion':'" + 'genera_rec_req' + "'}",
                url: "../WebServices/WebServiceProcesosIniciales.asmx/GeneraRecReq",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }


        function TareasIniciales() {
            return $.ajax({
                type: 'POST',
                data: "{'accion':'" + 'elimina_desctos_vencidos' + "'}",
                url: "../WebServices/WebServiceProcesosIniciales.asmx/GeneraRecReq",
                contentType: 'application/json; utf-8',
                dataType: 'json'
            });
        }



        function RegistrarSesionUsuario(idusu,nomusuario) {
            
            
            var date = new Date();
            var hoy = date.getDate().toString() + '/' + (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString();
            var ahorita = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

            var objUsuario = {
                "IdUsuario": idusu,
                "Nombre": '',
                "Correo": '',
                "Usuario": nomusuario,
                "Pass": '',
                "IdRol": 0,
                "Rfc": '',
                "Curp": '',
                "Ss": '',
                "Empleado": 0,
                "UsuCre": '',
                "UsuMod":'',
                "UsuEstatus": 1,
                "Activo": 1,
                "FecUltCon": date,
                "FecCre": ConvertirCadenaToFecha(hoy),
                "FecMod":ConvertirCadenaToFecha(hoy),
                "idarea":1,
                "accion": 4
            }


            var stringData = JSON.stringify(objUsuario);
            return $.ajax({
                type: 'POST',
                url: "../WebServices/WebServiceUsuario.asmx/GuardarUsuario",
                data: "{objUsuario:" + stringData + "}",
                contentType: 'application/json; utf-8',
                dataType: 'json'               
            });

        };
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
