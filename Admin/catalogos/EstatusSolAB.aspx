<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EstatusSolAB.aspx.vb" Inherits="Admin_catalogos_EstatusSolAB"
    %>

    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title>Estatus de la solicitud</title>
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style6 {
                width: 255px;
                height: 45px;
            }

            .style7 {
                height: 45px;
            }

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
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <table width="90%" align="center">
                    <tr>
                        <td colspan="4" align="center">ESTATUS DE LA SOLICITUD</td>
                    </tr>
                    <tr>
                        <td class="style8"></td>
                        <td colspan="3" class="style9">
                            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style6">
                            <br />
                            * Estatus de Solicitud:
                        </td>
                        <td colspan="3" class="style7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtEstatus" ErrorMessage="Introduzca estatus" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtEstatus" runat="server" Height="28px" Width="271px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            Activo:</td>
                        <td colspan="3">
                            <asp:CheckBox ID="chkactivo" runat="server" />
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
                        <td align="center" class="style10">
                            &nbsp;</td>
                        <td align="left" style="width: 183px">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
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