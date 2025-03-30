<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="OrigenSol.aspx.vb" Inherits="Admin_catalogos_OrigenSol" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style6 {
                width: 495px;
            }

            .style7 {
                width: 495px;
                height: 25px;
            }

            .style8 {
                height: 23px;
            }
        </style>
        <script type="text/javascript" language="JavaScript">
            function openph(img) {
                //alert(img);
                var url1 = "OrigenSolAB.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=300,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }

            function openphe(img) {
                //alert(img);
                pwidth = "500px"; pheight = "300px"; pleft = 0; ptop = 0; centrado = 1;

                var left = (screen.width / 2) - (pwidth / 2);
                var top = (screen.height / 2) - (pheight / 2);
                //centrado=1=centrado
                //centrado=0=sin centrado

                if (centrado == 0) {
                    left = pleft;
                    top = ptop;
                }

                //window.open(ventana, nombreventana, "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=" + pwidth + ",height=" + pheight + ",top=" + top + ",left=" + left)
                var url1 = "OrigenSolAB.aspx?ResponseType=Edit&id=" + img;
                newWindow = window.showModalDialog(url1, "ventana", "dialogHeight:" + pheight + ";dialogWidth:" + pwidth + ";toolbar:no;location:no;directories:no;status=no;menubar:no;scrollbars:yes;resizable:yes;copyhistory:no;dialogtop:" + top + ";dialogleft:" + left)

                /*var url1 = "ModulosAB.aspx?ResponseType=Edit&id=" + img;*/
                //newWindow = window.open(url1, "test", "top=50,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=300,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
                if (newWindow.focus()) {
                    newWindow.focus()
                }
            }
        </script>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table width="100%">
            <tr>
                <td colspan="3" align="center" class="style8"><strong>CATÁLOGO DE ORIGEN DE SOLICITUD</strong></td>
            </tr>
            <tr>
                <td class="style6"></td>
            </tr>
            <tr>
                <td align="right" class="style7">Origen:</td>
                <td colspan="2" class="style1">
                    <asp:DropDownList ID="cmbOrigen" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">

                    <asp:Image id="Agregar" ImageUrl="~/Admin/imagenes/agregar.png" runat="server"></asp:Image>
                    &nbsp;
                </td>
                <td align="left">
                    <asp:ImageButton ID="btnBuscar" runat="server" Text="Buscar" TabIndex="1"
                        ImageUrl="~/Admin/imagenes/buscar.png" />
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
                    <asp:GridView ID="grvOrigen" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                        Width="100%" AutoGenerateColumns="False" DataKeyNames="cOrigId" AllowSorting="True"
                        style="margin-top: 0px" HorizontalAlign="Center" CssClass="mGrid" PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="True" HeaderText="Modificar">
                                <ItemTemplate>

                                    <asp:Image id="Editar" ImageUrl="~/Admin/imagenes/editar_usuario.png"
                                        runat="server"></asp:Image>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="True" HeaderText="Eliminar">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="btnEliminar_Usuario"
                                        ImageUrl="~/Admin/imagenes/eliminar_usuario.png" BorderStyle="None"
                                        OnCommand="botones" CommandName="Eliminar"
                                        CommandArgument='<%# Eval("cOrigId")%>'
                                        OnClientClick="return confirm('¿Desea eliminar el registro?');" />

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" HeaderText="IdOrigen">
                                <ItemTemplate>
                                    <asp:Label ID="cOrigId" runat="server" Text='<%# Eval("cOrigId")%>' Visible="true">
                                    </asp:Label>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Nombre" DataField="cOrigNombre">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cEstDesc" HeaderText="Estatus" />
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