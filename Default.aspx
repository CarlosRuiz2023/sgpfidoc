<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="Admin_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head id="Head1" runat="server">
    <title>FIDOC</title>
    <style type="text/css">
        .style1
        {
            height: 21px;
        }
        .auto-style1 {
            width: 36px;
        }
        .auto-style2 {
            height: 26px;
            width: 36px;
        }
        .auto-style3 {
            height: 27px;
            width: 36px;
        }
        .auto-style5 {
            height: 26px;
            width: 133px;
        }
        .auto-style6 {
            height: 27px;
            width: 133px;
        }
        .auto-style7 {
            width: 178px;
            height: 26px;
        }
    </style>

   


</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
    <table style="width: 233px">
    <tr>
        <td colspan="3" style="text-align: center" class="style1">
            </td>
    </tr>
    <tr>
        <td colspan="3" style="height: 21px; text-align: center">
            <asp:Image ID="Image1" runat="server" 
                ImageUrl="~/Admin/imagenes/logo_fidoc.png" />
        </td>
    </tr>
    <tr>
        <td colspan="3" style="text-align: center; height: 21px;">
            <span style="font-size: 24pt">
            Inicio de Sesión</span>
        </td>
    </tr>
    <tr>
        <td valign="top" class="auto-style5">
            <asp:Label ID="lblUsuario" runat="server" Text="Usuario:"></asp:Label></td>
        <td style="text-align: right;" valign="top" class="auto-style7">
            <asp:TextBox ID="txtUsuario" runat="server" Columns="15" ></asp:TextBox></td>
        <td valign="top" class="auto-style2">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsuario"
               Display="Dynamic" ErrorMessage="Usuario Requerido" ForeColor="Red">*</asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td class="auto-style5">
            <asp:Label ID="lblPassword" runat="server" Text="Contraseña:"></asp:Label></td>
        <td style="width: 178px; height: 26px; text-align: right;">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Columns="15"></asp:TextBox></td>
        <td class="auto-style2">
            <asp:RequiredFieldValidator ID="PasswordRequiredFieldValidator" runat="server" ControlToValidate="txtPassword"
               Display="Dynamic" ErrorMessage="Contraseña Requerida" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: right">
        </td>
        <td colspan="1" style="text-align: right" class="auto-style1">
        </td>
    </tr>
    <tr>
        <td class="auto-style6">        </td>
        <td style="width: 178px; text-align: right; height: 27px;">
            <asp:ImageButton ID="btnDefault" runat="server" ImageUrl="~/Admin/imagenes/iniciar.png" />
        </td>
        <td style="text-align: right" class="auto-style3">
        </td>
    </tr>
    <tr>
        <td colspan="3" style="height: 27px; text-align: center">
            <asp:ValidationSummary ID="DefaultValidationSummary" runat="server" 
                ForeColor="#CC0000" />
        </td>
    </tr>
</table>
<br />
<asp:Label ID="lblMessage" runat="server" ForeColor="#CC0000"></asp:Label>
    </div>
    </form>
</body>
</html>
