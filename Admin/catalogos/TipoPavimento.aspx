<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="TipoPavimento.aspx.vb" Inherits="Admin_catalogos_TipoPavimento" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style6 {
                width: 495px;
            }

            .auto-style1 {
                width: 495px;
                height: 25px;
            }
        </style>
        <script type="text/javascript" language="JavaScript">
            function openph(img) {
                //alert(img);
                var url1 = "TipoPavimentoAB.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=350,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }
            function openpe(img) {
                //alert(img);
                var url1 = "TipoPavimentoE.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=400,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }

        </script>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table width="100%">
            <tr>
                <td colspan="3" align="center"><strong>Tipos de Terreno</strong></td>
            </tr>
            <tr>
                <td class="style6"></td>
            </tr>
            <tr>
                <td align="right" class="auto-style1">Tipo de Terreno:</td>
                <td colspan="2" class="style3">
                    <asp:DropDownList ID="cmbTiposPav" runat="server" Height="16px" style="margin-right: 0px"
                        Width="154px">
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
                    <asp:GridView ID="grvPavimento" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                        Width="100%" AutoGenerateColumns="False" DataKeyNames="cTipoPavId" AllowSorting="True"
                        style="margin-top: 0px" AllowPaging="True" CssClass="mGrid" PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>

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
                            <%--<asp:HyperLinkField DataNavigateUrlFormatString="~/Catalogos/UsuariosAB.aspx?id={0}"
                                DataTextField="mUsuId" HeaderText="ID" DataNavigateUrlFields="mUsuId" />--%>
                            <asp:TemplateField ShowHeader="false" HeaderText="TipoPavId" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="cTipoPavId" runat="server" Text='<%# Eval("cTipoPavId")%>'
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
                            <asp:BoundField HeaderText="Tipo de Terreno" DataField="cTipoPav" />
                            <asp:BoundField DataField="cTipoPavRom" HeaderText="Etiqueta de Terreno" />
                        </Columns>
                        <EmptyDataTemplate>
                            <table cellspacing="0" cellpadding="4"
                                style="color:#333333;width:100%;border-collapse:collapse;margin-top: 0px">
                                <tr style="color:White;background-color:#FF6600;font-weight:bold;">
                                    <th scope="col">Tipo de Terreno</th>
                                    <th scope="col">Etiqueta de Terreno</th>
                                </tr>
                            </table>
                            No se encontraron registros
                        </EmptyDataTemplate>
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