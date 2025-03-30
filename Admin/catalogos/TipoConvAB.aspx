<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TipoConvAB.aspx.vb" Inherits="Admin_catalogos_TipoConvAB" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title></title>
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
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <table width="90%" align="center">
                    <tr>
                        <td colspan="4" align="center" class="style9">TIPO DE CONVENIO</td>
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
                            * Nombre:
                        </td>
                        <td colspan="3" class="style7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtTipo" ErrorMessage="Introduzca tipo de convenio" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtTipo" runat="server" Width="271px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td colspan="3">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            &nbsp;</td>
                        <td align="center" class="style10">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1"
                                ImageUrl="~/imagenes/guardar.png" /> --%>
                        </td>
                        <td align="left" style="width: 183px">
                            <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" Text="Cancelar" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </div>
        </form>
    </body>

    </html>