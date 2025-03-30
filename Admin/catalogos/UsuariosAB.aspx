<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UsuariosAB.aspx.vb" Inherits="Admin_catalogos_UsuariosAB" %>

    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title>Usuarios</title>
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style8 {
                width: 255px;
                height: 23px;
            }

            .style9 {
                height: 23px;
            }

            .style10 {
                width: 124px;
            }

            .auto-style35 {
                width: 183px;
                font-size: x-small;
            }

            .auto-style2 {
                width: 183px;
                font-size: x-small;
            }
        </style>
        <script src="../../js/JScript_General.js" type="text/javascript"></script>
        <script type="text/javascript" language="JavaScript">
            function validartexto(e) {
                tecla = (document.all) ? e.keyCode : e.which;
                if (tecla == 8) return true;
                patron = /^[\w\/\-\s\t\n]*$/;
                te = String.fromCharCode(tecla);
                return patron.test(te);
            }

            function fecha(e) {
                tecla = (document.all) ? e.keyCode : e.which;
                if (tecla == 8) return true;
                patron = /^[0-9\/]$/;
                te = String.fromCharCode(tecla);
                return patron.test(te);
            }

            function validardecimales(objeto) {
                var valor = objeto.value;
                if (!(/^\d+(\.{0,1}\d{0,2})?$/.test(valor))) {
                    objeto.value = objeto.value.substring(0, objeto.value.length - 1);
                }
            }

            function validar(e) {
                tecla = (document.all) ? e.keyCode : e.which;
                if (tecla == 8) return true;
                patron = /\d/;
                te = String.fromCharCode(tecla);
                return patron.test(te);
            }
        </script>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <table width="90%" align="center">
                    <tr>
                        <td colspan="4" align="center"><strong>USUARIOS</strong></td>
                    </tr>
                    <tr>
                        <td class="style8"></td>
                        <td colspan="3" class="style9">
                            <asp:Label ID="lblerror" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <br />
                            <span style="color:Red">*</span> No. Empleado:
                        </td>
                        <td colspan="3">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                ControlToValidate="txtEmpleado" ErrorMessage="No. Empleado Invalido"
                                SetFocusOnError="True" ValidationExpression="^\d+?$" ForeColor="Red">
                            </asp:RegularExpressionValidator>
                            <br />

                            <asp:TextBox ID="txtEmpleado" runat="server" Width="64px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <br />
                            <span style="color:Red">*</span> Nombre:
                        </td>
                        <td colspan="3">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="txtNombre" ErrorMessage="Introduce el nombre" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtNombre" runat="server" Width="279px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            Area:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtArea" runat="server" Width="277px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <br />
                            <span style="color:Red">*</span> Correo electrónico:
                        </td>
                        <td colspan="3" style="margin-left: 40px">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                ControlToValidate="txtCorreo" ErrorMessage="Introduce el correo" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtCorreo" runat="server" Width="284px"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                ControlToValidate="txtCorreo" ErrorMessage="Correo Inválido" SetFocusOnError="True"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            CURP:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtCurp" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            RFC:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtRFC" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            SS:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtSS" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style6">
                            <br />
                            <span style="color:Red">*</span> Cuenta de usuario:
                        </td>
                        <td colspan="3" class="style7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtUsuario" ErrorMessage="Introduzca usuario" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <br />
                            <asp:Label ID="lblcontra" runat="server" Text="* Contraseña"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                ControlToValidate="txtPass" ErrorMessage="Introduzca contraseña" ForeColor="Red"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtPass" runat="server" Text="" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtPass2" runat="server" Text="" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td colspan="3">
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPass"
                                ControlToValidate="txtPass2" ErrorMessage="Las contraseñas no son idénticas"
                                ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <span style="color:Red">*</span> Rol:
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="cmbRol" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            <span style="color:Red">*</span> Estatus:
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="cmbEstatus" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Capturo:</td>
                        <td colspan="2">
                            <asp:Label ID="lblCapturo" runat="server" style="font-weight: 700; font-size: x-small">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Fecha:</td>
                        <td colspan="2">
                            <asp:Label ID="lblFecCap" runat="server" style="font-weight: 700; font-size: x-small">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style2">Modifico:</td>
                        <td colspan="2">
                            <asp:Label ID="lblModifico" runat="server" style="font-weight: 700; font-size: x-small">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style2">Fecha:</td>
                        <td colspan="2">
                            <asp:Label ID="lblFecMod" runat="server" style="font-weight: 700; font-size: x-small">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td colspan="2" align="left">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td colspan="3">
                            <asp:ScriptManager ID="ScriptManager2" runat="server">
                            </asp:ScriptManager>
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td align="center" class="style10">
                            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Admin/imagenes/guardar.png" />
                            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1"
                                ImageUrl="~/imagenes/guardar.png" /> --%>
                        </td>
                        <td align="left" style="width: 183px">
                            <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Admin/imagenes/cancelar.png" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </div>

        </form>
    </body>

    </html>