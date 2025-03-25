<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Roles.aspx.vb" Inherits="Admin_catalogos_Roles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style6
        {
            width: 495px;
        }
        .style7
        {
            width: 495px;
            height: 25px;
        }
    </style>
    <script type="text/javascript" language="JavaScript">
        function openph(img) {
            //alert(img);
            var url1 = "RolesAB.aspx?ResponseType=Edit&id=" + img;
            newWindow = window.open(url1, "test", "top=50,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=600,width=600,status=no,scrollbars=yes,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }   
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%">
    <tr>
    <td colspan="3" align="center"><strong>CATÁLOGO DE ROLES</strong></td>
    </tr>
    <tr>
    <td class="style6"></td>
    </tr>
    <tr>
    <td align="right" class="style7">Rol:</td><td colspan="2" class="style1">
        <asp:DropDownList ID="cmbRol" runat="server">     </asp:DropDownList>
        </td>
    </tr>
    <tr>
    <td align="center" colspan="2">
        <asp:Image id="Agregar" ImageUrl="~/Admin/imagenes/agregar.png" runat="server"></asp:Image>  
    </td>
    <td align="left">
        <asp:ImageButton ID="btnBuscar" runat="server" Text="Buscar" TabIndex="1" ImageUrl="~/Admin/imagenes/buscar.png" />
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
        <asp:GridView ID="grvRoles" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None" Width="100%" AutoGenerateColumns="False" 
            DataKeyNames="cRolId" style="margin-top: 0px" 
            HorizontalAlign="Center" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"  >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="True" HeaderText="Modificar">
                  <ItemTemplate>
                   
                        <asp:Image id="Editar" ImageUrl="~/Admin/imagenes/editar_usuario.png" runat="server"></asp:Image>                
                  </ItemTemplate>                  
                  <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="True" HeaderText="Eliminar">
                  <ItemTemplate>   
                  <asp:Image id="Eliminar" ImageUrl="~/Admin/imagenes/eliminar_usuario.png" runat="server"></asp:Image>
                   
                  </ItemTemplate>                  
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" HeaderText="cRolId" Visible="False">
                  <ItemTemplate>   
                      <asp:Label ID="cRolId" runat="server" Text='<%# Eval("cRolId")%>' Visible="false" ></asp:Label>
                                                   
                  </ItemTemplate>                  
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="cRolId" Visible="False" SortExpression="cRolId" 
                    HeaderText="cRolId" />
                <asp:BoundField HeaderText="Rol" DataField="cRolNombre" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Estatus" DataField="cEstDesc" >
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

