<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RolesAB.aspx.vb" Inherits="Admin_catalogos_RolesAB" %>

    <!DOCTYPE html
        PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head id="Head1" runat="server">
        <title></title>
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style8 {
                width: 255px;
                height: 23px;
            }

            .style9 {
                height: 23px;
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
                        <td colspan="3" align="center"><strong>ROLES</strong></td>
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
                            Rol:
                        </td>
                        <td colspan="2">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ControlToValidate="txtRol" ErrorMessage="Introduce el rol" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                            <br />
                            <asp:TextBox ID="txtRol" runat="server" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 255px">
                            Descripción:</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtDescripcion" runat="server" Width="350px"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr>
                        <td align="right" style="width: 255px">
                            * Estatus:</td>
                        <td colspan="2">
                            <asp:DropDownList ID="cmbEstatus" runat="server">
                            </asp:DropDownList>
                        </td>
                        </tr>--%>
                        <tr>
                            <td align="right" style="width: 255px">
                                Activo:</td>
                            <td colspan="2" align="left">
                                <asp:CheckBox ID="chkactivo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 255px">
                                &nbsp;</td>
                            <td colspan="2" align="left">
                                <asp:Label ID="lblComentario" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 255px">&nbsp;</td>
                            <td colspan="2" align="left">
                                <asp:GridView ID="grvPermisos" runat="server" AutoGenerateColumns="False"
                                    OnRowDataBound="grvPermisos_RowDataBound" DataKeyNames="mModId" CssClass="mGrid"
                                    PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt">
                                    <Columns>
                                        <asp:BoundField DataField="mModId" HeaderText="mModId" />
                                        <asp:BoundField DataField="cModNombre" HeaderText="Módulo" />

                                        <asp:TemplateField HeaderText="Consultar">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkConsultar" runat="server"
                                                    Checked='<%# Eval("mAccCons") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Alta">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkAgregar" runat="server"
                                                    Checked='<%# Eval("mAccAlta") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Eliminar">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkBaja" runat="server"
                                                    Checked='<%# Eval("mAccBaja") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Modificar">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkMod" runat="server"
                                                    Checked='<%# Eval("mAccMod") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Administrar">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkAdmon" runat="server"
                                                    Checked='<%# Eval("mAccAdmon") %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

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
                            <td align="center" style="width: 183px">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 255px">
                                &nbsp;</td>
                            <td align="center" style="width: 183px">
                                <asp:ImageButton ID="btnGuardar" runat="server"
                                    ImageUrl="~/Admin/imagenes/guardar.png" />
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                </table>
            </div>
        </form>
    </body>

    </html>