﻿<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Poligono.aspx.vb"
    Inherits="Admin_catalogos_Poligono" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style6 {
                width: 495px;
            }

            .auto-style1 {
                width: 495px;
                height: 51px;
            }

            .auto-style2 {
                height: 51px;
            }
        </style>
        <script type="text/javascript" language="JavaScript">
            function openph(img) {
                //alert(img);
                var url1 = "PoligonoAB.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=550,width=850,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }
            function openEP(img) {
                //alert(img);
                var url1 = "PoligonoE.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=280,width=560,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }
        </script>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table width="100%">
            <tr>
                <td colspan="3" align="center"><strong>POLIGONOS</strong></td>
            </tr>
            <tr>
                <td class="style6"></td>
            </tr>
            <tr>
                <td align="right" class="auto-style1">NOMBRE DEL POLIGONO:</td>
                <td colspan="2" class="auto-style2">
                    <asp:TextBox ID="txtPoligono" runat="server" Width="280px" Height="25px"></asp:TextBox>
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
                    <asp:GridView ID="grvPoligono" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                        Width="100%" AutoGenerateColumns="False" DataKeyNames="cIdPoligono" AllowSorting="True"
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
                            <asp:TemplateField ShowHeader="false" HeaderText="IdPoligono" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="cIdPoligono" runat="server" Text='<%# Eval("cIdPoligono")%>'
                                        Visible="false"></asp:Label>
                                    <%--<input type="image" src="../../imagenes/eliminar_usuario.png" alt="Editar"
                                        title="Ver" onclick="openph('<%# Eval(" mUsuId") %>')" /> --%>
                                        <%-- <asp:ImageButton runat="server" ID="btnEliminar_Usuario"
                                            ImageUrl="~/imagenes/eliminar_usuario.png" BorderStyle="None"
                                            OnCommand="botones" CommandName="Eliminar"
                                            CommandArgument='<%# Eval("mUsuId")%>' /> --%>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="cEtiqueta" HeaderText="Nombre Polígono" />

                            <asp:BoundField DataField="cOrigenGobierno" HeaderText="Origen" />
                            <asp:BoundField DataField="cNoRegistro" HeaderText="Num. Registro" />

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