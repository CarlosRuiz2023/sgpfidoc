<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Usuarios.aspx.vb" Inherits="Admin_catalogos_Usuarios" %>

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
            var url1 = "UsuariosAB.aspx?ResponseType=Edit&id=" + img;
            newWindow = window.open(url1, "test", "top=10,left=100,menubar=no,toolbar=no,location=no, resizable=no,height=650,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }   
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table width="100%">
    <tr>
    <td colspan="3" align="center"><strong>CATÁLOGO DE USUARIOS</strong></td>
    </tr>
    <tr>
    <td class="style6"></td>
    </tr>
    <tr>
    <td align="right" class="style6">Nombre:</td><td colspan="2">
        <asp:TextBox ID="txtBuscar" runat="server" Width="250px"></asp:TextBox>
        </td>
    </tr>
    <tr>
    <td align="right" class="style7">Rol:</td><td colspan="2" class="style1">
        <asp:DropDownList ID="cmbRol" runat="server">
        </asp:DropDownList>
        </td>
    </tr>
    <tr>
    <td align="center" colspan="2"> 
        <asp:Image id="Agregar" ImageUrl="~/Admin/imagenes/agregar.png" runat="server"></asp:Image>        
        <%--<asp:HyperLink ID="lnkAgregar" runat="server" 
            NavigateUrl="~/catalogos/UsuariosA.aspx" >Agregar</asp:HyperLink>--%>
        </td>
    <td align="left">
    <asp:ImageButton ID="btnBuscar2" runat="server" Text="Buscar" TabIndex="1" ImageUrl="~/Admin/imagenes/buscar.png" />
      <%--  <asp:Button ID="btnBuscar" runat="server" Text="Buscar" TabIndex="1" />--%>
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
        <asp:GridView ID="grvUsuarios" runat="server" CellPadding="4" ForeColor="#FFFFCC" 
            GridLines="None" Width="100%" AutoGenerateColumns="False" 
            DataKeyNames="mUsuId" AllowSorting="True" style="margin-top: 0px" 
            AllowPaging="True" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" PageSize="20"  >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="True" HeaderText="Modificar" >
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
                 <asp:TemplateField ShowHeader="false" HeaderText="mUsuId" Visible="False">
                  <ItemTemplate>   
                      <asp:Label ID="mUsuId" runat="server" Text='<%# Eval("mUsuId")%>' Visible="false" ></asp:Label>                
                  </ItemTemplate>                  
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="mUsuId" Visible="False" SortExpression="mUsuId" HeaderText="mUsuId" />
                <asp:BoundField HeaderText="Nombre" DataField="mUsuNombre" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Area" DataField="mUsuArea" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="mUsuCuenta" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Rol" DataField="rol" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Correo" DataField="mUsuCorreo" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Estatus" DataField="cEstDesc" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#FF6600" Font-Bold="True" ForeColor="White" />
            <PagerStyle  HorizontalAlign="Center" />
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

