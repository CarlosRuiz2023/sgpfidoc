<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TipoPavimentoE.aspx.vb" Inherits="Admin_catalogos_TipoPavimentoE" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      <style type="text/css">
        .style6
        {
            width: 255px;
            height: 45px;
        }
        .style7
        {
            height: 45px;
        }
        .style8
        {
            width: 255px;
            height: 23px;
        }
        .style9
        {
            height: 23px;
              font-weight: 700;
          }
          .style10
          {
              width: 124px;
          }
          .auto-style1 {
              width: 29%;
              height: 64px;
          }
          .auto-style2 {
              height: 64px;
          }
          .auto-style3 {
              width: 77px;
          }
          .auto-style4 {
              width: 29%;
              height: 23px;
          }
          .auto-style6 {
              width: 29%;
          }
          .auto-style7 {
              width: 13%;
          }
          .auto-style8 {
              width: 2%;
          }
    </style>
</head>
<body style="height: 245px; width: 476px">
    <form id="form1" runat="server">
    <div>
    <table align="center" style="width: 99%">
        <tr>
        <td colspan="4" align="center" class="style9">TIPO DE TERRENO</td>
        </tr>
        <tr>
        <td class="auto-style4"></td>
        <td colspan="3" class="style9">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style1">
            <br />
            *Tipo de Terreno:</td>
        <td colspan="3" class="auto-style2">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="txtTipoPAvimento" ErrorMessage="Introduzca programa" 
                ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtTipoPavimento" runat="server" Height="25px" style="margin-bottom: 0px" Width="193px" Enabled="False"></asp:TextBox>
            <br />
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style6">
            <br />
            *Etiqueta de Terreno:</td>
        <td colspan="3">
            <br />
            <asp:TextBox ID="txtTipoPavRom" runat="server" Height="28px" Width="197px" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style4" >
            </td>
        <td colspan="3" class="style9">
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style6" >
            &nbsp;</td>
        <td align="center" class="auto-style7">
            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"  /> 
            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1" ImageUrl="~/imagenes/guardar.png" />  --%>      
        </td>
        <td align="left" class="auto-style3">
            <asp:Button ID="btnCancelar" runat="server" CausesValidation="False" 
                Text="Cancelar" />
        </td>
        <td class="auto-style8">
            &nbsp;</td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>