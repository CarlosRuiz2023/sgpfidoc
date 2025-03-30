<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TipoPavimentoAB.aspx.vb"
    Inherits="Admin_catalogos_TipoPavimentoAB" %>

    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title></title>
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
                font-weight: 700;
            }

            .style10 {
                width: 124px;
            }

            .auto-style3 {
                width: 77px;
            }

            .auto-style4 {
                width: 114px;
                height: 23px;
            }

            .auto-style6 {
                width: 114px;
            }

            .auto-style7 {
                width: 13%;
            }

            .auto-style8 {
                width: 10%;
            }

            .auto-style35 {
                width: 114px;
                font-size: xx-small;
            }

            .auto-style36 {
                font-size: xx-small;
            }

            .auto-style38 {
                height: 22px;
            }

            .auto-style39 {
                width: 114px;
                height: 22px;
            }

            .auto-style40 {
                font-weight: 700;
            }
        </style>
    </head>

    <body style="height: 245px; width: 504px">
        <form id="form1" runat="server">
            <div>
                <table align="center" style="width: 99%">
                    <tr>
                        <td colspan="4" align="center" class="auto-style40">TIPO DE TERRENO</td>
                    </tr>
                    <tr>
                        <td class="auto-style4"></td>
                        <td colspan="3" class="style9">
                            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style39">
                            <br />
                            *Tipo de Terreno :
                        </td>
                        <td colspan="3" class="auto-style38">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtTipoPAvimento" ErrorMessage="Introduzca programa" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtTipoPavimento" runat="server" Height="25px" style="margin-bottom: 0px"
                                Width="193px"></asp:TextBox>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style6">
                            <br />
                            *Etiqueta de Terreno:
                        </td>
                        <td colspan="3">
                            <br />
                            <asp:TextBox ID="txtTipoPavRom" runat="server" Height="28px" Width="197px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Capturo:</td>
                        <td colspan="3">
                            <asp:Label ID="lblCapturo" runat="server" style="font-weight: 700; "
                                CssClass="auto-style36"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Fecha:</td>
                        <td colspan="3">
                            <asp:Label ID="lblFecCap" runat="server" style="font-weight: 700; " CssClass="auto-style36">
                            </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Modifico:</td>
                        <td colspan="3">
                            <asp:Label ID="lblModifico" runat="server" style="font-weight: 700; "
                                CssClass="auto-style36"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="auto-style35">Fecha:</td>
                        <td colspan="3">
                            <asp:Label ID="lblFecMod" runat="server" style="font-weight: 700; " CssClass="auto-style36">
                            </asp:Label>
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
                            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Admin/imagenes/guardar.png" />
                            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1"
                                ImageUrl="~/imagenes/guardar.png" /> --%>
                        </td>
                        <td align="left" class="auto-style3">
                            <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Admin/imagenes/cancelar.png" />
                        </td>
                        <td class="auto-style8">
                            &nbsp;</td>
                    </tr>
                </table>
            </div>
        </form>
    </body>

    </html>