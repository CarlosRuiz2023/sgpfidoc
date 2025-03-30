<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="CambiarA.aspx.vb"
    Inherits="Admin_catalogos_CambiarA" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style8 {
                width: 183px;
                height: 30px;
            }

            .style9 {
                height: 30px;
            }

            .style10 {
                width: 252px;
                height: 30px;
            }

            .style11 {
                width: 476px;
                height: 30px;
            }

            .style12 {
                width: 476px;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div>
            <table width="90%" align="center">
                <tr>
                    <td colspan="4" align="center" class="style9"><strong>CAMBIAR CONTRASEÑA</strong></td>
                </tr>
                <tr>
                    <td class="style11" align="right">
                        &nbsp;</td>
                    <td colspan="3" class="style9">
                        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="style11" align="right">
                        <asp:Label ID="lblactual" runat="server" Text="Contraseña actual:"></asp:Label>
                    </td>
                    <td colspan="3" class="style9">
                        <asp:TextBox ID="txtActual" runat="server" Text="" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style12">
                        <br />
                        <asp:Label ID="lblcontra" runat="server" Text="Contraseña nueva:"></asp:Label>
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
                    <td align="right" class="style12">
                        <asp:Label ID="lblcontra0" runat="server" Text="Confirmar nueva:"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtPass2" runat="server" Text="" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style12">
                        &nbsp;</td>
                    <td colspan="3">
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPass"
                            ControlToValidate="txtPass2" ErrorMessage="Las contraseñas no son identicas" ForeColor="Red"
                            SetFocusOnError="True"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style12">
                        &nbsp;</td>
                    <td colspan="3">
                        <asp:Label ID="lblComentario" runat="server" ForeColor="#009933"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="style11">
                    </td>
                    <td align="center" class="style10">
                        <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Admin/imagenes/cambiar.png" />
                        <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1"
                            ImageUrl="~/imagenes/guardar.png" /> --%>
                    </td>
                    <td align="left" class="style8">
                        &nbsp;</td>
                    <td class="style9">
                    </td>
                </tr>
            </table>
        </div>
    </asp:Content>