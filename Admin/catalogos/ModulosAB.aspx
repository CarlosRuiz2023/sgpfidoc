<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ModulosAB.aspx.vb" Inherits="Admin_catalogos_ModulosAB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
      <style type="text/css">
        .style8
        {
            width: 255px;
            height: 23px;
        }
        .style9
        {
            height: 23px;
        }
          .style10
          {
              width: 95px;
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
        <td colspan="3" align="center">Módulos</td>
        </tr>
        <tr>
        <td style="width: 255px"></td>
        <td colspan="2"></td>
        </tr>
        <tr>
        <td class="style8"></td>
        <td colspan="2" class="style9">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
        <td align="right" style="width: 255px">
            <br />
            * 
            Módulo:</td>
        <td colspan="2">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtModulo" ErrorMessage="Introduce el módulo" 
                ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtModulo" runat="server" Width="275px" Height="16px"></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td align="right" style="width: 255px">
            Descripción:</td>
        <td colspan="2">
            <asp:TextBox ID="txtDescripcion" runat="server" Width="277px"></asp:TextBox>
            </td>
        </tr>
        <tr>
    <td align="right" class="auto-style35">Capturo:</td><td colspan="2">
            <asp:Label ID="lblCapturo" runat="server" style="font-weight: 700; font-size: x-small"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style35">Fecha:</td><td colspan="2">
            <asp:Label ID="lblFecCap" runat="server" style="font-weight: 700; font-size: x-small"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style2">Modifico:</td><td colspan="2">
            <asp:Label ID="lblModifico" runat="server" style="font-weight: 700; font-size: x-small"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style2">Fecha:</td><td colspan="2">
            <asp:Label ID="lblFecMod" runat="server" style="font-weight: 700; font-size: x-small"></asp:Label>
        </td>
        </tr>
        <tr>
        <td align="right" style="width: 255px" >
            &nbsp;</td>
        <td colspan="2" align="left">
            &nbsp;</td>
        </tr>
        <tr>
        <td align="right" style="width: 255px" >
            &nbsp;</td>
        <td align="center" class="style10">
            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Admin/imagenes/guardar.png" />
        </td>
        <td>
            &nbsp;</td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
