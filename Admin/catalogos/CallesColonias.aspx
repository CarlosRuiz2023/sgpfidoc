<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CallesColonias.aspx.vb" Inherits="Admin_catalogos_CallesColonias" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Calles y Colonias</title>
    <link href="../../css/estilos.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style6
        {
            width: 266px;
        }
        .style7
        {
            width: 266px;
            height: 25px;
        }
        .style8
        {
            height: 23px;
        }
    </style>
    <script src="../../js/JScript_General.js" type="text/javascript"></script>
    <script type="text/javascript" language="JavaScript">
        function openph(img) {
            //alert(img);
            var url1 = "UsuariosAB.aspx?ResponseType=Edit&id=" + img;
            newWindow = window.open(url1, "test", "top=0,left=0,menubar=no,toolbar=no,location=no, resizable=no,height=650,width=500,status=no,scrollbars=no,minimizable=no,maxmizable=no,resizable=0,titlebar=no;");
            if (newWindow.focus()) {
                newWindow.focus()
            }
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%">
    <tr>
    <td colspan="3" align="center">CALLES Y COLONIAS</td>
    </tr>
    <tr>
    <td class="style6"></td>
    </tr>
    <tr>
    <td align="right" class="style6">Calle:</td><td colspan="2">
        <asp:TextBox ID="txtCalle" runat="server" Width="250px"></asp:TextBox>
        </td>
    </tr>
    <tr>
    <td align="right" class="style7">Colonia:</td><td colspan="2" class="style1">
        <asp:TextBox ID="txtColonia" runat="server" Width="250px"></asp:TextBox>
        </td>
    </tr>
    <tr>
    <td align="right" class="style6">Calle anterior:</td><td colspan="2">
        <asp:TextBox ID="txtCalleA" runat="server" Width="250px"></asp:TextBox>
        </td>
    </tr>
    <tr>
    <td align="right" class="style6">&nbsp;</td><td colspan="2">
        &nbsp;</td>
    </tr>
    <tr>
    <td align="center" colspan="2">
        </td>
    <td align="left">
    <asp:ImageButton ID="btnBuscar2" runat="server" TabIndex="1" ImageUrl="~/Admin/imagenes/buscar.png" />
        <%--  <asp:Button ID="btnBuscar" runat="server" Text="Buscar" TabIndex="1" />--%>
        </td>
    </tr>
    <tr>
    <td colspan="3" class="style8"></td>
    </tr>
    <tr>
    <td colspan="3">
        <asp:GridView ID="grvCalles" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None" Width="100%" AutoGenerateColumns="False" 
            AllowSorting="True" style="margin-top: 0px" AllowPaging="True" PageSize="20">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>   
                        <asp:Label ID="SECFNO" runat="server" Text='<%# Eval("SECFNO")%>' Visible="false" ></asp:Label> 
                        <asp:Label ID="SSCFNO" runat="server" Text='<%# Eval("SSCFNO")%>' Visible="false" ></asp:Label>
                        <asp:Label ID="CLACNO" runat="server" Text='<%# Eval("CLACNO")%>' Visible="false" ></asp:Label> 
                        <asp:Label ID="idcalle" runat="server" Text='<%# Eval("CLACNO")%>' Visible="false" ></asp:Label>                                               
                    </ItemTemplate> 
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="True" HeaderText="Calle">
                    <ItemTemplate>   
                        <asp:LinkButton ID="calle" runat="server" Text='<%# Eval("NACCNO")%>'></asp:LinkButton>                  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="True" HeaderText="Colonia">
                    <ItemTemplate>   
                        <asp:Label ID="colonia" runat="server" Text='<%# Eval("NOMFNO")%>'></asp:Label>                  
                    </ItemTemplate>
                </asp:TemplateField>   
                <asp:TemplateField ShowHeader="True" HeaderText="Calle anterior">
                    <ItemTemplate>   
                        <asp:Label ID="callea" runat="server" Text='<%# Eval("NANCNO")%>'></asp:Label>                  
                    </ItemTemplate>
                </asp:TemplateField>               
                <%--<asp:BoundField DataField="NOMFNO" HeaderText="Colonia"/>--%>
            </Columns>
            <EmptyDataTemplate>
                <table cellspacing="0" cellpadding="4" id="grvCalles" style="color:#333333;width:100%;border-collapse:collapse;margin-top: 0px">
		            <tr style="color:White;background-color:#FF6600;font-weight:bold;">
			            <th scope="col">&nbsp;</th><th scope="col">Calle</th><th scope="col">Colonia</th>
		            </tr>
                </table>
                No se ecnontraron registros
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
    </div>
    </form>
    <script type="text/javascript" language="JavaScript">
        function devolverValor(valor1, valor2, valor3, valor4, valor5) {
            //alert(valor1); alert(valor2); alert(valor3); alert(valor4); alert(valor5);          
            //window.opener.document.getElementById('<%= txtCalle.ClientID %>').value = valor;
            m = "'ContentPlaceHolder1_SECFNO'";
            window.opener.document.getElementById('ContentPlaceHolder1_SECFNO').value = valor1;
            window.opener.document.getElementById('ContentPlaceHolder1_SSCFNO').value = valor2;
            window.opener.document.getElementById('ContentPlaceHolder1_CLACNO').value = valor3;
            window.opener.document.getElementById('ContentPlaceHolder1_txtCalle').value = valor4;
            window.opener.document.getElementById('ContentPlaceHolder1_Calle').value = valor4;
            window.opener.document.getElementById('ContentPlaceHolder1_txtColonia').value = valor5;
            window.opener.document.getElementById('ContentPlaceHolder1_Col').value = valor5;
            //alert(valor1); alert(valor2); alert(valor3); alert(valor4); alert(valor5);    
            window.close();
        }
    </script>
</body>
</html>
