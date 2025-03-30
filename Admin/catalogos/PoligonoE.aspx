<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PoligonoE.aspx.vb" Inherits="Admin_catalogos_PoligonoE" %>

    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
                font-weight: 700;
            }

            .style10 {
                width: 124px;
            }

            .auto-style1 {
                width: 48%;
                height: 49px;
            }

            .auto-style3 {
                width: 77px;
            }

            .auto-style4 {
                width: 48%;
                height: 23px;
            }

            .auto-style6 {
                width: 48%;
            }

            .auto-style7 {
                width: 13%;
            }

            .auto-style8 {
                width: 2%;
            }

            .auto-style9 {
                height: 49px;
            }
        </style>
    </head>

    <body style="height: 163px; width: 537px">
        <form id="form1" runat="server">
            <div>
                <table align="center" style="width: 99%">
                    <tr>
                        <td colspan="4" align="center" class="style9">BAJA DE POLIGONO DE GOBIERNO</td>
                    </tr>
                    <tr>
                        <td class="auto-style4"></td>
                        <td colspan="3" class="style9">
                            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style1">
                            *Nombre de Polígono a eliminar:</td>
                        <td colspan="3" class="auto-style9" align="center">
                            <asp:Label ID="lblPoligono" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style4">
                        </td>
                        <td colspan="3" class="style9">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style6">
                            &nbsp;</td>
                        <td align="center" class="auto-style7">
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" />
                            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1"
                                ImageUrl="~/imagenes/guardar.png" /> --%>
                        </td>
                        <td align="left" class="auto-style3">
                            <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" Text="Cancelar" />
                        </td>
                        <td class="auto-style8">
                            &nbsp;</td>
                    </tr>
                </table>
            </div>
        </form>
    </body>

    </html>