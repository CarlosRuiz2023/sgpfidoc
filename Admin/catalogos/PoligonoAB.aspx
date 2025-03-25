<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PoligonoAB.aspx.vb" Inherits="Admin_catalogos_PoligonoAB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
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
          .auto-style4 {
              width: 172px;
              height: 23px;
          }
          .auto-style36 {
              font-size: xx-small;
          }
          .auto-style38 {
              height: 3px;
          }
          .auto-style40 {
              font-weight: 700;
          }
          .auto-style42 {
              height: 3px;
              font-weight: 700;
              width: 172px;
          }
          .auto-style45 {
              width: 172px;
          }
          .auto-style46 {
              width: 51px;
          }
          .auto-style47 {
              font-size: xx-small;
              width: 172px;
              height: 16px;
          }
          .auto-style48 {
              height: 23px;
          }
          .auto-style51 {
              height: 16px;
          }
        </style>
</head>
<body style="height: 508px; width: 781px; margin-right: 0px;">
    <form id="form1" runat="server">
    <div>
    <table align="center" style="width: 97%">
        <tr>
        <td colspan="4" align="center" class="auto-style40">POLIGONOS DE GOBIERNO</td>
        </tr>
        <tr>
        <td class="auto-style4"></td>
        <td colspan="3" class="style9">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style42">
            *Nombre del Poligono:</td>
        <td colspan="3" class="auto-style38">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="txtPoligono" ErrorMessage="Introduzca Nombre del Polígono" 
                ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtPoligono" runat="server" Height="25px" style="margin-bottom: 0px" Width="351px"></asp:TextBox>
            <br />
            </td>
        </tr>
        <tr>
        <td align="right" class="auto-style45">
            <br />
            *Descricpción:</td>
        <td colspan="3">
            <asp:TextBox ID="txtDescrip" runat="server" Height="132px" Width="530px"></asp:TextBox>
            <br />
            </td>
        </tr>
         <tr>
    <td align="right" class="auto-style45">Origen del Polígono:</td><td colspan="3">
            <asp:TextBox ID="txtOrigenGobierno" runat="server" Height="25px" style="margin-bottom: 0px" Width="190px"></asp:TextBox>
        </td>
        </tr>
         <tr>
    <td align="right" class="auto-style45">Num. de Registro:</td><td colspan="3" class="auto-style48">
            <asp:TextBox ID="txtNumRegistro" runat="server" Height="25px" style="margin-bottom: 0px" Width="193px"></asp:TextBox>
        </td>
        </tr>
         <tr>
    <td align="right" class="auto-style47"></td><td colspan="3" class="auto-style51">
        </td>
        </tr>
         <tr>
    <td align="right" class="auto-style48">Capturo:</td><td colspan="3" class="auto-style48">
            <asp:Label ID="lblCapturo" runat="server" style="font-weight: 700; " CssClass="auto-style36"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style48">Fecha:</td><td colspan="3" class="auto-style48">
            <asp:Label ID="lblFecCap" runat="server" style="font-weight: 700; " CssClass="auto-style36"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style48">Modifico:</td><td colspan="3" class="auto-style48">
            <asp:Label ID="lblModifico" runat="server" style="font-weight: 700; " CssClass="auto-style36"></asp:Label>
        </td>
        </tr>
        <tr>
    <td align="right" class="auto-style48">Fecha:</td><td colspan="3" class="auto-style48">
            <asp:Label ID="lblFecMod" runat="server" style="font-weight: 700; " CssClass="auto-style36"></asp:Label>
        </td>
        </tr>
        <tr>
        <td class="auto-style45">
            </td>
        <td class="auto-style46">
            </td>
        </tr>
        <tr>
        <td class="auto-style45">           
        <td class="auto-style46">
            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Admin/imagenes/guardar.png" />
            <%-- <asp:ImageButton ID="btnGuardar" runat="server" Text="Buscar" TabIndex="1" ImageUrl="~/imagenes/guardar.png" />  --%>      
        </td>
        <td >
            <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Admin/imagenes/cancelar.png" />
        </td>
        <td >
            
        </tr>
    </table>
    </div>
    </form>
</body>
</html>