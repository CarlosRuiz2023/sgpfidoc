<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="TipoConv.aspx.vb"
    Inherits="Admin_catalogos_TipoConv" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style6 {
                width: 495px;
            }

            .auto-style1 {
                width: 550px;
            }
        </style>
        <script type="text/javascript" language="JavaScript">
            function openph(img) {
                //alert(img);
                var url1 = "TipoConvAB.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=250,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }
        </script>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <table width="100%">
            <tr>
                <td colspan="3" align="center">Tipo de Convenio</td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
            </tr>
            <tr>
                <td align="right" class="auto-style1">Tipo de Convenio:</td>
                <td colspan="2">
                    <asp:DropDownList ID="cmbTipoC" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <%--<asp:Button ID="btnAgregar" runat="server" Text="Agregar" TabIndex="2" />--%><%-- <a
                        href="UsuariosAB.aspx"><img src="../../imagenes/agregar.png" alt="Agregar" id="btnAgregar" />
                        </a>--%><%--<input type="image" src="../../imagenes/agregar.png" alt="Agregar" title="Ver"
                            onclick="openph('0')" />--%>
                        <asp:Image id="Agregar" ImageUrl="~/Admin/imagenes/agregar.png" runat="server"></asp:Image>
                        <%--<asp:HyperLink ID="lnkAgregar" runat="server"
                            NavigateUrl="~/catalogos/UsuariosA.aspx">Agregar</asp:HyperLink>--%>
                </td>
                <td align="left">
                    <asp:ImageButton ID="btnBuscar2" runat="server" Text="Buscar" TabIndex="1"
                        ImageUrl="~/Admin/imagenes/buscar.png" />
                    <%-- <asp:Button ID="btnBuscar" runat="server" Text="Buscar" TabIndex="1" />--%>
                </td>
            </tr>
            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">Registros:
                    <asp:Label ID="lblTotalRegistros" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:GridView ID="grvTiposC" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                        Width="100%" AutoGenerateColumns="False" DataKeyNames="cTConvId" AllowSorting="True"
                        style="margin-top: 0px" AllowPaging="True" CssClass="mGrid" PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>

                            <%--<asp:HyperLinkField DataNavigateUrlFormatString="~/Catalogos/UsuariosAB.aspx?id={0}"
                                DataTextField="mUsuId" HeaderText="ID" DataNavigateUrlFields="mUsuId" />--%>

                            <asp:TemplateField ShowHeader="True" HeaderText="Modificar">
                                <ItemTemplate>
                                    <%--<a href="UsuariosAB.aspx?id=<%# Eval(" mUsuId")%>"><input type="image"
                                            src="../../imagenes/editar_usuario.png" alt="Editar" title="Editar" /></a>
                                        --%>
                                        <%--<input type="image" src="../../imagenes/editar_usuario.png" alt="Editar"
                                            title="Editar" id="Editar" onclick="openph('<%# Eval(" mUsuId") %>')" />--%>
                                            <asp:Image id="Editar" ImageUrl="~/Admin/imagenes/editar_usuario.png"
                                                runat="server"></asp:Image>
                                            <%--<asp:ImageButton runat="server" ID="btn_Editar_Usuario"
                                                ImageUrl="~/imagenes/editar_usuario.png" BorderStyle="None"
                                                OnCommand="botones" CommandName="Editar"
                                                CommandArgument='<%# Eval("mUsuId")%>' />--%>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="True" HeaderText="Eliminar">
                                <ItemTemplate>
                                    <asp:Image id="Eliminar" ImageUrl="~/Admin/imagenes/eliminar_usuario.png"
                                        runat="server"></asp:Image>
                                    <%--<input type="image" src="../../imagenes/eliminar_usuario.png" alt="Editar"
                                        title="Ver" onclick="openph('<%# Eval(" mUsuId") %>')" /> --%>
                                        <%-- <asp:ImageButton runat="server" ID="btnEliminar_Usuario"
                                            ImageUrl="~/imagenes/eliminar_usuario.png" BorderStyle="None"
                                            OnCommand="botones" CommandName="Eliminar"
                                            CommandArgument='<%# Eval("mUsuId")%>' /> --%>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="false" HeaderText="cTConvId" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="cTConvId" runat="server" Text='<%# Eval("cTConvId")%>'
                                        Visible="false"></asp:Label>
                                    <%--<input type="image" src="../../imagenes/eliminar_usuario.png" alt="Editar"
                                        title="Ver" onclick="openph('<%# Eval(" mUsuId") %>')" /> --%>
                                        <%-- <asp:ImageButton runat="server" ID="btnEliminar_Usuario"
                                            ImageUrl="~/imagenes/eliminar_usuario.png" BorderStyle="None"
                                            OnCommand="botones" CommandName="Eliminar"
                                            CommandArgument='<%# Eval("mUsuId")%>' /> --%>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="cTConvId" Visible="False" SortExpression="cTConvId"
                                HeaderText="cTConvId" />
                            <asp:BoundField DataField="cTConvNombre" HeaderText="Nombre">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />

                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:Content>